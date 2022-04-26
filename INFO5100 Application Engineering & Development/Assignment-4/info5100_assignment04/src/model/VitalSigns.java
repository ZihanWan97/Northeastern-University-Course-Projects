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
public class VitalSigns {
    private int systolicPressure;
    private int diastolicPressure;
    private Boolean isNormal;
    

    
    public int getSystolicPressure() {
        return systolicPressure;
    }

    public void setSystolicPressure(int systolicPressure) {
        this.systolicPressure = systolicPressure;
    }

    public int getDiastolicPressure() {
        return diastolicPressure;
    }

    public void setDiastolicPressure(int diastolicPressure) {
        this.diastolicPressure = diastolicPressure;
    }

    public Boolean getIsNormal() {
        return isNormal;
    }

    public void setIsNormal(Boolean isNormal) {
        this.isNormal = isNormal;
    }
    
    public void setIsNormal() {
        if (this.systolicPressure <=139 && this.systolicPressure >=90 && this.diastolicPressure >=60 && this.diastolicPressure <= 89) {
            this.isNormal = true;
        } else {
            this.isNormal = false;
        }
  
    }
    


    
}
