<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>




<%
   
    int eventoId = Integer.parseInt(request.getParameter("eventoId"));
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";
    String dbUser = "root";
    String dbPassword = "Admin$1234";
    Integer usuarioId = (Integer) session.getAttribute("usuarioId");  // Obtener el usuarioId desde la sesión
    String usuarioIdStr = usuarioId != null ? usuarioId.toString() : "";  // Convertir a String si no es null
     
    try {
        // Establecer la conexión con la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Verificar que haya entradas suficientes
        String checkQuery = "SELECT entradas_disponibles FROM Eventos WHERE id = ?";
        stmt = conn.prepareStatement(checkQuery);
        stmt.setInt(1, eventoId);
        rs = stmt.executeQuery();

        int entradasDisponibles = 0;
        if (rs.next()) {
            entradasDisponibles = rs.getInt("entradas_disponibles");
             
        }

        if (entradasDisponibles >= cantidad) {
            // Insertar la reserva en la tabla Reservas
           
            String insertQuery = "INSERT INTO Reservas (usuario_id, evento_id, cantidad) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertQuery);
            stmt.setInt(1, usuarioId);
            stmt.setInt(2, eventoId);
            stmt.setInt(3, cantidad);
            stmt.executeUpdate();

            // Actualizar la cantidad de entradas disponibles en la tabla Eventos
            String updateQuery = "UPDATE Eventos SET entradas_disponibles = entradas_disponibles - ? WHERE id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setInt(1, cantidad);
            stmt.setInt(2, eventoId);
            stmt.executeUpdate();

            // Mensaje de éxito
            out.println("<p style='color: green;'>Compra realizada con éxito. Gracias por su compra.</p>");
            out.println("<a href='newjsp.jsp'>Volver a la lista de eventos</a>");
        } else {
            // Mensaje de error si no hay suficientes entradas
            out.println("<p style='color: red;'>Error: No hay suficientes entradas disponibles para este evento.</p>");
            out.println("<a href='newjsp.jsp'>Volver a la lista de eventos</a>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color: red;'>Error al procesar la solicitud de compra.</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
