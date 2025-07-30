/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Jonas
 */
   
import java.util.Date;

public class AppsModel {

    private int idApp;
    private int idStation;
    private String typeCarburant;
    private double quantite;
    private Date dateApp;
    private String fournisseur;

    // Constructeurs
    public AppsModel() {}

    public AppsModel(int idApp, int idStation, String typeCarburant, double quantite,
                                   Date dateApp, String fournisseur) {
        this.idApp = idApp;
        this.idStation = idStation;
        this.typeCarburant = typeCarburant;
        this.quantite = quantite;
        this.dateApp = dateApp;
        this.fournisseur = fournisseur;
    }

    // Getters et Setters
    public int getIdApp() {
        return idApp;
    }

    public void setIdApp(int idApp) {
        this.idApp = idApp;
    }

    public int getIdStation() {
        return idStation;
    }

    public void setIdStation(int idStation) {
        this.idStation = idStation;
    }

    public String getTypeCarburant() {
        return typeCarburant;
    }

    public void setTypeCarburant(String typeCarburant) {
        this.typeCarburant = typeCarburant;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public Date getDateApp() {
        return dateApp;
    }

    public void setDateApp(Date dateApp) {
        this.dateApp = dateApp;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }
}

