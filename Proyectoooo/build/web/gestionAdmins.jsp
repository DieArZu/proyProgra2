<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administrador</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 50px 0 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            box-sizing: border-box;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 15px 0;
            text-align: center;
            width: 100%;
        }
        h2 {
            color: #333;
            font-size: 22px;
            margin-bottom: 20px;
            text-align: center;
        }
        .content-container {
            width: 90%;
            max-width: 1500px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            height: auto; /* Esto asegura que el contenedor se ajuste automáticamente al contenido */

        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 100%;

        }
        th, td {
            padding: 8px 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 20px;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        td {
            font-size: 20px;
        }
        .no-events {
            text-align: center;
            font-style: italic;
            color: #888;
        }

        /* Navigation Bar Styles */
        nav {
            background-color: #333;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000; /* Asegúrate de que esté por encima de otros elementos */
            height: 50px; /* Establece la altura de la barra de navegación */
            font-size: 20px;
        }

        nav ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            font-size: 20px;
        }
        nav ul li {
            margin: 0 15px;
            font-size: 20px;
        }
        nav ul li a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
            font-size: 20px;
        }
        nav ul li a:hover {
            background-color: #4CAF50;
        }

        /* Media Queries */
        @media (max-width: 768px) {
            h2 {
                font-size: 18px;
            }
            table {
                font-size: 12px;
            }
            th, td {
                padding: 6px 10px;
            }
            .content-container {
                width: 95%;
                padding: 15px;
            }
            nav ul {
                flex-direction: column;
                align-items: center;
            }
            nav ul li {
                margin: 5px 0;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 16px;
            }
            table {
                font-size: 10px;
            }
            th, td {
                padding: 5px 8px;
            }
            .content-container {
                width: 100%;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <%
        if (session.getAttribute("usuarioId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <!-- Navigation bar -->
    <nav>
        <ul>

            <li><a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">Añadir Evento</a></li>
            <li><a href="login.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>

    <header>
        <h2>Panel de Control - Administrador</h2>
    </header>

    <div class="content-container">
        <%
            String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";
            String dbUser = "root";
            String dbPassword = "Admin$1234";

            Connection conn = null;
            Statement stmtEventos = null;
            ResultSet rsEventos = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                String queryEventos = "SELECT * FROM Eventos";
                stmtEventos = conn.createStatement();
                rsEventos = stmtEventos.executeQuery(queryEventos);

                if (rsEventos.next()) {
        %>

        <h2>Lista de Eventos Disponibles</h2>

        <div class="table-container" style="max-height: 800px; overflow-y: auto;">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Fecha</th>
                        <th>Foto</th>
                        <th>Ubicación</th>
                        <th>Entradas Disponibles</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        do {
                    %>
                    <tr>
                        <td><%= rsEventos.getInt("id")%></td>
                        <td><%= rsEventos.getString("nombre")%></td>
                        <td><%= rsEventos.getString("descripcion")%></td>
                        <td><%= rsEventos.getDate("fecha")%></td>
                        <td>
                            <div class="card" style="width: 15rem; display: flex; justify-content: center; align-items: center;">
                                <img src="<%= rsEventos.getString("foto")%>" class="card-img-top" alt="..." style="width: 150px; height: 150px; object-fit: cover;">
                            </div>

                        </td>
                        <td><%= rsEventos.getString("ubicacion")%></td>
                        <td><%= rsEventos.getInt("entradas_disponibles")%></td>
                        <td>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editarModal<%= rsEventos.getInt("id")%>">
                                Editar
                            </button>
                        </td>
                    </tr>
                    <!-- Modal de Edición para cada Evento -->
                <div class="modal fade" id="editarModal<%= rsEventos.getInt("id")%>" tabindex="-1" aria-labelledby="editarModalLabel<%= rsEventos.getInt("id")%>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editarModalLabel<%= rsEventos.getInt("id")%>">Editar Evento</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Formulario de Edición -->
                                <form action="editarEvento.jsp" method="POST">
                                    <input type="hidden" name="id" value="<%= rsEventos.getInt("id")%>">

                                    <div class="mb-3">
                                        <label for="txtNombre<%= rsEventos.getInt("id")%>" class="form-label">Nombre del Evento</label>
                                        <input type="text" class="form-control" id="txtNombre<%= rsEventos.getInt("id")%>" name="nombre" value="<%= rsEventos.getString("nombre")%>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtDescripcion<%= rsEventos.getInt("id")%>" class="form-label">Descripción</label>
                                        <textarea class="form-control" id="txtDescripcion<%= rsEventos.getInt("id")%>" name="descripcion" rows="3" required><%= rsEventos.getString("descripcion")%></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtFoto<%= rsEventos.getInt("id")%>" class="form-label">Foto</label>
                                        <input type="text" class="form-control" id="txtFoto<%= rsEventos.getInt("id")%>" name="foto" value="<%= rsEventos.getString("foto")%>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtFecha<%= rsEventos.getInt("id")%>" class="form-label">Fecha del Evento</label>
                                        <input type="date" class="form-control" id="txtFecha<%= rsEventos.getInt("id")%>" name="fecha" value="<%= rsEventos.getDate("fecha")%>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtUbicacion<%= rsEventos.getInt("id")%>" class="form-label">Ubicación</label>
                                        <input type="text" class="form-control" id="txtUbicacion<%= rsEventos.getInt("id")%>" name="ubicacion" value="<%= rsEventos.getString("ubicacion")%>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtEntradas<%= rsEventos.getInt("id")%>" class="form-label">Entradas Disponibles</label>
                                        <input type="number" class="form-control" id="txtEntradas<%= rsEventos.getInt("id")%>" name="entradas_disponibles" value="<%= rsEventos.getInt("entradas_disponibles")%>" required>
                                    </div>
                                    <button type="submit" class="btn btn-info">Actualizar Evento</button>
                                </form>

                                <form action="eliminarEventos.jsp" method="POST" class="mt-3">
                                    <!-- Pasamos el ID del evento para eliminarlo -->
                                    <input type="hidden" name="id" value="<%= rsEventos.getInt("id")%>">
                                    <button type="submit" class="btn btn-danger">Eliminar Evento</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    } while (rsEventos.next());
                %>
                </tbody>
            </table>
        </div>

        <%
                } else {
                    out.println("<p>No se encontraron eventos.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Error de conexión a la base de datos.</p>");
            } finally {
                try {
                    if (rsEventos != null) {
                        rsEventos.close();
                    }
                    if (stmtEventos != null) {
                        stmtEventos.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
    <!-- Modal agregar eventos -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Añadir Nuevo Evento</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <form action="anadirEventos.jsp" method="POST">
                        <div class="mb-3">
                            <label for="txtNombre" class="form-label">Nombre del Evento</label>
                            <input type="text" class="form-control" id="txtNombre" name="txtNombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="txtDescripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="txtDescripcion" name="txtDescripcion" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="txtFoto" class="form-label">URL de la Foto</label>
                            <input type="text" class="form-control" id="txtFoto" name="txtFoto" placeholder="http://example.com/photo.jpg" required>
                        </div>

                        <div class="mb-3">
                            <label for="txtFecha" class="form-label">Fecha del Evento</label>
                            <input type="date" class="form-control" id="txtFecha" name="txtFecha" required>
                        </div>
                        <div class="mb-3">
                            <label for="txtUbicacion" class="form-label">Ubicación</label>
                            <input type="text" class="form-control" id="txtUbicacion" name="txtUbicacion" required>
                        </div>
                        <div class="mb-3">
                            <label for="txtEntradas" class="form-label">Entradas Disponibles</label>
                            <input type="number" class="form-control" id="txtEntradas" name="txtEntradas" required>
                        </div>
                        <button type="submit" class="btn btn-info">Añadir Evento</button>
                    </form>        
                </div>                    
            </div>
        </div>
    </div>









    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
