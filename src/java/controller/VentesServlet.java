/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StationsDao;
import dao.UsersDao;
import dao.VentesDao;
import model.VentesModel;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AppsModel;
import model.StationsModel;
import model.UsersModel;

/**
 *
 * @author Jonas
 */
@WebServlet(name = "VentesServlet", urlPatterns = {"/VentesServlet"})
public class VentesServlet extends HttpServlet {

    VentesDao dao = null;
    StationsDao sd = null;
    UsersDao ud = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VentesServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VentesServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        load(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        String action = null;
        action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add" ->
                    enregistrer(request, response);
                default ->
                    load(request, response);
            }
        } else {
            load(request, response);
        }

    }

    protected void load(HttpServletRequest request, HttpServletResponse response) {

        try {
            
            ud = new UsersDao();
            dao = new VentesDao();
            sd = new StationsDao();
            
            List<UsersModel> listeUsers = ud.lister();
            List<VentesModel> listeVentes = dao.lister();
            
            double totalVentes = 0;
            double totalGasoline = 0;
            double totalDiesel = 0;
            try {
                List<StationsModel> listeStations = sd.lister();
                
                for (VentesModel v : listeVentes) {
                    totalVentes += v.getMontantTotal();
                    if ("gasoline".equalsIgnoreCase(v.getTypeCarburant())) {
                        totalGasoline += v.getQuantite();
                    } else if ("diesel".equalsIgnoreCase(v.getTypeCarburant())) {
                        totalDiesel += v.getQuantite();
                    }
                }
                
                request.setAttribute("ventes", listeVentes);
                request.setAttribute("stations", listeStations);
                request.setAttribute("users", listeUsers);
                request.setAttribute("totalVentes", totalVentes);
                request.setAttribute("totalGasoline", totalGasoline);
                request.setAttribute("totalDiesel", totalDiesel);
                request.getRequestDispatcher("/ventes/index.jsp").forward(request, response);
                
            } catch (ClassNotFoundException | SQLException | ServletException | IOException ex) {
                try {
                    request.setAttribute("msg", "Erreur lors du chargement des ventes : " + ex.getMessage());
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex1) {
                    Logger.getLogger(VentesServlet.class.getName()).log(Level.SEVERE, null, ex1);
                }
                
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VentesServlet.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    private void enregistrer(HttpServletRequest request, HttpServletResponse response) {
        try {
            
            sd = new StationsDao();
            
            int idStation = Integer.parseInt(request.getParameter("idStation"));
            int idUser = Integer.parseInt(request.getParameter("idUser"));
            String typeCarburant = request.getParameter("typeCarburant");
            double quantite = Double.parseDouble(request.getParameter("quantite"));
            double prixUnitaire = Double.parseDouble(request.getParameter("prixUnitaire"));
            double montantTotal = quantite * prixUnitaire;
            
            double gDispo = 0.0;
            double dDispo = 0.0;
            //recherche du station pour trouver sa capacite disponible
            List<StationsModel> stationTrouve = sd.listerParId(""+idStation);
            for(StationsModel sm : stationTrouve){
                gDispo = sm.getQuantiteGazoline();
               dDispo =  sm.getQuantiteDiesel();
               break;
            }
            if((gDispo < quantite && typeCarburant.equalsIgnoreCase("gasoline")) ||
                    (dDispo < quantite && typeCarburant.equalsIgnoreCase("diesel"))
            ){
               request.setAttribute("msg","pas de carburant suffisant pour faire cette vente, Quantite disponible : "
                       + "Diesel : "+dDispo + " Gazoline : "+gDispo);
                try {
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(VentesServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                return;
            }
            if(typeCarburant.equalsIgnoreCase("gasoline")){
            sd.modifierDisponible(""+idStation, "quantite_gazoline", (gDispo - quantite));
           }else{
                sd.modifierDisponible(""+idStation, "quantite_diesel", (dDispo - quantite));
           }

            VentesModel vente = new VentesModel();
            
            vente.setIdStation(idStation);
            vente.setIdUser(idUser);
            vente.setTypeCarburant(typeCarburant);
            vente.setQuantite(quantite);
            vente.setPrixUnitaire(prixUnitaire);
            vente.setMontantTotal(montantTotal);

            // Enregistrement en base de données
            dao = new VentesDao();
            if (dao.enregistrer(vente) > 0) {
                request.setAttribute("msg", "Vente enregistrée avec succès !");
                load(request, response); // Recharge la liste des ventes
            }

        } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
            try {
                request.setAttribute("error", "Erreur lors de l'enregistrement de la vente : " + e.getMessage());
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(VentesServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
