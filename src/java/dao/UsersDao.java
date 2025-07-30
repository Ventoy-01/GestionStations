/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.List;
import model.UsersModel;
import services.IDao;
import bdutils.DBConnection;
import java.util.ArrayList;

/**
 *
 * @author Jonas
 */
public class UsersDao implements IDao<UsersModel>{
    Connection con = null ;
    PreparedStatement ps = null;
    ResultSet rs = null;
    

    @Override
    public int enregistrer(UsersModel e) throws ClassNotFoundException, SQLException {
       con = DBConnection.getConnection();
       
       String req = "INSERT INTO users (username, email , password, role) Values (?,?,?,?)" ;
       ps = con.prepareStatement(req);
       ps.setString(1, e.getUsername());
       ps.setString(2, e.getEmail());
       ps.setString(3, e.getPassword());
       ps.setString(4, e.getRole());
       
       int result = ps.executeUpdate();
       
       DBConnection.closeCon(rs, ps, con);
       return result;
    }

    @Override
    public int modifier(UsersModel e) throws ClassNotFoundException, SQLException {
        return 0;
    }

    @Override
    public int supprimer(String id) throws ClassNotFoundException, SQLException {
        con = DBConnection.getConnection();
       
       String req = "DELETE FROM users WHERE id = ? " ;
       ps = con.prepareStatement(req);  
       ps.setString(1, id);
       int result = ps.executeUpdate();
       
       DBConnection.closeCon(rs, ps, con);
      
       return result;
    }
    
    @Override
    public UsersModel rechercher(String id) throws ClassNotFoundException, SQLException {
        return null;
    }
    
    public UsersModel rechercher(String username, String password) throws SQLException, ClassNotFoundException {
    con = DBConnection.getConnection();
    String req = "SELECT * FROM users WHERE username=? AND password=?";
    ps = con.prepareStatement(req);
    ps.setString(1, username);
    ps.setString(2, password);
    rs = ps.executeQuery();

    if (rs.next()) {
        UsersModel user = new UsersModel();
        user.setIdUser(rs.getInt("id_user"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        return user;
    }

    return null;
}


    @Override
    public List<UsersModel> lister() throws ClassNotFoundException, SQLException {
    
    List<UsersModel> list = new ArrayList<>();
    con = DBConnection.getConnection();
    String sql = "SELECT * FROM users";
    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();

    while (rs.next()) {
        UsersModel u = new UsersModel();
        u.setIdUser(rs.getInt("id_user"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setRole(rs.getString("role"));
        list.add(u);
    }

    DBConnection.closeCon(rs, ps, con);
    return list;
}

    
}
