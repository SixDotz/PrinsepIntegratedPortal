/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.viewmodel;

import java.util.ArrayList;
import java.util.List;
import net.sourceforge.stripes.action.FileBean;

/**
 *
 * @author Joyceee
 */
public class NewLetsGoForm {
    private String title;
    private int category;
    private String date;
    private String time;
    private String venue;
    private int capacity;
    private String contact;
    private String details;
    private ArrayList friends;
    private List<FileBean> photoUrl;
    
    public NewLetsGoForm(){}

    public NewLetsGoForm(String title, int category, String date, String time, String venue, int capacity, String contact, String details, ArrayList friends, List<FileBean> photoUrl) {
        this.title = title;
        this.category = category;
        this.date = date;
        this.time = time;
        this.venue = venue;
        this.capacity = capacity;
        this.contact = contact;
        this.details = details;
        this.friends = friends;
        this.photoUrl = photoUrl;
    }
    
    public String getTitle() {
        return title;
    }

    public int getCategory() {
        return category;
    }

    public String getDate() {
        return date;
    }

    public String getTime() {
        return time;
    }

    public String getVenue() {
        return venue;
    }

    public int getCapacity() {
        return capacity;
    }

    public String getContact() {
        return contact;
    }

    public String getDetails() {
        return details;
    }

    public ArrayList getFriends() {
        return friends;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public void setFriends(ArrayList friends) {
        this.friends = friends;
    }

    public List<FileBean> getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(List<FileBean> photoUrl) {
        this.photoUrl = photoUrl;
    }    
}
