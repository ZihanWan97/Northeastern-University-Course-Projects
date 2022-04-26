/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Eva
 */
public class Person {
    private int personId;
    private String personName;
    private Integer personAge;
    private House house;
    private String ageGroup;
    
    private static int id = 0;
    
    @Override
    public String toString() {
        return personName;
    }
    
    
    public Person() {
        id++;
        personId = id;
     
    } 

    public int getPersonId() {
        return personId;
    }

    public void setPersonId(int personId) {
        this.personId = personId;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public Integer getPersonAge() {
        return personAge;
    }

    public void setPersonAge(Integer personAge) {
        this.personAge = personAge;
        setAgeGroup(personAge);
    }


    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public String getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(String ageGroup) {
        this.ageGroup = ageGroup;
        
    }

    public void setAgeGroup(int personage) {
        if (personage < 18) {
            this.ageGroup = "0 - 17";
        } else if (personage >= 18 && personage <= 65) {
            this.ageGroup = "18 - 65";
        } else if (personage>= 66 && personage <= 79) {
            this.ageGroup = "66 - 79";
        } else if (personage>= 80 && personage <= 100) {
            this.ageGroup = "80 - 100";
        }
    }

    
    
    



    

    
    
    
    



    
    
    
}


