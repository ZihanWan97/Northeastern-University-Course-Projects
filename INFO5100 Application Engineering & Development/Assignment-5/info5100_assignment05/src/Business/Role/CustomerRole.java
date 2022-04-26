/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.Role;

import Business.EcoSystem;

import Business.Organization;
import Business.UserAccount.UserAccount;
import userinterface.CustomerRole.CustomerAreaJPanel;
import javax.swing.JPanel;

/**
 *
 * @author Eva
 */
public class CustomerRole extends Role{

    public CustomerRole() {
        this.type = RoleType.Customer;
    }
    
    
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, EcoSystem ecoSystem) {
        return new CustomerAreaJPanel(userProcessContainer, account,ecoSystem);
    }
    
    
}
