<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="messages.jsp"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gestion des Approvisionnements</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .badge-gasoline {
                background-color: #28a745;
            }
            .badge-diesel {
                background-color: #17a2b8;
            }
        </style>
    </head>
    <body class="bg-light">
        <%
            UsersModel user = (UsersModel) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <div class="container mt-5">
            <!-- Titre et bouton -->
            <div class="d-flex justify-content-between align-items-center flex-wrap mb-4 p-4 rounded shadow-sm bg-white border border-primary-subtle">
                <div class="d-flex flex-wrap justify-content-between align-items-start gap-4 mb-4 p-4 rounded shadow-sm bg-white border border-primary-subtle">

                    <div class="d-flex flex-column flex-md-row align-items-start gap-3">
                        <div class="d-flex align-items-center gap-2">
                            <i class="fas fa-truck-loading text-primary fs-4"></i>
                            <h2 class="h4 fw-bold text-primary mb-0">Gestion des Approvisionnements</h2>
                        </div>
                        <span class="badge bg-info text-dark mt-2 mt-md-0">
                            Dernière mise à jour :
                            <%= new java.text.SimpleDateFormat("dd MMM yyyy à HH:mm").format(new java.util.Date()) %>
                        </span>
                    </div>

                    <div class="d-flex justify-content-between align-items-center w-100 mb-4">
                        <div>
                            <a href="${pageContext.request.contextPath}/DashboardServlet" class="btn btn-outline-secondary shadow-sm">
                                <i class="fas fa-arrow-left me-2"></i> Retour
                            </a>
                        </div>

                        <div>
                            <button class="btn btn-primary d-flex align-items-center shadow-sm"
                                    data-bs-toggle="modal" data-bs-target="#addModal">
                                <i class="fas fa-plus me-2"></i> Ajouter un approvisionnement
                            </button>
                        </div>

                    </div>

                </div>

            </div>

            <!-- Tableau approvisionnements -->
            <div class="card shadow-sm border-0 rounded mb-5">
                <div class="card-body">
                    <%
                        List<AppsModel> approvisionnements = (List<AppsModel>) request.getAttribute("Approvisionnements");
                        List<StationsModel> stations = (List<StationsModel>) request.getAttribute("stations");
                    %>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle text-center">
                            <thead class="table-light">
                                <tr>
                                    <th>Station</th>
                                    <th>Type Carburant</th>
                                    <th>Quantité (Gal)</th>
                                    <th>Fournisseur</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (approvisionnements != null && !approvisionnements.isEmpty()) {
                                    for (AppsModel app : approvisionnements) {
                                        String commune = "Inconnue";
                                        if (stations != null) {
                                            for (StationsModel s : stations) {
                                                if (s.getIdStation() == app.getIdStation()) {
                                                    commune = s.getCommune();
                                                    break;
                                                }
                                            }
                                        }
                                %>
                                <tr>
                                    <td><%= commune %></td>
                                    <td>
                                        <span class="badge <%= app.getTypeCarburant().equals("gasoline") ? "badge-gasoline" : "badge-diesel" %>">
                                            <%= app.getTypeCarburant().equals("gasoline") ? "Gazoline" : "Diesel" %>
                                        </span>
                                    </td>                                    <td><%= app.getQuantite() %></td>
                                    <td><%= app.getFournisseur() %></td>
                                    <td><%= app.getDateApp() %></td>

                                </tr>
                                <% }} else { %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted">Aucun approvisionnement enregistré.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal d'ajout -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form action="${pageContext.request.contextPath}/AppsServlet" method="POST" class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Nouvel approvisionnement</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="idStation" class="form-label">Station</label>
                            <select class="form-select" name="idStation" required>
                                <option value="">Sélectionner une station</option>
                                <% if (stations != null) {
                                    for (StationsModel s : stations) { %>
                                <option value="<%= s.getIdStation() %>"><%= s.getCommune() %></option>
                                <%  } } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="typeCarburant" class="form-label">Type de carburant</label>
                            <select class="form-select" name="typeCarburant" required>
                                <option value="">Sélectionner</option>
                                <option value="gasoline">Gazoline</option>
                                <option value="diesel">Diesel</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="quantite" class="form-label">Quantité (Gallons)</label>
                            <input type="number" name="quantite" min="1" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="fournisseur" class="form-label">Fournisseur</label>
                            <input type="text" name="fournisseur" class="form-control" required>
                        </div>    

                    </div>
                    <div class="modal-footer">
                        <button type="submit" name="action" value="enregistrer" class="btn btn-success">Enregistrer</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@include  file="/layout/footer.jsp"%>;

    </body>
</html>
