package app.model;

import java.util.Date;
import java.util.HashMap;

public class LetsGoEvent extends Event {

    private int eventID;
    private User eventOrganizer;
    private String title;
    private EventCategory category;
    private Date eventStartDateTime;
    private Date eventEndDateTime;
    private String venue;
    private int maxCapacity;
    private String details;
    private String contact;
    private String eventPhotoUrl;
    private HashMap<Integer, LetsGoEventAttendee> invitees;

    public LetsGoEvent(int eventID, User eventOrganizer, EventCategory category, String title, Date eventStartDateTime, Date eventEndDateTime, String venue, int maxCapacity, String details, String contact, String eventPhotoUrl, HashMap<Integer, LetsGoEventAttendee> invitees) {
        this(eventOrganizer,
                category,
                title,
                eventStartDateTime,
                eventEndDateTime,
                venue,
                maxCapacity,
                details,
                contact,
                eventPhotoUrl,
                invitees);
        
        this.eventID = eventID;
    }

    public LetsGoEvent(User eventOrganizer, EventCategory category, String title, Date eventStartDateTime, Date eventEndDateTime, String venue, int maxCapacity, String details, String contact, String eventPhotoUrl, HashMap<Integer, LetsGoEventAttendee> invitees) {
        this(title,
                eventStartDateTime,
                eventEndDateTime,
                venue,
                maxCapacity,
                details,
                contact,
                eventPhotoUrl,
                invitees);

        this.eventOrganizer = eventOrganizer;
        this.category = category;
    }

    private LetsGoEvent(String title, Date eventStartDateTime, Date eventEndDateTime, String venue, int maxCapacity, String details, String contact, String eventPhotoUrl, HashMap<Integer, LetsGoEventAttendee> invitees) {
        this.title = title;
        this.eventStartDateTime = eventStartDateTime;
        this.eventEndDateTime = eventEndDateTime;
        this.venue = venue;
        this.maxCapacity = maxCapacity;
        this.details = details;
        this.contact = contact;
        this.eventPhotoUrl = eventPhotoUrl;
        this.invitees = invitees;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public User getEventOrganizer() {
        return eventOrganizer;
    }

    public void setEventOrganizer(User eventOrganizer) {
        this.eventOrganizer = eventOrganizer;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public EventCategory getCategory() {
        return category;
    }

    public void setCategory(EventCategory category) {
        this.category = category;
    }

    public Date getEventStartDateTime() {
        return eventStartDateTime;
    }

    public void setEventStartDateTime(Date eventStartDateTime) {
        this.eventStartDateTime = eventStartDateTime;
    }

    public Date getEventEndDateTime() {
        return eventEndDateTime;
    }

    public void setEventEndDateTime(Date eventEndDateTime) {
        this.eventEndDateTime = eventEndDateTime;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }

    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEventPhotoUrl() {
        return eventPhotoUrl;
    }

    public void setEventPhotoUrl(String eventPhotoUrl) {
        this.eventPhotoUrl = eventPhotoUrl;
    }

    public HashMap<Integer, LetsGoEventAttendee> getInvitees() {
        return invitees;
    }

    public void setInvitees(HashMap<Integer, LetsGoEventAttendee> invitees) {
        this.invitees = invitees;
    }
}
