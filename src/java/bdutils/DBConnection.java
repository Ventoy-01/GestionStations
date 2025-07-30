/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bdutils;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jonas
 */
public class DBConnection {
    // definir une methode pour recuperer la connection a la BD
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException{
        // charger le pilote de la BD
        Class.forName("com.mysql.cj.jdbc.Driver");
        // definir les parametres de connection a la BD
        String url="jdbc:mysql://localhost:3306/stationdb";
        String user="root";
        String password="";
        // Etablir la connection
        return DriverManager.getConnection(url, user, password);  
        
    } 
    
    public static void closeCon(ResultSet r, PreparedStatement p,Connection c){
        
            try {
                if(r!=null){
                r.close();
                }
                 if(p!=null){
                p.close();
                }
                 if(c!=null){
                c.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
}

 
