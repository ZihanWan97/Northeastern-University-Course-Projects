/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.WorkQueue;

import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class CinemaQueue {
    private ArrayList<CinemaRequest> cinemaRequestList;

    public CinemaQueue() {
        cinemaRequestList = new ArrayList();
    }

    public ArrayList<CinemaRequest> getCinemaRequestList() {
        return cinemaRequestList;
    }

    public void setCinemaRequestList(ArrayList<CinemaRequest> cinemaRequestList) {
        this.cinemaRequestList = cinemaRequestList;
    }
    
    public CinemaRequest addCinemaRequest(String name) {
        CinemaRequest cinemaRequest = new CinemaRequest(name);
        cinemaRequestList.add(cinemaRequest);
        return cinemaRequest;
    }
    
    public void addCinemaRequest(CinemaRequest cinemaRequest) {
        cinemaRequestList.add(cinemaRequest);
    }
    
    public void removecinemaRequest (CinemaRequest crq) {
        cinemaRequestList.remove(crq);
    }
}
