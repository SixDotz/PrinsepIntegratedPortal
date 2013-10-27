/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

/**
 *
 * @author Young Lim
 */
import app.infrastructure.BaseActionBean;
import app.model.User;
import net.sourceforge.stripes.action.*;
import org.json.simple.JSONArray;
import app.model.dataaccess.UserDA;
import java.io.StringReader;
import java.util.ArrayList;
import org.json.simple.JSONObject;

public class UserListActionBean extends BaseActionBean {

    public UserListActionBean() {
        super("");
    }
    public ArrayList<User> users = new ArrayList<User>();
    public String callback;

    public void setCallback(String callback) {
        this.callback = callback;
    }

    public String JSONPUser() {
        UserDA uDA = new UserDA();

        users = uDA.getValidUser_All();
        User currentUser = this.getUser();

        // create a JSONObject to hold relevant info for each item in cart and stuff all of these objects in a JSONArray
        JSONArray itemList = new JSONArray();
        for (User user : this.users) {
            if (user.getUserID() != currentUser.getUserID()) {
                JSONObject ci = new JSONObject();
                ci.put("FullName", user.getFullName()); // product name
                ci.put("FacebookID", user.getFacebookID());
                ci.put("UserID", user.getUserID());
                ci.put("Photo", "https://graph.facebook.com/" + user.getFacebookID() + "/picture");
                itemList.add(ci);
            }
        }

        if (callback == null) {
            callback = "callback";
        }

        // return the object as a JSON String
        return callback + "(" + itemList.toJSONString() + ")";
    }

    public Resolution index() {
        return new StreamingResolution("text", new StringReader(JSONPUser()));
    }
}
