/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import app.infrastructure.BaseModel;

/**
 *
 * @author Lim
 */
public class LetsGoEventAttendee extends BaseModel {

    private int LetsGoEventID;
    private LetsGoEvent letsGoEvent;
    private User user;
    private String rsvpStatus;

    public LetsGoEventAttendee(int LetsGoEventID, User user, String rsvpStatus) {
        this(user, rsvpStatus);

        this.LetsGoEventID = LetsGoEventID;
    }

    public LetsGoEventAttendee(LetsGoEvent letsGoEvent, User user, String rsvpStatus) {
        this(user, rsvpStatus);
        
        this.letsGoEvent = letsGoEvent;
    }

    private LetsGoEventAttendee(User user, String rsvpStatus) {
        this.user = user;
        this.rsvpStatus = rsvpStatus;
    }

    public int getLetsGoEventID() {
        return LetsGoEventID;
    }

    public void setLetsGoEventID(int LetsGoEventID) {
        this.LetsGoEventID = LetsGoEventID;
    }

    public LetsGoEvent getLetsGoEvent() {
        return letsGoEvent;
    }

    public void setLetsGoEvent(LetsGoEvent letsGoEvent) {
        this.letsGoEvent = letsGoEvent;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getRsvpStatus() {
        return rsvpStatus;
    }

    public void setRsvpStatus(String rsvpStatus) {
        this.rsvpStatus = rsvpStatus;
    }
}
