/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.infrastructure;

/**
 *
 * @author Lim
 */
import java.util.Date;

public abstract class BaseModel {

    private Date effStartDate;
    private Date effEndDate;
    private Date createdDateTime;
    private Date updateDateTime;
    private String createdByID;
    private String updatedByID;
    private boolean isActive;
    private boolean isSystem;
    
    public BaseModel(){
        
    }

    public BaseModel(Date effStartDate, Date effEndDate, Date createdDateTime, Date updateDateTime, String createdByID, String updatedByID, boolean isActive, boolean isSystem) {
        this.effStartDate = effStartDate;
        this.effEndDate = effEndDate;
        this.createdDateTime = createdDateTime;
        this.updateDateTime = updateDateTime;
        this.createdByID = createdByID;
        this.updatedByID = updatedByID;
        this.isActive = isActive;
        this.isSystem = isSystem;
    }   

    public Date getEffStartDate() {
        return effStartDate;
    }

    public Date getEffEndDate() {
        return effEndDate;
    }

    public Date getCreatedDateTime() {
        return createdDateTime;
    }

    public Date getUpdateDateTime() {
        return updateDateTime;
    }

    public String getCreatedByID() {
        return createdByID;
    }

    public String getUpdatedByID() {
        return updatedByID;
    }

    public boolean isActive() {
        return isActive;
    }

    public boolean isIsSystem() {
        return isSystem;
    }

    public void setEffStartDate(Date effStartDate) {
        this.effStartDate = effStartDate;
    }

    public void setEffEndDate(Date effEndDate) {
        this.effEndDate = effEndDate;
    }

    public void setCreatedDateTime(Date createdDateTime) {
        this.createdDateTime = createdDateTime;
    }

    public void setUpdateDateTime(Date updateDateTime) {
        this.updateDateTime = updateDateTime;
    }

    public void setCreatedByID(String createdByID) {
        this.createdByID = createdByID;
    }

    public void setUpdatedByID(String updatedByID) {
        this.updatedByID = updatedByID;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public void setIsSystem(boolean isSystem) {
        this.isSystem = isSystem;
    }
}
