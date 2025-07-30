/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import bdutils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.AppsModel;
import services.IDao;

/**
 *
 * @author Jonas
 */


public class AppsDao implements IDao<AppsModel>{

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    // Enregistrer un approvisionnement
    @Override
    public int enregistrer(AppsModel app) throws SQLException, ClassNotFoundException {
        con = DBConnection.getConnection();
        String req = "INSERT INTO approvisionnements (id_station, type_carburant, quantite, fournisseur) VALUES (?, ?, ?, ?)";

        ps = con.prepareStatement(req);
        ps.setInt(1, app.getIdStation());
        ps.setString(2, app.getTypeCarburant());
        ps.setDouble(3, app.getQuantite());
        ps.setString(4, app.getFournisseur());

        int result = ps.executeUpdate();
        DBConnection.closeCon(rs, ps, con);
        System.out.println("Résultat de l'enregistrement : " + result);
        return result;
    }

    @Override
    public List<AppsModel> lister() throws SQLException, ClassNotFoundException {
        
        List<AppsModel> liste = new ArrayList<>();
        con = DBConnection.getConnection();
        String req = "SELECT * FROM approvisionnements";

        ps = con.prepareStatement(req);
        rs = ps.executeQuery();

        while (rs.next()) {
            AppsModel app = new AppsModel();
            app.setIdApp(rs.getInt("id_app"));
            app.setIdStation(rs.getInt("id_station"));
            app.setTypeCarburant(rs.getString("type_carburant"));
            app.setQuantite(rs.getDouble("quantite"));
            app.setDateApp(rs.getDate("date_app"));
            app.setFournisseur(rs.getString("fournisseur"));

            liste.add(app);
        }

        DBConnection.closeCon(rs, ps, con);
        return liste;
    }

    @Override
    public AppsModel rechercher(String id) throws SQLException, ClassNotFoundException {
        con = DBConnection.getConnection();
        String req = "SELECT * FROM approvisionnements WHERE id_app = ?";

        ps = con.prepareStatement(req);
        ps.setString(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            AppsModel app = new AppsModel();
            app.setIdApp(rs.getInt("id_app"));
            app.setIdStation(rs.getInt("id_station"));
            app.setTypeCarburant(rs.getString("type_carburant"));
            app.setQuantite(rs.getInt("quantite"));
            app.setDateApp(rs.getDate("date_app"));
            app.setFournisseur(rs.getString("fournisseur"));

            DBConnection.closeCon(rs, ps, con);
            return app;
        }

        DBConnection.closeCon(rs, ps, con);
        return null;
    }
    
    
    @Override
    public int supprimer(String id) throws SQLException, ClassNotFoundException {
        con = DBConnection.getConnection();
        String req = "DELETE FROM approvisionnements WHERE id_app = ?";
        ps = con.prepareStatement(req);
        ps.setString(1, id);
        int result = ps.executeUpdate();

        DBConnection.closeCon(rs, ps, con);
        return result;
    }

    // Mettre à jour un approvisionnement
    @Override
    public int modifier(AppsModel app) throws SQLException, ClassNotFoundException {
        con = DBConnection.getConnection();
        String req = "UPDATE approvisionnements SET id_station=?, type_carburant=?, quantite=?, date_app=?, fournisseur=? WHERE id_app=?";

        ps = con.prepareStatement(req);
        ps.setInt(1, app.getIdStation());
        ps.setString(2, app.getTypeCarburant());
        ps.setDouble(3, app.getQuantite());
        ps.setDate(4, new java.sql.Date(app.getDateApp().getTime()));
        ps.setString(5, app.getFournisseur());
        ps.setInt(6, app.getIdApp());

        int result = ps.executeUpdate();
        DBConnection.closeCon(rs, ps, con);
        return result;
    }
    
    
    public List<AppsModel> listerParIdStation(String idStation) throws SQLException, ClassNotFoundException {
        
        List<AppsModel> liste = new ArrayList<>();
        con = DBConnection.getConnection();
        String req = "SELECT * FROM approvisionnements where id_station = ?";

        ps = con.prepareStatement(req);
        ps.setString(1, idStation);
        rs = ps.executeQuery();

        while (rs.next()) {
            AppsModel app = new AppsModel();
            app.setIdApp(rs.getInt("id_app"));
            app.setIdStation(rs.getInt("id_station"));
            app.setTypeCarburant(rs.getString("type_carburant"));
            app.setQuantite(rs.getDouble("quantite"));
            app.setDateApp(rs.getDate("date_app"));
            app.setFournisseur(rs.getString("fournisseur"));

            liste.add(app);
        }

        DBConnection.closeCon(rs, ps, con);
        return liste;
    }
    
    public List<AppsModel> getTroisDerniersApprovisionnements() throws ClassNotFoundException, SQLException {
    List<AppsModel> derniersApps = new ArrayList<>();
    con = DBConnection.getConnection();

    String req = "SELECT * FROM approvisionnements ORDER BY date_app DESC LIMIT 3";
    ps = con.prepareStatement(req);
    rs = ps.executeQuery();

    while (rs.next()) {
        AppsModel app = new AppsModel();
        app.setIdApp(rs.getInt("id_app"));
        app.setIdStation(rs.getInt("id_station"));
        app.setTypeCarburant(rs.getString("type_carburant"));
        app.setQuantite(rs.getInt("quantite"));
        app.setFournisseur(rs.getString("fournisseur"));
        app.setDateApp(rs.getTimestamp("date_app"));
        derniersApps.add(app);
    }

    DBConnection.closeCon(rs, ps, con);
    return derniersApps;
}

    
    
}

