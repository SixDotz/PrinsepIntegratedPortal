/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.infrastructure;

/**
 *
 * @author Lim
 */
import app.model.Notification;
import app.model.User;
import app.model.dataaccess.NotificationDA;
import app.model.dataaccess.UserDA;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public abstract class BaseActionBean implements ActionBean {

    private final String STRNOTIFICATIONS = "NOTIFICATIONS";
    private String view;
    private ActionBeanContext ctx;
    
    private final String USERHASH = "USERHASH";

    public BaseActionBean(String view) {
        this.view = view;
    }

    public ActionBeanContext getContext() {
        return ctx;
    }

    public void setContext(ActionBeanContext ctx) {
        this.ctx = ctx;
    }

    protected Object getServletContextAttribute(String name) {
        return this.ctx.getServletContext().getAttribute(name);
    }

    protected void setServletContextAttribute(String name, Object value) {
        this.ctx.getServletContext().setAttribute(name, value);
    }

    public HttpServletResponse getResponse() {
        return ctx.getResponse();
    }

    public HttpServletRequest getRequest() {
        return ctx.getRequest();
    }

    public HttpSession getSession() {
        return getRequest().getSession();
    }

    public Object getSessionAttribute(String attributeName) {
        return this.getSession().getAttribute(attributeName);
    }

    public void setSessionAttribute(String attributeName, Object value) {
        this.getSession().setAttribute(attributeName, value);
    }

    public String getParameter(String name) {
        return getContext().getRequest().getParameter(name);
    }

    public String[] getParameters(String name) {
        return getContext().getRequest().getParameterValues(name);
    }

    protected User getUser() {
        return (User) this.getSessionAttribute("user");
    }

    protected void setUser(User user) {
        this.setSessionAttribute("user", user);
    }
    
    public HashMap<Integer, User> getUserHash() {
        //Retrive from Servlet Context
        return (HashMap<Integer, User>) getServletContextAttribute(USERHASH);
    }

    public void setUserHash(HashMap<Integer, User> userHash) {
        setSessionAttribute(USERHASH, userHash);
    }

    protected void setNotification(ArrayList<Notification> notifications) {
        //Save to Servlet Context
        setServletContextAttribute(STRNOTIFICATIONS, notifications);

    }

    public ArrayList<Notification> getNotification() {
        //Retrive from Servlet Context
        return (ArrayList<Notification>) getServletContextAttribute(STRNOTIFICATIONS);
    }

    //public Date getSystemDate() {
    //    Date today = new Date();
    //    Date systemDate = DateUtils.addSeconds(today, getDifference());
    //    return systemDate;
    //}
    @SuppressWarnings("unchecked")
    public String getLastUrl() {
        HttpServletRequest req = getContext().getRequest();
        StringBuilder sb = new StringBuilder();

        // Start with the URI and the path
        String uri = (String) req.getAttribute("javax.servlet.forward.request_uri");
        String path = (String) req.getAttribute("javax.servlet.forward.path_info");
        if (uri == null) {
            uri = req.getRequestURI();
            path = req.getPathInfo();
        }
        sb.append(uri);
        if (path != null) {
            sb.append(path);
        }

        // Now the request parameters
        sb.append('?');
        Map<String, String[]> map =
                new HashMap<String, String[]>(req.getParameterMap());

        // Remove previous locale parameter, if present.
        map.remove(PrinsepLocalePicker.LOCALE);

        // Append the parameters to the URL
        for (String key : map.keySet()) {
            String[] values = map.get(key);
            for (String value : values) {
                sb.append(key).append('=').append(value).append('&');
            }
        }
        // Remove the last '&'
        sb.deleteCharAt(sb.length() - 1);

        return sb.toString();
    }

    public String getView() {
        return this.view;
    }

    protected void postNotification(int eventId, int organizerID, String details) {
        NotificationDA nDa = new NotificationDA();
        nDa.InsertNotification(eventId, organizerID, this.getUser().getUserID(), details);
    }

    @DefaultHandler
    public Resolution defaultAction() {
        User user = (User) this.getSessionAttribute("user");

        if (user != null) {
            NotificationDA n_da = new NotificationDA();

            setNotification(n_da.getValidTopTenNotification_ByUserID(user.getUserID()));
        }
        
        UserDA uda = new UserDA();
        HashMap<Integer, User> userHash = uda.getAllUsers();
        setUserHash(userHash);

        return index();
    }

    public abstract Resolution index();
}
