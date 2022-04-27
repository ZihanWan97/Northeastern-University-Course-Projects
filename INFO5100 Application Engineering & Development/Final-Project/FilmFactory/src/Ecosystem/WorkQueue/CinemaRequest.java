/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.WorkQueue;

import Ecosystem.Platform.Room;
import Ecosystem.Enterprise.Enterprise;
import Ecosystem.Movie.Movie;
import Ecosystem.UserAccount.UserAccount;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author huangrongjing
 */
public class CinemaRequest {
    private Movie movie;
    private Enterprise cinemaEn;
    private UserAccount cinemaAdmin;
    private List<UserAccount> cinemaEmployeeList;
    private String movieName;
    private Room room;
    private double price;
    
    public CinemaRequest(String movieName) {
        this.movieName = movieName;
        cinemaEmployeeList = new ArrayList();
    }
    
    @Override
    public String toString() {
        return movieName;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Enterprise getCinemaEn() {
        return cinemaEn;
    }

    public void setCinemaEn(Enterprise cinemaEn) {
        this.cinemaEn = cinemaEn;
    }

    public List<UserAccount> getCinemaEmployeeList() {
        return cinemaEmployeeList;
    }

    public void setCinemaEmployeeList(List<UserAccount> cinemaEmployeeList) {
        this.cinemaEmployeeList = cinemaEmployeeList;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }
    
    public void addEmployee(UserAccount em) {
        cinemaEmployeeList.add(em);
    }

    public UserAccount getCinemaAdmin() {
        return cinemaAdmin;
    }

    public void setCinemaAdmin(UserAccount cinemaAdmin) {
        this.cinemaAdmin = cinemaAdmin;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    
    
}
