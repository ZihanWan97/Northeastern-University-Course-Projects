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
import model.Patient;
import model.Community;
import model.House;

/**
 *
 * @author Eva
 */
public class AddPatientJPanel extends javax.swing.JPanel {

    /**
     * Creates new form AddPatientJPanel
     */
    
    JPanel workAreaJPanel;
    Admin admin;
    
    
    public AddPatientJPanel(JPanel wajp, Admin a) {
        initComponents();
        setSize(600,600);
        workAreaJPanel =wajp;
        admin = a;
        
                
        cmbCommunity.setModel(new DefaultComboBoxModel<>(new String[]{
        "Northeastern","Southeastern"

        }));
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        lblPatientAge = new javax.swing.JLabel();
        lblPatientName = new javax.swing.JLabel();
        btnConfirmAdd = new javax.swing.JButton();
        txtPatientName = new javax.swing.JTextField();
        lblHouse = new javax.swing.JLabel();
        lblTitle = new javax.swing.JLabel();
        btnBack = new javax.swing.JButton();
        txtPatientAge = new javax.swing.JTextField();
        lblNameValid = new javax.swing.JLabel();
        lblAgeValid = new javax.swing.JLabel();
        lblCommunity = new javax.swing.JLabel();
        cmbCommunity = new javax.swing.JComboBox<>();
        txtHouse = new javax.swing.JTextField();
        lblHouseValid = new javax.swing.JLabel();

        setBackground(new java.awt.Color(255, 255, 255));

        lblPatientAge.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblPatientAge.setText("Patient Age:");

        lblPatientName.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblPatientName.setText("Patient Name:");

        btnConfirmAdd.setBackground(new java.awt.Color(204, 0, 0));
        btnConfirmAdd.setFont(new java.awt.Font("微软雅黑", 1, 18)); // NOI18N
        btnConfirmAdd.setForeground(new java.awt.Color(255, 255, 255));
        btnConfirmAdd.setText("Confirm Add");
        btnConfirmAdd.setBorderPainted(false);
        btnConfirmAdd.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnConfirmAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnConfirmAddActionPerformed(evt);
            }
        });

        txtPatientName.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        txtPatientName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtPatientNameActionPerformed(evt);
            }
        });
        txtPatientName.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtPatientNameKeyReleased(evt);
            }
        });

        lblHouse.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblHouse.setText("House:");

        lblTitle.setFont(new java.awt.Font("微软雅黑", 1, 24)); // NOI18N
        lblTitle.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTitle.setText("Add New Patient");

        btnBack.setBackground(new java.awt.Color(0, 0, 0));
        btnBack.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        btnBack.setForeground(new java.awt.Color(255, 255, 255));
        btnBack.setText("<< Back");
        btnBack.setBorderPainted(false);
        btnBack.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBackActionPerformed(evt);
            }
        });

        txtPatientAge.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
        txtPatientAge.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtPatientAgeKeyReleased(evt);
            }
        });

        lblNameValid.setFont(new java.awt.Font("Times New Roman", 0, 10)); // NOI18N
        lblNameValid.setForeground(new java.awt.Color(51, 51, 51));
        lblNameValid.setMaximumSize(new java.awt.Dimension(42, 23));
        lblNameValid.setMinimumSize(new java.awt.Dimension(42, 23));

        lblAgeValid.setFont(new java.awt.Font("Times New Roman", 0, 10)); // NOI18N
        lblAgeValid.setForeground(new java.awt.Color(51, 51, 51));
        lblAgeValid.setMaximumSize(new java.awt.Dimension(42, 23));
        lblAgeValid.setMinimumSize(new java.awt.Dimension(42, 23));

        lblCommunity.setFont(new java.awt.Font("微软雅黑", 1, 14)); // NOI18N
        lblCommunity.setText("Community:");

        cmbCommunity.setFont(new java.awt.Font("微软雅黑", 0, 12)); // NOI18N
        cmbCommunity.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        cmbCommunity.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmbCommunityActionPerformed(evt);
            }
        });

        txtHouse.setFont(new java.awt.Font("微软雅黑", 1, 12)); // NOI18N
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
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addComponent(lblTitle, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(183, 183, 183)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblPatientName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblPatientAge, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(28, 28, 28))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblCommunity, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblHouse, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(8, 8, 8)))
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(txtHouse)
                                    .addComponent(cmbCommunity, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(txtPatientAge)
                                    .addComponent(txtPatientName, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addComponent(btnConfirmAdd, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblAgeValid, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblNameValid, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblHouseValid, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(112, 112, 112))))
        );

        layout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {lblAgeValid, lblHouseValid, lblNameValid});

        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(btnBack)
                .addGap(82, 82, 82)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(lblTitle)
                        .addGap(28, 28, 28)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                .addComponent(lblPatientName)
                                .addComponent(txtPatientName, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(lblNameValid, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(27, 27, 27)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtPatientAge, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblPatientAge)))
                    .addComponent(lblAgeValid, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(27, 27, 27)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(lblCommunity)
                    .addComponent(cmbCommunity, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(28, 28, 28)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(lblHouse)
                        .addComponent(txtHouse, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(lblHouseValid, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(32, 32, 32)
                .addComponent(btnConfirmAdd, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(166, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnConfirmAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnConfirmAddActionPerformed
        // TODO add your handling code here:
        if(txtPatientName.getText().equals("")||txtPatientAge.getText().equals("")||txtHouse.getText().equals("")){

            JOptionPane.showMessageDialog(null, "Please enter all information!", "Warning", JOptionPane.WARNING_MESSAGE);
        }else{

            //Patient p;
            //p = admin.getPatientDirectory().addPatient();
            //p.setPersonName(txtPatientName.getText());
            //p.setPersonAge(Integer.parseInt(txtPatientAge.getText()));
            //p.setHouse(cmbHouse.getSelectedItem().toString());
            //JOptionPane.showMessageDialog(this, "Patient added");
            
            Patient p;
            p = admin.getPatientDirectory().addPatient();
            Community c;
            c = admin.getCity().newCommunity();
            c.setCommunityName(cmbCommunity.getSelectedItem().toString());
            House h = c.newHouse();
            h.setHouseName(txtHouse.getText());
            h.setCityName(admin.getCity().getCityName());
            p.setPersonName(txtPatientName.getText());
            p.setPersonAge(Integer.parseInt(txtPatientAge.getText()));
            p.setHouse(h);
            
            JOptionPane.showMessageDialog(this, "Patient added");


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
        // only letters
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
        // only numbers
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

    private void cmbCommunityActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmbCommunityActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cmbCommunityActionPerformed

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

    private void txtHouseActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtHouseActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtHouseActionPerformed

    private void txtPatientNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtPatientNameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtPatientNameActionPerformed

        
        
        


     
                                             

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBack;
    private javax.swing.JButton btnConfirmAdd;
    private javax.swing.JComboBox<String> cmbCommunity;
    private javax.swing.JLabel lblAgeValid;
    private javax.swing.JLabel lblCommunity;
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
