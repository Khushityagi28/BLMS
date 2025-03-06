<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String dbURL = "jdbc:derby://localhost:1527/blms";
    String dbUser = "akshita";
    String dbPassword = "akshita";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Retrieve form data
        String studentId = request.getParameter("studentId");
        String userId = request.getParameter("userId");
        String studentName = request.getParameter("studentName");
        String phoneNo = request.getParameter("studentPhoneNo");
        String email = request.getParameter("studentEmail");
        String password = request.getParameter("studentPassword");
        String address = request.getParameter("studentAddress");

        // Load the Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        conn.setAutoCommit(false); // Begin transaction

        // Insert into the Users table
        String insertUserQuery = "INSERT INTO Users (Login_id, User_id, Password, User_role) VALUES " +
                                 "((SELECT COALESCE(MAX(Login_id), 0) + 1 FROM Users), ?, ?, 'STUDENT')";
        pstmt = conn.prepareStatement(insertUserQuery);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);
        pstmt.executeUpdate();

        // Insert into the Student table
        String insertStudentQuery = "INSERT INTO Student (Student_id, User_id, Password, Student_name, " +
                                     "Student_Email, Student_PhoneNo, Student_Address) " +
                                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertStudentQuery);
        pstmt.setString(1, studentId);
        pstmt.setString(2, userId);
        pstmt.setString(3, password);
        pstmt.setString(4, studentName);
        pstmt.setString(5, email);
        pstmt.setString(6, phoneNo);
        pstmt.setString(7, address);
        pstmt.executeUpdate();

        // Commit the transaction
        conn.commit();

        // Set session attributes and redirect to home page
        session.setAttribute("role", "Student");
        session.setAttribute("userid", userId);
        response.sendRedirect("HomePage.jsp");
    } catch (Exception e) {
        // Rollback transaction on error
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }

        // Log the error and redirect with an error message
        e.printStackTrace();
        String errorMessage = e.getMessage();
        response.sendRedirect("RegisterStudent.jsp?error=failed&message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
    } finally {
        // Close resources
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
