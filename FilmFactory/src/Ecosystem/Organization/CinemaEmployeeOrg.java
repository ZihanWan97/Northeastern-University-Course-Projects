/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Organization;

import Ecosystem.Role.CinemaEmployeeRole;
import Ecosystem.Role.Role;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class CinemaEmployeeOrg extends Organization{

    public CinemaEmployeeOrg() {
        super(Organization.Type.CinemaEmployee.getValue());
    }
    
    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roles = new ArrayList();
        roles.add(new CinemaEmployeeRole());
        return roles;
    }
}
