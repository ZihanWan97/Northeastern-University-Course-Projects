/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem;

import Ecosystem.Network.Network;
import Ecosystem.Organization.Organization;
import Ecosystem.Role.Role;
import Ecosystem.Role.SystemAdminRole;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class FilmFactorySystem extends Organization{
    private static FilmFactorySystem business;
    private ArrayList<Network> networkList;
    
    public static FilmFactorySystem getInstance() {
        if (business == null) {
            business = new FilmFactorySystem();
        }
        return business;
    }
    
    public Network createAndAddNetwork() {
        Network network = new Network();
        networkList.add(network);
        return network;
    }
    
    @Override
    public ArrayList<Role> getSupportedRole() {
        ArrayList<Role> roleList = new ArrayList<Role>();
        roleList.add(new SystemAdminRole());
        return roleList;
    }
    
    private FilmFactorySystem() {
        super(null);
        networkList = new ArrayList<Network>();
    }

    public ArrayList<Network> getNetworkList() {
        return networkList;
    }

    public void setNetworkList(ArrayList<Network> networkList) {
        this.networkList = networkList;
    }
    
    public boolean checkIfUserIsUnique(String userName){
        if(!this.getUserAccountDirectory().checkIfUsernameIsUnique(userName)){
            return false;
        }
        for(Network network:networkList){
            
        }
        return true;
    }
}
