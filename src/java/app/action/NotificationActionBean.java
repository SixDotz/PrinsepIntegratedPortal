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
import app.model.Notification;
import app.model.User;
import app.model.dataaccess.NotificationDA;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import net.sourceforge.stripes.action.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class NotificationActionBean extends BaseActionBean {

    public String callback;

    public NotificationActionBean() {
        super("/WEB-INF/jsp/Notification.jsp");
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    public Resolution getJsonNotifications() {
        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a");

        User user = this.getUser();

        NotificationDA da = new NotificationDA();
        ArrayList<Notification> notifications = da.getValidNotification_ByUserID(user.getUserID());

        // create a JSONObject to hold relevant info for each item in cart and stuff all of these objects in a JSONArray
        JSONObject jsonObj;
        JSONArray jsonNotifications = new JSONArray();

        for (Notification notif : notifications) {
            jsonObj = new JSONObject();

            jsonObj.put("NotificationID", notif.getNotificationID());
            jsonObj.put("Description", notif.getDescription());
            jsonObj.put("PostedOn", formatter.format(notif.getCreatedDateTime()));

            jsonNotifications.add(jsonObj);
        }

        if (callback == null) {
            callback = "callback";
        }

        return new StreamingResolution("text", new StringReader(callback + "(" + jsonNotifications.toJSONString() + ")"));
    }

    public Resolution index() {
        return new ForwardResolution(this.getView());
    }

    public Resolution markNotificationsRead() {
        NotificationDA n_da = new NotificationDA();
        String parameters = this.getParameter("read");

        //Split id up
        String[] arrParam = parameters.split(",");

        //Update notification as read
        for (String notifID : arrParam) {
            n_da.updateNotification_isRead(Integer.parseInt(notifID));
        }

        return new StreamingResolution("text/html", "success");
    }
}
