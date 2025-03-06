<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
    <head>
        <title>Teacher Registration</title>
        <style>
            :root {
                --primary-color: #2563eb;
                --primary-hover: #1d4ed8;
                --background: #f8fafc;
                --card-background: #ffffff;
                --text-color: #1e293b;
                --border-color: #e2e8f0;
                --error-color: #ef4444;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Inter', system-ui, -apple-system, sans-serif;
                text-align: center;
                background-color: var(--background);
                background-image: 
                    radial-gradient(at 40% 20%, hsla(215,98%,61%,0.1) 0px, transparent 50%),
                    radial-gradient(at 80% 0%, hsla(189,100%,56%,0.1) 0px, transparent 50%),
                    radial-gradient(at 0% 50%, hsla(355,100%,93%,0.1) 0px, transparent 50%);
                color: var(--text-color);
                margin: 0;
                padding: 2rem;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .container {
                padding: 2.5rem;
                width: 90%;
                max-width: 800px;
                background: var(--card-background);
                border-radius: 1rem;
                box-shadow: 
                    0 4px 6px -1px rgba(0, 0, 0, 0.1),
                    0 2px 4px -1px rgba(0, 0, 0, 0.06);
                overflow: hidden;
            }

            h1 {
                font-size: 1.875rem;
                font-weight: 700;
                color: var(--text-color);
                margin-bottom: 2rem;
                position: relative;
                display: inline-block;
            }

            h1::after {
                content: '';
                position: absolute;
                bottom: -0.5rem;
                left: 50%;
                transform: translateX(-50%);
                width: 50%;
                height: 3px;
                background: var(--primary-color);
                border-radius: 2px;
            }

            .form-row {
                display: flex;
                flex-wrap: wrap;
                gap: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .form-row div {
                flex: 1 1 calc(50% - 0.75rem);
                min-width: 250px;
            }

            label {
                display: block;
                text-align: left;
                margin-bottom: 0.5rem;
                font-weight: 500;
                font-size: 0.875rem;
                color: var(--text-color);
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="tel"],
            textarea {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid var(--border-color);
                border-radius: 0.5rem;
                font-size: 0.875rem;
                transition: all 0.2s ease;
                background-color: #f8fafc;
            }

            input:focus,
            textarea:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            textarea {
                height: 100px;
                resize: vertical;
            }

            input[type="submit"] {
                width: 100%;
                padding: 0.875rem;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-size: 1rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                margin-top: 1rem;
            }

            input[type="submit"]:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }

            input[type="submit"]:active {
                transform: translateY(0);
            }

            .error-message {
                display: none;
                color: var(--error-color);
                background-color: #fee2e2;
                border: 1px solid #fecaca;
                padding: 1rem;
                border-radius: 0.5rem;
                margin-bottom: 1.5rem;
                text-align: left;
            }

            @media (max-width: 640px) {
                .container {
                    padding: 1.5rem;
                }

                .form-row div {
                    flex: 1 1 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Teacher Registration</h1>
            
            <!-- Error message container -->
            <div id="errorMessage" class="error-message"></div>
            
            <form action="TeacherRegistrationHandler.jsp" method="POST">
                <div class="form-row">
                    <div>
                        <label for="teacherId">Teacher ID:</label>
                        <input type="text" id="teacherId" name="teacherId" required>
                    </div>
                    <div>
                        <label for="userId">User ID:</label>
                        <input type="text" id="userId" name="userId" required>
                    </div>
                </div>

                <div class="form-row">
                    <div>
                        <label for="teacherName">Name:</label>
                        <input type="text" id="teacherName" name="teacherName" required>
                    </div>
                    <div>
                        <label for="designation">Designation:</label>
                        <input type="text" id="designation" name="designation" required>
                    </div>
                </div>

                <div class="form-row">
                    <div>
                        <label for="subjectSpecialization">Subject Specialization:</label>
                        <input type="text" id="subjectSpecialization" name="subjectSpecialization" required>
                    </div>
                    <div>
                        <label for="teacherPhoneNo">Phone Number:</label>
                        <input type="tel" id="teacherPhoneNo" name="teacherPhoneNo" required>
                    </div>
                </div>

                <div class="form-row">
                    <div>
                        <label for="teacherEmail">Email:</label>
                        <input type="email" id="teacherEmail" name="teacherEmail" required>
                    </div>
                    <div>
                        <label for="teacherPassword">Password:</label>
                        <input type="password" id="teacherPassword" name="teacherPassword" required>
                    </div>
                </div>

                <div class="form-row">
                    <div>
                        <label for="teacherAddress">Address:</label>
                        <textarea id="teacherAddress" name="teacherAddress" required></textarea>
                    </div>
                </div>

                <input type="submit" value="Register">
            </form>
        </div>

        <script>
            window.onload = function() {
                const errorMessage = document.getElementById('errorMessage');
                const urlParams = new URLSearchParams(window.location.search);
    
                if (urlParams.get('error') === 'unauthorized') {
                errorMessage.style.display = 'block';
                errorMessage.textContent = 'Registration failed: Unauthorized User ID or already registered';
            } else if (urlParams.get('error') === 'failed') {
            const message = urlParams.get('message');
            errorMessage.style.display = 'block';
            errorMessage.textContent = 'Registration failed: ' + (message || 'Please try again');
            }
        };
        </script>
    </body>
</html>