/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model.dataaccess;

import app.infrastructure.BaseDataAccess;
import app.infrastructure.DataAccessUtil;
import app.model.*;
import app.model.enumeration.Enum_EventAttendee_Status;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

/**
 *
 * @author Lim
 */
public class LetsGoEventDA extends BaseDataAccess {

    public int insertNewComment(int eventID, int userID, String comment) {
        return DataAccessUtil.mySQLExecuteNonQuery(sp_LetsGoEvent.asp_InsertLetsGoEventComment.toString(),
                eventID, userID, comment);
    }

    public int insertNewEvent(int organizerID, String title, int categoryID, Date startDateTime,
            String venue, int capacity, String details, String contact, String photoUrl) {
        //NOTE: Parameters passed in MISSING- invite list
        //NOTE: return statement half done
        //RMB: to pass in endDateTime as null
        DataAccessUtil da = new DataAccessUtil();
        ResultSet rs = da.mySQLExecuteResultSet(sp_LetsGoEvent.asp_InsertLetsGoEvent.toString(),
                organizerID, title, categoryID, startDateTime, null, venue, capacity, details,
                contact, photoUrl);
        
        if(rs != null){
            try{
                rs.next();
                
                return rs.getInt("NewLetsGoID");
            }
            catch(SQLException e){
                e.printStackTrace();
            }
        }
        
        return 0;
    }

    public ArrayList<LetsGoEvent> getValidLetsGoEvent(int numOfRows) {
        ArrayList<LetsGoEvent> events = new ArrayList<LetsGoEvent>();

        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rs = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent.name());

            if (rs != null) {
                while (rs.next()) {
                    //Make use of common helper method to generate all the details from DB & Add Event to List of Events
                    events.add(createEventDetails(rs));

                    if (events.size() == numOfRows) {
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return events;
    }

    public int insertCommentLike(int commentID, int userID) {
        return DataAccessUtil.mySQLExecuteNonQuery(sp_LetsGoEvent.asp_InsertLetsGoEvent_Comment_Like.toString(), commentID, userID);
    }

    public int deleteCommentLike(int commentID, int userID) {
        return DataAccessUtil.mySQLExecuteNonQuery(sp_LetsGoEvent.asp_DeleteLetsGoEvent_Comment_Like.toString(), commentID, userID);
    }

    public ArrayList<LetsGoEvent> getValidLetsGoEvent() {
        ArrayList<LetsGoEvent> events = new ArrayList<LetsGoEvent>();

        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rs = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent.name());

            if (rs != null) {
                while (rs.next()) {
                    //Make use of common helper method to generate all the details from DB & Add Event to List of Events
                    events.add(createEventDetails(rs));
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return events;
    }

    public LetsGoEvent getValidLetsGoEvent_ByLetsGoID(int letsGoID) {
        LetsGoEvent lge = null;
        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rs = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent_ByEventID.toString(), letsGoID);

            if (rs != null) {
                //Set resultset pointer
                rs.next();

                //Make use of common helper method to generate all the details from DB
                lge = createEventDetails(rs);
            }

        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return lge;
    }

    private LetsGoEvent createEventDetails(ResultSet rs) {
        LetsGoEvent event = null;

        User attendeeUser = null;
        LetsGoEventAttendee lgeAttendee = null;

        //Retrieve attendees
        DataAccessUtil dau2 = new DataAccessUtil();

        try {
            ResultSet rsAttendees = dau2.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEventAttendee_ByEventID.toString(), rs.getInt("LetsGoID"));

            //Create List of Attendees
            HashMap<Integer, LetsGoEventAttendee> attendees = new HashMap<Integer, LetsGoEventAttendee>();

            if (rsAttendees != null) {
                while (rsAttendees.next()) {
                    //Create user object
                    attendeeUser = new User(rsAttendees.getInt("UserID"),
                            rsAttendees.getString("FullName"),
                            rsAttendees.getLong("FacebookID"),
                            rsAttendees.getString("SmuEmail"),
                            null, null, null);

                    attendeeUser = (User) this.populateStandardColumns(attendeeUser, rsAttendees);

                    //Create attendee object and put into HashMap
                    lgeAttendee = new LetsGoEventAttendee(rsAttendees.getInt("LetsGoID"), attendeeUser, rsAttendees.getString("RSVPStatus"));
                    attendees.put(rsAttendees.getInt("UserID"), new LetsGoEventAttendee(rs.getInt("LetsGoID"), attendeeUser, rsAttendees.getString("RSVPStatus")));
                }
            }

            //Create the Event Creator Object
            User eventOrganizer = new User(rs.getInt("UserID"), rs.getString("FullName"), rs.getLong("FacebookID"), rs.getString("SMUEmail"), null, null, null);

            //Create the Event Category Object
            EventCategory category = new EventCategory(rs.getInt("CategoryID"), rs.getString("CategoryName"), rs.getString("CategoryDesc"));

            //Create the event Object
            event = new LetsGoEvent(rs.getInt("LetsGoID"),
                    eventOrganizer,
                    category,
                    rs.getString("EventTitle"),
                    rs.getTimestamp("StartDateTime"),
                    rs.getTimestamp("EndDateTime"),
                    rs.getString("Venue"),
                    rs.getInt("MaxCapacity"),
                    rs.getString("Details"),
                    rs.getString("ContactNo"),
                    rs.getString("EventPhotoUrl"),
                    attendees);

            //Populate Standard Columns
            event = (LetsGoEvent) this.populateStandardColumns(event, rs);


        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return event;
    }

    public ArrayList<LetsGoEventAttendee> getValidLetsGoAttendee() {
        ArrayList<LetsGoEventAttendee> lgAttendeeList = new ArrayList<LetsGoEventAttendee>();
        LetsGoEventAttendee lgAttendee = null;
        User attendee = null;

        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rsAttendee = null;

            rsAttendee = dau.mySQLExecuteResultSet(sp_Notification.asp_GetValidLetsGoEventAttendee.toString());
            if (rsAttendee != null) {
                while (rsAttendee.next()) {
                    attendee = new User(rsAttendee.getInt("UserID"),
                            rsAttendee.getString("FullName"),
                            rsAttendee.getLong("FacebookID"),
                            rsAttendee.getString("SmuEmail"),
                            null, null, null);

                    attendee = (User) this.populateStandardColumns(attendee, rsAttendee);

                    lgAttendee = new LetsGoEventAttendee(rsAttendee.getInt("LetsGoID"), attendee, rsAttendee.getString("RSVPStatus"));

                    lgAttendeeList.add(lgAttendee);
                }
            }
        } catch (SQLException e) {
            DataAccessUtil.writeSQLExceptionLog(e);
        }
        return lgAttendeeList;
    }

    public void UpdateInsertLetsGoAttendee(int eventId, int uId, String rsvpStatus) {
        DataAccessUtil dau = new DataAccessUtil();
        if (rsvpStatus.equals(Enum_EventAttendee_Status.going.toString())) {
            //change rsvpStatus to Going
            dau.mySQLExecuteNonQuery(sp_Notification.asp_UpdateLetsGoEvent_Attendee_Going.toString(), eventId, uId);
        } else if (rsvpStatus.equals(Enum_EventAttendee_Status.not_going.toString())) {
            //change rsvpStatus to Not going    
            dau.mySQLExecuteNonQuery(sp_Notification.asp_UpdateLetsGoEvent_Attendee_NotGoing.toString(), eventId, uId);
        }
    }

    public ArrayList<LetsGoEventComment> getValidLetsGoEvent_Comment(int letsGoId, int userId) {
        ArrayList<LetsGoEventComment> lgeCommentList = new ArrayList<LetsGoEventComment>();
        LetsGoEventComment lgeComment = null;
        LetsGoEvent lgEvent = null;
        User user = null;
        boolean isLike = false;

        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rsComment = null;

            User liker = null;
            int likerId = 0;

            rsComment = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent_Comment.toString(), letsGoId, userId);

            if (rsComment != null) {
                while (rsComment.next()) {
                    lgEvent = new LetsGoEvent(rsComment.getInt("LetsGoID"), null, null, null, null, null, null, 0, null, null, null, null);
                    user = new User(rsComment.getInt("UserID"), null, 0, null, null, null, null);
                    
                    //change to using wasNull
                    likerId = rsComment.getInt("Liker");
                    if (!rsComment.wasNull()){
                        liker = new User(likerId,null, 0, null, null, null, null);
                    }

                    lgeComment = new LetsGoEventComment(rsComment.getInt("CommentID"),
                            lgEvent, user, rsComment.getString("Comment"), null, liker);
                    
                    lgeComment = (LetsGoEventComment)this.populateStandardColumns(lgeComment, rsComment);

                    lgeCommentList.add(lgeComment);
                }
            }
        } catch (SQLException e) {
            DataAccessUtil.writeSQLExceptionLog(e);
        }
        return lgeCommentList;
    }
    
    public String getRsvpStatus(int letsGoID, int loggedUserID){
        String rsvpStatus = Enum_EventAttendee_Status.going.toString();
        String dbRsvpStatus = "";
        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rsRsvpStatus = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEventAttendee_ByEventID.toString(), letsGoID);
            if (rsRsvpStatus != null){
                while(rsRsvpStatus.next()){
                    int userID = rsRsvpStatus.getInt("UserID");
                    if (rsRsvpStatus.wasNull()){
                        //if doesnt exists, button should be "going"
                        rsvpStatus = Enum_EventAttendee_Status.going.toString();
                    }else if (userID == loggedUserID){
                        dbRsvpStatus = rsRsvpStatus.getString("RSVPStatus");
                        if (dbRsvpStatus.equals(Enum_EventAttendee_Status.pending.toString()) || dbRsvpStatus.equals(Enum_EventAttendee_Status.not_going.toString())){
                            //if the dbRsvpStatus is pending or not going, change RsvpStatus to going
                            rsvpStatus = Enum_EventAttendee_Status.going.toString();
                        }else if (dbRsvpStatus.equals(Enum_EventAttendee_Status.going.toString())){
                            //if the dbRsvpStatus is going, change RsvpStatu to not going
                            rsvpStatus = Enum_EventAttendee_Status.not_going.toString();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            DataAccessUtil.writeSQLExceptionLog(e);
        }
        
        return rsvpStatus;
    }
}
