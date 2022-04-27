/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.FilmFactorySystem;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.PlatformEmployee.CinemaEmployeeWorkAreaJPanel;

/**
 *
 * @author huangrongjing
 */
public class CinemaEmployeeRole extends Role{

    public CinemaEmployeeRole() {
        this.type = RoleType.CinemaEmployee;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new CinemaEmployeeWorkAreaJPanel(userProcessContainer, account, system);
    }
    
}
