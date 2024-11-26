<%-- 
    Document   : anadirEventos
    Created on : 12 nov 2024, 17:20:30
    Author     : USUARIO
--%>


<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";
        String dbUser = "root";
        String dbPassword = "Admin$1234";

        try {
            // Establecer la conexión con la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            String sqlReservas = "DELETE FROM Reservas WHERE evento_id = ?";
            try (PreparedStatement statementReservas = conn.prepareStatement(sqlReservas)) {
                statementReservas.setInt(1, id);
                statementReservas.executeUpdate();
            }

            String sql = "DELETE FROM Eventos WHERE id = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setInt(1, id);
                statement.executeUpdate();

                out.println("<body style='margin: 0; padding: 0; background: linear-gradient(to right, #6a11cb, #2575fc); color: white; font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh;'>");
                out.println("<div style='text-align: center; padding: 30px; border-radius: 10px; background-color: rgba(255, 255, 255, 0.2); max-width: 600px;'>");
                out.println("<h3 style='font-size: 2rem; margin-bottom: 20px;'> Evento eliminado con exito </h3>");
                out.println("<a href='gestionAdmins.jsp' style='display: inline-block; padding: 10px 20px; border: 2px solid white; border-radius: 5px; background-color: transparent; color: white; font-size: 1.5rem; text-decoration: none; cursor: pointer;'>Volver a eventos</a>");
                out.println("</div>");
                out.println("</body>");

          }

        
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<pstyle='color: red;'>Error al eliminar el evento: " + e.getMessage() + "</p>");
    }

    
    finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

%>


