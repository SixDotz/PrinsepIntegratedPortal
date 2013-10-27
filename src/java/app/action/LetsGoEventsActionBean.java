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
import app.model.LetsGoEventAttendee;
import app.model.User;
import app.model.dataaccess.LetsGoEventDA;
import java.util.ArrayList;
import net.sourceforge.stripes.action.*;

public class LetsGoEventsActionBean extends BaseActionBean {

    private final String STREVENTS = "EVENTS";
    private final String STRATTENDEE = "ATTENDEE";
    public int eventId;
    public String rsvpStatus;
    public String details;
    public int organizerId;

    public void setRsvpStatus(String rsvpStatus) {
        this.rsvpStatus = rsvpStatus;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public int getEventId(){
        return this.eventId;
    }
    
    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getOrganizerId() {
        return organizerId;
    }

    public void setOrganizerId(int organizerId) {
        this.organizerId = organizerId;
    }

    public ArrayList<LetsGoEvent> getEvents() {
        //Retrive from Servlet Context
        return (ArrayList<LetsGoEvent>) getServletContextAttribute(STREVENTS);
    }

    public ArrayList<LetsGoEventAttendee> getAttendee() {
        //Retrieve from Servlet Context
        return (ArrayList<LetsGoEventAttendee>) getServletContextAttribute(STRATTENDEE);
    }

    private void setEvents(ArrayList<LetsGoEvent> events) {
        //Save to Servlet Context
        setServletContextAttribute(STREVENTS, events);
    }

    private void setLetsGoAttendee(ArrayList<LetsGoEventAttendee> attendee) {
        //Save to Servlet Context
        setServletContextAttribute(STRATTENDEE, attendee);
    }

    public LetsGoEventsActionBean() {
        super("/WEB-INF/jsp/LetsGoEvents.jsp");
    }

    public Resolution index() {
        LetsGoEventDA da = new LetsGoEventDA();

        setLetsGoAttendee(da.getValidLetsGoAttendee());
        setEvents(da.getValidLetsGoEvent());

        return new ForwardResolution(getView());
    }

    public Resolution join() {
        User user = this.getUser();

        if (user != null) {
            LetsGoEventDA lgeDa = new LetsGoEventDA();

            //Post notification to event organizer
            this.postNotification(eventId, organizerId, details);

            //Update attendence status
            lgeDa.UpdateInsertLetsGoAttendee(eventId, user.getUserID(), rsvpStatus);
        }

        //return new ForwardResolution(getView());
        return new StreamingResolution("text/html", "success");
    }
}
