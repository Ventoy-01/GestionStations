/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import bdutils.DBConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.VentesModel;
import services.IDao;

/**
 *
 * @author Jonas
 */
public class VentesDao implements IDao<VentesModel> {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    @Override
    public int enregistrer(VentesModel e) throws ClassNotFoundException, SQLException {
        con = DBConnection.getConnection();
        String req = "INSERT INTO ventes (id_station, id_user, type_carburant, quantite, prix_unitaire, montant_total ) "
                + "values (?, ?, ?, ?, ?, ?) ";

        ps = con.prepareStatement(req);

        ps.setInt(1, e.getIdStation());
        ps.setInt(2, e.getIdUser());
        ps.setString(3, e.getTypeCarburant());
        ps.setDouble(4, e.getQuantite());
        ps.setDouble(5, e.getPrixUnitaire());
        ps.setDouble(6, e.getMontantTotal());

        int result = ps.executeUpdate();

        DBConnection.closeCon(rs, ps, con);

        return result;
    }

    @Override
    public int modifier(VentesModel e) throws ClassNotFoundException, SQLException {

        con = DBConnection.getConnection();

        String req = "UPDATE ventes set type_carburant = ?, quantite = ?, prix_unitaire = ?, montant_total = ? Where id_vente=?";

        ps = con.prepareStatement(req);

        ps.setString(1, e.getTypeCarburant());
        ps.setDouble(2, e.getQuantite());
        ps.setDouble(3, e.getPrixUnitaire());
        ps.setDouble(4, e.getMontantTotal());
        ps.setDouble(5, e.getIdVente());

        int result = ps.executeUpdate();

        DBConnection.closeCon(rs, ps, con);

        return result;
    }

    @Override
    public int supprimer(String id) throws ClassNotFoundException, SQLException {

        con = DBConnection.getConnection();

        String req = "DELETE * FROM ventes where id_Vente = ?";

        ps = con.prepareStatement(req);
        ps.setString(1, id);

        int result = ps.executeUpdate();
        DBConnection.closeCon(rs, ps, con);

        return result;
    }

    @Override
    public VentesModel rechercher(String id) throws ClassNotFoundException, SQLException {

        con = DBConnection.getConnection();

        String req = "SELECT * from ventes where id_vente = ?";

        ps = con.prepareStatement(req);
        ps.setString(1, id);

        rs = ps.executeQuery();

        VentesModel vente = null;

        if (rs.next()) {
            vente = new VentesModel();

            vente.setIdVente(rs.getInt("id_vente"));
            vente.setIdStation(rs.getInt("id_station"));
            vente.setIdUser(rs.getInt("id_user"));
            vente.setTypeCarburant(rs.getString("type_carburant"));
            vente.setQuantite(rs.getDouble("quantite"));
            vente.setPrixUnitaire(rs.getDouble("prix_unitaire"));
            vente.setDateVente(rs.getDate("date_vente"));
            vente.setMontantTotal(rs.getDouble("montant_total"));
        }

        DBConnection.closeCon(rs, ps, con);

        return vente;
    }

    @Override
    public List<VentesModel> lister() throws ClassNotFoundException, SQLException {
        con = DBConnection.getConnection();

        String req = "SELECT * from ventes";

        ps = con.prepareStatement(req);

        rs = ps.executeQuery();

        List<VentesModel> liste = new ArrayList<>();

        while (rs.next()) {

            VentesModel vente = new VentesModel();

            vente.setIdVente(rs.getInt("id_vente"));
            vente.setIdStation(rs.getInt("id_station"));
            vente.setIdUser(rs.getInt("id_user"));
            vente.setTypeCarburant(rs.getString("type_carburant"));
            vente.setQuantite(rs.getDouble("quantite"));
            vente.setPrixUnitaire(rs.getDouble("prix_unitaire"));
            vente.setDateVente(rs.getDate("date_vente"));
            vente.setMontantTotal(rs.getDouble("montant_total"));

            liste.add(vente);

        }

        return liste;
    }

    public List<VentesModel> listerTroisDernieres() throws ClassNotFoundException, SQLException {
        List<VentesModel> ventes = new ArrayList<>();
        con = DBConnection.getConnection();

        String req = "SELECT * FROM ventes ORDER BY date_vente DESC LIMIT 3";
        ps = con.prepareStatement(req);
        rs = ps.executeQuery();

        while (rs.next()) {
            VentesModel v = new VentesModel();
            v.setIdVente(rs.getInt("id_vente"));
            v.setIdStation(rs.getInt("id_station"));
            v.setTypeCarburant(rs.getString("type_carburant"));
            v.setQuantite(rs.getDouble("quantite"));
            v.setDateVente(rs.getTimestamp("date_vente"));
            ventes.add(v);
        }

        DBConnection.closeCon(rs, ps, con);

        return ventes;
    }
    //////////////////////////////////////////
    /////////////////////////////////////////
    ////////////////////////////////////////

    public Map<String, Object> getTopStationByType(String typeCarburant) throws SQLException, ClassNotFoundException {
        Map<String, Object> data = null;

        String sql = """
        SELECT v.id_station,  s.commune,
               SUM(v.quantite) AS total_quantite,
               SUM(v.montant_total) AS total_revenu
        FROM ventes v
        JOIN stations s ON v.id_station = s.id_station
        WHERE v.type_carburant = ?
        GROUP BY v.id_station, s.commune
        ORDER BY total_revenu DESC
        LIMIT 1
    """;

        con = DBConnection.getConnection();
        ps = con.prepareStatement(sql);

            ps.setString(1, typeCarburant);
            rs = ps.executeQuery();

            if (rs.next()) {
                data = new HashMap<>();
                data.put("id_station", rs.getInt("id_station"));
                data.put("commune", rs.getString("commune"));
                data.put("quantite", rs.getDouble("total_quantite"));
                data.put("montant", rs.getDouble("total_revenu"));
            }
        

        return data;
    }

}
