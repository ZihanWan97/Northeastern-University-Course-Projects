/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.WorkQueue;

import Ecosystem.Enterprise.Enterprise;
import Ecosystem.Movie.Movie;
import Ecosystem.UserAccount.UserAccount;
import java.util.Date;

/**
 *
 * @author huangrongjing
 */
public class TicketRequest {
    public Movie movie;
    public String price;
    public Enterprise enterprise;
    //public Date date;
    public UserAccount customer;
    public UserAccount cinema;
    public String ID;
    public String time;
    public String comment;

    public TicketRequest() {
        this.ID = this.getRandomNumberByNum(6);
        this.comment = " ";
    }

    
    @Override
    public String toString() {
        return ID;
    }
    
    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public UserAccount getCustomer() {
        return customer;
    }

    public void setCustomer(UserAccount customer) {
        this.customer = customer;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }
    
    public static String getRandomNumberByNum(int num) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < num; i++) {
            long randomNum = Math.round(Math.floor(Math.random() * 10.0D));
            sb.append(randomNum);
        }
        return sb.toString();
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public UserAccount getCinema() {
        return cinema;
    }

    public void setCinema(UserAccount cinema) {
        this.cinema = cinema;
    }
    
    
    
}
