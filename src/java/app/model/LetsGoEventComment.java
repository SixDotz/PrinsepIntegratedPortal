/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import app.infrastructure.BaseModel;
import java.util.List;

/**
 *
 * @author Lim
 */
public class LetsGoEventComment extends BaseModel {
    private int commentID;
    private LetsGoEvent letsGoEvent;
    private User userID;
    private String comment;
    
    private List<User> likes;

    public LetsGoEventComment(int commentID, LetsGoEvent letsGoEvent, User userID, String comment, List<User> likes) {
        this(letsGoEvent, userID, comment, likes);
        
        this.commentID = commentID;       
    }   
    
    private LetsGoEventComment(LetsGoEvent letsGoEvent, User userID, String comment, List<User> likes) {
        this.letsGoEvent = letsGoEvent;
        this.userID = userID;
        this.comment = comment;
        
        this.likes = likes;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public LetsGoEvent getLetsGoEvent() {
        return letsGoEvent;
    }

    public void setLetsGoEvent(LetsGoEvent letsGoEvent) {
        this.letsGoEvent = letsGoEvent;
    }

    public User getUserID() {
        return userID;
    }

    public void setUserID(User userID) {
        this.userID = userID;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public List<User> getLikes() {
        return likes;
    }

    public void setLikes(List<User> likes) {
        this.likes = likes;
    }
}
