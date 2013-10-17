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
import net.sourceforge.stripes.action.*;

public class NotificationActionBean extends BaseActionBean {
    
    public NotificationActionBean(){
        super("/WEB-INF/jsp/Notification.jsp");
    }
    
    public Resolution index(){
        return new ForwardResolution(getView());
    }    
}
