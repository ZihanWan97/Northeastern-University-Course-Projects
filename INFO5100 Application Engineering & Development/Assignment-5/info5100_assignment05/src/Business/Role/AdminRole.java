/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.Role;

import Business.EcoSystem;

import Business.Organization;
import Business.UserAccount.UserAccount;
import userinterface.RestaurantAdminRole.AdminWorkAreaJPanel;
import javax.swing.JPanel;

/**
 *
 * @author Eva
 */
public class AdminRole extends Role{

    public AdminRole() {
        this.type = RoleType.RestaurantAdmin;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, EcoSystem ecoSystem) {
        return new AdminWorkAreaJPanel(userProcessContainer,account,ecoSystem);
    }

    
    
}
