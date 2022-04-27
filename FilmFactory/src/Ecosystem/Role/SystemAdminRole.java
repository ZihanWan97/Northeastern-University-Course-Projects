/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.FilmFactorySystem;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.SystemAdmin.SystemAdminWorkAreaJPanel;

/**
 *
 * @author huangrongjing
 */
public class SystemAdminRole extends Role{

    public SystemAdminRole() {
        this.type = RoleType.SystemAdmin;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new SystemAdminWorkAreaJPanel(userProcessContainer, system);
    }
}
