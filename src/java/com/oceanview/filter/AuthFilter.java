/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.oceanview.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")  // This filter applies to ALL URLs
public class AuthFilter implements Filter {
    
    private static final String[] PUBLIC_PATHS = {
        "/login",
        "/views/login.jsp",
        "/css/",
        "/js/",
        "/images/",
        "/index.html",
        "/index.jsp",
        // Public booking pages for website visitors
        "/reservation/new",
        "/reservation",              // booking POST
        "/views/newReservation.jsp",
        "/views/bookingSuccess.jsp",
        "/bill",
        "/views/bill.jsp",
        "/qr-image",
        "/views/qr.jsp"
    };
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, 
                        FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        String path = req.getRequestURI().substring(req.getContextPath().length());
        System.out.println("Filter processing: " + path); // For debugging
        
        // Allow public resources
        if (isPublicPath(path)) {
            System.out.println("Public path - allowing: " + path);
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            // User is logged in - allow access
            System.out.println("Logged in user - allowing: " + path);
            chain.doFilter(request, response);
        } else {
            // User not logged in - redirect to login
            System.out.println("Not logged in - redirecting to login from: " + path);
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
        }
    }
    
    private boolean isPublicPath(String path) {
        // Root path should redirect to login
        if (path.equals("/") || path.isEmpty()) {
            return false;  // Will be redirected to login
        }
        
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                return true;
            }
        }
        return false;
    }
    
    @Override
    public void destroy() {}
}
