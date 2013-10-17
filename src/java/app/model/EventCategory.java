/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import app.infrastructure.BaseModel;
import java.util.Date;

/**
 *
 * @author Lim
 */
public class EventCategory extends BaseModel {
    private int categoryID;
    private String categoryName;
    private String categoryDesc;

    public EventCategory(int categoryID, String categoryName, String categoryDesc) {
        super();
        
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.categoryDesc = categoryDesc;
    }

    public EventCategory(int categoryID, String categoryName, String categoryDesc, Date effStartDate, Date effEndDate, Date createdDateTime, Date updateDateTime, String createdByID, String updatedByID, boolean isActive, boolean isSystem) {
        super(effStartDate, effEndDate, createdDateTime, updateDateTime, createdByID, updatedByID, isActive, isSystem);
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.categoryDesc = categoryDesc;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc;
    }
}
