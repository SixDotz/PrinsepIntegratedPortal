/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model.dataaccess;

import app.infrastructure.BaseDataAccess;
import app.infrastructure.DataAccessUtil;
import app.model.HostelEvent;
import app.model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Lim
 */
public class HostelEventDA extends BaseDataAccess {

    public ArrayList<HostelEvent> getValidHostelEvent_Highlight() {
        int hostelEventID = 0;
        HostelEvent event = null;
        ArrayList<User> eventAdmins = null;

        ArrayList<HostelEvent> lst = new ArrayList<HostelEvent>();

        try {
            DataAccessUtil dau = new DataAccessUtil();
            //ArrayList<ResultSet> rss = dau.mySQLExecuteResultSet(sp_HostelEvent.asp_GetValidHostelEvent.toString());

            ResultSet rs = dau.mySQLExecuteResultSet(sp_HostelEvent.asp_GetValidHostelEvent.toString());//rss.get(0);            

            if (rs != null) {
                while (rs.next()) {
                    //Retrieve Event ID to get Event Admins
                    hostelEventID = rs.getInt("HostelEventID");

                    //Get Event Admin List
                    eventAdmins = getHostelEventAdmin(hostelEventID);

                    //Create Hostel Event Object
                    event = new HostelEvent(hostelEventID,
                            rs.getString("EventTitle"),
                            rs.getDate("StartDateTime"),
                            rs.getDate("EndDateTime"),
                            rs.getString("Venue"),
                            rs.getString("Details"),
                            rs.getString("EventLargePhotoUrl"),
                            rs.getString("EventSmallPhotoUrl"),
                            rs.getString("EventDocRepository"),
                            true,
                            eventAdmins);

                    //Add Hostel Event Object to ArrayList
                    lst.add(event);
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return lst;
    }

    private ArrayList<User> getHostelEventAdmin(int hostelEventID) throws SQLException {
        User user = null;
        ArrayList<User> eventAdmins = new ArrayList<User>();

        //Call database to retrieve list of admins
        DataAccessUtil dau = new DataAccessUtil();
        //ArrayList<ResultSet> rss = dau.mySQLExecuteResultSet(sp_HostelEvent.asp_GetValidHostelEventAdmin_ByHostelEventID.toString(), hostelEventID);
        //ResultSet rs = rss.get(0);
        ResultSet rs = dau.mySQLExecuteResultSet(sp_HostelEvent.asp_GetValidHostelEventAdmin_ByHostelEventID.toString(), hostelEventID);
        
        //Iterate through the ResultSet to get the event admins (users)
        while (rs.next()) {
            //Create new user object
            user = new User(rs.getInt("UserID"), rs.getString("FullName"), rs.getString("FacebookID"), rs.getString("SMUEmail"), null, null, null);

            //Add event admin (user) to ArrayList
            eventAdmins.add(user);
        }

        return eventAdmins;
    }
}
