/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Enterprise;

import Ecosystem.Platform.RoomDirectory;
import Ecosystem.Platform.TimePeriodDirectory;
import Ecosystem.Role.Role;
import java.util.ArrayList;



/**
 *
 * @author huangrongjing
 */
public class CinemaEn extends Enterprise{
    
    public RoomDirectory roomDirectory;
    public TimePeriodDirectory timePeriodDirectory;
    
    public CinemaEn(String name) {
        super(name, EnterpriseType.CinemaEn);
        this.roomDirectory = new RoomDirectory();
        this.timePeriodDirectory = new TimePeriodDirectory();
    }
    
    @Override
    public ArrayList<Role> getSupportedRole() {
        return null;
    }

    public RoomDirectory getRoomDirectory() {
        return roomDirectory;
    }

    public void setRoomDirectory(RoomDirectory roomDirectory) {
        this.roomDirectory = roomDirectory;
    }

    public TimePeriodDirectory getTimePeriodDirectory() {
        return timePeriodDirectory;
    }

    public void setTimePeriodDirectory(TimePeriodDirectory timePeriodDirectory) {
        this.timePeriodDirectory = timePeriodDirectory;
    }
    
    
}
