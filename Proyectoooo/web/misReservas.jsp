<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Reservas</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
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
            max-width: 900px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            font-size: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
        .no-reservas {
            text-align: center;
            font-style: italic;
            color: #888;
        }

        /* Navigation Bar Styles */
        nav {
            background-color: #333;
            width: 100%;
        }
        nav ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }
        nav ul li {
            margin: 0 15px;
            
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

        /* Media Queries for responsive design */
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
    <!-- Navigation bar -->
    <nav>
        <ul>
            <li><a href="login.jsp">Inicio</a></li>
            <li><a href="newjsp.jsp">Eventos</a></li>
             <li><a href="login.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>

    <!-- Header -->
    <header>
        <div class="welcome-container">
            <% String nombreId = (String) session.getAttribute("nombreId"); %>
            <h1>Bienvenido <%= nombreId %></h1>
        </div>
    </header>

    <!-- Main Content -->
    <div class="content-container">
        <%
            // Obtener el usuarioId desde la sesión
            Integer usuarioId = (Integer) session.getAttribute("usuarioId");

            if (usuarioId == null) {
                response.sendRedirect("login.jsp"); // Redirigir al login si no hay usuario en sesión
                return;
            }

            // Variables para la conexión a la base de datos
            String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";  // Cambia la URL si es necesario
            String dbUser = "root";  
            String dbPassword = "Admin$1234";  // Cambia con tu contraseña de MySQL

            Connection conn = null;
            PreparedStatement stmtReservas = null;
            ResultSet rsReservas = null;
            PreparedStatement stmtEliminar = null;
            PreparedStatement stmtActualizarEvento = null;

          
                // Establecer la conexión con la base de datos
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Cargar el driver
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword); // Conectar a la base de datos
                } catch (ClassNotFoundException e) {
                    out.println("<p style='color: red;'>Error al cargar el driver JDBC: " + e.getMessage() + "</p>");
                    return; // Terminar la ejecución si no se puede cargar el driver
                } catch (SQLException e) {
                    out.println("<p style='color: red;'>Error al establecer la conexión con la base de datos: " + e.getMessage() + "</p>");
                    return; // Terminar la ejecución si no se puede conectar
                }

                // Consulta para obtener las reservas del usuario actual
                String queryReservas = "SELECT r.id, r.cantidad, r.fecha_reserva, e.id AS evento_id, e.nombre AS evento_nombre " +
                                       "FROM Reservas r JOIN Eventos e ON r.evento_id = e.id " +
                                       "WHERE r.usuario_id = ?";
                stmtReservas = conn.prepareStatement(queryReservas);
                stmtReservas.setInt(1, usuarioId);
                rsReservas = stmtReservas.executeQuery();
        %>

        <h2>Mis Reservas</h2>
        <p>Usuario: <%= nombreId %></p>

        <table>
            <thead>
                <tr>
                    <th>ID Reserva</th>
                    <th>Evento</th>
                    <th>Cantidad</th>
                    <th>Fecha de Reserva</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
        <%
                if (!rsReservas.isBeforeFirst()) {
                    // No hay reservas
        %>
                    <tr><td colspan="5" class="no-reservas">No tienes reservas aún.</td></tr>
        <%
                } else {
                    while (rsReservas.next()) {
        %>
                    <tr>
                        <td><%= rsReservas.getInt("id") %></td>
                        <td><%= rsReservas.getString("evento_nombre") %></td>
                        <td><%= rsReservas.getInt("cantidad") %></td>
                        <td><%= rsReservas.getTimestamp("fecha_reserva") %></td>
                        <td>
                            <!-- Formulario para eliminar reserva -->
                            <form action="misReservas.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="reservaId" value="<%= rsReservas.getInt("id") %>" />
                                <input type="hidden" name="eventoId" value="<%= rsReservas.getInt("evento_id") %>" />
                                <input type="hidden" name="cantidad" value="<%= rsReservas.getInt("cantidad") %>" />
                                <input type="submit" value="Eliminar Reserva" style="background-color: red; color: white;" />
                            </form>
                        </td>
                    </tr>
        <%
                    }
                }
        %>
            </tbody>
        </table>

        <%
            // Eliminar reserva y actualizar cantidad de entradas
            String reservaIdParam = request.getParameter("reservaId");
            String eventoIdParam = request.getParameter("eventoId");
            String cantidadParam = request.getParameter("cantidad");

            if (reservaIdParam != null && eventoIdParam != null && cantidadParam != null) {
                int reservaId = Integer.parseInt(reservaIdParam);
                int eventoId = Integer.parseInt(eventoIdParam);
                int cantidad = Integer.parseInt(cantidadParam);

                try {
                    // Iniciar transacción
                    conn.setAutoCommit(false);

                    // Actualizar el número de entradas disponibles
                    String updateEventoQuery = "UPDATE Eventos SET entradas_disponibles = entradas_disponibles + ? WHERE id = ?";
                    stmtActualizarEvento = conn.prepareStatement(updateEventoQuery);
                    stmtActualizarEvento.setInt(1, cantidad);
                    stmtActualizarEvento.setInt(2, eventoId);
                    stmtActualizarEvento.executeUpdate();

                    // Eliminar la reserva
                    String deleteReservaQuery = "DELETE FROM Reservas WHERE id = ?";
                    stmtEliminar = conn.prepareStatement(deleteReservaQuery);
                    stmtEliminar.setInt(1, reservaId);
                    stmtEliminar.executeUpdate();

                    conn.commit();  // Confirmar cambios
                    
                    response.sendRedirect("misReservas.jsp");
                    //out.println("<p style='color: green;'>Reserva eliminada exitosamente y cantidad de entradas actualizada.</p>");
                    //out.println("<a href='newjsp.jsp'>Volver a la lista de eventos</a>");
                    
                } catch (SQLException e) {
                    conn.rollback(); // Revertir cambios en caso de error
                    out.println("<p style='color: red;'>Error al eliminar la reserva: " + e.getMessage() + "</p>");
                }
            }

            // Cerrar recursos
            try {
                if (stmtReservas != null) stmtReservas.close();
                if (rsReservas != null) rsReservas.close();
                if (stmtEliminar != null) stmtEliminar.close();
                if (stmtActualizarEvento != null) stmtActualizarEvento.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p style='color: red;'>Error al cerrar los recursos: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</body>
</html>
