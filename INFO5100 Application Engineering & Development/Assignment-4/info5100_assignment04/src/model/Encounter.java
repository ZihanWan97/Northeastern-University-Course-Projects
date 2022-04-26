/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Eva
 */
public class Encounter extends VitalSigns{
    private String encounterId;
    private String time;
    
    
    private static int id = 0;
    
    @Override
    public String toString() {
        return encounterId;
    }
    
    public Encounter() {
        id++;
        encounterId = String.valueOf(id);  
    }

    public String getEncounterId() {
        return encounterId;
    }

    public void setEncounterId(String encounterId) {
        this.encounterId = encounterId;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    } 
    
    
    
}
