/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.Role;

import Business.EcoSystem;
import Business.Organization;
import Business.UserAccount.UserAccount;
import javax.swing.JPanel;
import userinterface.DeliveryManRole.DeliveryManWorkAreaJPanel;

/**
 *
 * @author Eva
 */
public class DeliveryManRole extends Role {

    public DeliveryManRole() {
        this.type = RoleType.DeliveryMan;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, EcoSystem ecoSystem) {
        return new DeliveryManWorkAreaJPanel(userProcessContainer,account,ecoSystem);//To change body of generated methods, choose Tools | Templates.
    }
    
}
