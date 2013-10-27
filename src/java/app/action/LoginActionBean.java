/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

import app.infrastructure.BaseActionBean;
import app.model.User;
import app.model.dataaccess.UserDA;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import java.net.*;

/**
 *
 * @author Lim
 */
public class LoginActionBean extends BaseActionBean {

    private String facebookName;

    public LoginActionBean() {
        super("/CommLife.action");
    }

    public Resolution index() {
        //Retrieve Facebook ID from Parameter
        String strFacebookID = this.getParameter("facebookId");
        String currentUrl =  URLDecoder.decode(this.getParameter("currentUrl"));
        
        //Clean up currentUrl
        currentUrl = currentUrl.replace(getRequest().getContextPath(),"");
        
        if(strFacebookID  != null){
            long facebookID = Long.parseLong(strFacebookID);
            
            UserDA uDA = new UserDA();
            User user= uDA.getValidUser_ByFacebookID(facebookID);
            
            this.setUser(user);
        }

        //Redirect user back to the page he/she was from
        return new RedirectResolution(currentUrl);
    }

    public Resolution logout() {
        getSession().removeAttribute("user");

        return new RedirectResolution(getView());
    }

    public String getFacebookName() {
        return facebookName;
    }

    public void setFacebookName(String facebookName) {
        this.facebookName = facebookName;
    }
}
