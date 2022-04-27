/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Organization;

import Ecosystem.Organization.Organization.Type;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class OrganizationDirectory {
    private ArrayList<Organization> organizationList;
    
    public OrganizationDirectory() {
        organizationList = new ArrayList();
    }

    public ArrayList<Organization> getOrganizationList() {
        return organizationList;
    }
    
    public Organization createOrganization(Type type) {
        Organization organization = null;
        if (type.getValue().equals(Type.CinemaEmployee.getValue())){
            organization = new CinemaEmployeeOrg();
            organizationList.add(organization);
        }
        else if (type.getValue().equals(Type.CinemaManager.getValue())){
            organization = new CinemaManagerOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.FilmAdmin.getValue())) {
            organization = new FilmAdminOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.FilmDirector.getValue())) {
            organization = new FilmDirectorOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.FilmScriptwriter.getValue())) {
            organization = new FilmScriptwriterOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.FilmShoot.getValue())) {
            organization = new FilmShootOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.ReviewAuditor.getValue())) {
            organization = new ReviewAuditorOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.SystemAdmin.getValue())) {
            organization = new SystemAdminOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.ReviewAdmin.getValue())) {
            organization = new ReviewAdminOrg();
            organizationList.add(organization);
        } else if (type.getValue().equals(Type.Customer.getValue())) {
            organization = new CustomerOrg();
            organizationList.add(organization);
        }
        
        return organization;
    }
}
