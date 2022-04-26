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
public class PatientDirectory {
    private List<Patient> patientDirectory;
    
    public PatientDirectory() {
        patientDirectory = new ArrayList<Patient>();
    }

    public List<Patient> getPatientDirectory() {
        return patientDirectory;
    }

    public void setPatientDirectory(List<Patient> patientDirectory) {
        this.patientDirectory = patientDirectory;
    }


    public Patient addPatient() {
        Patient p = new Patient();
        patientDirectory.add(p);
        return p;
    }
    
    public void removePatient(Patient p) {
        patientDirectory.remove(p);
    }
    
    public void addPatient(Patient p) {
        patientDirectory.add(p);
    }

    
    
    
}


