<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String dbURL = "jdbc:derby://localhost:1527/blms";
    String dbUser = "akshita";
    String dbPassword = "akshita";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Get user input
        String userId = request.getParameter("userid").trim();
        String password = request.getParameter("password").trim();

        // Validate input
        if (userId == null || userId.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("LoginPage.jsp?error=empty");
            return;
        }

        // Load the Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to validate credentials
        String query = "SELECT User_role FROM Users WHERE User_id = ? AND Password = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Set session attributes and redirect
            String role = rs.getString("User_role");
            session.setAttribute("role", role);
            session.setAttribute("userid", userId);
            response.sendRedirect("HomePage.jsp");
        } else {
            // Invalid credentials
            response.sendRedirect("LoginPage.jsp?error=invalid");
        }
    } catch (Exception e) {
        // Handle exceptions
        e.printStackTrace();
        response.sendRedirect("LoginPage.jsp?error=unexpected");
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
