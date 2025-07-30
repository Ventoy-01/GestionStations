<%-- 
    Document   : index
    Created on : 12 juil. 2025, 21:51:49
    Author     : Jonas
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="messages.jsp" %>
<%@ page import="java.util.*, model.StationsModel, model.UsersModel" %>
<html>
    <head>
        <title>Liste des stations</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
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
            List<String> communesDisponibles = Arrays.asList("Cap-Haitien", "Limonade", "Terrier-Rouge", "Fort-Liberte");
            Set<String> communesEnBase = new HashSet<>();
            List<StationsModel> lesStations = (List<StationsModel>) request.getAttribute("lesStations");

            String communeActuelle = request.getParameter("commune"); 

            if (lesStations != null) {
                for (StationsModel s : lesStations) {
                    if (!s.getCommune().equals(communeActuelle)) {
                        communesEnBase.add(s.getCommune());
                    }
                }
            }
        %>

        <div class="bg-gradient-to-r from-blue-50 via-white to-emerald-50 rounded-3xl shadow-2xl border border-gray-100 mb-10 overflow-hidden">
            <!-- En-tête stylisé -->
            <div class="p-6 bg-white bg-opacity-90 backdrop-blur-sm border-b border-gray-200">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center gap-4">
                        <a href="${pageContext.request.contextPath}/DashboardServlet" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i> Retour
                        </a>
                        <h2 class="text-3xl font-bold text-blue-800">Stations d’Essence</h2>
                    </div>
                    <button class="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white px-5 py-2.5 rounded-xl shadow-md transition flex items-center"
                            data-bs-toggle="modal" 
                            data-bs-target="#ajoutModal">
                        <i class="fas fa-plus mr-2"></i> Ajouter une station
                    </button>
                </div>

                <!-- Recherche -->
<!--                <div class="relative max-w-md">
                    <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="text" 
                           class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition" 
                           placeholder="Rechercher une station...">
                </div>-->
            </div>

            <!-- Table responsive -->
            <div class="overflow-x-auto bg-white bg-opacity-70 backdrop-blur-sm">
                <table class="min-w-full text-sm text-gray-700">
                    <thead>
                        <tr class="text-left bg-blue-100 text-blue-800 uppercase tracking-wider text-xs">
                            <th class="px-6 py-4">ID</th>
                            <th class="px-6 py-4">Localisation</th>
                            <th class="px-6 py-4">Capacite (Gal)</th>
                            <th class="px-6 py-4">Disponible (Gal)</th>
                            <th class="px-6 py-4">C. Disponible (%)</th>
                            <th class="px-6 py-4 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<StationsModel> stations = (List<StationsModel>) request.getAttribute("stations");
                           if (stations != null) {
                               for (StationsModel s : stations) { %>
                        <tr class="border-b border-gray-100 hover:bg-blue-50 transition">
                            <td class="px-6 py-4 font-semibold"><%= s.getIdStation() %></td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-gray-800"><%= s.getCommune() %></div>
                                <div class="text-sm text-gray-500"><%= s.getAdresse() %></div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex gap-6">
                                    <div>
                                        <div class="text-xs text-blue-600 font-semibold">Gazoline</div>
                                        <div class="text-sm"> <%= s.getCapaciteGazoline() %> Gal</div>
                                    </div>
                                    <div>
                                        <div class="text-xs text-yellow-600 font-semibold">Diesel</div>
                                        <div class="text-sm"> <%= s.getCapaciteDiesel() %> Gal</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex gap-6">
                                    <div>
                                        <div class="text-xs text-blue-600 font-semibold">Gazoline</div>
                                        <div class="text-sm"><%= s.getQuantiteGazoline() %>  Gal</div>
                                    </div>
                                    <div>
                                        <div class="text-xs text-yellow-600 font-semibold">Diesel</div>
                                        <div class="text-sm"><%= s.getQuantiteDiesel() %>  Gal</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex gap-6">
                                    <div>
                                        <div class="text-xs text-blue-600 font-semibold">Gazoline</div>
                                        <div class="text-sm"><%= String.format("%.2f",(s.getQuantiteGazoline() / s.getCapaciteGazoline())*100) %> %</div>
                                    </div>
                                    <div>
                                        <div class="text-xs text-yellow-600 font-semibold">Diesel</div>
                                        <div class="text-sm"><%=String.format("%.2f", (s.getQuantiteDiesel() / s.getCapaciteDiesel())*100) %> %</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <button class="text-blue-600 hover:text-blue-800 mr-4"
                                        onclick="openEditModal(
                                                        '<%= s.getIdStation() %>',
                                                        '<%= s.getCommune() %>',
                                                        '<%= s.getAdresse() %>',
                                                        '<%= s.getCapaciteGazoline() %>',
                                                        '<%= s.getCapaciteDiesel() %>',
                                                        '<%= s.getQuantiteGazoline() %>',
                                                        '<%= s.getQuantiteDiesel() %>')">
                                    <i class="fas fa-edit"></i> Modifier
                                </button>
                                   
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="4" class="px-6 py-12 text-center text-gray-500">
                                <i class="fas fa-gas-pump text-3xl mb-2 block"></i>
                                Aucune station enregistrée pour l’instant.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Footer -->
            <div class="px-6 py-4 text-sm text-gray-600 border-t border-gray-100 bg-white bg-opacity-80">
                Total : <strong><%= stations != null ? stations.size() : 0 %></strong> station(s)
            </div>
        </div>

    <!-- Modal pour l'ajout -->
    <div class="modal fade" id="ajoutModal" tabindex="-1" aria-labelledby="ajoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ajoutModalLabel">Ajouter une station</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/StationsServlet" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-sm">Commune :</label>
                            <select name="commune" class="form-select" required>
                                <option value="">-- Choisir une commune --</option>
                                <%
                                    for (String c : communesDisponibles) {
                                        if (!communesEnBase.contains(c)) {
                                %>
                                <option value="<%= c %>"><%= c %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>


                        <div class="mb-3">
                            <label class="form-label">Adresse :</label>
                            <input type="text" name="adresse" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacité Gazoline (Gal) :</label>
                            <input type="number" step="0.1" name="capacite_gazoline" class="form-control" min="1.0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacité Diesel (Gal) :</label>
                            <input type="number" step="0.1" name="capacite_diesel" class="form-control" min="1.0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quantité Gazoline (Gal) :</label>
                            <input type="number" step="0.1" name="quantite_gazoline" class="form-control" min="0.0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quantité Diesel (Gal) :</label>
                            <input type="number" step="0.1" name="quantite_diesel" class="form-control" min="0.0" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                        <input type="submit" class="btn btn-primary" name="action" value="Enregistrer">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal pour la modification -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Modifier la station</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/StationsServlet" method="post">
                    <input type="hidden" id="edit_id" name="id">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Commune :</label>
                            <input type="text" id="edit_commune" name="commune" class="form-control" readonly required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Adresse :</label>
                            <input type="text" id="edit_adresse" name="adresse" class="form-control" readonly required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacité Gazoline (Gal) :</label>
                            <input type="number" step="0.1" id="edit_capacite_gazoline" name="capacite_gazoline" class="form-control" min="1.0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacité Diesel (Gal) :</label>
                            <input type="number" step="0.1" id="edit_capacite_diesel" name="capacite_diesel" class="form-control" min="1.0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quantité Gazoline (Gal) :</label>
                            <input type="number" step="0.1" id="edit_quantite_gazoline" name="quantite_gazoline" class="form-control" min="0.0" readonly required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quantité Diesel (Gal) :</label>
                            <input type="number" step="0.1" id="edit_quantite_diesel" name="quantite_diesel" class="form-control" min="0.0" readonly required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                        <input type="submit" class="btn btn-primary" name="action" value="Valider">
                    </div>
                </form>
            </div>
        </div>
    </div>
        
   <!-- Scripts Bootstrap et JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Fonction corrigée pour ouvrir le modal de modification
    function openEditModal(id, commune, adresse, capaciteGazoline, capaciteDiesel, quantiteGazoline, quantiteDiesel) {
        
        document.getElementById('edit_id').value = id;
        document.getElementById('edit_commune').value = commune;
        document.getElementById('edit_adresse').value = adresse;
        document.getElementById('edit_capacite_gazoline').value = capaciteGazoline;
        document.getElementById('edit_capacite_diesel').value = capaciteDiesel;
        document.getElementById('edit_quantite_gazoline').value = quantiteGazoline;
        document.getElementById('edit_quantite_diesel').value = quantiteDiesel;

        var editModal = new bootstrap.Modal(document.getElementById('editModal'));
        editModal.show();
    }

    </script>
    <%@include  file="/layout/footer.jsp"%>;
    </body>
</html>
