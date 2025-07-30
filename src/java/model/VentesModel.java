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


public class VentesModel {
    
    private int idVente;
    private int idStation;
    private int idUser;
    private String typeCarburant;
    private double quantite;
    private Date dateVente;
    private double prixUnitaire;
    private double montantTotal;

    // Constructeurs
    public VentesModel() {}

    public VentesModel(int idVente, int idStation, int idUser, String typeCarburant, double quantite,
                       Date dateVente, double prixUnitaire, double montantTotal) {
        this.idVente = idVente;
        this.idStation = idStation;
        this.idUser = idUser;
        this.typeCarburant = typeCarburant;
        this.quantite = quantite;
        this.dateVente = dateVente;
        this.prixUnitaire = prixUnitaire;
        this.montantTotal = montantTotal;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

  

 

    // Getters et Setters
    public int getIdVente() {
        return idVente;
    }

    public void setIdVente(int idVente) {
        this.idVente = idVente;
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

    public Date getDateVente() {
        return dateVente;
    }

    public void setDateVente(Date dateVente) {
        this.dateVente = dateVente;
    }

    public double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public double getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(double montantTotal) {
        this.montantTotal = montantTotal;
    }
}

