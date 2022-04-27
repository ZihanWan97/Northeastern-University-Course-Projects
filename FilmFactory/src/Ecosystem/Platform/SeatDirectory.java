/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Platform;

import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class SeatDirectory {
    private ArrayList<Seat> seatList;

    public SeatDirectory() {
        seatList =  new ArrayList<Seat>(15);
        seatList.add(new Seat("A1"));
        seatList.add(new Seat("A2"));
        seatList.add(new Seat("A3"));
        seatList.add(new Seat("A4"));
        seatList.add(new Seat("A5"));
        seatList.add(new Seat("B1"));
        seatList.add(new Seat("B2"));
        seatList.add(new Seat("B3"));
        seatList.add(new Seat("B4"));
        seatList.add(new Seat("B5"));
        seatList.add(new Seat("C1"));
        seatList.add(new Seat("C2"));
        seatList.add(new Seat("C3"));
        seatList.add(new Seat("C4"));
        seatList.add(new Seat("C5"));
    }
    
    

    public ArrayList<Seat> getSeatList() {
        return seatList;
    }

    public void setSeatList(ArrayList<Seat> seatList) {
        this.seatList = seatList;
    }
    
    
}
