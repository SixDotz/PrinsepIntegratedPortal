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
import app.model.LetsGoEvent;
import app.model.dataaccess.LetsGoEventDA;
import java.util.ArrayList;
import net.sourceforge.stripes.action.*;

public class LetsGoEventsActionBean extends BaseActionBean {
    
    private final String STREVENTS = "EVENTS";

    public ArrayList<LetsGoEvent> getEvents(){
        //Retrive from Servlet Context
        return (ArrayList<LetsGoEvent>)getServletContextAttribute(STREVENTS);
    }
    
    private void setEvents(ArrayList<LetsGoEvent> events){
        //Save to Servlet Context
        setServletContextAttribute(STREVENTS, events);
    }
    
    public LetsGoEventsActionBean(){
        super("/WEB-INF/jsp/LetsGoEvents.jsp");
    }
    
    public Resolution index(){
        LetsGoEventDA da  = new LetsGoEventDA();
        
        setEvents(da.getValidLetsGoEvent());
        
        return new ForwardResolution(getView());
    }    
}
