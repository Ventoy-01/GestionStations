/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UsersDao;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UsersModel;

/**
 *
 * @author Jonas
 */
@WebServlet(name = "UsersServlet", urlPatterns = {"/UsersServlet"})
public class UsersServlet extends HttpServlet {

    UsersDao ud = null;
    UsersModel um = null;

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
            out.println("<title>Servlet UsersServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UsersServlet at " + request.getContextPath() + "</h1>");
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
        action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "logout" ->
                    logout(request, response);
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
        String action = null;
        action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "login" ->
                    login(request, response);
                case "add" ->
                    enregistrer(request, response);
                default ->
                    load(request, response);
            }
        } else {
            load(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) {

        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        if (userName != null && password != null && !userName.isEmpty() && !password.isEmpty()) {
            try {
                um = new UsersModel();
                ud = new UsersDao();
                
                um = ud.rechercher(userName, password);
                if (um != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", um);
                    response.sendRedirect("DashboardServlet");
                } else {
                    request.setAttribute("msg", "Nom d'utilisateur ou mot de passe incorrect.");
                    response.sendRedirect("login.jsp?error=1");
                }
            } catch (ClassNotFoundException | SQLException | IOException ex) {
                try {
                    request.setAttribute("msg", ex.getMessage());
                    request.getRequestDispatcher("messages.jsp").forward(request, response);
                } catch (ServletException | IOException ex1) {
                    Logger.getLogger(UsersServlet.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
        } else {
            request.setAttribute("msg", "Veuillez remplir tous les champs.");
            try {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(UsersServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void load(HttpServletRequest request, HttpServletResponse response) {
        try {
            UsersDao dao = new UsersDao();
            List<UsersModel> users = dao.lister();
            request.setAttribute("users", users);
            request.getRequestDispatcher("users/index.jsp").forward(request, response);
        } catch (ServletException | IOException | ClassNotFoundException | SQLException ex) {
            try {
                request.setAttribute("msg", "Erreur lors du chargement des utilisateurs : " + ex.getMessage());
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            } catch (ServletException | IOException e) {

            }
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp");
        } catch (IOException ex) {
            Logger.getLogger(UsersServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void enregistrer(HttpServletRequest request, HttpServletResponse response) {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            UsersModel user = new UsersModel();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            UsersDao dao = new UsersDao();
            int result = dao.enregistrer(user);

            if (result > 0) {
                load(request, response);
            } else {
                request.setAttribute("msg", "Échec de l'enregistrement de l'utilisateur.");
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            }

        } catch (ServletException | IOException | ClassNotFoundException | SQLException ex) {
            try {
                request.setAttribute("msg", "Erreur lors de l'enregistrement : " + ex.getMessage());
                request.getRequestDispatcher("messages.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
            
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
