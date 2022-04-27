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
public class TicketQueue {
    private ArrayList<TicketRequest> ticketRequestList;

    public TicketQueue() {
        ticketRequestList = new ArrayList();
    }

    public ArrayList<TicketRequest> getTicketRequestList() {
        return ticketRequestList;
    }

    public void setTicketRequestList(ArrayList<TicketRequest> ticketRequestList) {
        this.ticketRequestList = ticketRequestList;
    }
    
    public TicketRequest addTicketRequest() {
        TicketRequest ticketRequest = new TicketRequest();
        ticketRequestList.add(ticketRequest);
        return ticketRequest;
    }
    
    public void addTicketRequest(TicketRequest ticketRequest){
        this.ticketRequestList.add(ticketRequest);
    }
    
    public void removeTicketRequest(TicketRequest trq) {
        ticketRequestList.remove(trq);
    }
}
