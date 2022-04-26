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
public class Community {
    private String communityName;
    private String cityName;
    private ArrayList<House> houseList=new ArrayList<House>();
    
    public Community() {
    }

    public Community(String cityName) {
        this.cityName = cityName;
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

    public ArrayList<House> getHouseList() {
        return houseList;
    }

    public void setHouseList(ArrayList<House> houseList) {
        this.houseList = houseList;
    }
    
    public House newHouse(){
        House newHouse = new House();
        newHouse.setCommunityName(communityName);
        newHouse.setCityName(cityName);
        houseList.add(newHouse); 
        return newHouse;
    }
    
}
