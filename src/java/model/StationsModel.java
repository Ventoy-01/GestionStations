/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Jonas
 */

public class StationsModel {

    private int idStation;
    private String commune;
    private String adresse;
    private double capaciteGazoline;
    private double capaciteDiesel;
    private double quantiteGazoline;
    private double quantiteDiesel;

    // Constructeurs
    public StationsModel() {}

    public StationsModel(int idStation, String commune, String adresse, double capaciteGazoline,
                        double capaciteDiesel, double quantiteGazoline, double quantiteDiesel) {
        this.idStation = idStation;
        this.commune = commune;
        this.adresse = adresse;
        this.capaciteGazoline = capaciteGazoline;
        this.capaciteDiesel = capaciteDiesel;
        this.quantiteGazoline = quantiteGazoline;
        this.quantiteDiesel = quantiteDiesel;
    }

    // Getters et Setters
    public int getIdStation() {
        return idStation;
    }

    public void setIdStation(int idStation) {
        this.idStation = idStation;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public double getCapaciteGazoline() {
        return capaciteGazoline;
    }

    public void setCapaciteGazoline(double capaciteGazoline) {
        this.capaciteGazoline = capaciteGazoline;
    }

    public double getCapaciteDiesel() {
        return capaciteDiesel;
    }

    public void setCapaciteDiesel(double capaciteDiesel) {
        this.capaciteDiesel = capaciteDiesel;
    }

    public double getQuantiteGazoline() {
        return quantiteGazoline;
    }

    public void setQuantiteGazoline(double quantiteGazoline) {
        this.quantiteGazoline = quantiteGazoline;
    }

    public double getQuantiteDiesel() {
        return quantiteDiesel;
    }

    public void setQuantiteDiesel(double quantiteDiesel) {
        this.quantiteDiesel = quantiteDiesel;
    }
}

