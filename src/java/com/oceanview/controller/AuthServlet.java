package com.oceanview.controller;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/logout", "/dashboard"})
public class AuthServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        switch(path) {
            case "/login":
                // Show login page in modal (redirect to home with login modal)
                response.sendRedirect(request.getContextPath() + "/");
                break;
            case "/logout":
                logout(request, response);
                break;
            case "/dashboard":
                showDashboard(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        String action = request.getParameter("action");
        
        if ("/login".equals(path) && "login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            User user = userDAO.authenticate(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole());

                // After login, always go to main dashboard page
                response.sendRedirect(request.getContextPath() + "/views/dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                // Stay on homepage but show modal with error
                request.getRequestDispatcher("/").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    // Optional: /dashboard GET just sends user back to generic dashboard
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        response.sendRedirect(request.getContextPath() + "/views/dashboard.jsp");
    }
}