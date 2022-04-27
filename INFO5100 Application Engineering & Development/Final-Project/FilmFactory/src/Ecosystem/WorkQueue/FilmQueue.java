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
public class FilmQueue {
    private ArrayList<FilmRequest> filmRequestList;

    public FilmQueue() {
        filmRequestList = new ArrayList();
    }

    public ArrayList<FilmRequest> getFilmRequestList() {
        return filmRequestList;
    }

    public void setFilmRequestList(ArrayList<FilmRequest> filmRequestList) {
        this.filmRequestList = filmRequestList;
    }
    
    public FilmRequest addFilmRequest() {
        FilmRequest filmRequest = new FilmRequest();
        filmRequestList.add(filmRequest);
        return filmRequest;
    }
    
    public void removeFilmRequest(FilmRequest frq) {
        filmRequestList.remove(frq);
    }
}
