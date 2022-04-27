/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Organization;

import Ecosystem.Employee.EmployeeDirectory;
import Ecosystem.Role.Role;
import Ecosystem.WorkQueue.FilmQueue;
import Ecosystem.UserAccount.UserAccountDirectory;
import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public abstract class Organization {
    private String name;
    private FilmQueue workQueue;
    private EmployeeDirectory employeeDirectory;
    private UserAccountDirectory userAccountDirectory;
    private int organizationID;
    private static int counter=0;
    
    public enum Type{
        CinemaEmployee("CinemaEmployee"),
        CinemaManager("CinemaManager"),
        CinemaRoom("CinemaRoom"),
        Customer("Customer"),
        FilmActor("FilmActor"),
        FilmAdmin("FilmAdmin"),
        FilmDirector("FilmDirector"),
        FilmScriptwriter("FilmScriptwriter"),
        FilmShoot("FilmShoot"),
        ReviewAdmin("ReviewAdmin"),
        ReviewAuditor("ReviewAuditor"),
        SystemAdmin("SystemAdmin");
        
        private String value;
        private Type(String value) {
            this.value = value;
        }
        public String getValue() {
            return value;
        }
    }
    
    public Organization(String name) {
        this.name = name;
        workQueue = new FilmQueue();
        employeeDirectory = new EmployeeDirectory();
        userAccountDirectory = new UserAccountDirectory();
        organizationID = counter;
        ++counter;
    }

    public abstract ArrayList<Role> getSupportedRole();
    
    public UserAccountDirectory getUserAccountDirectory() {
        return userAccountDirectory;
    }

    public int getOrganizationID() {
        return organizationID;
    }

    public EmployeeDirectory getEmployeeDirectory() {
        return employeeDirectory;
    }
    
    public String getName() {
        return name;
    }

    public FilmQueue getWorkQueue() {
        return workQueue;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setWorkQueue(FilmQueue workQueue) {
        this.workQueue = workQueue;
    }

    @Override
    public String toString() {
        return name;
    }
}
