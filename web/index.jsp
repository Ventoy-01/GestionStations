<%-- 
    Document   : index
    Created on : 10 juil. 2025, 23:25:15
    Author     : Jonas
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - Gestion Stations</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <!-- Style personnalisé -->
    <style>
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
        
        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            padding: 15px 5%;
        }
        
        .navbar-brand {
            font-weight: 700;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
        }
        
        .navbar-brand i {
            color: var(--primary-color);
            margin-right: 10px;
            font-size: 1.5rem;
        }
        
        .nav-link {
            color: var(--secondary-color);
            font-weight: 500;
            margin: 0 10px;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            color: var(--primary-color);
        }
        
        /* Hero Section */
        .hero {
            padding: 100px 5% 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(52, 152, 219, 0.1) 0%, transparent 40%);
            z-index: -1;
        }
        
        .hero-logo {
            width: 100px;
            height: 100px;
            background: var(--primary-color);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            font-size: 2.5rem;
            box-shadow: 0 10px 25px rgba(52, 152, 219, 0.3);
        }
        
        .hero-title {
            font-weight: 700;
            color: var(--secondary-color);
            margin-bottom: 20px;
            font-size: 2.8rem;
        }
        
        .hero-subtitle {
            color: var(--text-muted);
            font-weight: 400;
            margin-bottom: 40px;
            font-size: 1.3rem;
            line-height: 1.6;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 12px 35px;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            margin: 10px;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        }
        
        .btn-outline-primary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            font-weight: 600;
            padding: 10px 30px;
            border-radius: 50px;
            transition: all 0.3s ease;
            margin: 10px;
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
        }
        
        /* Features Section */
        .features {
            padding: 80px 5%;
            background: white;
        }
        
        .section-title {
            text-align: center;
            font-weight: 700;
            color: var(--secondary-color);
            margin-bottom: 60px;
            font-size: 2.2rem;
        }
        
        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            height: 100%;
            border: 1px solid rgba(0, 0, 0, 0.03);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .feature-icon {
            width: 70px;
            height: 70px;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            color: var(--primary-color);
            font-size: 1.8rem;
        }
        
        .feature-title {
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 15px;
            text-align: center;
        }
        
        .feature-text {
            color: var(--text-muted);
            font-weight: 400;
            text-align: center;
            font-size: 0.95rem;
            line-height: 1.7;
        }
        
        /* Stats Section */
        .stats {
            padding: 80px 5%;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        /* Testimonials */
        .testimonials {
            padding: 80px 5%;
            background: #f9f9f9;
        }
        
        .testimonial-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
        }
        
        .testimonial-text {
            font-style: italic;
            color: var(--text-muted);
            margin-bottom: 20px;
            position: relative;
        }
        
        .testimonial-text::before {
            content: '"';
            font-size: 4rem;
            position: absolute;
            top: -20px;
            left: -15px;
            color: rgba(52, 152, 219, 0.1);
            font-family: serif;
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
        }
        
        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-weight: bold;
        }
        
        .author-info h5 {
            margin-bottom: 0;
            font-weight: 600;
        }
        
        .author-info p {
            margin-bottom: 0;
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        
        
        /* Responsive */
        @media (max-width: 992px) {
            .hero-title {
                font-size: 2.3rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
        }
        
        @media (max-width: 768px) {
            .hero {
                padding: 80px 5% 60px;
            }
            
            .hero-title {
                font-size: 2rem;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
        }
        
        @media (max-width: 576px) {
            .hero-logo {
                width: 80px;
                height: 80px;
                font-size: 2rem;
            }
            
            .hero-title {
                font-size: 1.8rem;
            }
            
            .btn-primary, .btn-outline-primary {
                display: block;
                width: 100%;
                margin: 10px auto;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-gas-pump"></i>
                <span>Gestion Stations</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Accueil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#fonctionnalite">Fonctionnalités</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#temoignage">Temoignage</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Connexion</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-logo animate__animated animate__fadeIn">
                <i class="fas fa-gas-pump"></i>
            </div>
            <h1 class="hero-title animate__animated animate__fadeInUp">Gestion Complète de Stations</h1>
            <p class="hero-subtitle animate__animated animate__fadeInUp animate__delay-1s">
                Solution tout-en-un pour la gestion des ventes, des stocks et des approvisionnements. 
                Optimisez votre station avec des outils puissants et une interface intuitive.
            </p>
            <div class="animate__animated animate__fadeInUp animate__delay-2s">
                <a href="login.jsp" class="btn btn-primary btn-lg">
                    <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="fonctionnalite">
        <div class="container">
            <h2 class="section-title">Nos Fonctionnalités</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="feature-card animate__animated animate__fadeInUp">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3 class="feature-title">Analytique Avancée</h3>
                        <p class="feature-text">
                            Tableaux de bord complets avec analyses des ventes, tendances et prévisions pour une prise de décision éclairée.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate__animated animate__fadeInUp animate__delay-1s">
                        <div class="feature-icon">
                            <i class="fas fa-boxes"></i>
                        </div>
                        <h3 class="feature-title">Gestion des Stocks</h3>
                        <p class="feature-text">
                            Suivi en temps réel des niveaux de stock, alertes automatiques et gestion des commandes.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate__animated animate__fadeInUp animate__delay-2s">
                        <div class="feature-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <h3 class="feature-title">Approvisionnement</h3>
                        <p class="feature-text">
                            Optimisation des livraisons et gestion des fournisseurs pour une chaîne d'approvisionnement efficace.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

 

    <!-- Testimonials -->
    <section class="testimonials" id="temoignage">
        <div class="container">
            <h2 class="section-title">Témoignages</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <p class="testimonial-text">
                            Cette solution a révolutionné notre gestion de station. Nous avons réduit nos pertes de 30% et amélioré notre productivité.
                        </p>
                        <div class="testimonial-author">
                            <div class="author-avatar">JC</div>
                            <div class="author-info">
                                <h5>Jonas Clocin</h5>
                                <p>Station Total, Fort-Liberte</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <p class="testimonial-text">
                            L'interface est intuitive et les rapports détaillés nous aident à prendre de meilleures décisions commerciales.
                        </p>
                        <div class="testimonial-author">
                            <div class="author-avatar">VC</div>
                            <div class="author-info">
                                <h5>Vinchy Cherenfant</h5>
                                <p>Station Shell, Limonade</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <p class="testimonial-text">
                            Le support client est exceptionnel et le système s'intègre parfaitement avec nos autres outils.
                        </p>
                        <div class="testimonial-author">
                            <div class="author-avatar">VP</div>
                            <div class="author-info">
                                <h5>Valendino Pierre</h5>
                                <p>Station BP, Cap-Haitien</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-5" style="background: white;" id="contact">
        <div class="container text-center py-4">
            <h2 class="mb-4">Prêt à transformer votre gestion de station ?</h2>
            <a href="login.jsp" class="btn btn-primary btn-lg me-3">
                <i class="fas fa-sign-in-alt me-2"></i>Se connecter
            </a>
            <a href="#" class="btn btn-outline-primary btn-lg">
                <i class="fas fa-phone-alt me-2"></i>Nous contacter
            </a>
        </div>
    </section>


    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Scripts d'animation -->
    <script>
        // Animation au défilement
        document.addEventListener('DOMContentLoaded', function() {
            const animateElements = document.querySelectorAll('.feature-card, .testimonial-card');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate__animated', 'animate__fadeInUp');
                        observer.unobserve(entry.target);
                    }
                });
            }, {
                threshold: 0.1
            });
            
            animateElements.forEach(el => {
                observer.observe(el);
            });
        });
    </script>
    <%@include  file="./layout/footer.jsp"%>;
</body>
</html>