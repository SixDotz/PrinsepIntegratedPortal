/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import app.infrastructure.BaseModel;

/**
 *
 * @author Lim
 */
public class Role extends BaseModel {
    private int roleID;
    private String roleName;
    private String roleDesc;

    public Role(int roleID, String roleName, String roleDesc) {
        this(roleName, roleDesc);
        
        this.roleID = roleID;
    }

    public Role(String roleName, String roleDesc) {
        this.roleName = roleName;
        this.roleDesc = roleDesc;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }
}
