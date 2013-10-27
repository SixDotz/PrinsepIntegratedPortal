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
import java.util.*;

/**
 *
 * @author Lim
 */
public class UserDA extends BaseDataAccess {

    public User getValidUser_ByUserID(int uID) {
        User user = null;

        try {
            DataAccessUtil dau = new DataAccessUtil();
            //ArrayList<ResultSet> rss = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent.name());
            //ResultSet rs = rss.get(0);
            ResultSet rs = dau.mySQLExecuteResultSet(sp_User.asp_GetValidUser_ByUserID.name(), uID);

            if (rs != null) {
                rs.next();

                //Create the user Object
                user = new User(rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getInt("FacebookID"),
                        rs.getString("SmuEmail"),
                        null,
                        null,
                        null);

            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return user;
    }

    public User getValidUser_ByFacebookID(long facebookId) {
        User validUser = null;
        try {
            DataAccessUtil dau = new DataAccessUtil();
            System.out.println("IDA" + facebookId);
            ResultSet rsUser = dau.mySQLExecuteResultSet(sp_User.asp_GetValidUser_ByFacebookID.toString(), facebookId);
            if (rsUser != null) {
                while (rsUser.next()) {

                    Long id = (long) rsUser.getInt("FacebookID");

                    validUser = new User(rsUser.getInt("UserID"), rsUser.getString("FullName"), id, rsUser.getString("SmuEmail"), null, null, null);
                }
            }

        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }
        return validUser;
    }

    public HashMap<Integer, User> getAllUsers() {
        int userId = 0;
        User validUser = null;
        HashMap<Integer, User> validUserHash = new HashMap<Integer, User>();
        try {
            DataAccessUtil dau = new DataAccessUtil();
            ResultSet rsValidUsers = dau.mySQLExecuteResultSet(sp_User.asp_GetValidUser.toString());
            if (rsValidUsers != null) {
                while (rsValidUsers.next()) {
                    long facebookId = (long) rsValidUsers.getInt("FacebookID");
                    String photoUrl = "https://graph.facebook.com/" + facebookId + "/picture";

                    validUser = new User(rsValidUsers.getInt("UserID"), rsValidUsers.getString("FullName"), facebookId, rsValidUsers.getString("SmuEmail"), null, null, null, photoUrl);
                    validUserHash.put(rsValidUsers.getInt("UserID"), validUser);
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }
        return validUserHash;
    }

    public ArrayList<User> getValidUser_All() {
        User user = null;
        ArrayList<Role> roles = new ArrayList<Role>();

        ArrayList<User> userList = new ArrayList<User>();

        try {
            DataAccessUtil dau = new DataAccessUtil();
            //ArrayList<ResultSet> rss = dau.mySQLExecuteResultSet(sp_LetsGoEvent.asp_GetValidLetsGoEvent.name());
            //ResultSet rs = rss.get(0);
            ResultSet rs = dau.mySQLExecuteResultSet(sp_User.asp_GetValidUser.name());

            if (rs != null) {
                while (rs.next()) {

                    //Create the user Object
                    user = new User(rs.getInt("UserID"),
                            rs.getString("FullName"),
                            rs.getInt("FacebookID"),
                            rs.getString("SmuEmail"),
                            null,
                            null,
                            null);
                    userList.add(user);
                }
            }
        } catch (SQLException e) {
            //Write exeption to log file
            DataAccessUtil.writeSQLExceptionLog(e);
        }

        return userList;
    }
}
