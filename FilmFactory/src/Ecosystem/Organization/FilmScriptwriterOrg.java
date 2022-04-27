/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Organization;

import Ecosystem.Role.FilmAdminRole;
import Ecosystem.Role.FilmScriptwriterRole;
import Ecosystem.Role.Role;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class FilmScriptwriterOrg extends Organization{
    public FilmScriptwriterOrg() {
        super(Organization.Type.FilmScriptwriter.getValue());
    }
    
    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roles = new ArrayList();
        roles.add(new FilmScriptwriterRole());
        return roles;
    }
}
