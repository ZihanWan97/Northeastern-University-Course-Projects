/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Organization;

import Ecosystem.Role.CinemaEmployeeRole;
import Ecosystem.Role.Role;
import Ecosystem.Role.SystemAdminRole;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class SystemAdminOrg extends Organization{

    public SystemAdminOrg() {
        super(Organization.Type.SystemAdmin.getValue());
    }
    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roles = new ArrayList();
        roles.add(new SystemAdminRole());
        return roles;
    }
}
