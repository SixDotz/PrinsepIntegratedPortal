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

public class LetsGoEventsEditActionBean extends BaseActionBean {
    
    public LetsGoEventsEditActionBean(){
        super("/WEB-INF/jsp/LetsGoEvents_Edit.jsp");
    }
    
    public Resolution index(){
        return new ForwardResolution(getView());
    }    
}
