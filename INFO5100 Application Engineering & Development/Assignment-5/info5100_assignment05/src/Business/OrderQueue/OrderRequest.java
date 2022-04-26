/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.OrderQueue;

import Business.Order.Order;
import Business.UserAccount.UserAccount;
import java.util.Date;

/**
 *
 * @author Eva
 */
public abstract class OrderRequest {


    private UserAccount restaurant;
    private UserAccount sender;
    private UserAccount receiver;
    private UserAccount deliver;
    private String foodName;
    private String status;
    private Integer price;
    private String id;
    private static int count = 0;
    private Order order;
    private String comment;
    
    public OrderRequest(){
        count++;
        id = String.valueOf(count);
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public UserAccount getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(UserAccount restaurant) {
        this.restaurant = restaurant;
    }

    public UserAccount getSender() {
        return sender;
    }

    public void setSender(UserAccount sender) {
        this.sender = sender;
    }

    public UserAccount getReceiver() {
        return receiver;
    }

    public void setReceiver(UserAccount receiver) {
        this.receiver = receiver;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public UserAccount getDeliver() {
        return deliver;
    }

    public void setDeliver(UserAccount deliver) {
        this.deliver = deliver;
    }
    
    

    @Override
    public String toString() {
        return status;
    }
    

}
