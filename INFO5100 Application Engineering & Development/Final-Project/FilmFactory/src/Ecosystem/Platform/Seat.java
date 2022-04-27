/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Platform;

/**
 *
 * @author huangrongjing
 */
public class Seat {
    public String name;
    public boolean isAva;

    public Seat(String name) {
        this.name = name;
        this.isAva = true;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isIsAva() {
        return isAva;
    }

    public void setIsAva(boolean isAva) {
        this.isAva = isAva;
    }
    
    
}
