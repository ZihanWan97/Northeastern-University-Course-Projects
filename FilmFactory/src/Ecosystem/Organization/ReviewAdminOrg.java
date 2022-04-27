/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Organization;

import Ecosystem.Role.ReviewAdminRole;
import Ecosystem.Role.Role;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class ReviewAdminOrg extends Organization {

    public ReviewAdminOrg() {
        super(Organization.Type.ReviewAdmin.getValue());
    }
    
    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roles = new ArrayList();
        roles.add(new ReviewAdminRole());
        return roles;
    }
}
