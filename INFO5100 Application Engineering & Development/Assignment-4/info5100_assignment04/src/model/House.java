/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author Eva
 */
public class House {
    private String houseName;
    private String communityName;
    private String cityName;
    private ArrayList<Person> residenceList=new ArrayList<Person>();
    
    public House() {
    }

    public House(String houseName) {
        this.houseName = houseName;
    }    

    public String getHouseName() {
        return houseName;
    }

    public void setHouseName(String houseName) {
        this.houseName = houseName;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public ArrayList<Person> getResidenceList() {
        return residenceList;
    }

    public void setResidenceList(ArrayList<Person> residenceList) {
        this.residenceList = residenceList;
    }
    
    

    
    
    
    
    
}
