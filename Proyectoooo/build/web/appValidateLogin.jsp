<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    String email = request.getParameter("txtemail");
    String password = request.getParameter("txtpassword");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";
    String dbUser = "root";
    String dbPassword = "Admin$1234";

    if (email != null && password != null) {
        try {
            // Establecer la conexión con la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Consultar la tabla de usuarios
            String query = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            // Si hay un registro con ese email y contraseña, redirigir a index.jsp
            if (rs.next()) {
                // Las credenciales son correctas
                int usuarioId = rs.getInt("id");  // Obtener el id del usuario
                session.setAttribute("usuarioId", usuarioId);  // Guardar el id en la sesión
                String nombreId = rs.getString("nombre");  // Obtener el nombre
                session.setAttribute("nombreId", nombreId);  // Guardar el nombre en la sesión
                String role = rs.getString("role");

                if ("admin".equalsIgnoreCase(role)) {

                    response.sendRedirect("gestionAdmins.jsp");
                } else {

                    response.sendRedirect("newjsp.jsp");
                }

            } else {
                // Las credenciales son incorrectas

                out.println("<body style='margin: 0; padding: 0; background: linear-gradient(to right, #6a11cb, #2575fc); color: white; font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh;'>");
                out.println("<div style='text-align: center; padding: 30px; border-radius: 10px; background-color: rgba(255, 255, 255, 0.2); max-width: 600px;'>");
                out.println("<h3 style='font-size: 2rem; margin-bottom: 20px;'> Correo o Contraseña incorrectas</h3>");
                out.println("<a href='login.jsp' style='display: inline-block; padding: 10px 20px; border: 2px solid white; border-radius: 5px; background-color: transparent; color: white; font-size: 1.5rem; text-decoration: none; cursor: pointer;'>Volver a intentar</a>");
                out.println("</div>");
                out.println("</body>");

            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color: red;'>Error de conexión a la base de datos</h3>");
            // Agregar el botón para volver al index.jsp
            out.println("<form action='login.jsp' method='get'>");
            out.println("<input type='submit' value='Volver al inicio' />");
            out.println("</form>");
        } finally {
            // Cerrar recursos
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
    }
%>
