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
                font-size: 18px; /* Aumentar tamaño de fuente general */
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
            }

            .login-container {
                max-width: 500px;
                width: 100%;
                background-color: #fff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
                text-align: center;
            }

            .logo h2 {
                font-size: 2.5rem; /* Aumentar tamaño del título */
                margin-bottom: 20px;
                color: #333;
            }

            .form-label {
                font-size: 1.2rem; /* Aumentar tamaño de etiquetas */
                font-weight: bold;
                margin-bottom: 20px;
                color: #333;
            }

            .form-control {
                border-radius: 10px; /* Bordes redondeados en los campos de entrada */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                font-size: 1.1rem; /* Aumentar tamaño del texto en los campos */
                padding: 12px;
            }

            .btn-primary {
                background-color: #2575fc;
                border: none;
                padding: 14px;
                font-size: 1.3rem; /* Aumentar tamaño del botón */
                border-radius: 10px;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #6a11cb;
            }

            .text-center p {
                font-size: 1.1rem; /* Aumentar tamaño del texto en pie de página */
            }

            .text-center a {
                color: #2575fc;
                text-decoration: none;
                font-size: 1.1rem; /* Aumentar tamaño de enlaces */
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
                font-size: 1rem; /* Aumentar tamaño de mensajes de alerta */
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
                <div class="form-label">
                    <label for="txtemail" class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" id="txtemail" name="txtemail" required>
                </div>

                <div class="form-label">
                    <label for="txtpassword" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="txtpassword" name="txtpassword" required>
                </div>

                <button type="submit" class="btn btn-primary mt-3">Iniciar Sesión</button>
            </form>

            <div class="form-label">
                <p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
            </div>
        </div>

        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
