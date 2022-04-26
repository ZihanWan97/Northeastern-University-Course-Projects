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
public class City {
    private String cityName;
    private ArrayList<Community> communityList=new ArrayList<Community>();
    
    
    public City(String name) {
        this.cityName = name;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }
    
    

    public ArrayList<Community> getCommunityList() {
        return communityList;
    }

    public void setCommunityList(ArrayList<Community> communityList) {
        this.communityList = communityList;
    }
    
    public Community newCommunity(){
        Community newCommunity=new Community();
        communityList.add(newCommunity);
        newCommunity.setCommunityName(cityName);
        return newCommunity;
    }
    
    public void newCommunity(Community com){
        communityList.add(com);
        com.setCommunityName(cityName);
    }
    
    
    
    
}
