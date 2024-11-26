<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Connection conn = null;
    PreparedStatement stmt = null;
    String dbUrl = "jdbc:mysql://localhost:3306/reservasdatabaseweb";
    String dbUser = "root";
    String dbPassword = "Admin$1234";

    if (email != null && password != null) {
        try {
            // Establecer la conexión con la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Comprobar si el email ya existe en la base de datos
            String checkQuery = "SELECT * FROM Usuarios WHERE email = ?";
            stmt = conn.prepareStatement(checkQuery);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // El email ya está registrado
                out.println("<body style='margin: 0; padding: 0; background: linear-gradient(to right, #6a11cb, #2575fc); color: white; font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh;'>");
                out.println("<div style='text-align: center; padding: 30px; border-radius: 10px; background-color: rgba(255, 255, 255, 0.2); max-width: 600px;'>");
                out.println("<h3 style='font-size: 2rem; margin-bottom: 20px;'>El correo electrónico ya está registrado</h3>");
                out.println("<a href='registro.jsp' style='display: inline-block; padding: 10px 20px; border: 2px solid white; border-radius: 5px; background-color: transparent; color: white; font-size: 1.5rem; text-decoration: none; cursor: pointer;'>Volver a intentar</a>");
                out.println("</div>");
                out.println("</body>");

            } else {
                // Si el email no existe, insertar el nuevo usuario
                String insertQuery = "INSERT INTO Usuarios (nombre, email, password) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(insertQuery);
                stmt.setString(1, nombre);
                stmt.setString(2, email);
                stmt.setString(3, password);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Registro exitoso

                    out.println("<body style='margin: 0; padding: 0; background: linear-gradient(to right, #6a11cb, #2575fc); color: white; font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh;'>");
                    out.println("<div style='text-align: center; padding: 30px; border-radius: 10px; background-color: rgba(255, 255, 255, 0.2); max-width: 600px;'>");
                    out.println("<h3 style='font-size: 2rem; margin-bottom: 20px;'>Usuario Registrado con éxito</h3>");
                    out.println("<a href='login.jsp' style='display: inline-block; padding: 10px 20px; border: 2px solid white; border-radius: 5px; background-color: transparent; color: white; font-size: 1.5rem; text-decoration: none; cursor: pointer;'>Iniciar sesion</a>");
                    out.println("</div>");
                    out.println("</body>");

                    

                } else {
                    out.println("<h3 style='color: red;'>Error al registrar el usuario. Intenta de nuevo.</h3>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color: red;'>Error de conexión a la base de datos</h3>");
        } finally {
            // Cerrar recursos
            try {
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
