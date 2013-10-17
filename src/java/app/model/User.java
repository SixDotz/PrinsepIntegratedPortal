/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import app.infrastructure.BaseModel;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Lim
 */
public class User extends BaseModel {

    private int userID;
    private String fullName;
    private String facebookID;
    private String smuEmail;
    private Date lastLoginDateTime;
    private Date lastLogoutDateTime;
    
    private String facebookName;
    private String facebookProfilePhotoUrl;
    
    private List<Role> roles;

    public User(int userID, String fullName, String facebookID, String smuEmail, Date lastLoginDateTime, Date lastLogoutDateTime, List<Role> roles) {
        this(fullName, facebookID, smuEmail, lastLoginDateTime, lastLogoutDateTime, roles);

        this.userID = userID;
    }

    public User(String fullName, String facebookID, String smuEmail, Date lastLoginDateTime, Date lastLogoutDateTime, List<Role> roles) {
        this.fullName = fullName;
        this.facebookID = facebookID;
        this.smuEmail = smuEmail;
        this.lastLoginDateTime = lastLoginDateTime;
        this.lastLogoutDateTime = lastLogoutDateTime;
        
        this.roles = roles;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }   

    public String getFacebookID() {
        return facebookID;
    }

    public void setFacebookID(String facebookID) {
        this.facebookID = facebookID;
    }

    public String getSmuEmail() {
        return smuEmail;
    }

    public void setSmuEmail(String smuEmail) {
        this.smuEmail = smuEmail;
    }

    public Date getLastLoginDateTime() {
        return lastLoginDateTime;
    }

    public void setLastLoginDateTime(Date lastLoginDateTime) {
        this.lastLoginDateTime = lastLoginDateTime;
    }

    public Date getLastLogoutDateTime() {
        return lastLogoutDateTime;
    }

    public void setLastLogoutDateTime(Date lastLogoutDateTime) {
        this.lastLogoutDateTime = lastLogoutDateTime;
    }

    public String getFacebookName() {
        return facebookName;
    }

    public void setFacebookName(String facebookName) {
        this.facebookName = facebookName;
    }

    public String getFacebookProfilePhotoUrl() {
        return facebookProfilePhotoUrl;
    }

    public void setFacebookProfilePhotoUrl(String facebookProfilePhotoUrl) {
        this.facebookProfilePhotoUrl = facebookProfilePhotoUrl;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
}
