<%@page contentType="text/html" isErrorPage="true" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erreur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="alert alert-danger">
        <h3>Une erreur est survenue :</h3>
        <p>
            <%
                // Si "msg" existe dans request
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
                    out.print(msg);
                } else if (exception != null) {
                    out.print(exception.getMessage());
                } else {
                    out.print("Erreur inconnue. "+ msg);
                }
            %>
        </p>
    </div>
    <button onclick="window.history.back()" class="btn btn-primary" >Retour</button>
</body>
</html>