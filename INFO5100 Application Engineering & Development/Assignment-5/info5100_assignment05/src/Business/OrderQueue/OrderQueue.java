/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.OrderQueue;

import Business.Order.FoodCatalog;
import Business.Order.MasterOrderList;
import java.util.ArrayList;

/**
 *
 * @author Eva
 */
public class OrderQueue {
    
    private ArrayList<OrderRequest> orderRequestList;
    private FoodCatalog foodCatalog;
    private MasterOrderList masterOrderList;

    public OrderQueue() {
        orderRequestList = new ArrayList();
        foodCatalog=new FoodCatalog();
        masterOrderList=new MasterOrderList();
    }

    public ArrayList<OrderRequest> getOrderRequestList() {
        return orderRequestList;
    }

    public FoodCatalog getFoodCatalog() {
        return foodCatalog;
    }

    public void setFoodCatalog(FoodCatalog foodCatalog) {
        this.foodCatalog = foodCatalog;
    }

    public MasterOrderList getMasterOrderList() {
        return masterOrderList;
    }

    public void setMasterOrderList(MasterOrderList masterOrderList) {
        this.masterOrderList = masterOrderList;
    }
   
    public void setOrderRequestList(ArrayList<OrderRequest> orderRequestList) {
        this.orderRequestList = orderRequestList;
    }
    public void removeOrderRequest(OrderRequest orderRequest){
        orderRequestList.remove(orderRequest);
    }

}