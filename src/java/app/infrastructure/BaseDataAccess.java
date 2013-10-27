/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.infrastructure;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Lim
 */
public abstract class BaseDataAccess {

    public BaseDataAccess() {
    }
    
    protected BaseModel populateStandardColumns(BaseModel model, ResultSet rs) throws SQLException{
        model.setCreatedByID(rs.getString("CreatedByID"));
        model.setCreatedDateTime(rs.getTimestamp("CreatedDateTime"));
        model.setEffEndDate(rs.getTimestamp("EffEndDate"));
        model.setEffStartDate(rs.getTimestamp("EffStartDate"));
        model.setUpdateDateTime(rs.getTimestamp("UpdatedDateTime"));
        model.setUpdatedByID(rs.getString("UpdatedByID"));
        model.setIsActive(rs.getBoolean("IsActive"));
        model.setIsSystem(rs.getBoolean("IsSystem"));
                
        return model;
    }
}
