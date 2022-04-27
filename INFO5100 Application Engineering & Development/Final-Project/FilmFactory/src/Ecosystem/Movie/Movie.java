/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Movie;

import Ecosystem.UserAccount.UserAccount;
import java.util.List;
import javax.swing.Icon;

/**
 *
 * @author huangrongjing
 */
public class Movie {
    private String name;
    private static int count = 0;
    private String ID;
    private String type;
    private String description;
    private Integer duration;
    private Icon poster;
    private String picPath;
    private UserAccount director;
    private List<String> actorCatalog;
    private UserAccount scriptwriter;
    private UserAccount cameraman;

    @Override
    public String toString() {
        return name; 
    }

    public Movie(String name) {
        this.name = name;
        count++;
        ID = String.valueOf(count);
    }
    
//    public Movie() {
//        count++;
//        ID = String.valueOf(count);
//    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }
    
    public Icon getPoster() {
        return poster;
    }

    public void setPoster(Icon poster) {
        this.poster = poster;
    }
    
    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }

    public UserAccount getDirector() {
        return director;
    }

    public void setDirector(UserAccount director) {
        this.director = director;
    }

    public List<String> getActorCatalog() {
        return actorCatalog;
    }

    public void setActorCatalog(List<String> actorCatalog) {
        this.actorCatalog = actorCatalog;
    }

    public UserAccount getScriptwriter() {
        return scriptwriter;
    }

    public void setScriptwriter(UserAccount scriptwriter) {
        this.scriptwriter = scriptwriter;
    }

    public UserAccount getCameraman() {
        return cameraman;
    }

    public void setCameraman(UserAccount cameraman) {
        this.cameraman = cameraman;
    }
}
