/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Enterprise;

import java.util.ArrayList;
import static javax.management.Query.or;

/**
 *
 * @author huangrongjing
 */
public class EnterpriseDirectory {
    private ArrayList<Enterprise> enterpriseList;
   

    public ArrayList<Enterprise> getEnterpriseList() {
        return enterpriseList;
    }

    public void setEnterpriseList(ArrayList<Enterprise> enterpriseList) {
        this.enterpriseList = enterpriseList;
    }
    
    public EnterpriseDirectory(){
        enterpriseList=new ArrayList<Enterprise>();
    }
    
    //Create enterprise
    public Enterprise createAndAddEnterprise(String name, Enterprise.EnterpriseType type){
        Enterprise enterprise = null;
        if (type == Enterprise.EnterpriseType.CinemaEn){
            enterprise = new CinemaEn(name);
            enterpriseList.add(enterprise);
        } else if (type == Enterprise.EnterpriseType.CustomerEn){
            enterprise = new CustomerEn(name);
            enterpriseList.add(enterprise);
        } else if (type == Enterprise.EnterpriseType.FilmEn) {
            enterprise = new FilmEn(name);
            enterpriseList.add(enterprise);
        } else if (type == Enterprise.EnterpriseType.ReviewEn) {
            enterprise = new ReviewEn(name);
            enterpriseList.add(enterprise);
        } else if (type == Enterprise.EnterpriseType.SystemAdminEn) {
            enterprise = new SystemAdminEn(name);
            enterpriseList.add(enterprise);
        }
        return enterprise;
    }
}
