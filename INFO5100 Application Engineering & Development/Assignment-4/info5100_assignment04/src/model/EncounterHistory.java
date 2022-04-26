/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author Eva
 */
public class EncounterHistory {
        private List<Encounter> encounterHistory;
        
        public EncounterHistory() {
            encounterHistory = new ArrayList<Encounter>();
        }

    public List<Encounter> getEncounterHistory() {
        return encounterHistory;
    }

    public void setEncounterHistory(List<Encounter> encounterHistory) {
        this.encounterHistory = encounterHistory;
    }
    
    public Encounter addEncounter() {
        Encounter e = new Encounter();
        encounterHistory.add(e);
        return e;
         }
    
        public void removeEncounter(Encounter e) {
            encounterHistory.remove(e);
         }  
        
    public Encounter getCurrentEn(){
        int num = encounterHistory.size()-1;
        return encounterHistory.get(num);
        
    }       

         
        

        
    
}
