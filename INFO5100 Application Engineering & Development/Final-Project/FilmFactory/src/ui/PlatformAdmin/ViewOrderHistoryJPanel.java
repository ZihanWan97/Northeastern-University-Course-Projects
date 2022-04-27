/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui.PlatformAdmin;

import Ecosystem.Enterprise.Enterprise;
import Ecosystem.FilmFactorySystem;
import Ecosystem.Network.Network;
import Ecosystem.Organization.Organization;
import Ecosystem.UserAccount.UserAccount;
import Ecosystem.WorkQueue.TicketRequest;
import java.awt.CardLayout;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Eva
 */
public class ViewOrderHistoryJPanel extends javax.swing.JPanel {

    /**
     * Creates new form ViewOrderHistoryJPanel
     */
    JPanel workArea;
    FilmFactorySystem system;
    UserAccount cinemaAdmin;
    public ViewOrderHistoryJPanel(JPanel workArea, UserAccount cinemaAdmin, FilmFactorySystem system) {
        initComponents();
        this.workArea= workArea;
        this.system = system;
        this.cinemaAdmin = cinemaAdmin;        
        setSize(750, 530);
        populateTable();
    }

    private void populateTable(){
        DefaultTableModel model = (DefaultTableModel) infoTable.getModel();
        model.setRowCount(0);
        //JOptionPane.showMessageDialog(this, "bp1");
        for(Network network:system.getNetworkList()) {
            //JOptionPane.showMessageDialog(this, "bp2");
            for (Enterprise enterprise: network.getEnterpriseDirectory().getEnterpriseList()) {
                //JOptionPane.showMessageDialog(this, "bp3");
                for(Organization org: enterprise.getOrganizationDirectory().getOrganizationList()) {
                    //JOptionPane.showMessageDialog(this, "bp4");
                    for(UserAccount ua: org.getUserAccountDirectory().getUserAccountList()) {
                        //JOptionPane.showMessageDialog(this, "bp5");
                        if (ua.equals(cinemaAdmin)) {
                            //JOptionPane.showMessageDialog(this, "bp6");
                            for(TicketRequest trq: ua.getTicketQueue().getTicketRequestList()) {
                                Object[] row = new Object[4];
                                row[0] = trq;
                                row[1] = trq.getCustomer().getUsername();
                                row[2] = trq.getMovie().getName();
                                row[3] = trq.getPrice();
                                //row[4] = trq.getComment();
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

        lblTitle = new javax.swing.JLabel();
        btnBack = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        infoTable = new javax.swing.JTable();
        btnViewComment = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        txaComment = new javax.swing.JTextArea();

        setBackground(new java.awt.Color(10, 10, 10));

        lblTitle.setFont(new java.awt.Font("Segoe UI Black", 1, 24)); // NOI18N
        lblTitle.setForeground(new java.awt.Color(255, 255, 255));
        lblTitle.setText("View Order History");

        btnBack.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnBack.setForeground(new java.awt.Color(255, 255, 255));
        btnBack.setText("<<Back");
        btnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBackActionPerformed(evt);
            }
        });

        infoTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Ticket ID", "Customer", "Movie", "Price"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jScrollPane1.setViewportView(infoTable);

        btnViewComment.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnViewComment.setForeground(new java.awt.Color(255, 255, 255));
        btnViewComment.setText("View Comment");
        btnViewComment.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnViewCommentActionPerformed(evt);
            }
        });

        jLabel2.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(255, 255, 255));
        jLabel2.setText("Comment:");

        txaComment.setEditable(false);
        txaComment.setBackground(new java.awt.Color(10, 10, 10));
        txaComment.setColumns(20);
        txaComment.setRows(5);
        jScrollPane2.setViewportView(txaComment);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(251, 251, 251)
                        .addComponent(lblTitle))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(35, 35, 35)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jLabel2)
                            .addComponent(btnViewComment, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(btnBack)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 672, Short.MAX_VALUE)
                            .addComponent(jScrollPane2))))
                .addContainerGap(43, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(37, 37, 37)
                .addComponent(btnBack)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(lblTitle)
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnViewComment)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 130, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(32, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBackActionPerformed
        workArea.remove(this);
        CardLayout layout = (CardLayout) workArea.getLayout();
        layout.previous(workArea);
    }//GEN-LAST:event_btnBackActionPerformed

    private void btnViewCommentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnViewCommentActionPerformed
        int selectedRowIndex = infoTable.getSelectedRow();
        if(selectedRowIndex<0){
            JOptionPane.showMessageDialog(this, "Please select a product row");
            return;
        }
        TicketRequest trq = (TicketRequest)this.infoTable.getValueAt(selectedRowIndex, 0);
        txaComment.setText(trq.getComment());
    }//GEN-LAST:event_btnViewCommentActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBack;
    private javax.swing.JButton btnViewComment;
    private javax.swing.JTable infoTable;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JLabel lblTitle;
    private javax.swing.JTextArea txaComment;
    // End of variables declaration//GEN-END:variables
}
