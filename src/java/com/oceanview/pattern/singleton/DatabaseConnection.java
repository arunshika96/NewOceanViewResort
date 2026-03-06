package com.oceanview.pattern.singleton;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseConnection {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseConnection.class.getName());
    private static volatile DatabaseConnection instance;
    private static Connection connection;
    private Properties props = new Properties();
    
    private DatabaseConnection() {
        try {
            loadProperties();
            initializeConnection();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize database connection", e);
        }
    }
    
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }
    
    private void loadProperties() throws Exception {
        try (InputStream input = getClass().getClassLoader()
                .getResourceAsStream("database.properties")) {
            if (input == null) {
                throw new Exception("database.properties not found");
            }
            props.load(input);
        }
    }
    
    private void initializeConnection() throws ClassNotFoundException, SQLException {
        Class.forName(props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver"));
        
        String url = props.getProperty("db.url", "jdbc:mysql://localhost:3306/oceanview_resort");
        String username = props.getProperty("db.username", "root");
        String password = props.getProperty("db.password", "");
        
        connection = DriverManager.getConnection(url + "?useSSL=false&serverTimezone=UTC", 
                                                username, password);
        LOGGER.info("Database connected successfully");
    }
    
    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            synchronized (this) {
                if (connection == null || connection.isClosed()) {
                    try {
                        initializeConnection();
                    } catch (Exception e) {
                        throw new SQLException("Failed to reconnect to database", e);
                    }
                }
            }
        }
        return connection;
    }
    
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Database connection closed");
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing connection", e);
            }
        }
    }
    
    public boolean testConnection() {
        try {
            return getConnection() != null && !getConnection().isClosed();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Connection test failed", e);
            return false;
        }
    }
}