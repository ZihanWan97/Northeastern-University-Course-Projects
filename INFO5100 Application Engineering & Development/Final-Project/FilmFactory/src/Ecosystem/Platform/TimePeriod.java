/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Platform;
import Ecosystem.Enterprise.CinemaEn;
import Ecosystem.Movie.Movie;
import Ecosystem.Movie.MovieDirectory;
import java.util.Date;

/**
 *
 * @author huangrongjing
 */
public class TimePeriod {

    public String time;
    public MovieDirectory movieList;
    
    public TimePeriod(String time) {
        this.time = time;
        movieList = new MovieDirectory();
    }
    
    @Override
    public String toString() {
        return time; 
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public MovieDirectory getMovieList() {
        return movieList;
    }

    public void setMovieList(MovieDirectory movieList) {
        this.movieList = movieList;
    }
}
