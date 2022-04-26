/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business;

import Business.Role.SystemAdminRole;
import Business.Role.Role;
import java.util.ArrayList;

/**
 *
 * @author Eva
 */
public class SysAdminOrganization extends Organization{
    public SysAdminOrganization() {
        super(Organization.Type.SysAdmin.getValue());
    }

    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roles = new ArrayList();
        roles.add(new SystemAdminRole());
        return roles;
    }
}
