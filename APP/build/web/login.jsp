<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <style>
            body {
                background: linear-gradient(to right, #6a11cb, #2575fc); /* Fondo degradado */
                font-family: 'Arial', sans-serif;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
            }

            .login-container {
                max-width: 400px;
                width: 100%;
                background-color: #fff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
                text-align: center;
            }

            .logo h2 {
                font-size: 2rem;
                margin-bottom: 20px;
                color: #333;
            }

            .form-label {
                font-weight: bold;
                color: #333;
            }

            .mb-4 {
                margin-bottom: 1.5rem; /* Espacio adicional entre campos */
            }

            .form-control {
                border-radius: 10px; /* Bordes redondeados en los campos de entrada */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 10px;
            }

            .btn-primary {
                background-color: #2575fc;
                border: none;
                padding: 12px;
                font-size: 1.1rem;
                border-radius: 10px;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #6a11cb;
            }

            .text-center p {
                font-size: 0.9rem;
            }

            .text-center a {
                color: #2575fc;
                text-decoration: none;
                font-weight: bold;
            }

            .text-center a:hover {
                text-decoration: underline;
            }

            .alert-danger {
                border-radius: 10px;
                padding: 10px;
                background-color: #f8d7da;
                color: #721c24;
                font-weight: bold;
                margin-bottom: 15px;
            }

        </style>
    </head>
    <body>

        <div class="login-container">
            <div class="logo">
                <h2><strong>App Reservas</strong></h2>
            </div>



            <!-- Formulario de inicio de sesión -->
            <form action="appValidateLogin.jsp">
                <div class="mb-4">
                    <label for="txtemail" class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" id="txtemail" name="txtemail" required>
                </div>

                <div class="mb-4">
                    <label for="txtpassword" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="txtpassword" name="txtpassword" required>
                </div>

                <button type="submit" class="btn btn-primary mt-3">Iniciar Sesión</button>
            </form>

            <div class="text-center mt-4">
                <p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
            </div>
        </div>

        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
