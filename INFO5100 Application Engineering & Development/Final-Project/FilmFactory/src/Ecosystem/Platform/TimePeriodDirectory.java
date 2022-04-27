/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ecosystem.Platform;

import java.util.ArrayList;

/**
 *
 * @author huangrongjing
 */
public class TimePeriodDirectory {
    private ArrayList<TimePeriod> timePeriodList;

    public TimePeriodDirectory() {
        this.timePeriodList = new ArrayList<TimePeriod>(5);
        this.timePeriodList.add(new TimePeriod("10:00 -- 13:00")); 
        this.timePeriodList.add(new TimePeriod("13:00 -- 16:00"));
        this.timePeriodList.add(new TimePeriod("16:00 -- 19:00"));
        this.timePeriodList.add(new TimePeriod("19:00 -- 22:00"));
        this.timePeriodList.add(new TimePeriod("22:00 -- 01:00"));
    }

    public ArrayList<TimePeriod> getTimePeriodList() {
        return timePeriodList;
    }

    public void setTimePeriodList(ArrayList<TimePeriod> timePeriodList) {
        this.timePeriodList = timePeriodList;
    }
    
}
