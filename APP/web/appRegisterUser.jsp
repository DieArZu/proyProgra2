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
                out.println("<h3 style='color: red;'>Error: El correo electrónico ya está registrado</h3>");
                out.println("<a href='register.jsp'>Volver a intentar</a>");
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
                    out.println("<h3 style='color: green;'>¡Usuario registrado con éxito!</h3>");
                    out.println("<a href='login.jsp'>Ir al inicio</a>");
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
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
