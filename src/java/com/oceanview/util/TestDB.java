package com.oceanview.util;

import com.oceanview.pattern.singleton.DatabaseConnection;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        System.out.println("Testing Database Connection...");
        
        DatabaseConnection db = DatabaseConnection.getInstance();
        
        if (db.testConnection()) {
            System.out.println("✅ SUCCESS: Connected to database!");
        } else {
            System.out.println("❌ FAILED: Could not connect to database!");
        }
    }
}