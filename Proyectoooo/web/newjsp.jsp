<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Eventos</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            box-sizing: border-box;
        }

     

        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
            font-size: 18px;
        }

        .content-container {
            
            
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            width: 80%;
            padding: 15px;

        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            font-size: 20px;

        }

        th, td {
            padding: 10px 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            justify-content: center;
          

        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        td {
            color: #333;
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
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            flex-direction: row;
            align-items: center;
            font-size: 25px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }

        nav ul li a:hover {
            background-color: #4CAF50;
        }

        
    </style>

</head>
<body>
    <!-- Navigation bar -->
   



    <div class="content-container">
          <br>
        <br>
          <br>
        <br>
        <br>
        <br>
            <br>
        <br>
        <br>
          <br>
        <br>
         <nav>
        <ul>
            <li><a href="login.jsp">Inicio</a></li>
            <li><a href="misReservas.jsp">Mis Reservas</a></li>
            <li><a href="login.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>
        <br>
        <br>
    
        
        <%
            // Obtener el usuarioId desde la sesión
            Integer usuarioId = (Integer) session.getAttribute("usuarioId");
            String nombreId = (String) session.getAttribute("nombreId");

            if (usuarioId == null) {
                response.sendRedirect("login.jsp"); // Redirigir al login si no hay usuario en sesión
                return;
            }

            // Variables para la conexión a la base de datos
            String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";  // Cambia la URL si es necesario
            String dbUser = "root";  // Cambia con tu usuario de MySQL
            String dbPassword = "Admin$1234";  // Cambia con tu contraseña de MySQL

            Connection conn = null;
            Statement stmtEventos = null;
            PreparedStatement stmtReservas = null;
            ResultSet rsEventos = null;
            ResultSet rsReservas = null;

            try {
                // Establecer la conexión con la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                // Consulta para obtener todos los eventos
                String queryEventos = "SELECT * FROM Eventos";
                stmtEventos = conn.createStatement();
                rsEventos = stmtEventos.executeQuery(queryEventos);

                // Mostrar los eventos en una tabla HTML
                if (rsEventos.next()) {
        %>

        <h2>Lista de Eventos Disponibles</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Fecha evento</th>
                    <th>Foto</th>
                    <th>Ubicación</th>
                    <th>Entradas Disponibles</th>
                    <th>Comprar Entradas</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Recorrer los resultados y mostrar cada evento en una fila
                    do {
                %>
                <tr>
                    <td><%= rsEventos.getInt("id")%></td>
                    <td><%= rsEventos.getString("nombre")%></td>
                    <td><%= rsEventos.getString("descripcion")%></td>
                    <td><%= rsEventos.getDate("fecha")%></td>
                    <td>
                        <div class="card" style="width: 10rem; margin-right: 2px;">
                            <img src="<%= rsEventos.getString("foto")%>" class="card-img-top" alt="..." style="width: 100px; height: 100px; object-fit: cover;">
                        </div>
                    </td>
                    <td><%= rsEventos.getString("ubicacion")%></td>
                    <td><%= rsEventos.getInt("entradas_disponibles")%></td>
                    <td>
                        <form action="comprarEntradas.jsp" method="post">
                            <input type="hidden" name="eventoId" value="<%= rsEventos.getInt("id")%>" />
                            <label for="cantidad">Cantidad:</label>
                            <input type="number" name="cantidad" min="1" max="10" required style="padding: 12px 15px; font-size: 1.2rem; width: 70%; max-width: 100px; border-radius: 5px; border: 1px solid #ccc;" />
                            <input type="submit" value="Comprar" style="margin-top: 15px; margin-bottom: 10px; font-size: 20px; display: block; margin-left: 65px" />

                        </form>
                    </td>
                </tr>

                <%
                    } while (rsEventos.next());  // Continuar mientras haya más filas
                %>
            </tbody>
        </table>

        <%
            } else {
                out.println("<p>No se encontraron eventos.</p>");
            }

            // Consulta para obtener las reservas del usuario actual
            String queryReservas = "SELECT r.id, r.cantidad, r.fecha_reserva, e.nombre AS evento_nombre "
                    + "FROM Reservas r JOIN Eventos e ON r.evento_id = e.id "
                    + "WHERE r.usuario_id = ?";
            stmtReservas = conn.prepareStatement(queryReservas);
            stmtReservas.setInt(1, usuarioId);
            rsReservas = stmtReservas.executeQuery();
        %>

        <div class="section-divider"></div>

        <h2>Mis Reservas</h2>
        <p>Usuario: <%= nombreId%></p>

        <table>
            <thead>
                <tr>
                    <th>ID Reserva</th>
                    <th>Evento</th>
                    <th>Cantidad</th>
                    <th>Fecha de Reserva</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (!rsReservas.isBeforeFirst()) {
                        // No hay reservas
                %>
                <tr><td colspan="4" class="no-reservas">No tienes reservas aún.</td></tr>
                <%
                } else {
                    while (rsReservas.next()) {
                %>
                <tr>
                    <td><%= rsReservas.getInt("id")%></td>
                    <td><%= rsReservas.getString("evento_nombre")%></td>
                    <td><%= rsReservas.getInt("cantidad")%></td>
                    <td><%= rsReservas.getTimestamp("fecha_reserva")%></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Error de conexión a la base de datos.</p>");
            } finally {
                // Cerrar recursos
                try {
                    if (rsEventos != null) {
                        rsEventos.close();
                    }
                    if (rsReservas != null) {
                        rsReservas.close();
                    }
                    if (stmtEventos != null) {
                        stmtEventos.close();
                    }
                    if (stmtReservas != null) {
                        stmtReservas.close();
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


