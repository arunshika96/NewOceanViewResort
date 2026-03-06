package com.oceanview.util;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

public class TestUserDAO {
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        
        System.out.println("=== Testing User Authentication ===");
        
        // Test with admin credentials (from your database)
        User user = userDAO.authenticate("admin", "Admin@123");
        
        if (user != null) {
            System.out.println("✅ Login successful!");
            System.out.println("User Details:");
            System.out.println("  Name: " + user.getFullName());
            System.out.println("  Username: " + user.getUsername());
            System.out.println("  Role: " + user.getRole());
            System.out.println("  Email: " + user.getEmail());
        } else {
            System.out.println("❌ Login failed!");
        }
    }
}