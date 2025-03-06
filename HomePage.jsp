<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    String userId = (String) session.getAttribute("userid");
    if (role == null || userId == null) {
        response.sendRedirect("LoginPage.jsp?error=sessionExpired");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | Learning Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
    </style>
</head>
<body class="bg-gray-50">
    <!-- Navigation Bar -->
    <nav class="gradient-bg text-white shadow-lg">
        <div class="container mx-auto px-6 py-4 flex justify-between items-center">
            <div class="flex items-center">
                <i class="fas fa-graduation-cap text-2xl mr-3"></i>
                <span class="text-xl font-bold">Learning Portal</span>
            </div>
            <div class="flex items-center">
                <span class="mr-4">Welcome, <%= role %></span>
                <span class="mr-4 text-sm opacity-75">ID: <%= userId %></span>
                <a href="Logout.jsp" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition duration-200">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mx-auto px-6 py-8">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-800 mb-2"><%= role %> Dashboard</h1>
            <div class="h-1 w-20 bg-purple-500 rounded"></div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <% if ("Student".equalsIgnoreCase(role)) { %>
                <!-- Student Cards -->
                <a href="ViewAssignments.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-purple-500 mb-4">
                        <i class="fas fa-tasks text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">View Assignments</h3>
                    <p class="text-gray-600">Check your pending and completed assignments</p>
                </a>
                <a href="DownloadNotes.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-blue-500 mb-4">
                        <i class="fas fa-book-reader text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Download Notes</h3>
                    <p class="text-gray-600">Access study materials and resources</p>
                </a>
                <a href="SubmitAssignments.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-green-500 mb-4">
                        <i class="fas fa-upload text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Submit Assignments</h3>
                    <p class="text-gray-600">Upload your completed assignments</p>
                </a>
            <% } else if ("Teacher".equalsIgnoreCase(role)) { %>
                <!-- Teacher Cards -->
                <a href="UploadNotes.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-blue-500 mb-4">
                        <i class="fas fa-file-upload text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Upload Study Notes</h3>
                    <p class="text-gray-600">Share learning materials with students</p>
                </a>
                <a href="ViewSubmissions.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-green-500 mb-4">
                        <i class="fas fa-check-circle text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">View Submissions</h3>
                    <p class="text-gray-600">Review student assignments</p>
                </a>
                <a href="CreateAssignments.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-purple-500 mb-4">
                        <i class="fas fa-plus-circle text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Create Assignments</h3>
                    <p class="text-gray-600">Create new tasks for students</p>
                </a>
                <!-- Notifications Section -->
                <a href="SendNotification.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-yellow-500 mb-4">
                        <i class="fas fa-bell text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Send Notifications</h3>
                    <p class="text-gray-600">Send important updates to students</p>
                </a>
                <a href="ViewNotifications.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-red-500 mb-4">
                        <i class="fas fa-envelope-open-text text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">View Notifications</h3>
                    <p class="text-gray-600">Check previously sent notifications</p>
                </a>
            <% } else if ("Admin".equalsIgnoreCase(role)) { %>
                <!-- Admin Cards -->
                <a href="ManageUsers.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-blue-500 mb-4">
                        <i class="fas fa-users-cog text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Manage Users</h3>
                    <p class="text-gray-600">Add, edit, or remove system users</p>
                </a>
                <a href="ViewReports.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-green-500 mb-4">
                        <i class="fas fa-chart-bar text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">View Reports</h3>
                    <p class="text-gray-600">Access system analytics and reports</p>
                </a>
                <a href="ConfigureSystem.jsp" class="dashboard-card bg-white rounded-lg shadow-md p-6 hover:shadow-xl">
                    <div class="text-purple-500 mb-4">
                        <i class="fas fa-cogs text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Configure System</h3>
                    <p class="text-gray-600">Modify system settings and preferences</p>
                </a>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white mt-12">
        <div class="container mx-auto px-6 py-4">
            <div class="flex justify-between items-center">
                <div>
                    <p class="text-sm">&copy; 2025 Learning Portal. All rights reserved.</p>
                </div>
                <div class="flex space-x-4">
                    <a href="#" class="hover:text-gray-300"><i class="fas fa-question-circle"></i> Help</a>
                    <a href="#" class="hover:text-gray-300"><i class="fas fa-envelope"></i> Contact</a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
