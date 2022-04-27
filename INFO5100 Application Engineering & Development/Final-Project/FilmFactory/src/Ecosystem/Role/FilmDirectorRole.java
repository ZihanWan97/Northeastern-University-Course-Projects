/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.FilmFactorySystem;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.FilmDirector.FilmDirectorWorkAreaJPanel;

/**
 *
 * @author huangrongjing
 */
public class FilmDirectorRole extends Role{

    public FilmDirectorRole() {
        this.type = RoleType.FilmDirector;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new FilmDirectorWorkAreaJPanel(userProcessContainer, account, system);
    }
}
