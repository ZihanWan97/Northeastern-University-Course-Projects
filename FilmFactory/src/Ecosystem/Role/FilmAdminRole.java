/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.FilmFactorySystem;
import Ecosystem.Movie.MovieDirectory;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.FilmAdmin.FilmAdminWorkAreaJPanel;


/**
 *
 * @author huangrongjing
 */
public class FilmAdminRole extends Role{
    public FilmAdminRole() {
        this.type = RoleType.FilmAdmin;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new FilmAdminWorkAreaJPanel(userProcessContainer, account, system);
    }
}
