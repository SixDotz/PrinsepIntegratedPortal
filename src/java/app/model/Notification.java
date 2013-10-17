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
public class Notification extends BaseModel {
    private int notificationID;
    private Event event;
    private User user;
    private String description;

    public Notification(int notificationID, Event event, User user, String description) {
        this(event, user, description);
        
        this.notificationID = notificationID;
    }

    public Notification(Event event, User user, String description) {
        this.event = event;
        this.user = user;
        this.description = description;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
