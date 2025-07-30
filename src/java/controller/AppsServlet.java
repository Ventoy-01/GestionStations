/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AppsDao;
import dao.StationsDao;
import java.sql.*;
import dao.UsersDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AppsModel;
import model.StationsModel;

/**
 *
 * @author Jonas
 */
@WebServlet(name = "AppsServlet", urlPatterns = {"/AppsServlet"})
public class AppsServlet extends HttpServlet {

    StationsDao station = null;
    AppsDao dao = null;

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
            out.println("<title>Servlet AppsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AppsServlet at " + request.getContextPath() + "</h1>");
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

        String action = null;
        action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "enregistrer" ->
                    enregistrer(request, response);
                default ->
                    load(request, response);
            }

        } else {
            load(request, response);
        }

    }

    protected void load(HttpServletRequest request, HttpServletResponse response) {

        dao = new AppsDao();

        try {
            List<AppsModel> listeApps = dao.lister();

            station = new StationsDao();
            List<StationsModel> listeStations = station.lister();
            request.setAttribute("Approvisionnements", listeApps);
            request.setAttribute("stations", listeStations);
            try {
                request.getRequestDispatcher("apps/index.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println("rien dans la base de donnees");
            }

        } catch (ClassNotFoundException | SQLException ex) {
            try {
                request.setAttribute("msg", "Erreur lors du chargement des approvisionnements : " + ex.getMessage());
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            } catch (ServletException | IOException ex1) {
                Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }
    }

    protected void enregistrer(HttpServletRequest request, HttpServletResponse response) {

        try {

            int idStation = Integer.parseInt(request.getParameter("idStation"));
            String typeCarburant = request.getParameter("typeCarburant");
            double quantite = Double.parseDouble(request.getParameter("quantite"));
            String fournisseur = request.getParameter("fournisseur");

            List<StationsModel> listeStation = station.listerParId("" + idStation);

            double gazDispo = 0.0;
            double dieDispo = 0.0;
            double gazCap = 0.0;
            double dieCap = 0.0;

            for (StationsModel sm : listeStation) {
                dieDispo = sm.getQuantiteDiesel();
                gazDispo = sm.getQuantiteGazoline();
                
                gazCap = sm.getCapaciteGazoline();
                dieCap = sm.getCapaciteDiesel();              
           }
            
           double resGaz = gazCap - gazDispo;
           double resDie = dieCap - dieDispo;

            if ((resGaz < quantite && typeCarburant.equalsIgnoreCase("gasoline")) ||
                 (resDie < quantite && typeCarburant.equalsIgnoreCase("diesel"))) {
                
                double res = resDie;
                if("gasoline".equalsIgnoreCase(typeCarburant)){
                    res = resGaz;
                }
                
                request.setAttribute("msg", "La Capacite restante est inferieur a la quantite approvisionnee | Capacite restante : "+res);
                try {
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                return;
            }
            
           if(typeCarburant.equalsIgnoreCase("gasoline")){
            station.modifierDisponible(""+idStation, "quantite_gazoline", (gazDispo + quantite));
           }else{
                station.modifierDisponible(""+idStation, "quantite_diesel", (dieDispo + quantite));
           }

            AppsModel app = new AppsModel();

            app.setIdStation(idStation);
            app.setTypeCarburant(typeCarburant);
            app.setQuantite(quantite);
            app.setFournisseur(fournisseur);

            dao = new AppsDao();
            if (dao.enregistrer(app) > 0) {
                load(request, response);
            } else {
                request.setAttribute("msg", "Erreur d'enregistrement");
                try {
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
