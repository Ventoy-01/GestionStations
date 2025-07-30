<%-- 
    Document   : login
    Created on : 10 juil. 2025, 23:28:15
    Author     : Jonas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="messages.jsp"%>
<%@ page import="java.util.List, model.*" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Gestion Carburant</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Google Fonts - Montserrat -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <!-- Animate.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

        <style>
            /* Footer */
            :root {
                --primary-color: #3498db;
                --primary-dark: #2980b9;
                --secondary-color: #2c3e50;
                --accent-color: #e74c3c;
                --light-color: #ecf0f1;
                --dark-color: #2c3e50;
                --text-muted: #7f8c8d;
            }

            body {
                font-family: 'Montserrat', sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                color: var(--dark-color);
                margin: 0;
            }

            footer {
                background: var(--secondary-color);
                color: white;
                padding: 60px 5% 30px;
            }

            .copyright {
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                padding-top: 20px;
                margin-top: 40px;
                text-align: center;
                opacity: 0.7;
                font-size: 0.9rem;
            }


            .nav-item:hover {
                background-color: rgba(59, 130, 246, 0.1);
                border-left: 3px solid #3b82f6;
            }
            .nav-item.active {
                background-color: rgba(59, 130, 246, 0.2);
                border-left: 3px solid #3b82f6;
            }
            .mobile-sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            .mobile-sidebar.open {
                transform: translateX(0);
            }
            .sidebar-overlay {
                display: none;
                background-color: rgba(0,0,0,0.5);
            }
            .sidebar-overlay.open {
                display: block;
            }
        </style>

    </head>
    <body class="bg-gray-50">
        <%
            UsersModel user = (UsersModel) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <%
            List<StationsModel> stations = (List<StationsModel>) request.getAttribute("stations");
            List<AppsModel> derniersApps = (List<AppsModel>) request.getAttribute("derniersApps");
            List<VentesModel> ventesRecentes = (List<VentesModel>) request.getAttribute("ventesRecentes");
        %>
        <div class="flex h-screen overflow-hidden">
            <!-- Mobile Sidebar Overlay -->
            <div id="sidebarOverlay" class="sidebar-overlay fixed inset-0 z-20"></div>

            <!-- Sidebar -->
            <aside id="sidebar" class="mobile-sidebar bg-white w-64 fixed inset-y-0 left-0 z-30 shadow-lg md:relative md:translate-x-0">
                <div class="flex flex-col h-full p-4">
                    <!-- Logo -->
                    <div class="flex items-center p-2 mb-4">
                        <i class="fas fa-gas-pump text-blue-600 text-2xl mr-3"></i>
                        <span class="text-xl font-bold text-gray-800">GESTION STATIONS</span>
                    </div>

                    <!-- Navigation -->
                    <nav class="flex-1">
                        <a href="#" class="nav-item active flex items-center p-3 rounded-lg mb-2">
                            <i class="fas fa-tachometer-alt text-blue-500 w-6 mr-3"></i>
                            <span>Tableau de bord</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/StationsServlet" class="nav-item flex items-center p-3 rounded-lg mb-2">
                            <i class="fas fa-gas-pump text-blue-500 w-6 mr-3"></i>
                            <span>Stations</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/AppsServlet" class="nav-item flex items-center p-3 rounded-lg mb-2">
                            <i class="fas fa-truck text-blue-500 w-6 mr-3"></i>
                            <span>Approvisionnements</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/VentesServlet" class="nav-item flex items-center p-3 rounded-lg mb-2">
                            <i class="fas fa-store text-blue-500 w-6 mr-3"></i>
                            <span>Ventes</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/UsersServlet" class="nav-item flex items-center p-3 rounded-lg mb-2">
                            <i class="fas fa-user text-blue-500 w-6 mr-3"></i>
                            <span>Utilisateurs</span>
                        </a>

                        <!-- Bottom logout -->
                        <!-- Bottom logout -->
                        <div class="mt-auto">
                            <a href="${pageContext.request.contextPath}/UsersServlet?action=logout" 
                               class="flex items-center p-3 rounded-lg text-red-500 hover:bg-red-50">
                                <i class="fas fa-sign-out-alt w-6 mr-3"></i>
                                <span>Déconnexion</span>
                            </a>
                        </div>

                        <div class="flex items-center space-x-4 ml-5 mt-20">
                            <div class="text-right hidden sm:block">
                                <p class="font-medium"><%=user.getUsername().toUpperCase()%></p>
                                <p class="text-sm text-gray-500"><%=user.getRole()%></p>
                            </div>
                            <div class="relative">
                                <img class="w-10 h-10 rounded-full border border-blue-200" src="https://randomuser.me/api/portraits/men/44.jpg" alt="Profile">
                                <span class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-white"></span>
                            </div>
                        </div>
                    </nav>
                </div>
            </aside>

            <!-- Main Content -->
            <div class="flex-1 flex flex-col overflow-hidden">
                <main class="flex-1 overflow-y-auto p-6">
                    <!-- Page Title -->
                    <div class="mb-12 relative">
                        <h1 class="text-5xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-blue-400 mb-2">Tableau de bord</h1>
                        <p class="text-xl  max-w-2xl">Visualisation complète des performances et statistiques de votre réseau de stations-service</p>
                        <div class="absolute bottom-0 left-0 w-20 h-1 bg-gradient-to-r from-blue-400 to-blue-200 rounded-full"></div>
                    </div>

                    <!-- Stats Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                        <!-- Station Card -->
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex justify-between">
                                <div>
                                    <p class="text-gray-500 text-sm">Stations actives</p>
                                    <h3 class="text-2xl font-bold mt-1">        <!-- Pied de tableau simple -->
                                        <%= stations != null ? stations.size() : 0 %> stations
                                    </h3>
                                    <!--<p class="text-green-500 text-xs mt-2"><i class="fas fa-arrow-up mr-1"></i> 0 nouvelle cette semaine</p>-->
                                </div>
                                <div class="w-12 h-12 bg-blue-50 rounded-full flex items-center justify-center">
                                    <i class="fas fa-store text-blue-500 text-xl"></i>
                                </div>
                            </div>
                        </div>
                        <%
                            double totalGazoline = 0;
                            double totalDiesel = 0;
                            double capaciteGazoline = 0;
                            double capaciteDiesel = 0;

                            // NE PAS redeclarer stations ici
                            if (stations != null) {
                                for (StationsModel s : stations) {
                                    totalGazoline += s.getQuantiteGazoline();
                                    totalDiesel += s.getQuantiteDiesel();
                                    capaciteGazoline += s.getCapaciteGazoline();
                                    capaciteDiesel += s.getCapaciteDiesel();
                                }
                            }
                        %>

                        <!-- Gasoline Card -->
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex justify-between">
                                <div class="bg-white shadow-sm rounded-lg p-3 text-sm w-full max-w-xs">
                                    <p class="text-gray-400 font-medium mb-1">Total Gazoline (disp/Cap)</p>
                                    <h6 class="text-gray-800 font-semibold text-base"><%= totalGazoline %> Gal / <%= capaciteGazoline %> Gal</h6>
                                    <!--                                    <p class="text-red-500 mt-1 flex items-center text-xs">
                                                                            <i class="fas fa-arrow-down mr-1"></i> 3.2% depuis hier
                                                                        </p>-->
                                </div>
                                <div class="w-12 h-12 bg-green-50 rounded-full flex items-center justify-center">
                                    <i class="fas fa-gas-pump text-green-500 text-xl"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Diesel Card -->
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex justify-between">
                                <div class="bg-white shadow-sm rounded-lg p-3 text-sm w-full max-w-xs">
                                    <p class="text-gray-400 font-medium mb-1">Total Diesel (disp/Cap)</p>
                                    <h6 class="text-gray-800 font-semibold text-base"><%= totalDiesel %> Gal / <%= capaciteDiesel %> Gal</h6>
                                    <!--                                    <p class="text-green-500 mt-1 flex items-center text-xs">
                                                                            <i class="fas fa-arrow-up mr-1"></i> +1.8% depuis hier
                                                                        </p>-->
                                </div>

                                <div class="w-12 h-12 bg-orange-50 rounded-full flex items-center justify-center">
                                    <i class="fas fa-oil-can text-orange-500 text-xl"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Charts Row -->
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                        <!-- Recent Sales -->
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex justify-between items-center mb-4">
                                <h2 class="text-lg font-semibold">Ventes récentes</h2>
                                <a href="${pageContext.request.contextPath}/VentesServlet" class="text-blue-500 text-sm">
                                    Voir tout <i class="fas fa-chevron-right ml-1"></i>
                                </a>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="w-full">
                                    <thead>
                                        <tr class="text-left text-gray-500 text-sm border-b">
                                            <th class="pb-3">Station</th>
                                            <th class="pb-3">Type</th>
                                            <th class="pb-3">Volume</th>
                                            <th class="pb-3">Heure</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            if (ventesRecentes != null && !ventesRecentes.isEmpty()) {
                                                for (VentesModel vente : ventesRecentes) {
                                                    String commune = "Inconnue";
                                                    if (stations != null) {
                                                        for (StationsModel s : stations) {
                                                            if (s.getIdStation() == vente.getIdStation()) {
                                                                commune = s.getCommune();
                                                                break;
                                                            }
                                                        }
                                                    }
                                        %>
                                        <tr class="border-b text-sm">
                                            <td class="py-3"><%= commune %></td>
                                            <td class="py-3 <%= vente.getTypeCarburant().equals("diesel") ? "text-orange-500" : "text-blue-500" %>">
                                                <%= vente.getTypeCarburant().toUpperCase() %>
                                            </td>
                                            <td class="py-3"><%= vente.getQuantite() %> Gal</td>
                                            <td class="py-3 text-gray-500">
                                                <%= new java.text.SimpleDateFormat("HH:mm").format(vente.getDateVente()) %>
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <tr><td colspan="4" class="py-3 text-center">Aucune vente récente</td></tr>
                                        <% } %>
                                    </tbody>

                                </table>
                            </div>
                        </div>

                        <!-- Livraisons récentes -->
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100 mb-6">
                            <div class="flex justify-between items-center mb-4">
                                <h2 class="text-lg font-semibold">🚚 Livraisons récentes</h2>
                                <a href="${pageContext.request.contextPath}/AppsServlet" class="text-blue-500 text-sm hover:underline">
                                    Voir tout <i class="fas fa-chevron-right ml-1"></i>
                                </a>
                            </div>

                            <div class="overflow-x-auto">
                                <table class="w-full text-sm text-left text-gray-700">
                                    <thead class="text-xs text-gray-500 uppercase border-b">
                                        <tr>
                                            <th class="pb-3">Four..</th>
                                            <th class="pb-3">Commune</th>
                                            <th class="pb-3">Type</th>
                                            <th class="pb-3">Qte (Gal)</th>
                                            <th class="pb-3">Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (derniersApps != null && !derniersApps.isEmpty()) {
                                            for (AppsModel app : derniersApps) {
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
                                        <tr class="border-b hover:bg-gray-50">
                                            <td class="py-2"><%= app.getFournisseur() %></td>
                                            <td class="py-2"><%= commune %></td>
                                            <td class="py-2"><%= app.getTypeCarburant() %></td>
                                            <td class="py-2"><%= app.getQuantite() %></td>
                                            <td class="py-2"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(app.getDateApp()) %></td>
                                        </tr>
                                        <% } } else { %>
                                        <tr>
                                            <td colspan="5" class="text-center py-4 text-gray-500 italic">Aucun approvisionnement récent</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- -->
                    <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100 mb-6">
                        <h2 class="text-lg font-semibold mb-4">🏆 Meilleures stations</h2>
                        <table class="w-full text-sm text-left text-gray-700">
                            <thead class="text-xs text-gray-500 uppercase border-b">
                                <tr>
                                    <th class="py-2">Commune</th>
                                    <th class="py-2">Type Carburant</th>
                                    <th class="py-2">Quantité (gal)</th>
                                    <th class="py-2">Revenus (HTG)</th>
                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <td class="px-4 py-2">${topDiesel.commune}</td>
                                    <td class="px-4 py-2 font-medium">Diesel</td>
                                    <td class="px-4 py-2">${topDiesel.quantite}</td>
                                    <td class="px-4 py-2">${topDiesel.montant}</td>
                                </tr>

                                <tr>
                                    <td class="px-4 py-2">${topGazoline.commune}</td>
                                    <td class="px-4 py-2 font-medium">Gazoline</td>
                                    <td class="px-4 py-2">${topGazoline.quantite}</td>
                                    <td class="px-4 py-2">${topGazoline.montant}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <footer>
                        <div class="container">
                            <div class="copyright">
                                &copy; 2025 Gestion Stations. Tous droits réservés.
                            </div>
                        </div>
                    </footer>
                </main>
            </div>
        </div>


        <script>
            // Mobile sidebar toggle
            const menuToggle = document.getElementById('menuToggle');
            const sidebar = document.getElementById('sidebar');
            const sidebarOverlay = document.getElementById('sidebarOverlay');

            menuToggle.addEventListener('click', () => {
                sidebar.classList.toggle('open');
                sidebarOverlay.classList.toggle('open');
            });

            sidebarOverlay.addEventListener('click', () => {
                sidebar.classList.remove('open');
                sidebarOverlay.classList.remove('open');
            });

            // Set active nav item
            document.querySelectorAll('.nav-item').forEach(item => {
                item.addEventListener('click', function () {
                    document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');

                    // Close sidebar on mobile after selection
                    if (window.innerWidth < 768) {
                        sidebar.classList.remove('open');
                        sidebarOverlay.classList.remove('open');
                    }
                });
            });
        </script>

    </body>
</html>