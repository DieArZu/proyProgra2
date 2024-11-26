<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de Usuario</title>
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
                max-width: 500px;
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

                font-size: 1.2rem; /* Aumentar tamaño de etiquetas */
                font-weight: bold;
                margin-bottom: 20px;
                color: #333;
            }

            .form-control {
                border-radius: 10px; /* Bordes redondeados en los campos de entrada */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 10px;
                font-size: 1.2rem; /* Aumentar tamaño de etiquetas */
                font-weight: bold;
                margin-bottom: 20px; /* Espaciado adicional debajo */
                color: #333;
            }

            .btn-primary {
                background-color: #2575fc;
                border: none;
                padding: 12px;
                font-size: 1.5rem;
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

            .alert-success {
                border-radius: 10px;
                padding: 10px;
                background-color: #d4edda;
                color: #155724;
                font-weight: bold;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <div class="logo">
                <h2><strong>Registro de Usuario</strong></h2>
            </div>



            <!-- Formulario de registro -->
            <form action="appRegisterUser.jsp" method="post">
                <div class="mb-4">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                </div>

                <div class="mb-4">
                    <label for="email" class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <button type="submit" class="btn btn-primary mt-3">Registrarse</button>
            </form>

            <div class="mt-4">
                <p>¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
            </div>
        </div>

        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>



