/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

/**
 *
 * @author Lim
 */
import app.infrastructure.BaseModel;


public class ImportDestination extends BaseModel {

    private int destinationID;
    private String destinationName;
    private String dBConnHash;
    private String tableName;
    private String primaryKeyColumn;
    private String uniqueTableName;
    private String uniqueDBColumn;
    private String uniqueGUIColumn;
    private String deleteStoredProc;

    public ImportDestination(int destinationID, String destinationName, String dBConnHash, String tableName, String primaryKeyColumn, String uniqueTableName, String uniqueDBColumn, String uniqueGUIColumn, String deleteStoredProc) {
        this.destinationID = destinationID;
        this.destinationName = destinationName;
        this.dBConnHash = dBConnHash;
        this.tableName = tableName;
        this.primaryKeyColumn = primaryKeyColumn;
        this.uniqueTableName = uniqueTableName;
        this.uniqueDBColumn = uniqueDBColumn;
        this.uniqueGUIColumn = uniqueGUIColumn;
        this.deleteStoredProc = deleteStoredProc;
    }

    public int getDestinationID() {
        return destinationID;
    }

    public void setDestinationID(int destinationID) {
        this.destinationID = destinationID;
    }

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public String getdBConnHash() {
        return dBConnHash;
    }

    public void setdBConnHash(String dBConnHash) {
        this.dBConnHash = dBConnHash;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getPrimaryKeyColumn() {
        return primaryKeyColumn;
    }

    public void setPrimaryKeyColumn(String primaryKeyColumn) {
        this.primaryKeyColumn = primaryKeyColumn;
    }

    public String getUniqueTableName() {
        return uniqueTableName;
    }

    public void setUniqueTableName(String uniqueTableName) {
        this.uniqueTableName = uniqueTableName;
    }

    public String getUniqueDBColumn() {
        return uniqueDBColumn;
    }

    public void setUniqueDBColumn(String uniqueDBColumn) {
        this.uniqueDBColumn = uniqueDBColumn;
    }

    public String getUniqueGUIColumn() {
        return uniqueGUIColumn;
    }

    public void setUniqueGUIColumn(String uniqueGUIColumn) {
        this.uniqueGUIColumn = uniqueGUIColumn;
    }

    public String getDeleteStoredProc() {
        return deleteStoredProc;
    }

    public void setDeleteStoredProc(String deleteStoredProc) {
        this.deleteStoredProc = deleteStoredProc;
    }
}
