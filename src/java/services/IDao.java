/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package services;

import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Jonas
 * @param <T>
 */ 
public interface IDao <T> {
    
    int enregistrer(T e) throws ClassNotFoundException, SQLException;

    int modifier(T e) throws ClassNotFoundException, SQLException;

    int supprimer(String id) throws ClassNotFoundException, SQLException;

    T rechercher(String id) throws ClassNotFoundException, SQLException;

    List<T> lister() throws ClassNotFoundException, SQLException;
}
