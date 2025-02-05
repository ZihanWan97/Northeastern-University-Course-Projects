/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userinterface.SystemAdminWorkArea;

import Business.EcoSystem;
import Business.Employee.Employee;
import Business.Organization;
import Business.OrganizationDirectory;
import Business.Role.CustomerRole;
import Business.UserAccount.UserAccount;
import Business.Role.Role;
import Business.DB4OUtil.DB4OUtil;
import java.awt.CardLayout;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Eva
 */
public class ManageCustomerJPanel extends javax.swing.JPanel {

    private OrganizationDirectory organizationDir;
    private JPanel userProcessContainer;
    private UserAccount userAccount;
    EcoSystem ecosystem;
    
    /**
     * Creates new form ManageOrganizationJPanel
     */
    public ManageCustomerJPanel(JPanel userProcessContainer,EcoSystem ecosystem) {
        initComponents();
        this.setSize(600, 600);
        this.userProcessContainer = userProcessContainer;
        //this.organizationDir = organizationDir;
        this.ecosystem = ecosystem;
        populateTable();
    }
    
    
    private void populateTable(){
        DefaultTableModel model = (DefaultTableModel) infoTable.getModel();
        
        model.setRowCount(0);
        
        for (UserAccount userAccount : ecosystem.getUserAccountDirectory().getUserAccountList()){
            if (userAccount.getRole().toString().equals("Customer")){
                Object[] row = new Object[2];
                row[0] = userAccount;
                row[1] = userAccount.getPassword();
                model.addRow(row);
            }
            
        }
    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        lblTitle = new javax.swing.JLabel();
        btnBack = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        infoTable = new javax.swing.JTable();
        lblNewCustomer = new javax.swing.JLabel();
        lblName = new javax.swing.JLabel();
        txtName = new javax.swing.JTextField();
        btnCreate = new javax.swing.JButton();
        btnUpdate = new javax.swing.JButton();
        btnDelete = new javax.swing.JButton();
        lblPwd = new javax.swing.JLabel();
        txtPwd = new javax.swing.JTextField();
        btnSubmit = new javax.swing.JButton();

        setBackground(new java.awt.Color(255, 255, 255));

        lblTitle.setFont(new java.awt.Font("微软雅黑", 1, 24)); // NOI18N
        lblTitle.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTitle.setText("Manage Customers");

        btnBack.setBackground(new java.awt.Color(0, 0, 0));
        btnBack.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        btnBack.setForeground(new java.awt.Color(255, 255, 255));
        btnBack.setText("<< Back");
        btnBack.setBorderPainted(false);
        btnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBackActionPerformed(evt);
            }
        });

        infoTable.setFont(new java.awt.Font("微软雅黑", 1, 10)); // NOI18N
        infoTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null},
                {null, null},
                {null, null},
                {null, null}
            },
            new String [] {
                "Name", "Password"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jScrollPane1.setViewportView(infoTable);
        if (infoTable.getColumnModel().getColumnCount() > 0) {
            infoTable.getColumnModel().getColumn(0).setPreferredWidth(50);
        }

        lblNewCustomer.setFont(new java.awt.Font("微软雅黑", 3, 12)); // NOI18N
        lblNewCustomer.setText("Add Customer:");

        lblName.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        lblName.setText("Name:");

        btnCreate.setBackground(new java.awt.Color(204, 0, 0));
        btnCreate.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        btnCreate.setForeground(new java.awt.Color(255, 255, 255));
        btnCreate.setText("Create");
        btnCreate.setBorderPainted(false);
        btnCreate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCreateActionPerformed(evt);
            }
        });

        btnUpdate.setBackground(new java.awt.Color(204, 0, 0));
        btnUpdate.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        btnUpdate.setForeground(new java.awt.Color(255, 255, 255));
        btnUpdate.setText("Update");
        btnUpdate.setBorderPainted(false);
        btnUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnUpdateActionPerformed(evt);
            }
        });

        btnDelete.setBackground(new java.awt.Color(0, 0, 255));
        btnDelete.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        btnDelete.setForeground(new java.awt.Color(255, 255, 255));
        btnDelete.setText("Delete");
        btnDelete.setBorderPainted(false);
        btnDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDeleteActionPerformed(evt);
            }
        });

        lblPwd.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        lblPwd.setText("Password:");

        btnSubmit.setBackground(new java.awt.Color(204, 0, 0));
        btnSubmit.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        btnSubmit.setForeground(new java.awt.Color(255, 255, 255));
        btnSubmit.setText("Confirm Update");
        btnSubmit.setBorderPainted(false);
        btnSubmit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSubmitActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(180, 180, 180)
                        .addComponent(lblTitle))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(36, 36, 36)
                        .addComponent(btnBack))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(104, 104, 104)
                        .addComponent(btnUpdate)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(btnSubmit))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(103, 103, 103)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(btnDelete)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 387, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(115, 115, 115)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(19, 19, 19)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                        .addComponent(txtName, javax.swing.GroupLayout.PREFERRED_SIZE, 171, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addGroup(layout.createSequentialGroup()
                                            .addComponent(lblPwd)
                                            .addGap(18, 18, 18)
                                            .addComponent(txtPwd, javax.swing.GroupLayout.PREFERRED_SIZE, 171, javax.swing.GroupLayout.PREFERRED_SIZE)))
                                    .addComponent(lblName))
                                .addGap(18, 18, 18)
                                .addComponent(btnCreate))
                            .addComponent(lblNewCustomer))))
                .addContainerGap(110, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(33, 33, 33)
                .addComponent(btnBack)
                .addGap(20, 20, 20)
                .addComponent(lblTitle)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 141, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnUpdate)
                    .addComponent(btnSubmit)
                    .addComponent(btnDelete))
                .addGap(40, 40, 40)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(lblNewCustomer)
                        .addGap(11, 11, 11)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(7, 7, 7)
                                .addComponent(lblName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(3, 3, 3)
                                .addComponent(txtName)))
                        .addGap(10, 10, 10)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(3, 3, 3)
                                .addComponent(txtPwd))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(7, 7, 7)
                                .addComponent(lblPwd, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(27, 27, 27)
                        .addComponent(btnCreate, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addGap(183, 183, 183))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnCreateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCreateActionPerformed
        String name = txtName.getText();
        String pwd = txtPwd.getText();
        if (name.isEmpty() || pwd.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Username/password cannot be empty!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        } else {
            UserAccount account = ecosystem.getUserAccountDirectory().createUserAccount(name, pwd, null, new CustomerRole());
            JOptionPane.showMessageDialog(this, "Created successfully！");
            populateTable();
        }
        
        /*Organization organization = (Organization) cmbOrganizationList.getSelectedItem();
        String name = txtName.getText();
        
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Employee name cannot be empty.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        
        organization.getEmployeeDirectory().createEmployee(name);
        txtName.setText("");
        populateTable(organization);*/
        
    }//GEN-LAST:event_btnCreateActionPerformed

    private void btnBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBackActionPerformed

        userProcessContainer.remove(this);
        CardLayout layout = (CardLayout) userProcessContainer.getLayout();
        layout.previous(userProcessContainer);
    }//GEN-LAST:event_btnBackActionPerformed

    private void btnUpdateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnUpdateActionPerformed
        int row = infoTable.getSelectedRow();
        if(row<0){
            JOptionPane.showMessageDialog(null, "Please select a customer!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        UserAccount a = (UserAccount)infoTable.getValueAt(row,0);
        txtName.setText(a.getUsername());
        txtPwd.setText(a.getPassword());
    }//GEN-LAST:event_btnUpdateActionPerformed

    private void btnSubmitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSubmitActionPerformed
        int row = infoTable.getSelectedRow();
        if(row<0){
            JOptionPane.showMessageDialog(null, "Please select a customer!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        UserAccount a = (UserAccount)infoTable.getValueAt(row,0);
        
        String name = txtName.getText();
        String pwd = txtPwd.getText();
        if (name.isEmpty() || pwd.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Username/password cannot be empty!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        } else {
            a.setPassword(pwd);
            a.setUsername(name);
            JOptionPane.showMessageDialog(this, "Updated successfully!");
            populateTable();
            
        }
    }//GEN-LAST:event_btnSubmitActionPerformed

    private void btnDeleteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDeleteActionPerformed
        int row = infoTable.getSelectedRow();
        if(row < 0) {
            JOptionPane.showMessageDialog(null, "Please select a customer!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        UserAccount a = (UserAccount)infoTable.getValueAt(row,0);
        //JOptionPane.showMessageDialog(null, "p = (row,0) over.");
        ecosystem.getUserAccountDirectory().removeUserAccount(a);
        JOptionPane.showMessageDialog(null, "Customer Deleted.");
        populateTable();
    }//GEN-LAST:event_btnDeleteActionPerformed

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBack;
    private javax.swing.JButton btnCreate;
    private javax.swing.JButton btnDelete;
    private javax.swing.JButton btnSubmit;
    private javax.swing.JButton btnUpdate;
    private javax.swing.JTable infoTable;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel lblName;
    private javax.swing.JLabel lblNewCustomer;
    private javax.swing.JLabel lblPwd;
    private javax.swing.JLabel lblTitle;
    private javax.swing.JTextField txtName;
    private javax.swing.JTextField txtPwd;
    // End of variables declaration//GEN-END:variables
}
