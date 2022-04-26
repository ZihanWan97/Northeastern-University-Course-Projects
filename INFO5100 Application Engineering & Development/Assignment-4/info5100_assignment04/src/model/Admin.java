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
public class Admin {
        private PatientDirectory patientDirectory;
        private PersonDirectory personDirectory;
        private ArrayList<City> cityList;
        private City city;
        
        
        public Admin() {
            personDirectory = new PersonDirectory();
            patientDirectory = new PatientDirectory();
            city = new City("Boston");
    }
        
        public Admin(PatientDirectory patientDirectory, PersonDirectory personDirectory) {
            this.patientDirectory = patientDirectory;
            this.personDirectory = personDirectory;
        }
    
    
        public Admin(PatientDirectory patientDirectory, PersonDirectory personDirectory, City city) {
            this.patientDirectory = patientDirectory;
            this.personDirectory = personDirectory;
            this.city = city;
        }
        
        public PatientDirectory getPatientDirectory() {
            return patientDirectory;
        }
        
        public PersonDirectory getPersonDirectory() {
            return personDirectory;
        } 

        public City getCity() {
            return city;
        }
        
        public ArrayList<City> getCityList() {
            return cityList;
         }
        
        public void setCityList(ArrayList<City> cityList) {
        this.cityList = cityList;
         }
        
        public void setPatientDirectory(PatientDirectory patientDirectory) {
        this.patientDirectory = patientDirectory;
        }
        
        public void setPersonDirectory(PersonDirectory personDirectory) {
        this.personDirectory = personDirectory;
        }
        
        public void setCity(City city) {
        this.city = city;
        }
        

        
    
}
