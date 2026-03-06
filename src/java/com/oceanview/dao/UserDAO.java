package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.pattern.singleton.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    private Connection connection;
    
    public UserDAO() {
        try {
            this.connection = DatabaseConnection.getInstance().getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Authenticate user for login
    // Change this method in UserDAO.java
public User authenticate(String username, String password) {
    // Use plain text comparison (since your DB has 123, 456)
    String sql = "SELECT * FROM users WHERE username = ? AND password = ? AND is_active = true";
    
    try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
        
        pstmt.setString(1, username);
        pstmt.setString(2, password);  // Plain text password
        
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                User user = mapResultSetToUser(rs);
                updateLastLogin(user.getUserId());
                return user;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
    
    // Get user by ID
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get user by username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Create new user
    public boolean createUser(User user, String password) {
        String sql = "INSERT INTO users (username, password, email, full_name, role) VALUES (?, SHA2(?, 256), ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, password);
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getFullName());
            pstmt.setString(5, user.getRole());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update last login timestamp
    private void updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = NOW() WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    // Change password
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        // First verify old password
        String verifySql = "SELECT user_id FROM users WHERE user_id = ? AND password = SHA2(?, 256)";
        
        try (PreparedStatement verifyStmt = connection.prepareStatement(verifySql)) {
            verifyStmt.setInt(1, userId);
            verifyStmt.setString(2, oldPassword);
            
            try (ResultSet rs = verifyStmt.executeQuery()) {
                if (rs.next()) {
                    // Old password correct, update to new
                    String updateSql = "UPDATE users SET password = SHA2(?, 256) WHERE user_id = ?";
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                        updateStmt.setString(1, newPassword);
                        updateStmt.setInt(2, userId);
                        return updateStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Deactivate user (soft delete)
    public boolean deactivateUser(int userId) {
        String sql = "UPDATE users SET is_active = false WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Activate user
    public boolean activateUser(int userId) {
        String sql = "UPDATE users SET is_active = true WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to map ResultSet to User object
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setFullName(rs.getString("full_name"));
        user.setRole(rs.getString("role"));
        user.setActive(rs.getBoolean("is_active"));
        
        Timestamp lastLogin = rs.getTimestamp("last_login");
        if (lastLogin != null) {
            user.setLastLogin(lastLogin.toLocalDateTime());
        }
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        return user;
    }
}