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
public class Admin {
    
    private CarCatalog carCatalog;

    public Admin() {
        carCatalog = new CarCatalog();
    }


    public CarCatalog getCarCatalog() {
        return carCatalog;
    }

    public void setCarCatalog(CarCatalog carCatalog) {
        this.carCatalog = carCatalog;
    }
    
}
