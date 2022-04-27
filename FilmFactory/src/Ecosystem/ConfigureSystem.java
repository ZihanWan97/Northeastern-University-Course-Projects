/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem;

import Ecosystem.Employee.Employee;
import Ecosystem.Enterprise.Enterprise;
import Ecosystem.Network.Network;
import Ecosystem.Organization.Organization;
import Ecosystem.Role.ReviewAdminRole;
import Ecosystem.Role.SystemAdminRole;
import Ecosystem.UserAccount.UserAccount;

/**
 *
 * @author huangrongjing
 */
public class ConfigureSystem {
    
    public static FilmFactorySystem configure() {
        FilmFactorySystem system = FilmFactorySystem.getInstance();
        Network network = system.createAndAddNetwork();
        network.setName("FilmFactoryNetwork");
        Enterprise systemAdminEn = network.getEnterpriseDirectory().createAndAddEnterprise("systemAdminEn", Enterprise.EnterpriseType.SystemAdminEn);
        Organization systemAdminOrg = systemAdminEn.getOrganizationDirectory().createOrganization(Organization.Type.SystemAdmin);
        UserAccount sysadmin = systemAdminOrg.getUserAccountDirectory().createUserAccount("sysadmin", "sysadmin", new SystemAdminRole());
        
        Enterprise customerEn = network.getEnterpriseDirectory().createAndAddEnterprise("CustomerEn", Enterprise.EnterpriseType.CustomerEn);
        Organization customerOrg = customerEn.getOrganizationDirectory().createOrganization(Organization.Type.Customer);
        
        Enterprise reviewEn = network.getEnterpriseDirectory().createAndAddEnterprise("reviewEn", Enterprise.EnterpriseType.ReviewEn);
        Organization reviewOrg = reviewEn.getOrganizationDirectory().createOrganization(Organization.Type.ReviewAdmin);
        reviewOrg.setName("ReviewAdminOrg");
        Organization reviewAuditorOrg = reviewEn.getOrganizationDirectory().createOrganization(Organization.Type.ReviewAuditor);
        reviewAuditorOrg.setName("ReviewAuditorOrg");
        UserAccount reviewAdmin = reviewOrg.getUserAccountDirectory().createUserAccount("rad", "rad", new ReviewAdminRole());
        //Employee employee = system.getEmployeeDirectory().createEmployee("sysadmin");
        //UserAccount ua = system.getUserAccountDirectory().createUserAccount("sysadmin", "sysadmin", new SystemAdminRole());
        
        return system;
    }
    
}
