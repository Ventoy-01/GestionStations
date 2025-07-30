/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import java.sql.*;
import java.util.List;
import services.IDao;
import model.StationsModel;
import bdutils.DBConnection;
import java.util.ArrayList;
/**
 *
 * @author Jonas
 */

public class StationsDao implements IDao<StationsModel>{
    //creation des variables globales
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    

    @Override
    public int enregistrer(StationsModel e) throws ClassNotFoundException, SQLException {
        
        //on recupere la connexion de la base de donnees (getConnection())
        con = DBConnection.getConnection();
        //requete sql d'enregistrement 
        String req = "INSERT INTO stations (commune, adresse, capacite_gazoline, capacite_diesel, quantite_gazoline, quantite_diesel) " +
                 "VALUES (?, ?, ?, ?, ?, ?)";        
        //preparation de la requete
        ps = con.prepareStatement(req);
        
        //passage des arguments
        ps.setString(1, e.getCommune());
        ps.setString(2, e.getAdresse());
        ps.setDouble(3, e.getCapaciteGazoline());
        ps.setDouble(4, e.getCapaciteDiesel());
        ps.setDouble(5, e.getQuantiteGazoline());
        ps.setDouble(6, e.getQuantiteDiesel());
       
        //execution de la requete
        int result = ps.executeUpdate();
        //fermeture de la connection
        DBConnection.closeCon(rs, ps, con);        
        //retour du resultat
        return result;
    }
    

    @Override
    public int modifier(StationsModel e) throws ClassNotFoundException, SQLException {
        // Connexion a la base
        con = DBConnection.getConnection();

        // Requete SQL de mise a jour
        String req = "UPDATE stations SET commune = ?, adresse = ?, capacite_gazoline = ?, capacite_diesel = ?, "
                   + "quantite_gazoline = ?, quantite_diesel = ? WHERE id_station = ?";

        // Preparation de la requete
        ps = con.prepareStatement(req);

        // Passage des paramètres
        ps.setString(1, e.getCommune());
        ps.setString(2, e.getAdresse());
        ps.setDouble(3, e.getCapaciteGazoline());
        ps.setDouble(4, e.getCapaciteDiesel());
        ps.setDouble(5, e.getQuantiteGazoline());
        ps.setDouble(6, e.getQuantiteDiesel());
        ps.setInt(7, e.getIdStation()); 

        // Execution
        int result = ps.executeUpdate();        
        //fermeture de la connection
        DBConnection.closeCon(rs, ps, con);
        //retour du resultat
        return result;
    }
    
    public int modifierDisponible(String idStation, String colonne, Double value) throws ClassNotFoundException, SQLException {
        // Connexion a la base
        con = DBConnection.getConnection();

        // Requete SQL de mise a jour
        String req = "UPDATE stations SET "+colonne+" = ? WHERE id_station = ?";
        // Preparation de la requete
        ps = con.prepareStatement(req);
        // Passage des paramètres
        ps.setDouble(1, value);
        ps.setString(2, idStation);
         
        // Execution
        int result = ps.executeUpdate();        
        //fermeture de la connection
        DBConnection.closeCon(rs, ps, con);
        //retour du resultat
        return result;
    }
    @Override
    public int supprimer(String id) throws ClassNotFoundException, SQLException {
        //les meme commentaires dessus
        con = DBConnection.getConnection();

        String req = "DELETE FROM stations WHERE id_station = ?";
        ps = con.prepareStatement(req);
        ps.setString(1, id);

        int result = ps.executeUpdate();
        DBConnection.closeCon(rs, ps, con);

        return result;
    }

    @Override
    public StationsModel rechercher(String id) throws ClassNotFoundException, SQLException {
        //les meme commentaires dessus 
        con = DBConnection.getConnection();
        String req = "SELECT * FROM stations WHERE id_station = ?";
        ps = con.prepareStatement(req);
        ps.setString(1, id);

        rs = ps.executeQuery();

        StationsModel station = null;

        if (rs.next()) {
            station = new StationsModel();
            station.setIdStation(rs.getInt("id_station"));
            station.setCommune(rs.getString("commune"));
            station.setAdresse(rs.getString("adresse"));
            station.setCapaciteGazoline(rs.getDouble("capacite_gazoline"));
            station.setCapaciteDiesel(rs.getDouble("capacite_diesel"));
            station.setQuantiteGazoline(rs.getDouble("quantite_gazoline"));
            station.setQuantiteDiesel(rs.getDouble("quantite_diesel"));
        }

        DBConnection.closeCon(rs, ps, con);


        return station;
    }

    @Override
    public List<StationsModel> lister() throws ClassNotFoundException, SQLException {
        con = DBConnection.getConnection();

        String req = "SELECT * FROM stations";
        ps = con.prepareStatement(req);
        rs = ps.executeQuery();

        List<StationsModel> liste = new ArrayList<>();

        while (rs.next()) {
            StationsModel station = new StationsModel();
            station.setIdStation(rs.getInt("id_station"));
            station.setCommune(rs.getString("commune"));
            station.setAdresse(rs.getString("adresse"));
            station.setCapaciteGazoline(rs.getDouble("capacite_gazoline"));
            station.setCapaciteDiesel(rs.getDouble("capacite_diesel"));
            station.setQuantiteGazoline(rs.getDouble("quantite_gazoline"));
            station.setQuantiteDiesel(rs.getDouble("quantite_diesel"));

            liste.add(station);
        }

        DBConnection.closeCon(rs, ps, con);


        return liste; 
    }
    
    
    public List<StationsModel> listerParId(String id) throws ClassNotFoundException, SQLException {
        con = DBConnection.getConnection();

        String req = "SELECT * FROM stations where id_station = ?";
        ps = con.prepareStatement(req);
        ps.setString(1, id);
        rs = ps.executeQuery();

        List<StationsModel> liste = new ArrayList<>();

        while (rs.next()) {
            StationsModel station = new StationsModel();
            station.setIdStation(rs.getInt("id_station"));
            station.setCommune(rs.getString("commune"));
            station.setAdresse(rs.getString("adresse"));
            station.setCapaciteGazoline(rs.getDouble("capacite_gazoline"));
            station.setCapaciteDiesel(rs.getDouble("capacite_diesel"));
            station.setQuantiteGazoline(rs.getDouble("quantite_gazoline"));
            station.setQuantiteDiesel(rs.getDouble("quantite_diesel"));

            liste.add(station);
        }

        DBConnection.closeCon(rs, ps, con);


        return liste; 
    }
    
}
