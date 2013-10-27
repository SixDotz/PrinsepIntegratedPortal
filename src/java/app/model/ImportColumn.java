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

public class ImportColumn extends BaseModel {

    private int mapID;
    private int destinationID;
    private String SourceColumnName;
    private String destinationDisplayName;
    private String destinationDBColumnName;
    private String dataType;
    private boolean isValidationRequired;
    private boolean isMandatoryField;
    private String AllowedFormat;
    private int minValue;
    private int maxValue;
    private String DefaultValue;
    private String lookupTableName;
    private String loopupID;
    private String lookupField;
    private String lookupGUIField;
    private String colDBHash;

    public ImportColumn(int mapID,
            int destinationID,
            String SourceColumnName,
            String destinationDisplayName,
            String destinationDBColumnName,
            String dataType,
            boolean isValidationRequired,
            boolean isMandatoryField,
            String AllowedFormat,
            int minValue,
            int maxValue,
            String DefaultValue,
            String lookupTableName,
            String loopupID,
            String lookupField,
            String lookupGUIField,
            String colDBHash) {
        this.mapID = mapID;
        this.destinationID = destinationID;
        this.SourceColumnName = SourceColumnName;
        this.destinationDisplayName = destinationDisplayName;
        this.destinationDBColumnName = destinationDBColumnName;
        this.dataType = dataType;
        this.isValidationRequired = isValidationRequired;
        this.isMandatoryField = isMandatoryField;
        this.AllowedFormat = AllowedFormat;
        this.minValue = minValue;
        this.maxValue = maxValue;
        this.DefaultValue = DefaultValue;
        this.lookupTableName = lookupTableName;
        this.loopupID = loopupID;
        this.lookupField = lookupField;
        this.lookupGUIField = lookupGUIField;
        this.colDBHash = colDBHash;
    }

    public int getMapID() {
        return mapID;
    }

    public void setMapID(int mapID) {
        this.mapID = mapID;
    }

    public int getDestinationID() {
        return destinationID;
    }

    public void setDestinationID(int destinationID) {
        this.destinationID = destinationID;
    }

    public String getSourceColumnName() {
        return SourceColumnName;
    }

    public void setSourceColumnName(String SourceColumnName) {
        this.SourceColumnName = SourceColumnName;
    }

    public String getDestinationDisplayName() {
        return destinationDisplayName;
    }

    public void setDestinationDisplayName(String destinationDisplayName) {
        this.destinationDisplayName = destinationDisplayName;
    }

    public String getDestinationDBColumnName() {
        return destinationDBColumnName;
    }

    public void setDestinationDBColumnName(String destinationDBColumnName) {
        this.destinationDBColumnName = destinationDBColumnName;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public boolean isIsValidationRequired() {
        return isValidationRequired;
    }

    public void setIsValidationRequired(boolean isValidationRequired) {
        this.isValidationRequired = isValidationRequired;
    }

    public boolean isIsMandatoryField() {
        return isMandatoryField;
    }

    public void setIsMandatoryField(boolean isMandatoryField) {
        this.isMandatoryField = isMandatoryField;
    }

    public String getAllowedFormat() {
        return AllowedFormat;
    }

    public void setAllowedFormat(String AllowedFormat) {
        this.AllowedFormat = AllowedFormat;
    }

    public int getMinValue() {
        return minValue;
    }

    public void setMinValue(int minValue) {
        this.minValue = minValue;
    }

    public int getMaxValue() {
        return maxValue;
    }

    public void setMaxValue(int maxValue) {
        this.maxValue = maxValue;
    }

    public String getDefaultValue() {
        return DefaultValue;
    }

    public void setDefaultValue(String DefaultValue) {
        this.DefaultValue = DefaultValue;
    }

    public String getLookupTableName() {
        return lookupTableName;
    }

    public void setLookupTableName(String lookupTableName) {
        this.lookupTableName = lookupTableName;
    }

    public String getLoopupID() {
        return loopupID;
    }

    public void setLoopupID(String loopupID) {
        this.loopupID = loopupID;
    }

    public String getLookupField() {
        return lookupField;
    }

    public void setLookupField(String lookupField) {
        this.lookupField = lookupField;
    }

    public String getLookupGUIField() {
        return lookupGUIField;
    }

    public void setLookupGUIField(String lookupGUIField) {
        this.lookupGUIField = lookupGUIField;
    }

    public String getColDBHash() {
        return colDBHash;
    }

    public void setColDBHash(String colDBHash) {
        this.colDBHash = colDBHash;
    }
}
