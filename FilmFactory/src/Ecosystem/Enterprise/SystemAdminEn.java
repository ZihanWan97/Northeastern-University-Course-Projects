/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Enterprise;

import Ecosystem.Role.Role;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class SystemAdminEn extends Enterprise{

    public SystemAdminEn(String name) {
        super(name, EnterpriseType.SystemAdminEn);
    }
    
    @Override
    public ArrayList<Role> getSupportedRole() {
        return null;
    }
}
