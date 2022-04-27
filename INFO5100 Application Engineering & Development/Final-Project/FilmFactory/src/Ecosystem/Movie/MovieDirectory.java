/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Movie;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author huangrongjing
 */
public class MovieDirectory {
    private ArrayList<Movie> movieList;
    //private int movieCount;

    public MovieDirectory() {
        movieList = new ArrayList<Movie>();
        //movieCount = movieList.size();
    }
    
    public ArrayList<Movie> getMovieList() {
        return movieList;
    }

    public void setMovieList(ArrayList<Movie> movieList) {
        this.movieList = movieList;
    }
    
    public Movie createMovie(String name) {
        Movie movie = new Movie(name);
        //movie.setID(String.valueOf(movieCount));
        movieList.add(movie);
        return movie;
    }
    
    public void createMovie(Movie movie) {
        this.movieList.add(movie);
    }
    
    public void removeMovie(Movie moive) {
        this.movieList.remove(moive);
    }
    
//    public Movie createMovie() {
//        Movie movie = new Movie();
//        movieList.add(movie);
//        return movie;
//    }
}
