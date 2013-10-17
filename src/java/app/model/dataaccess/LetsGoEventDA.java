/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model.dataaccess;

import app.infrastructure.BaseDataAccess;
import app.infrastructure.DataAccessUtil;
import app.model.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author Lim
 */
public class LetsGoEventDA extends BaseDataAccess {

    public ArrayList<LetsGoEvent> getValidLetsGoEvent() {
        LetsGoEvent event = null;
        User eventOrganizer = null;
        User attendeeUser = null;
        LetsGoEventAttendee lgeAttendee = null;
        EventCategory category = null;
        HashMap<Integer, LetsGoEventAttendee> attendees = null;
        ArrayList<LetsGoEvent> events = new ArrayList<LetsGoEvent>();

        try {
            DataAccessUtil dau = new DataAccessUtil();
            //ArrayList<ResultSet> rss = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent.name());
            //ResultSet rs = rss.get(0);
            ResultSet rs = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent.name());
            
            //ArrayList<ResultSet> rssAttendees = null;
            ResultSet rsAttendees = null;

            if (rs != null) {
                while (rs.next()) {
                    //Retrieve attendees
                    DataAccessUtil dau2 = new DataAccessUtil();
                    //rssAttendees = dau2.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEventAttendee_ByEventID.toString(),rs.getInt("EventID"));
                    //rsAttendees = rssAttendees.get(0);
                    //rsAttendees = dau2.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEventAttendee_ByEventID.toString(),rs.getInt("LetsGoID"));
                    
                    //Create List of Attendees
//                    attendees = new HashMap<Integer, LetsGoEventAttendee>();
//                    if(rsAttendees != null){
//                        while(rsAttendees.next()){
//                            //Create user object
//                            attendeeUser = new User(rsAttendees.getInt("UserID"), 
//                                    rsAttendees.getString("FullName"), 
//                                    rsAttendees.getString("FacebookID"), 
//                                    rsAttendees.getString("SMUEmail"), 
//                                    null, null, null);
//                            
//                            this.populateStandardColumns(attendeeUser, rsAttendees);
//                            
//                            //Create attendee object and put into HashMap
//                            lgeAttendee = new LetsGoEventAttendee(rsAttendees.getInt("LetsGoID"), attendeeUser, rsAttendees.getString("RSVPStatus"));
//                            attendees.put(rsAttendees.getInt("UserID"), new LetsGoEventAttendee(rsAttendees.getInt("LetsGoID"), attendeeUser, rsAttendees.getString("RSVPStatus")));
//                        }
//                    }
                    
                    //Create the Event Creator Object
                    //eventOrganizer = new User(rs.getInt("UserID"), rs.getString("FullName"), rs.getString("FacebookID"), rs.getString("SMUEmail"), null, null, null);

                    //Create the Event Category Object
                    //category = new EventCategory(rs.getInt("CategoryID"), rs.getString("CategoryName"), rs.getString("CategoryDesc"));

                    //Create the event Object
                    event = new LetsGoEvent(rs.getInt("LetsGoID"),
                            eventOrganizer,
                            category,
                            rs.getString("EventTitle"),
                            rs.getDate("StartDateTime"),
                            rs.getDate("EndDateTime"),
                            rs.getString("Venue"),
                            rs.getInt("MaxCapacity"),
                            rs.getString("Details"),
                            rs.getString("ContactNo"),
                            rs.getString("EventPhotoUrl"),
                            attendees);

                    //Add Event to List of Events
                    events.add(event);
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return events;
    }
}
