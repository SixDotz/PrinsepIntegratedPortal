/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

/**
 *
 * @author Lim
 */
import app.infrastructure.BaseActionBean;
import app.model.LetsGoEvent;
import app.model.LetsGoEventComment;
import app.model.User;
import app.model.dataaccess.LetsGoEventDA;
import app.model.dataaccess.UserDA;
import app.model.enumeration.Enum_EventAttendee_Status;
import java.util.ArrayList;
import java.util.HashMap;
import net.sourceforge.stripes.action.*;

public class LetsGoEventsDetailsActionBean extends BaseActionBean {

    private final String EVENT = "EVENT";
    private final String COMMENT = "COMMENT";
    private final String RSVPSTATUS = "RSVPSTATUS";
    public int commentId;
    public String status;
    public String[] invitees;

    public LetsGoEventsDetailsActionBean() {
        super("/WEB-INF/jsp/LetsGoEvents_Details.jsp");
    }

    public void setInvitees(String[] invitees) {
        this.invitees = invitees;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LetsGoEvent getLetsGoEvent() {
        return (LetsGoEvent) getServletContextAttribute(EVENT);
    }

    private void setLetsGoEvent(LetsGoEvent event) {
        setServletContextAttribute(EVENT, event);
    }

    private void setLetsGoEventComment(ArrayList<LetsGoEventComment> commentList) {
        setServletContextAttribute(COMMENT, commentList);
    }

    public ArrayList<LetsGoEventComment> getComments() {
        return null;
    }
    
    public String getRsvpStatus(){
        return (String) getServletContextAttribute(RSVPSTATUS);
    }
    
    public void setRsvpStatus(String rsvpStatus){
        setServletContextAttribute(RSVPSTATUS, rsvpStatus);
    }

    public Resolution index() {
        String str_LetsGoID = this.getParameter("LetsGo");
        User user = this.getUser();

        //call the userDa to retrieve all the user objects, with updated fb profile
        if (str_LetsGoID != null) {
            LetsGoEvent event;
            ArrayList<LetsGoEventComment> commentList;
            LetsGoEventDA da = new LetsGoEventDA();

            //Parse LetsGoID into an integer
            int letsGoID = Integer.parseInt(str_LetsGoID);

           //call database to check for rsvpStatus
            if(user != null){
                setRsvpStatus(da.getRsvpStatus(letsGoID, user.getUserID()));
            }            
           
            //Call the database to retrieve the details of the given event id            
            event = da.getValidLetsGoEvent_ByLetsGoID(letsGoID);

            //Call the database to retrieve the comments of the event
            if (user != null) {
                commentList = da.getValidLetsGoEvent_Comment(letsGoID, user.getUserID());
            } else {
                commentList = da.getValidLetsGoEvent_Comment(letsGoID, 0);
            }

            //Save LetsGoEvent into Servlet Context
            setLetsGoEvent(event);

            //Save LetsGoEventComments into Servlet Context
            setLetsGoEventComment(commentList);

            //Return view
            return new ForwardResolution(getView());
        }

        //Redirect user to All Events Page if parameter is not provided
        return new RedirectResolution(LetsGoEventsActionBean.class);
    }

    public Resolution postComment() {
        //Create new data access object
        String letsGoID = this.getParameter("LetsGo");
        LetsGoEventDA da = new LetsGoEventDA();

        //Insert new comment to database
        da.insertNewComment(Integer.parseInt(letsGoID), this.getUser().getUserID(), this.getParameter("comments"));

        //Redirect users back to event details page
        return new RedirectResolution(LetsGoEventsDetailsActionBean.class).addParameter("LetsGo", letsGoID);
    }

    public Resolution updateLikeUnlike() {
        User user = this.getUser();
        LetsGoEventDA lgeDA = new LetsGoEventDA();
        if (status.equals("like")) {
            //Insert into db
            lgeDA.insertCommentLike(commentId, user.getUserID());
        } else if (status.equals("unlike")) {
            //Delete from db
            lgeDA.deleteCommentLike(commentId, user.getUserID());
        }
        return new StreamingResolution("text/html", "success");
    }

    public Resolution inviteResidents() {
        LetsGoEventDA da = new LetsGoEventDA();

        String strEventID = this.getParameter("eventID");
        String strOrganizerID = this.getParameter("organizerID");
        String eventTitle = this.getParameter("eventTitle");

        int eventID = Integer.parseInt(strEventID);
        int organizerID = Integer.parseInt(strOrganizerID);


        for (String strInviteeUserID : invitees) {
            int inviteeUserID = Integer.parseInt(strInviteeUserID);
            da.UpdateInsertLetsGoAttendee(eventID, inviteeUserID, Enum_EventAttendee_Status.pending.toString());
            this.postNotification(eventID, inviteeUserID, getUser().getFullName() + " has invited to you to " + eventTitle + ".");

        }

        //Done
        return new StreamingResolution("text/html", "success");
    }
    
    public Resolution joinUnjoin(){
        User user = this.getUser();

        if (user != null) {
            LetsGoEventDA lgeDa = new LetsGoEventDA();
            
            int eventId = Integer.parseInt(this.getParameter("eventId"));
            int organizerId = Integer.parseInt(this.getParameter("organizerId"));
            String details = this.getParameter("details");
            String rsvpStatus = this.getParameter("rsvpStatus");

            //Post notification to event organizer
            this.postNotification(eventId, organizerId, details);

            //Update attendence status
            lgeDa.UpdateInsertLetsGoAttendee(eventId, user.getUserID(), rsvpStatus);
        }
        
        //Done
        return new StreamingResolution("text/html", "success");
    }
}
