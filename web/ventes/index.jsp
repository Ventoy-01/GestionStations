<%-- 
    Document   : index
    Created on : 20 juil. 2025, 00:49:00
    Author     : Jonas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="messages.jsp"%>
<%@ page import="java.util.List, model.* " %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestion des Ventes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .card-header {
                background-color: #4e73df;
                color: white;
            }
            .btn-primary {
                background-color: #4e73df;
                border-color: #3498db;
            }
            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }
            .table th {
                background-color: #f8f9fa;
            }
            .badge-gasoline {
                background-color: #28a745;
            }
            .badge-diesel {
                background-color: #17a2b8;
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
        <%
            List<VentesModel> ventes = (List<VentesModel>) request.getAttribute("ventes");
            List<StationsModel> stations = (List<StationsModel>) request.getAttribute("stations");
            List<UsersModel> users = (List<UsersModel>) request.getAttribute("users");
        %>
        <div class="container-fluid py-4">
            <div class="row">
                <div class="col-12">              
                    <div class="card">                    
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">
                                <a href="${pageContext.request.contextPath}/DashboardServlet" class="btn btn-light">
                                    <i class="fas fa-arrow-left me-2"></i> Retour
                                </a>  Gestion des Ventes</h4>
                            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addSaleModal">
                                <i class="fas fa-plus me-2"></i>Nouvelle Vente
                            </button>
                        </div>
                        <div class="card-body">
                            <!-- Filtres -->
                            <div class="row mb-4"> </div>

                            <!-- Statistiques -->
                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <h5 class="card-title">Total Ventes</h5>
                                            <p class="card-text display-6" id="totalSales">
                                                <%= String.format("%.2f", (Double) request.getAttribute("totalVentes")) %> GDES
                                            </p>                   
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <h5 class="card-title">Gazoline Vendue</h5>
                                            <p class="card-text display-6" id="gasolineSales">
                                                <%= String.format("%.2f", (Double) request.getAttribute("totalGasoline")) %> Gal
                                            </p>    
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <h5 class="card-title">Diesel Vendue</h5>
                                            <p class="card-text display-6" id="dieselSales">
                                                <%= String.format("%.2f", (Double) request.getAttribute("totalDiesel")) %> Gal
                                            </p>            
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tableau des ventes -->
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>User</th>
                                            <th>Station</th>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Quantité (Gal)</th>
                                            <th>Prix Unitaire</th>
                                            <th>Montant</th>
                                        </tr>
                                    </thead>
                                    <tbody id="salesTableBody">
                                        <% if (ventes != null && !ventes.isEmpty()) { %>
                                        <% for (VentesModel vente : ventes) { %>
                                        <tr>
                                            <td><%= vente.getIdVente() %></td>
                                            <td>
                                                <%
                                                    for (UsersModel u : (List<UsersModel>) request.getAttribute("users")) {
                                                        if (u.getIdUser() == vente.getIdUser()) {
                                                            out.print(u.getUsername());
                                                            break;
                                                        }
                                                    }
                                                %>
                                            </td>

                                            <td>
                                                <%
                                                    for (StationsModel s : (List<StationsModel>) request.getAttribute("stations")) {
                                                        if (s.getIdStation() == vente.getIdStation()) {
                                                            out.print(s.getCommune());
                                                            break;
                                                        }
                                                    }
                                                %>
                                            </td>


                                            <td><%= vente.getDateVente() %></td>
                                            <td>
                                                <span class="badge <%= vente.getTypeCarburant().equals("gasoline") ? "badge-gasoline" : "badge-diesel" %>">
                                                    <%= vente.getTypeCarburant().equals("gasoline") ? "Gazoline" : "Diesel" %>
                                                </span>
                                            </td>
                                            <td><%= String.format("%.2f", vente.getQuantite()) %> Gal</td>
                                            <td><%= String.format("%.2f", vente.getPrixUnitaire()) %> GDES</td>
                                            <td><%= String.format("%.2f", vente.getMontantTotal()) %> GDES</td>

                                        </tr>
                                        <% } %>
                                        <% } else { %>
                                        <tr>
                                            <td colspan="8" class="text-center text-muted">Aucune vente enregistrée.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>

                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal d'ajout de vente -->
        <div class="modal fade" id="addSaleModal" tabindex="-1" aria-labelledby="addSaleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addSaleModalLabel">Nouvelle Vente</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="saleForm" action="${pageContext.request.contextPath}/VentesServlet" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="idUser" value=<%=user.getIdUser()%> >
                            <div class="mb-3">
                                <label for="station" class="form-label">Choisir une station</label>
                                <select class="form-select" id="station" name="idStation" required>
                                    <option value="">Sélectionner...</option>
                                    <% if (stations != null){
                                        for (StationsModel s : stations){ %>
                                    <option value="<%=s.getIdStation()%>"><%=s.getCommune()%></option>
                                    <%}}%>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="fuelType" class="form-label">Type de carburant</label>
                                <select class="form-select" id="fuelType" name="typeCarburant" required>
                                    <option value="">Sélectionner...</option>
                                    <option value="gasoline">Gazoline</option>
                                    <option value="diesel">Diesel</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="quantity" class="form-label">Quantité (Gal)</label>
                                <input type="number" step="0.1" min="0.1" class="form-control" id="quantity" name="quantite" required>
                            </div>
                            <div class="mb-3">
                                <label for="unitPrice" class="form-label">Prix Unitaire (GDES/Gal)</label>
                                <input type="number" step="0.1" class="form-control" min="1" id="unitPrice" name="prixUnitaire" required>
                            </div>
                            <div class="mb-3">
                                <label for="totalAmount" class="form-label">Montant Total</label>
                                <input type="text" class="form-control" id="totalAmount" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                            <button type="submit" name="action" value="add" class="btn btn-primary">Enregistrer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Fonction pour calculer le montant total
            function calculateTotal() {
                const quantity = parseFloat(document.getElementById('quantity').value) || 0;
                const unitPrice = parseFloat(document.getElementById('unitPrice').value) || 0;
                const totalAmount = quantity * unitPrice;
                document.getElementById('totalAmount').value = totalAmount.toFixed(2) + ' GDES';
            }

            // Écouteurs pour le calcul automatique
            document.getElementById('quantity')?.addEventListener('input', calculateTotal);
            document.getElementById('unitPrice')?.addEventListener('input', calculateTotal);



            // Initialisation des tooltips Bootstrap
            document.addEventListener('DOMContentLoaded', function () {
                // Active les tooltips
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });
            });


        </script>
            <%@include  file="/layout/footer.jsp"%>;
    </body>
</html>