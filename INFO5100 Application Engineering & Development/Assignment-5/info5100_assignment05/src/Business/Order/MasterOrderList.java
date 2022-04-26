/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.Order;

import java.util.ArrayList;

/**
 *
 * @author Eva
 */
public class MasterOrderList {
    ArrayList<Order> orderList;

    public MasterOrderList() {
        orderList=new ArrayList<Order>();
    }

    public ArrayList<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(ArrayList<Order> orderList) {
        this.orderList = orderList;
    }
    
    public void addNewOrder(Order order){
        this.orderList.add(order);
    }
    public void removeOrder(Order order){
        this.orderList.remove(order);
    }    
}
