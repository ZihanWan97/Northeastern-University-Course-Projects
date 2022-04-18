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
public class CarCatalog {
    
    private List<Car> carCatalog;

    public CarCatalog() {
        carCatalog = new ArrayList<Car>();
    }

    public List<Car> getCarcatalog() {
        return carCatalog;
    }

    public Car addCar() {
        Car c = new Car();
        carCatalog.add(c);
        return c;
    }
    
    public void removeCar(Car c) {
        carCatalog.remove(c);
    }    

    

    
}