/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Lim
 */
public class HostelEvent extends Event {

    private int hostelEventID;
    private String eventTitle;
    private Date startDateTime;
    private Date endDateTime;
    private String venue;
    private String details;
    private String eventLargePhotoUrl;
    private String eventSmallPhotoUrl;
    private String eventDocRepo;
    private boolean isApproved;
    private List<User> eventAdmin;

    public HostelEvent(int hostelEventID, String eventTitle, Date startDateTime, Date endDateTime, String venue, String details, String eventLargePhotoUrl, String eventSmallPhotoUrl, String eventDocRepo, boolean isApproved, List<User> eventAdmin) {
        this(eventTitle,
                startDateTime,
                endDateTime,
                venue,
                details,
                eventLargePhotoUrl,
                eventSmallPhotoUrl,
                eventDocRepo,
                isApproved,
                eventAdmin);

        this.hostelEventID = hostelEventID;
    }

    public HostelEvent(String eventTitle, Date startDateTime, Date endDateTime, String venue, String details, String eventLargePhotoUrl, String eventSmallPhotoUrl, String eventDocRepo, boolean isApproved, List<User> eventAdmin) {
        this.eventTitle = eventTitle;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.venue = venue;
        this.details = details;
        this.eventLargePhotoUrl = eventLargePhotoUrl;
        this.eventSmallPhotoUrl = eventSmallPhotoUrl;
        this.eventDocRepo = eventDocRepo;
        this.isApproved = isApproved;
    }

    public int getHostelEventID() {
        return hostelEventID;
    }

    public void setHostelEventID(int hostelEventID) {
        this.hostelEventID = hostelEventID;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public Date getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(Date startDateTime) {
        this.startDateTime = startDateTime;
    }

    public Date getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(Date endDateTime) {
        this.endDateTime = endDateTime;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getEventLargePhotoUrl() {
        return eventLargePhotoUrl;
    }

    public void setEventLargePhotoUrl(String eventLargePhotoUrl) {
        this.eventLargePhotoUrl = eventLargePhotoUrl;
    }

    public String getEventSmallPhotoUrl() {
        return eventSmallPhotoUrl;
    }

    public void setEventSmallPhotoUrl(String eventSmallPhotoUrl) {
        this.eventSmallPhotoUrl = eventSmallPhotoUrl;
    }

    public String getEventDocRepo() {
        return eventDocRepo;
    }

    public void setEventDocRepo(String eventDocRepo) {
        this.eventDocRepo = eventDocRepo;
    }

    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public List<User> getEventAdmin() {
        return eventAdmin;
    }

    public void setEventAdmin(List<User> eventAdmin) {
        this.eventAdmin = eventAdmin;
    }
}
