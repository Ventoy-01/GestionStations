<%-- 
    Document   : index
    Created on : 18 juil. 2025, 21:51:47
    Author     : Jonas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="messages.jsp"%>
<%@ page import="java.util.*, model.UsersModel" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestion des Utilisateurs</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border: none;
            }
            .table-responsive {
                border-radius: 8px;
                overflow: hidden;
            }
            .table thead th {
                background-color: #4e73df;
                color: white;
                font-weight: 600;
            }
            .btn-primary {
                background-color: #4e73df;
                border: none;
            }
            .btn-primary:hover {
                background-color: #3a5bc7;
            }
            .btn-outline-secondary {
                border-color: #d1d3e2;
            }
            .btn-outline-secondary:hover {
                background-color: #f8f9fc;
            }
        </style>
    </head>
    <body>
        <%
            UsersModel user = (UsersModel) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="container py-5">
            <div class="card">
                <div class="card-header bg-white border-bottom-0">
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/DashboardServlet" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i> Retour
                        </a>
                        <h3 class="mb-0 text-center">Gestion des Utilisateurs</h3>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ajoutUserModal">
                            <i class="fas fa-plus me-2"></i> Ajouter
                        </button>
                    </div>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nom d'utilisateur</th>
                                    <th>Email</th>
                                    <th>Rôle</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<UsersModel> users = (List<UsersModel>) request.getAttribute("users");
                                    if (users != null) {
                                        for (UsersModel u : users) { 
                                %>
                                <tr>
                                    <td><%= u.getIdUser() %></td>
                                    <td><%= u.getUsername() %></td>
                                    <td><%= u.getEmail() %></td>
                                    <td>
                                        <span class="badge <%= u.getRole().equals("admin") ? "bg-primary" : "bg-secondary" %>">
                                            <%= u.getRole() %>
                                        </span>
                                    </td>

                                </tr>
                                <% 
                                        }
                                    } else { 
                                %>
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">
                                        <i class="fas fa-users-slash fa-2x mb-2"></i>
                                        <p>Aucun utilisateur trouvé</p>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal d'ajout d'utilisateur -->
        <div class="modal fade" id="ajoutUserModal" tabindex="-1" aria-labelledby="ajoutUserModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ajoutUserModalLabel">Ajouter un utilisateur</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/UsersServlet" method="POST">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="username" class="form-label">Nom d'utilisateur</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Mot de passe</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label for="role" class="form-label">Rôle</label>
                                <select class="form-select" id="role" name="role" required>
                                    <option value="user">Utilisateur</option>
                                    <option value="admin">Administrateur</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                            <button type="submit" class="btn btn-primary" name="action" value="add">Enregistrer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <%@include  file="/layout/footer.jsp"%>;

    </body>
</html>