/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Business.UserAccount;

import Business.Employee.Employee;
import Business.Role.Role;
import Business.OrderQueue.OrderQueue;
import Business.Role.CustomerRole;

/**
 *
 * @author Eva
 */
public class UserAccount {
    
    private String username;
    private String password;
    private Employee employee;
    private Role role;
    private OrderQueue orderQueue;
    

    public UserAccount() {
        orderQueue = new OrderQueue();
    }
    
    
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Employee getEmployee() {
        return employee;
    }

    public OrderQueue getOrderQueue() {
        return orderQueue;
    }

    
    
    @Override
    public String toString() {
        return username;
    }
    
    
    
}