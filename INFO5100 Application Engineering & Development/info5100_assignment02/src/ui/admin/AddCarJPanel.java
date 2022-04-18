/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui.admin;

import java.awt.CardLayout;
import java.awt.Component;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import model.Admin;
import model.Car;

/**
 *
 * @author Eva
 */
public class AddCarJPanel extends javax.swing.JPanel {
    
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date = new Date();
    Calendar calender = Calendar.getInstance();
    

    /**
     * Creates new form AddCarJPanel
     */
    JPanel workAreaJPanel;
    Admin admin;
    
    
    public AddCarJPanel(JPanel wajp, Admin a) {
        initComponents();
        setSize(600,600);
        workAreaJPanel =wajp;
        admin = a;
        
        cmbCarModel.setModel(new DefaultComboBoxModel<>(new String[]{
            "X","XL","XXL"
        }));
        
        cmbCarSeat.setModel(new DefaultComboBoxModel<>(new String[]{
            "5","7","9"
        }));
        
        cmbIsAvail.setModel(new DefaultComboBoxModel<>(new String[]{
            "Yes","No"
        }));
        
        cmbIsExpired.setModel(new DefaultComboBoxModel<>(new String[]{
            "Yes","No"
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

        lblIsAvail = new javax.swing.JLabel();
        txtCarName = new javax.swing.JTextField();
        cmbIsAvail = new javax.swing.JComboBox<>();
        lblCarBrand = new javax.swing.JLabel();
        lblIsExpired = new javax.swing.JLabel();
        txtCarBrand = new javax.swing.JTextField();
        cmbIsExpired = new javax.swing.JComboBox<>();
        lblCarModel = new javax.swing.JLabel();
        btnConfirmAdd = new javax.swing.JButton();
        lblCarCity = new javax.swing.JLabel();
        cmbCarModel = new javax.swing.JComboBox<>();
        txtCarCity = new javax.swing.JTextField();
        lblCarSeat = new javax.swing.JLabel();
        cmbCarSeat = new javax.swing.JComboBox<>();
        btnBack = new javax.swing.JButton();
        lblCarYear = new javax.swing.JLabel();
        lblTitle = new javax.swing.JLabel();
        txtCarYear = new javax.swing.JTextField();
        lblCarName = new javax.swing.JLabel();

        lblIsAvail.setText("Is Available?");

        cmbIsAvail.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        cmbIsAvail.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmbIsAvailActionPerformed(evt);
            }
        });

        lblCarBrand.setText("Car Brand:");

        lblIsExpired.setText("Is Expired?");

        cmbIsExpired.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));

        lblCarModel.setText("Car Model:");

        btnConfirmAdd.setText("Confirm Add");
        btnConfirmAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnConfirmAddActionPerformed(evt);
            }
        });

        lblCarCity.setText("Car City:");

        cmbCarModel.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        cmbCarModel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmbCarModelActionPerformed(evt);
            }
        });

        lblCarSeat.setText("Seats Number:");

        cmbCarSeat.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        cmbCarSeat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmbCarSeatActionPerformed(evt);
            }
        });

        btnBack.setText("<< Back");
        btnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBackActionPerformed(evt);
            }
        });

        lblCarYear.setText("Production Year:");

        lblTitle.setFont(new java.awt.Font("微软雅黑", 1, 18)); // NOI18N
        lblTitle.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTitle.setText("Add New Car");

        lblCarName.setText("Car Name:");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(lblTitle, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(btnBack)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGap(173, 173, 173)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblIsAvail, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(18, 18, 18))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblIsExpired, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(30, 30, 30))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblCarName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(42, 42, 42))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblCarBrand, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(36, 36, 36))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblCarModel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(36, 36, 36))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblCarCity, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(42, 42, 42))
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(lblCarSeat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addGap(18, 18, 18))
                                    .addComponent(lblCarYear, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                                .addGap(31, 31, 31)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtCarName)
                                    .addComponent(txtCarBrand)
                                    .addComponent(txtCarCity)
                                    .addComponent(txtCarYear)
                                    .addComponent(cmbCarSeat, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(cmbIsAvail, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(cmbIsExpired, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(cmbCarModel, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                                .addGap(172, 172, 172))
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addGap(72, 72, 72)
                                .addComponent(btnConfirmAdd, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addGap(246, 246, 246))))))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(btnBack)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(lblTitle)
                .addGap(30, 30, 30)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCarName)
                    .addComponent(txtCarName, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(28, 28, 28)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCarBrand)
                    .addComponent(txtCarBrand, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(26, 26, 26)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCarModel)
                    .addComponent(cmbCarModel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(23, 23, 23)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCarCity)
                    .addComponent(txtCarCity, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(28, 28, 28)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCarSeat)
                    .addComponent(cmbCarSeat, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(35, 35, 35)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCarYear)
                    .addComponent(txtCarYear, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(30, 30, 30)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblIsAvail)
                    .addComponent(cmbIsAvail, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(30, 30, 30)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblIsExpired)
                    .addComponent(cmbIsExpired, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(34, 34, 34)
                .addComponent(btnConfirmAdd)
                .addContainerGap(70, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void cmbIsAvailActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmbIsAvailActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cmbIsAvailActionPerformed

    private void btnConfirmAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnConfirmAddActionPerformed
        // TODO add your handling code here:
        if(txtCarName.getText().equals("")||txtCarBrand.getText().equals("")||txtCarCity.getText().equals("")||txtCarYear.getText().equals("")){
        
            JOptionPane.showMessageDialog(null, "Please enter all information!", "Warning", JOptionPane.WARNING_MESSAGE);
        }else{
            
            
        Car c;
        c = admin.getCarCatalog().addCar();
        c.setCarName(txtCarName.getText());
        c.setCarBrand(txtCarBrand.getText());
        c.setCarModel(cmbCarModel.getSelectedItem().toString());
        c.setCarCity(txtCarCity.getText());
        c.setCarSeat(cmbCarSeat.getSelectedItem().toString());
        c.setCarYear(txtCarYear.getText());
        c.setIsAvail(cmbIsAvail.getSelectedItem().toString());
        c.setIsExpired(cmbIsExpired.getSelectedItem().toString());
        c.setTime(dateFormat.format(date));
        
        JOptionPane.showMessageDialog(this, "Car added");
        System.out.println(dateFormat.format(date));
        
        
        
        
        }
        
        
      

    }//GEN-LAST:event_btnConfirmAddActionPerformed

    private void cmbCarModelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmbCarModelActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cmbCarModelActionPerformed

    private void cmbCarSeatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmbCarSeatActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cmbCarSeatActionPerformed

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


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBack;
    private javax.swing.JButton btnConfirmAdd;
    private javax.swing.JComboBox<String> cmbCarModel;
    private javax.swing.JComboBox<String> cmbCarSeat;
    private javax.swing.JComboBox<String> cmbIsAvail;
    private javax.swing.JComboBox<String> cmbIsExpired;
    private javax.swing.JLabel lblCarBrand;
    private javax.swing.JLabel lblCarCity;
    private javax.swing.JLabel lblCarModel;
    private javax.swing.JLabel lblCarName;
    private javax.swing.JLabel lblCarSeat;
    private javax.swing.JLabel lblCarYear;
    private javax.swing.JLabel lblIsAvail;
    private javax.swing.JLabel lblIsExpired;
    private javax.swing.JLabel lblTitle;
    private javax.swing.JTextField txtCarBrand;
    private javax.swing.JTextField txtCarCity;
    private javax.swing.JTextField txtCarName;
    private javax.swing.JTextField txtCarYear;
    // End of variables declaration//GEN-END:variables
}
