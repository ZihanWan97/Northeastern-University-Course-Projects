/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.WorkQueue;

import Ecosystem.Enterprise.Enterprise;
import Ecosystem.Movie.Movie;
import Ecosystem.UserAccount.UserAccount;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author huangrongjing
 */
public class FilmRequest {
    private Movie movie;
    private UserAccount filmAdin;
    private UserAccount director;
    private List<UserAccount> actorCatalog;
    private UserAccount cameraMan;
    private UserAccount scriptwriter;
    private UserAccount reviewAdmin;
    private UserAccount reviewAuditor;
    private UserAccount cinemaAdmin;
    private UserAccount cinemaEmployee;
    private String status;
    private String ID;
    private static int count = 0;
    private List<Enterprise> cinemaList;

    public FilmRequest() {
        count++;
        //ID = String.valueOf(count);
        ID = this.getRandomNumberByNum(6);
        cinemaList = new ArrayList();
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

    public UserAccount getFilmAdin() {
        return filmAdin;
    }

    public void setFilmAdin(UserAccount filmAdin) {
        this.filmAdin = filmAdin;
    }

    public UserAccount getDirector() {
        return director;
    }

    public void setDirector(UserAccount director) {
        this.director = director;
    }

    public List<UserAccount> getActorCatalog() {
        return actorCatalog;
    }

    public void setActorCatalog(List<UserAccount> actorCatalog) {
        this.actorCatalog = actorCatalog;
    }

    public UserAccount getCameraMan() {
        return cameraMan;
    }

    public void setCameraMan(UserAccount cameraMan) {
        this.cameraMan = cameraMan;
    }

    public UserAccount getScriptwriter() {
        return scriptwriter;
    }

    public void setScriptwriter(UserAccount scriptwriter) {
        this.scriptwriter = scriptwriter;
    }

    public UserAccount getReviewAdmin() {
        return reviewAdmin;
    }

    public void setReviewAdmin(UserAccount reviewAdmin) {
        this.reviewAdmin = reviewAdmin;
    }

    public UserAccount getReviewAuditor() {
        return reviewAuditor;
    }

    public void setReviewAuditor(UserAccount reviewAuditor) {
        this.reviewAuditor = reviewAuditor;
    }

    public UserAccount getCinemaAdmin() {
        return cinemaAdmin;
    }

    public void setCinemaAdmin(UserAccount cinemaAdmin) {
        this.cinemaAdmin = cinemaAdmin;
    }

    public UserAccount getCinemaEmployee() {
        return cinemaEmployee;
    }

    public void setCinemaEmployee(UserAccount cinemaEmployee) {
        this.cinemaEmployee = cinemaEmployee;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public List<Enterprise> getCinemaList() {
        return cinemaList;
    }

    public void setCinemaList(List<Enterprise> cinemaList) {
        this.cinemaList = cinemaList;
    }
    
    public void addCinemaEn(Enterprise en) {
        cinemaList.add(en);
    }
    
    public static String getRandomNumberByNum(int num) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < num; i++) {
            long randomNum = Math.round(Math.floor(Math.random() * 10.0D));
            sb.append(randomNum);
        }
        return sb.toString();
    }
    
    
}
