<%-- 
    Document   : login
    Created on : 10 juil. 2025, 23:25:15
    Author     : Jonas
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Connexion - Gestion Stations</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Google Fonts - Montserrat -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <!-- Style personnalisé -->
        <style>
            :root {
                --primary-color: #3498db;
                --primary-dark: #2980b9;
                --secondary-color: #2c3e50;
                --light-color: #ecf0f1;
                --text-muted: #7f8c8d;
            }

            body {
                font-family: 'Montserrat', sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
                padding: 20px;
            }

            .auth-container {
                max-width: 450px;
                width: 100%;
            }

            .auth-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.2);
                overflow: hidden;
                padding: 40px;
                position: relative;
            }

            .auth-card::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(52,152,219,0.1) 0%, rgba(255,255,255,0) 70%);
                z-index: -1;
            }

            .auth-logo {
                width: 80px;
                height: 80px;
                background: var(--primary-color);
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 25px;
                font-size: 2rem;
                box-shadow: 0 5px 20px rgba(52, 152, 219, 0.3);
            }

            .auth-title {
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 30px;
                font-size: 1.8rem;
                text-align: center;
            }

            .form-floating label {
                color: var(--text-muted);
                padding: 0 15px;
            }

            .form-control {
                border: 1px solid #e0e6ed;
                border-radius: 10px;
                padding: 14px 16px;
                margin-bottom: 20px;
                transition: all 0.3s ease;
                height: calc(3rem + 2px);
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.2);
            }

            .auth-btn {
                background-color: var(--primary-color);
                border: none;
                padding: 14px;
                border-radius: 10px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
                width: 100%;
                margin-top: 10px;
                font-size: 1rem;
            }

            .auth-btn:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
            }

            .auth-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 20px 0;
                font-size: 0.9rem;
            }

            .forgot-password a {
                text-decoration: underline;
                color: skyblue;
                cursor: pointer;

            }


            .auth-footer {
                text-align: center;
                margin-top: 30px;
                color: var(--text-muted);
                font-size: 0.9rem;
            }

            /* Style pour la modale */
            .modal-header {
                border-bottom: none;
                padding-bottom: 0;
            }

            .modal-footer {
                border-top: none;
            }

            .modal-icon {
                width: 60px;
                height: 60px;
                background: rgba(231, 76, 60, 0.1);
                color: #e74c3c;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                margin: 0 auto 20px;
            }

            @media (max-width: 576px) {
                .auth-card {
                    padding: 30px 20px;
                }

                .auth-title {
                    font-size: 1.6rem;
                }

                .auth-logo {
                    width: 70px;
                    height: 70px;
                    font-size: 1.8rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="auth-container">
            <%
                String error = request.getParameter("error");
                if (error != null && error.equals("1")) {
            %>
                <div class="alert alert-danger" role="alert">
                    Nom d'utilisateur ou mot de passe incorrect.
                 </div>
            <%
                }
            %>

            <div class="auth-card">
                <div class="auth-logo">
                    <i class="fas fa-gas-pump"></i>
                </div>

                <h2 class="auth-title">Connexion</h2>

                <form action="${pageContext.request.contextPath}/UsersServlet" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Nom d'utilisateur" required>
                        <label for="username"><i class="fas fa-user me-2"></i>Nom d'utilisateur</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Mot de passe" required>
                        <label for="password"><i class="fas fa-lock me-2"></i>Mot de passe</label>
                    </div>

                    <div class="auth-options">
                        <div >
                            <a href="index.jsp">Retour</a>
                        </div>
                        <div class="forgot-password">
                            <a style="color: blue ; text-decoration: underline" data-bs-toggle="modal" data-bs-target="#passwordModal">Mot de passe oublié ?</a>
                        </div>
                    </div>

                    <button type="submit" class="btn auth-btn" name="action" value="login">
                        <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                    </button>
                </form>

                <div class="auth-footer">
                    Système de gestion des stations © 2025
                </div>
            </div>
        </div>

        <!-- Modal Mot de passe oublié -->
        <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <div class="w-100">
                            <div class="modal-icon">
                                <i class="fas fa-key"></i>
                            </div>
                            <h5 class="modal-title" id="passwordModalLabel">Réinitialisation du mot de passe</h5>
                        </div>
                    </div>
                    <div class="modal-body text-center">
                        <p>Pour réinitialiser votre mot de passe, veuillez contacter votre administrateur système.</p>
                    
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">J'ai compris</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>