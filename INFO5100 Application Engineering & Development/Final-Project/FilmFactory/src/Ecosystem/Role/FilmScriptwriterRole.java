/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Role;

import Ecosystem.FilmFactorySystem;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import javax.swing.JPanel;
import ui.FilmScriptwriter.FilmScriptwriterWorkAreaJPanel;

/**
 *
 * @author huangrongjing
 */
public class FilmScriptwriterRole extends Role{

    public FilmScriptwriterRole() {
        this.type = RoleType.FilmScriptwriter;
    }
    
    @Override
    public JPanel createWorkArea(JPanel userProcessContainer, UserAccount account, Organization organization, FilmFactorySystem system) {
        
        return new FilmScriptwriterWorkAreaJPanel(userProcessContainer, account, system);
    }
}
