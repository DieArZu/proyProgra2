package paquetes;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseConnection {
    private Connection conn;

    public DatabaseConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/reservasdatabaseweb", "root", "Admin$1234");
        } catch (ClassNotFoundException ex) {
            throw new SQLException("Database driver not found", ex);
        }
    }

    public boolean validateLogin(String txtemail, String txtpassword) throws SQLException {
        if (conn == null || conn.isClosed()) {
            throw new SQLException("Database connection is not available");
        }

        String sql = "SELECT * FROM reservasdatabaseweb.users WHERE email = ? AND pwd = ?";
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, txtemail);
            statement.setString(2, txtpassword);
            try (ResultSet resultset = statement.executeQuery()) {
                return resultset.next();
            }
        }
    }

    public void Close() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(DatabaseConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
