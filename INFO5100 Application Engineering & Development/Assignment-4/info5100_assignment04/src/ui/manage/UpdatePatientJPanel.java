/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui.manage;

import java.awt.CardLayout;
import java.awt.Component;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import model.Admin;
import model.Community;
import model.House;
import model.Patient;

/**
 *
 * @author Eva
 */
public class UpdatePatientJPanel extends javax.swing.JPanel {

    /**
     * Creates new form UpdatePatientJPanel
     */
    
    private JPanel workAreaJPanel;
    private Patient patient;
    private Admin admin;
    private Community community;
    
    
    public UpdatePatientJPanel(JPanel wajp, Patient p, Admin a) {
        initComponents();
        setSize(600,600);
        workAreaJPanel = wajp;
        patient = p;
        admin = a;
        

        

        txtPatientName.setText(p.getPersonName());
        txtPatientAge.setText(p.getPersonAge().toString());  
        txtHouse.setText(p.getHouse().getHouseName());
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        btnConfirmAdd = new javax.swing.JButton();
        txtPatientName = new javax.swing.JTextField();
        lblTitle = new javax.swing.JLabel();
        btnBack = new javax.swing.JButton();
        txtPatientAge = new javax.swing.JTextField();
        lblPatientAge = new javax.swing.JLabel();
        lblPatientName = new javax.swing.JLabel();
        lblNameValid = new javax.swing.JLabel();
        lblAgeValid = new javax.swing.JLabel();
        lblHouse = new javax.swing.JLabel();
        txtHouse = new javax.swing.JTextField();
        lblHouseValid = new javax.swing.JLabel();

        setBackground(new java.awt.Color(255, 255, 255));

        btnConfirmAdd.setBackground(new java.awt.Color(204, 0, 0));
        btnConfirmAdd.setFont(new java.awt.Font("微软雅黑", 1, 18)); // NOI18N
        btnConfirmAdd.setForeground(new java.awt.Color(255, 255, 255));
        btnConfirmAdd.setText("Confirm Update");
        btnConfirmAdd.setBorderPainted(false);
        btnConfirmAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnConfirmAddActionPerformed(evt);
            }
        });

        txtPatientName.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        txtPatientName.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtPatientNameKeyReleased(evt);
            }
        });

        lblTitle.setFont(new java.awt.Font("微软雅黑", 1, 24)); // NOI18N
        lblTitle.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTitle.setText("Update Patient Information");

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

        txtPatientAge.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        txtPatientAge.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtPatientAgeKeyReleased(evt);
            }
        });

        lblPatientAge.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblPatientAge.setText("Patient Age:");

        lblPatientName.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblPatientName.setText("Patient Name:");

        lblNameValid.setFont(new java.awt.Font("Times New Roman", 0, 10)); // NOI18N
        lblNameValid.setForeground(new java.awt.Color(51, 51, 51));
        lblNameValid.setMaximumSize(new java.awt.Dimension(42, 23));
        lblNameValid.setMinimumSize(new java.awt.Dimension(42, 23));

        lblAgeValid.setFont(new java.awt.Font("Times New Roman", 0, 10)); // NOI18N
        lblAgeValid.setForeground(new java.awt.Color(51, 51, 51));
        lblAgeValid.setMaximumSize(new java.awt.Dimension(42, 23));
        lblAgeValid.setMinimumSize(new java.awt.Dimension(42, 23));

        lblHouse.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblHouse.setText("House:");

        txtHouse.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        txtHouse.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtHouseActionPerformed(evt);
            }
        });
        txtHouse.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtHouseKeyReleased(evt);
            }
        });

        lblHouseValid.setFont(new java.awt.Font("Times New Roman", 0, 10)); // NOI18N
        lblHouseValid.setForeground(new java.awt.Color(51, 51, 51));
        lblHouseValid.setMaximumSize(new java.awt.Dimension(42, 23));
        lblHouseValid.setMinimumSize(new java.awt.Dimension(42, 23));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(btnBack)
                        .addGap(0, 552, Short.MAX_VALUE))
                    .addComponent(lblTitle, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(183, 183, 183)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(lblHouse, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(lblPatientName, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 127, Short.MAX_VALUE)
                                    .addComponent(lblPatientAge, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtPatientAge, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(txtPatientName, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 129, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(txtHouse, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(lblHouseValid, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(lblAgeValid, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(lblNameValid, javax.swing.GroupLayout.DEFAULT_SIZE, 60, Short.MAX_VALUE)))
                            .addComponent(btnConfirmAdd, javax.swing.GroupLayout.PREFERRED_SIZE, 260, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
        );

        layout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {txtHouse, txtPatientAge, txtPatientName});

        layout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {lblAgeValid, lblHouseValid, lblNameValid});

        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(btnBack)
                .addGap(96, 96, 96)
                .addComponent(lblTitle)
                .addGap(27, 27, 27)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(6, 6, 6)
                        .addComponent(lblPatientName)
                        .addGap(38, 38, 38)
                        .addComponent(lblPatientAge)
                        .addGap(36, 36, 36)
                        .addComponent(lblHouse))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(txtPatientName, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(32, 32, 32)
                                .addComponent(txtPatientAge, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(57, 57, 57)
                                .addComponent(lblAgeValid, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(lblNameValid, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(30, 30, 30)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtHouse, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblHouseValid, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(29, 29, 29)
                .addComponent(btnConfirmAdd, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(191, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnConfirmAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnConfirmAddActionPerformed
        // TODO add your handling code here:
        if(txtPatientName.getText().equals("")||txtPatientAge.getText().equals("")||txtHouse.getText().equals("")){

            JOptionPane.showMessageDialog(null, "Please enter all information!", "Warning", JOptionPane.WARNING_MESSAGE);
            
        }else{
            

        patient.setPersonName(txtPatientName.getText());
        patient.setPersonAge(Integer.parseInt(txtPatientAge.getText()));
        patient.getHouse().setHouseName(txtHouse.getText());
       
        
        JOptionPane.showMessageDialog(this, "Patient updated");

        }
    }//GEN-LAST:event_btnConfirmAddActionPerformed

    private void btnBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBackActionPerformed
        // TODO add your handling code here:
        workAreaJPanel.remove(this);
        Component[] componentArray = workAreaJPanel.getComponents();
        Component component = componentArray[componentArray.length - 1];
        ManageJPanel manageJPanel = (ManageJPanel) component;
        manageJPanel.refreshTable();
        CardLayout layout = (CardLayout) workAreaJPanel.getLayout();
        layout.previous(workAreaJPanel);
    }//GEN-LAST:event_btnBackActionPerformed

    private void txtPatientNameKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtPatientNameKeyReleased
        // TODO add your handling code here:
        String regx = "^[\\p{L} .'-]+$";
        Pattern pattern = Pattern.compile(regx);
        Matcher match = pattern.matcher(txtPatientName.getText());       
        if(!match.matches()){
            lblNameValid.setText("Invalid");
        }
        else{
            lblNameValid.setText("OK");
        }       
    }//GEN-LAST:event_txtPatientNameKeyReleased

    private void txtPatientAgeKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtPatientAgeKeyReleased
        // TODO add your handling code here:
        String regx = "(?:\\b|-)([1-9]{1,2}[0]?|100)\\b";
        Pattern pattern = Pattern.compile(regx);
        Matcher match = pattern.matcher(txtPatientAge.getText());
        if(!match.matches()){
            lblAgeValid.setText("Invalid");
        }
        else{
            lblAgeValid.setText("OK");
        }
        
    }//GEN-LAST:event_txtPatientAgeKeyReleased

    private void txtHouseActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtHouseActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtHouseActionPerformed

    private void txtHouseKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtHouseKeyReleased
        // only numbers and letters
        String regx = "^[A-Za-z0-9]*$";
        Pattern pattern = Pattern.compile(regx);
        Matcher match = pattern.matcher(txtHouse.getText());
        if(!match.matches()){
            lblHouseValid.setText("Invalid");
        }
        else{
            lblHouseValid.setText("OK");
        }
    }//GEN-LAST:event_txtHouseKeyReleased


                                              


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBack;
    private javax.swing.JButton btnConfirmAdd;
    private javax.swing.JLabel lblAgeValid;
    private javax.swing.JLabel lblHouse;
    private javax.swing.JLabel lblHouseValid;
    private javax.swing.JLabel lblNameValid;
    private javax.swing.JLabel lblPatientAge;
    private javax.swing.JLabel lblPatientName;
    private javax.swing.JLabel lblTitle;
    private javax.swing.JTextField txtHouse;
    private javax.swing.JTextField txtPatientAge;
    private javax.swing.JTextField txtPatientName;
    // End of variables declaration//GEN-END:variables
}
