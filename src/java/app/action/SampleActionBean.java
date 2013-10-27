/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

import app.infrastructure.BaseActionBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.StreamingResolution;

/**
 *
 * @author Lim
 */
public class SampleActionBean extends BaseActionBean {
    
    public SampleActionBean(){
        super("/WEB-INF/jsp/_Sample.jsp");
    }
    
    public Resolution index(){
        this.setServletContextAttribute("test", "hello");
        
        return new ForwardResolution(getView());
    }
    
    public Resolution myResolution(){
        String fromContext = this.getServletContextAttribute("test").toString();
        
        return new StreamingResolution("text/html", "Hello Kimberly from the ActionBean!!! =D");
    }
}