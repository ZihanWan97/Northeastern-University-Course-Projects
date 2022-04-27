/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui.ReviewAdmin;

import Ecosystem.Enterprise.Enterprise;
import Ecosystem.FilmFactorySystem;
import Ecosystem.Network.Network;
import Ecosystem.Organization.Organization;
import Ecosystem.Role.ReviewAuditorRole;
import Ecosystem.UserAccount.UserAccount;
import java.awt.CardLayout;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Eva
 */
public class ManageAuditorsJPanel extends javax.swing.JPanel {

    /**
     * Creates new form ManageAuditorsJPanel
     */
    JPanel workArea;
    FilmFactorySystem system;
    public ManageAuditorsJPanel(JPanel workArea, FilmFactorySystem system) {
        initComponents();
        this.workArea= workArea;
        this.system = system;
        populateTable();
        sVGImage1.setSvgImage("UIDesign/undraw_add_user_re_5oib.svg", 230,160);
        setSize(750, 530);
    }
    
    private void populateTable() {
        DefaultTableModel model = (DefaultTableModel) infoTable.getModel();
        model.setRowCount(0);  
        for(Network network:system.getNetworkList()) {
            for (Enterprise enterprise: network.getEnterpriseDirectory().getEnterpriseList()) {
                if (enterprise.getEnterpriseType().toString().equals("ReviewEn")) {
                    for(Organization org: enterprise.getOrganizationDirectory().getOrganizationList()) {
                        for(UserAccount ua: org.getUserAccountDirectory().getUserAccountList()) {
                            if (!ua.getRole().toString().equals("ReviewAdmin")) {
                                Object[] row = new Object[2];
                                row[0] = ua;
                                row[1] = ua.getPassword();
                                model.addRow(row);
                            }
                        }
                    }
                }
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

        jLabel4 = new javax.swing.JLabel();
        btnBack = new javax.swing.JButton();
        txtPassword = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        infoTable = new javax.swing.JTable();
        btnUpdate = new javax.swing.JButton();
        btnConfirmUpdate = new javax.swing.JButton();
        btnDelete = new javax.swing.JButton();
        txtUserName = new javax.swing.JTextField();
        btnCreate = new javax.swing.JButton();
        jLabel3 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        lblTitle = new javax.swing.JLabel();
        sVGImage1 = new UIDesign.SVGImage();
        lblNameCheck = new javax.swing.JLabel();
        lblPasswordCheck = new javax.swing.JLabel();

        setBackground(new java.awt.Color(10, 10, 10));

        jLabel4.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setText("Password:");

        btnBack.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnBack.setForeground(new java.awt.Color(255, 255, 255));
        btnBack.setText("<<Back");
        btnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBackActionPerformed(evt);
            }
        });

        txtPassword.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtPasswordKeyReleased(evt);
            }
        });

        infoTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null},
                {null, null},
                {null, null},
                {null, null}
            },
            new String [] {
                "UserName", "Password"
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

        btnUpdate.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnUpdate.setForeground(new java.awt.Color(255, 255, 255));
        btnUpdate.setText("Update");
        btnUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnUpdateActionPerformed(evt);
            }
        });

        btnConfirmUpdate.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnConfirmUpdate.setForeground(new java.awt.Color(255, 255, 255));
        btnConfirmUpdate.setText("Comfirm Update");
        btnConfirmUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnConfirmUpdateActionPerformed(evt);
            }
        });

        btnDelete.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnDelete.setForeground(new java.awt.Color(255, 255, 255));
        btnDelete.setText("Delete");
        btnDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDeleteActionPerformed(evt);
            }
        });

        txtUserName.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtUserNameKeyReleased(evt);
            }
        });

        btnCreate.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnCreate.setForeground(new java.awt.Color(255, 255, 255));
        btnCreate.setText("Create");
        btnCreate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCreateActionPerformed(evt);
            }
        });

        jLabel3.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 255, 255));
        jLabel3.setText("UserName:");

        jLabel2.setFont(new java.awt.Font("Segoe UI Black", 1, 12)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(255, 255, 255));
        jLabel2.setText("Add New Auditor:");

        lblTitle.setFont(new java.awt.Font("Segoe UI Black", 1, 24)); // NOI18N
        lblTitle.setForeground(new java.awt.Color(255, 255, 255));
        lblTitle.setText("Manage Auditors");

        lblNameCheck.setFont(new java.awt.Font("Segoe UI Black", 0, 10)); // NOI18N
        lblNameCheck.setForeground(new java.awt.Color(255, 255, 255));

        lblPasswordCheck.setFont(new java.awt.Font("Segoe UI Black", 0, 10)); // NOI18N
        lblPasswordCheck.setForeground(new java.awt.Color(255, 255, 255));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(69, 69, 69)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(82, 82, 82)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(btnUpdate)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                        .addComponent(btnConfirmUpdate)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addComponent(btnDelete))
                                    .addComponent(jLabel2)))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(btnBack)
                                .addGap(113, 113, 113)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addGap(10, 10, 10)
                                        .addComponent(lblTitle))
                                    .addComponent(sVGImage1, javax.swing.GroupLayout.PREFERRED_SIZE, 230, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(191, 191, 191)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel4)
                            .addComponent(jLabel3))
                        .addGap(33, 33, 33)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(txtUserName)
                            .addComponent(txtPassword, javax.swing.GroupLayout.PREFERRED_SIZE, 133, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblPasswordCheck, javax.swing.GroupLayout.PREFERRED_SIZE, 38, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblNameCheck, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 38, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnCreate)))
                .addContainerGap(147, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(24, 24, 24)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(sVGImage1, javax.swing.GroupLayout.PREFERRED_SIZE, 160, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnBack))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblTitle)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 95, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnUpdate)
                    .addComponent(btnConfirmUpdate)
                    .addComponent(btnDelete))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel2)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(lblNameCheck, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(lblPasswordCheck, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtUserName, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel3))
                        .addGap(8, 8, 8)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(txtPassword, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addComponent(btnCreate, javax.swing.GroupLayout.PREFERRED_SIZE, 60, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(44, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBackActionPerformed
        workArea.remove(this);
        CardLayout layout = (CardLayout) workArea.getLayout();
        layout.previous(workArea);
    }//GEN-LAST:event_btnBackActionPerformed

    private void btnCreateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCreateActionPerformed
        String name = txtUserName.getText();
        String pwd =  txtPassword.getText();
        if (name.isEmpty() || pwd.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Something is invalid!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        } else {
            for(Network network: system.getNetworkList()) {
                for (Enterprise enterprise: network.getEnterpriseDirectory().getEnterpriseList()) {
                    if (enterprise.getEnterpriseType().toString().equals("ReviewEn")) {
                        for(Organization org: enterprise.getOrganizationDirectory().getOrganizationList()) {
                            if (org.getName().equals("ReviewAuditorOrg")) {
                                org.getUserAccountDirectory().createUserAccount(name, pwd, new ReviewAuditorRole());
                                JOptionPane.showMessageDialog(this, "Information Saved!");
                                populateTable();
                                txtUserName.setText("");
                                txtPassword.setText("");
                            }
                        }
                    }
                }
            }
        }
        
    }//GEN-LAST:event_btnCreateActionPerformed

    private void btnUpdateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnUpdateActionPerformed
        int row = infoTable.getSelectedRow();
        if(row<0){
            JOptionPane.showMessageDialog(null, "Please select a row!!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        UserAccount a = (UserAccount)infoTable.getValueAt(row,0);
        txtUserName.setText(a.getUsername());
        txtPassword.setText(a.getPassword());
    }//GEN-LAST:event_btnUpdateActionPerformed

    private void btnConfirmUpdateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnConfirmUpdateActionPerformed
        int row = infoTable.getSelectedRow();
        if(row<0){
            JOptionPane.showMessageDialog(null, "Please select a row!!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        UserAccount a = (UserAccount)infoTable.getValueAt(row,0);
        String name = txtUserName.getText();
        String pwd =  txtPassword.getText();
        if (name.isEmpty() || pwd.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Something is invalid!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        } else {
            a.setPassword(pwd);
            a.setUsername(name);
            JOptionPane.showMessageDialog(this, "Information Saved!");
            populateTable();
            
        }
        txtUserName.setText("");
        txtPassword.setText("");
    }//GEN-LAST:event_btnConfirmUpdateActionPerformed

    private void btnDeleteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDeleteActionPerformed
        int row = infoTable.getSelectedRow();
        if(row < 0) {
            JOptionPane.showMessageDialog(null, "Please select a row!!", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        
        UserAccount a = (UserAccount)infoTable.getValueAt(row,0);
        for(Network network:system.getNetworkList()) {
            for (Enterprise enterprise: network.getEnterpriseDirectory().getEnterpriseList()) {
                if (enterprise.getEnterpriseType().toString().equals("ReviewEn")) {
                    for(Organization org: enterprise.getOrganizationDirectory().getOrganizationList()) {
                        org.getUserAccountDirectory().removeUserAccount(a);
                    }
                }
            }
        }
        JOptionPane.showMessageDialog(null, "Deleted.");
        populateTable();
    }//GEN-LAST:event_btnDeleteActionPerformed

    private void txtUserNameKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtUserNameKeyReleased
        String regx = "^\\S*$";
        Pattern pattern = Pattern.compile(regx);
        Matcher match = pattern.matcher(txtUserName.getText());       
        if(!match.matches()){
            lblNameCheck.setText("Invalid");
        }
        else{
            lblNameCheck.setText("OK");
        }
    }//GEN-LAST:event_txtUserNameKeyReleased

    private void txtPasswordKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtPasswordKeyReleased
        String regx = "^\\S*$";
        Pattern pattern = Pattern.compile(regx);
        Matcher match = pattern.matcher(txtPassword.getText());       
        if(!match.matches()){
            lblPasswordCheck.setText("Invalid");
        }
        else{
            lblPasswordCheck.setText("OK");
        }
    }//GEN-LAST:event_txtPasswordKeyReleased


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBack;
    private javax.swing.JButton btnConfirmUpdate;
    private javax.swing.JButton btnCreate;
    private javax.swing.JButton btnDelete;
    private javax.swing.JButton btnUpdate;
    private javax.swing.JTable infoTable;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel lblNameCheck;
    private javax.swing.JLabel lblPasswordCheck;
    private javax.swing.JLabel lblTitle;
    private UIDesign.SVGImage sVGImage1;
    private javax.swing.JTextField txtPassword;
    private javax.swing.JTextField txtUserName;
    // End of variables declaration//GEN-END:variables
}
