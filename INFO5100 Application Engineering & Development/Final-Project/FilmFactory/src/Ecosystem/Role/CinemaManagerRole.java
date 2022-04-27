/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.Platform.RoomDirectory;
import Ecosystem.FilmFactorySystem;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.PlatformAdmin.CinemaAdminWorkAreaJPanel;


/**
 *
 * @author huangrongjing
 */
public class CinemaManagerRole extends Role{
    
    public CinemaManagerRole() {
        this.type = RoleType.CinemaManager;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new CinemaAdminWorkAreaJPanel(userProcessContainer, account, system);
    }
    
}
