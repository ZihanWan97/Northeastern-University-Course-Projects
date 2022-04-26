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
public class Patient extends Person{
    private EncounterHistory encounterHistory;
    
    public Patient() {
        encounterHistory = new EncounterHistory();
        
    }
    
    public EncounterHistory getEncounterHistory() {
        return encounterHistory;
    }
    
    public void setEncounterHistory(EncounterHistory encounterHistory) {
        this.encounterHistory = encounterHistory;
    }


    
    
    
    



    


    
}
