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
        // Retrieve form data
        String teacherId = request.getParameter("teacherId");
        String userId = request.getParameter("userId");
        String teacherName = request.getParameter("teacherName");
        String designation = request.getParameter("designation");
        String subjectSpecialization = request.getParameter("subjectSpecialization");
        String phoneNo = request.getParameter("teacherPhoneNo");
        String email = request.getParameter("teacherEmail");
        String password = request.getParameter("teacherPassword");
        String address = request.getParameter("teacherAddress");

        // Load the Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish database connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        conn.setAutoCommit(false); // Begin transaction

        // Check if the email exists in Authorized_Users and is not already registered
        String emailCheckQuery = "SELECT Is_registered FROM Authorized_Users WHERE Email = ?";
        pstmt = conn.prepareStatement(emailCheckQuery);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            boolean isRegistered = rs.getBoolean("Is_registered");
            if (isRegistered) {
                // Email already registered
                response.sendRedirect("RegisterTeacher.jsp?error=unauthorized");
                return;
            }
        } else {
            // Email not found in Authorized_Users
            response.sendRedirect("RegisterTeacher.jsp?error=unauthorized");
            return;
        }

        // Insert into Users table
        String insertUserQuery = "INSERT INTO Users (Login_id, User_id, Password, User_role) VALUES " +
                                 "((SELECT COALESCE(MAX(Login_id), 0) + 1 FROM Users), ?, ?, 'TEACHER')";
        pstmt = conn.prepareStatement(insertUserQuery);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);
        pstmt.executeUpdate();

        // Insert into Teacher_Info table
        String insertTeacherQuery = "INSERT INTO Teacher_Info (Teacher_id, User_id, Password, Teacher_name, " +
                                     "Designation, Subject_specialization, Teacher_PhoneNo, Teacher_Email) " +
                                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertTeacherQuery);
        pstmt.setString(1, teacherId);
        pstmt.setString(2, userId);
        pstmt.setString(3, password);
        pstmt.setString(4, teacherName);
        pstmt.setString(5, designation);
        pstmt.setString(6, subjectSpecialization);
        pstmt.setString(7, phoneNo);
        pstmt.setString(8, email);
        pstmt.executeUpdate();

        // Insert into Department_Info table
        String insertDeptQuery = "INSERT INTO Department_Info (Teacher_id, Teacher_Address) VALUES (?, ?)";
        pstmt = conn.prepareStatement(insertDeptQuery);
        pstmt.setString(1, teacherId);
        pstmt.setString(2, address);
        pstmt.executeUpdate();

        // Mark the email as registered in Authorized_Users
        String updateAuthorizedUserQuery = "UPDATE Authorized_Users SET Is_registered = TRUE WHERE Email = ?";
        pstmt = conn.prepareStatement(updateAuthorizedUserQuery);
        pstmt.setString(1, email);
        pstmt.executeUpdate();

        // Commit transaction
        conn.commit();

        // Set session attributes and redirect to home page
        session.setAttribute("role", "Teacher");
        session.setAttribute("userid", userId);
        response.sendRedirect("HomePage.jsp");
    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
        response.sendRedirect("RegisterTeacher.jsp?error=failed&message=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>
