/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

import app.infrastructure.BaseActionBean;
import app.model.User;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Lim
 */
public class LoginActionBean extends BaseActionBean {

    private User user;
    private String facebookName;

    public LoginActionBean() {
        super("/CommLife.action");
    }

    public Resolution index() {
        this.user = new User("Lim Li Long","94085084325", 
                             "lilong.lim.2011@sis.smu.edu.sg", 
                             null,  //Last Login Date 
                             null,  //Last Logout Date
                             null); //Roles <List>

        this.user.setFacebookName(facebookName);
        
        this.setSessionAttribute("user", user);

        return new RedirectResolution(getView());
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
