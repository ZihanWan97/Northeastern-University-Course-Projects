/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui.FilmCameraman;

import Ecosystem.FilmFactorySystem;
import Ecosystem.UserAccount.UserAccount;
import Ecosystem.WorkQueue.FilmRequest;
import java.io.File;
import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Eva
 */
public class FilmCameramanWorkAreaJPanel extends javax.swing.JPanel {

    /**
     * Creates new form FilmCameramanWorkAreaJpanel
     */
    JPanel workArea;
    FilmFactorySystem system;
    UserAccount account;
    public FilmCameramanWorkAreaJPanel(JPanel workArea, UserAccount account, FilmFactorySystem system) {
        initComponents();
        this.account = account;
        this.workArea= workArea;
        this.system = system;
        setSize(750, 530);
        populateTable();
    }
    
    private void populateTable(){
        DefaultTableModel model = (DefaultTableModel) infoTable.getModel();
        model.setRowCount(0);
        //JOptionPane.showMessageDialog(this, "bp1");
        for(FilmRequest m: account.getFilmQueue().getFilmRequestList()){
            //JOptionPane.showMessageDialog(this, "bp2");
            Object[] row = new Object[3];
            row[0] = m;
            row[1] = m.getMovie().getName();
            row[2] = m.getMovie().getType();
            //row[3] = m.getMovie().
            model.addRow(row);
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
        jScrollPane1 = new javax.swing.JScrollPane();
        infoTable = new javax.swing.JTable();
        lblScriptwriter = new javax.swing.JLabel();
        jLabel20 = new javax.swing.JLabel();
        lblMovieDuration = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        txtMovieDescription = new javax.swing.JTextArea();
        lblPoster = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        lblMovieType = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel17 = new javax.swing.JLabel();
        lblCameraman = new javax.swing.JLabel();
        btnView = new javax.swing.JButton();
        btnUpload = new javax.swing.JButton();
        jLabel7 = new javax.swing.JLabel();
        lblDirector = new javax.swing.JLabel();

        setBackground(new java.awt.Color(10, 10, 10));

        lblTitle.setFont(new java.awt.Font("Segoe UI Black", 1, 24)); // NOI18N
        lblTitle.setForeground(new java.awt.Color(255, 255, 255));
        lblTitle.setText("Film Cameraman Work Area");

        infoTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null},
                {null, null, null},
                {null, null, null},
                {null, null, null}
            },
            new String [] {
                "Movie ID", "Movie Name", "Movie Type"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jScrollPane1.setViewportView(infoTable);

        lblScriptwriter.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        lblScriptwriter.setForeground(new java.awt.Color(255, 255, 255));

        jLabel20.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel20.setForeground(new java.awt.Color(255, 255, 255));
        jLabel20.setText("Director:");

        lblMovieDuration.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        lblMovieDuration.setForeground(new java.awt.Color(255, 255, 255));

        jLabel8.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel8.setForeground(new java.awt.Color(255, 255, 255));
        jLabel8.setText("Movie Type:");

        jLabel9.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel9.setForeground(new java.awt.Color(255, 255, 255));
        jLabel9.setText("Movie Description:");

        txtMovieDescription.setEditable(false);
        txtMovieDescription.setBackground(new java.awt.Color(10, 10, 10));
        txtMovieDescription.setColumns(20);
        txtMovieDescription.setRows(5);
        jScrollPane2.setViewportView(txtMovieDescription);

        lblPoster.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(255, 255, 255)));

        jLabel16.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel16.setForeground(new java.awt.Color(255, 255, 255));
        jLabel16.setText("Cameramen:");

        lblMovieType.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        lblMovieType.setForeground(new java.awt.Color(255, 255, 255));

        jLabel3.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 255, 255));
        jLabel3.setText("Movie Details:");

        jLabel17.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel17.setForeground(new java.awt.Color(255, 255, 255));
        jLabel17.setText("Scriptwriters:");

        lblCameraman.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        lblCameraman.setForeground(new java.awt.Color(255, 255, 255));

        btnView.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnView.setForeground(new java.awt.Color(255, 255, 255));
        btnView.setText("View Details");
        btnView.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnViewActionPerformed(evt);
            }
        });

        btnUpload.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        btnUpload.setForeground(new java.awt.Color(255, 255, 255));
        btnUpload.setText("Upload Poster");
        btnUpload.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnUploadActionPerformed(evt);
            }
        });

        jLabel7.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        jLabel7.setForeground(new java.awt.Color(255, 255, 255));
        jLabel7.setText("Movie Duration:");

        lblDirector.setFont(new java.awt.Font("Segoe Print", 1, 14)); // NOI18N
        lblDirector.setForeground(new java.awt.Color(255, 255, 255));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(65, 65, 65)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 615, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                            .addComponent(btnUpload)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(btnView))
                        .addGroup(layout.createSequentialGroup()
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addComponent(lblPoster, javax.swing.GroupLayout.PREFERRED_SIZE, 180, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jLabel3))
                            .addGap(36, 36, 36)
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                .addComponent(jLabel8)
                                .addComponent(jLabel9)
                                .addComponent(jLabel7)
                                .addComponent(jLabel20)
                                .addComponent(jLabel16)
                                .addComponent(jLabel17))
                            .addGap(18, 18, 18)
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 251, Short.MAX_VALUE)
                                .addComponent(lblMovieType, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(lblMovieDuration, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(lblDirector, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(lblCameraman, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(lblScriptwriter, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(140, 140, 140)
                        .addComponent(lblTitle)))
                .addContainerGap(70, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(25, 25, 25)
                .addComponent(lblTitle)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 92, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnView)
                    .addComponent(btnUpload))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel8)
                            .addComponent(lblMovieType, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel9)
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jLabel7, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(lblMovieDuration, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jLabel20, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(lblDirector, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jLabel16, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(lblCameraman, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel17)
                            .addComponent(lblScriptwriter, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(lblPoster, javax.swing.GroupLayout.PREFERRED_SIZE, 240, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(37, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnUploadActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnUploadActionPerformed
        int selectedRowIndex = infoTable.getSelectedRow();
        if(selectedRowIndex<0){
            JOptionPane.showMessageDialog(this, "Please select a product row");
            return;
        }
        FilmRequest frq = (FilmRequest)this.infoTable.getValueAt(selectedRowIndex, 0);
        JFileChooser jFileChooser = new JFileChooser();
        jFileChooser.setCurrentDirectory(new File(System.getProperty("user.home")));
        
        FileNameExtensionFilter fileFilter = new FileNameExtensionFilter("jpg", "png","gif","*.Images");
        jFileChooser.addChoosableFileFilter(fileFilter);
        
        int fileState = jFileChooser.showSaveDialog(null);
        
        if(fileState == JFileChooser.APPROVE_OPTION){
            System.out.println("upload approve");
            File picture = jFileChooser.getSelectedFile();
            String path = picture.getAbsolutePath();
            ImageIcon pic = new ImageIcon(path);
                      
            //lblUpload.setIcon(new  ImageIcon(path));
            lblPoster.setIcon(pic); 
            frq.getMovie().setPicPath(path);
            populateTable();
        }
        else if(fileState == JFileChooser.CANCEL_OPTION) {
            System.out.println("upload cancel");
        }
            
        
    }//GEN-LAST:event_btnUploadActionPerformed

    private void btnViewActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnViewActionPerformed
        int selectedRowIndex = infoTable.getSelectedRow();
        if(selectedRowIndex<0){
            JOptionPane.showMessageDialog(this, "Please select a product row");
            return;
        }
        FilmRequest frq = (FilmRequest)this.infoTable.getValueAt(selectedRowIndex, 0);
        lblCameraman.setText(frq.getMovie().getCameraman().getUsername());
        lblDirector.setText(frq.getMovie().getDirector().getUsername());
        lblMovieDuration.setText(String.valueOf(frq.getMovie().getDuration()));
        lblMovieType.setText(frq.getMovie().getType());
        lblScriptwriter.setText(frq.getMovie().getScriptwriter().getUsername());
        txtMovieDescription.setText(frq.getMovie().getDescription());
        lblPoster.setIcon(new ImageIcon(frq.getMovie().getPicPath()));
    }//GEN-LAST:event_btnViewActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnUpload;
    private javax.swing.JButton btnView;
    private javax.swing.JTable infoTable;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JLabel lblCameraman;
    private javax.swing.JLabel lblDirector;
    private javax.swing.JLabel lblMovieDuration;
    private javax.swing.JLabel lblMovieType;
    private javax.swing.JLabel lblPoster;
    private javax.swing.JLabel lblScriptwriter;
    private javax.swing.JLabel lblTitle;
    private javax.swing.JTextArea txtMovieDescription;
    // End of variables declaration//GEN-END:variables
}
