/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

import app.infrastructure.BaseActionBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Lim
 */
public class HostelEventsActionBean extends BaseActionBean {
    
    public HostelEventsActionBean(){
        super("/WEB-INF/jsp/HostelEvents.jsp");
    }
    
    public Resolution index(){
        return new ForwardResolution(getView());
    }    
}