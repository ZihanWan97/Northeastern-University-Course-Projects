/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Platform;

import Ecosystem.Enterprise.CinemaEn;
import Ecosystem.Movie.Movie;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class Room {
    public int counter;
    public String ID;
    public int seatCount;
    public boolean isAvailable;
    public String status;
    public Movie sreenMovie;
    public int avaSeat;
    public TimePeriodDirectory timePeriodList;
    public SeatDirectory seatDirectory;
    
    
    public Room(String ID) {
        this.ID = ID;
        this.seatCount = 15;
        this.avaSeat = seatCount;
        this.isAvailable = true;
        this.status = "Available";
        this.seatDirectory = new SeatDirectory();
        this.timePeriodList = new TimePeriodDirectory();
    }

    public int getCounter() {
        return counter;
    }

    public void setCounter(int counter) {
        this.counter = counter;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public int getSeatCount() {
        return seatCount;
    }

    public void setSeatCount(int seatCount) {
        this.seatCount = seatCount;
    }

    public boolean isIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
        if (isAvailable == false) {
            this.status = "Not Available";
        } else {
            this.status = "Available";
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Movie getSreenMovie() {
        return sreenMovie;
    }

    public void setSreenMovie(Movie sreenMovie) {
        this.sreenMovie = sreenMovie;
    }

    public int getAvaSeat() {
        return avaSeat;
    }

    public void setAvaSeat(int avaSeat) {
        this.avaSeat = avaSeat;
    }
    
    @Override
    public String toString() {
        return ID; 
    }

    public TimePeriodDirectory getTimePeriodList() {
        return timePeriodList;
    }

    public void setTimePeriodList(TimePeriodDirectory timePeriodList) {
        this.timePeriodList = timePeriodList;
    }

    

    public SeatDirectory getSeatDirectory() {
        return seatDirectory;
    }

    public void setSeatDirectory(SeatDirectory seatDirectory) {
        this.seatDirectory = seatDirectory;
    }
    
    
}
