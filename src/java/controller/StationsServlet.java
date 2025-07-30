/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StationsDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.StationsModel;

/**
 *
 * @author Jonas
 */
@WebServlet(name = "StationsServlet", urlPatterns = {"/StationsServlet"})

public class StationsServlet extends HttpServlet {

    StationsModel model = null;
    StationsDao dao = null;

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
            out.println("<title>Servlet StationsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StationsServlet at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);
        String action = null;
        action = request.getParameter("opt");

        if (action != null) {
            switch (action) {
                case "delete" ->
                    supprimer(request, response);
                default ->
                    load(request, response);
            }
        } else {
            load(request, response);
        }
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
//        processRequest(request, response);
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "Enregistrer" ->
                    enregistrer(request, response);
                case "Valider" ->
                    modifier(request, response);
                default ->
                    load(request, response);
            }
        } else {
            load(request, response);
        }
    }

    protected void load(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        dao = new StationsDao();

        try {
            List<StationsModel> listeStations = dao.lister();

            request.setAttribute("stations", listeStations);
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException ex) {
            request.setAttribute("msg", "Erreur lors du chargement des stations : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        }
    }

    protected void enregistrer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        model = new StationsModel();

        try {
            // Récupération des données du formulaire
            String commune = request.getParameter("commune");
            String adresse = request.getParameter("adresse");

            double capGazoline = request.getParameter("capacite_gazoline") != null
                    ? Double.parseDouble(request.getParameter("capacite_gazoline")) : 0.0;

            double capDiesel = request.getParameter("capacite_diesel") != null
                    ? Double.parseDouble(request.getParameter("capacite_diesel")) : 0.0;

            double qtGazoline = request.getParameter("quantite_gazoline") != null
                    ? Double.parseDouble(request.getParameter("quantite_gazoline")) : 0.0;

            double qtDiesel = request.getParameter("quantite_diesel") != null
                    ? Double.parseDouble(request.getParameter("quantite_diesel")) : 0.0;

            if (capGazoline < qtGazoline) {
                request.setAttribute("msg", "La Capacite de Gazoline ne peut pas etre inferieur a la quantite");
                try {
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                return;
            }
            if (capDiesel < qtDiesel) {
                request.setAttribute("msg", "La Capacite de Diesel ne peut pas etre inferieur a la quantite");
                try {
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(AppsServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                return;
            }

            model.setCommune(commune);
            model.setAdresse(adresse);
            model.setCapaciteGazoline(capGazoline);
            model.setCapaciteDiesel(capDiesel);
            model.setQuantiteGazoline(qtGazoline);
            model.setQuantiteDiesel(qtDiesel);

            // DAO
            dao = new StationsDao();
            if (dao.enregistrer(model) > 0) {
                request.setAttribute("msg", "Station enregistrée avec succès !");
                load(request, response); // Recharge la liste des stations
            } else {
                request.setAttribute("msg", "Erreur lors de l'enregistrement !");
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            }

        } catch (NumberFormatException ex) {
            request.setAttribute("msg", "Erreur de format numérique : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            request.setAttribute("msg", "Erreur base de données : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        }
    }

    protected void modifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        model = new StationsModel();

        try {
            int idStation = request.getParameter("id") != null
                    ? Integer.parseInt(request.getParameter("id")) : 0;
            model.setIdStation(idStation);

            // Récupération des autres données du formulaire
            model.setCommune(request.getParameter("commune"));
            model.setAdresse(request.getParameter("adresse"));

            double capGazoline = request.getParameter("capacite_gazoline") != null
                    ? Double.parseDouble(request.getParameter("capacite_gazoline")) : 0.0;
            double capDiesel = request.getParameter("capacite_diesel") != null
                    ? Double.parseDouble(request.getParameter("capacite_diesel")) : 0.0;
            double qtGazoline = request.getParameter("quantite_gazoline") != null
                    ? Double.parseDouble(request.getParameter("quantite_gazoline")) : 0.0;
            double qtDiesel = request.getParameter("quantite_diesel") != null
                    ? Double.parseDouble(request.getParameter("quantite_diesel")) : 0.0;

            List<StationsModel> listeStationId = dao.listerParId("" + idStation);

            double totalGaz = 0.0;
            double totalDie = 0.0;

            for (StationsModel sm : listeStationId) {
                totalDie += sm.getQuantiteDiesel();
                totalGaz += sm.getQuantiteGazoline();
            }

            double res = totalDie;
            if (totalGaz > capGazoline) {
                res = totalGaz;
            }
            if (totalGaz > capGazoline || totalDie > capDiesel) {
                request.setAttribute("msg", "Capacite ne peut pas etre inferieur a la quantite disponible, capacite disponible : " + res);
                request.getRequestDispatcher("messages.jsp").forward(request, response);
                return;
            }

            model.setCapaciteGazoline(capGazoline);
            model.setCapaciteDiesel(capDiesel);
            model.setQuantiteGazoline(qtGazoline);
            model.setQuantiteDiesel(qtDiesel);

            dao = new StationsDao();
            if (dao.modifier(model) > 0) {
                request.setAttribute("msg", "Station mise à jour avec succès !");
                load(request, response);
            } else {
                request.setAttribute("msg", "Erreur lors de la mise à jour.");
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            }

        } catch (NumberFormatException ex) {
            request.setAttribute("msg", "ID invalide ou non numérique : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            request.setAttribute("msg", "Erreur base de données : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        }
    }

    protected void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        dao = new StationsDao();

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
//            int idStation = Integer.parseInt(idParam);
                System.out.println(idParam);

                if (dao.rechercher(idParam) != null) {
                    if (dao.supprimer(idParam) > 0) {
                        request.setAttribute("msg", "Station supprimée avec succès !");
                        load(request, response);
                    } else {
                        request.setAttribute("msg", "Échec de la suppression.");
                        request.getRequestDispatcher("messages.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Station introuvable.");
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "ID manquant pour suppression.");
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            }

        } catch (NumberFormatException ex) {
            request.setAttribute("msg", "ID invalide : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            request.setAttribute("msg", "Erreur base de données : " + ex.getMessage());
            request.getRequestDispatcher("messages.jsp").forward(request, response);
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
