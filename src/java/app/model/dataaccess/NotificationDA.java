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

/**
 *
 * @author Kimberly Lek
 */
public class NotificationDA extends BaseDataAccess {

    public ArrayList<Notification> getValidNotification_ByUserID(int uID) {
        ArrayList<Notification> notifications;
        DataAccessUtil dau = new DataAccessUtil();

        ResultSet rs = dau.mySQLExecuteResultSet(sp_Notification.asp_GetValidNotification_ByUserID.toString(), uID);

        notifications = buildNotificationList(rs, uID);

        return notifications;
    }

    public ArrayList<Notification> getValidTopTenNotification_ByUserID(int uID) {
        ArrayList<Notification> notifications;
        DataAccessUtil dau = new DataAccessUtil();

        ResultSet rs = dau.mySQLExecuteResultSet(sp_Notification.asp_GetValidTopTenNotification_ByUserID.toString(), uID);

        notifications = buildNotificationList(rs, uID);

        return notifications;
    }

    public void InsertNotification(int eventId, int organizerID, int sentById, String details) {
        try {
            DataAccessUtil dau = new DataAccessUtil();

            dau.mySQLExecuteNonQuery(sp_Notification.asp_InsertLetsGoEvent_Notification.toString(), eventId, organizerID, sentById, details);

        } catch (Exception e) {
            //Write exeption to log file
            e.printStackTrace();
        }
    }

    public void updateNotification_isRead(int nID) {
        try {
            DataAccessUtil dau = new DataAccessUtil();

            dau.mySQLExecuteNonQuery(sp_Notification.asp_UpdateNotification_isRead.toString(), nID);

        } catch (Exception e) {
            //Write exeption to log file
            e.printStackTrace();
        }
    }

    private ArrayList<Notification> buildNotificationList(ResultSet rs, int uID) {
        User user = null;
        User sentByUser = null;
        LetsGoEvent lgevent = null;
        HostelEvent hsevent = null;
        Notification notification = null;

        int hostelEventID = 0;
        int lgEventID = 0;
        int sentByID = 0;
        String redirectUrl = "";

        ArrayList<Notification> notifications = new ArrayList<Notification>();

        try {
            if (rs != null) {
                while (rs.next()) {
                    //Get user object by making use of UserDA getValidUser_ByUserID(uID)
                    UserDA user_da = new UserDA();
                    user = user_da.getValidUser_ByUserID(uID);                    

                    sentByID = rs.getInt("SentByID");
                    sentByUser = user_da.getValidUser_ByUserID(sentByID);
                    
                    //rs.wasNull() will check the last read column for null
                    //which is the "HostelEventID" column
                    hostelEventID = rs.getInt("HostelEventID");
                    if (!rs.wasNull()) {
                        //Get HostelEvent object by making use of HostelEventDA getValidHostelEvent_ByHostelEvent(hostelEventID)
                        HostelEventDA hs_da = new HostelEventDA();
                        hsevent = hs_da.getHostelEvent_ByEventID(hostelEventID);

                        //Redirect url for the HostelEvent when notification clicked
                        redirectUrl = "HostelEventsDetails.action?LetsGo=" + hostelEventID;

                        //Create the notification Object for Hostel Event
                        notification = new Notification(rs.getInt("NotificationID"),
                                hsevent,
                                user,
                                sentByUser,
                                rs.getString("Description"),
                                rs.getBoolean("isRead"),
                                rs.getTimestamp("createdDateTime"),
                                redirectUrl);

                        //Add Event to List of Events
                        notifications.add(notification);

                    } else {
                        //Get LetsGoEvent object by making use of LetsGoEventDA getValidLetsGoEvent_ByLetsGoEventID(letsGoEventID)
                        LetsGoEventDA lg_da = new LetsGoEventDA();
                        lgEventID = rs.getInt("LetsGoEventID");
                        lgevent = lg_da.getValidLetsGoEvent_ByLetsGoID(lgEventID);

                        //Redirect url for the LetsGoEvent when notification clicked 
                        redirectUrl = "LetsGoEventsDetails.action?LetsGo=" + lgEventID;
                        //Create the notification Object for Lets Go Event
                        notification = new Notification(rs.getInt("NotificationID"),
                                lgevent,
                                user,
                                sentByUser,
                                rs.getString("Description"),
                                rs.getBoolean("isRead"),
                                rs.getTimestamp("createdDateTime"),
                                redirectUrl);

                        //Add Event to List of Events
                        notifications.add(notification);
                    }
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return notifications;
    }
}
