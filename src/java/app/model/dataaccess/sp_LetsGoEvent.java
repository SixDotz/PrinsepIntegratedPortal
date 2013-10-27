/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model.dataaccess;

/**
 *
 * @author Lim
 */
public enum sp_LetsGoEvent {
    asp_GetValidLetsGoEvent,
    asp_GetValidLetsGoEvent_ByEventID,
    asp_GetValidLetsGoEvent_ByCreatorID,
    asp_GetValidLetsGoEvent_Comment,
    
    asp_GetValidLetsGoEventAttendee_ByEventID,
    
    asp_InsertLetsGoEventComment,
    asp_InsertLetsGoEvent_Comment_Like,
    
    asp_InsertLetsGoEvent,
    
    asp_UpdateLetsGoEvent,
    
    asp_DeleteLetsGoEvent,
    asp_DeleteLetsGoEvent_Comment_Like
}
