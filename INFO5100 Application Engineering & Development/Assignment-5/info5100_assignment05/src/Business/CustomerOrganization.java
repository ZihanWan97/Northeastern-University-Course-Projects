/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business;

import Business.Role.CustomerRole;
import Business.Role.Role;
import java.util.ArrayList;
/**
 *
 * @author Eva
 */
public class CustomerOrganization extends Organization{
    public CustomerOrganization() {
        super(Type.Customer.getValue());
    }

    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roles = new ArrayList<>();
        roles.add(new CustomerRole());
        return roles;
    }
}
