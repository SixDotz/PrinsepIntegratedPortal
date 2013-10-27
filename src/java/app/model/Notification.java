/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import app.infrastructure.BaseModel;
import java.util.*;

/**
 *
 * @author Lim
 */
public class Notification extends BaseModel {

    private int notificationID;
    private Event event;
    private User user;
    private User sentByUser;
    private String description;
    private boolean isRead;
    private Date createdDateTime;
    private String redirectUrl;

    public Notification(int notificationID, Event event, User user, User sentByUser, String description, boolean isRead, Date createdDateTime, String redirectUrl) {
        this(notificationID, event, user, sentByUser, description, isRead, createdDateTime);

        this.redirectUrl = redirectUrl;
    }

    public Notification(int notificationID, Event event, User user, User sentByUser, String description, boolean isRead, Date createdDateTime) {
        this(event, user, sentByUser, description, isRead, createdDateTime);

        this.notificationID = notificationID;
    }

    public Notification(Event event, User user, User sentByUser, String description, boolean isRead, Date createdDateTime) {
        this.event = event;
        this.user = user;
        this.sentByUser = sentByUser;
        this.description = description;
        this.isRead = isRead;
        this.createdDateTime = createdDateTime;
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

    public User getSentByUser() {
        return sentByUser;
    }

    public void setSentByUser(User sentByUser) {
        this.sentByUser = sentByUser;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Date getCreatedDateTime() {
        return createdDateTime;
    }

    public void setCreatedDateTime(Date createdDateTime) {
        this.createdDateTime = createdDateTime;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }
}
