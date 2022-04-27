/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.FilmFactorySystem;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.Customer.CustomerWorkAreaJPanel;

/**
 *
 * @author huangrongjing
 */
public class CustomerRole extends Role{

    public CustomerRole() {
        this.type = RoleType.Customer;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new CustomerWorkAreaJPanel(userProcessContainer, account, system);
    }
}
