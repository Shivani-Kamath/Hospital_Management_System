<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Patient" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<Patient> patientList = (List<Patient>) request.getAttribute("patientList");
    Patient patientToUpdate = (Patient) request.getAttribute("patientToUpdate");
    String updateSuccess = request.getParameter("updateSuccess");
    String addSuccess = request.getParameter("addSuccess");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Professional Medical Color Palette - Same as add patient form */
            --primary-color: #0f4c75;
            --primary-light: #3282b8;
            --primary-dark: #0b3954;
            --secondary-color: #e8f4f8;
            --accent-color: #00a8cc;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            
            /* Neutral Colors */
            --white: #ffffff;
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            
            /* Text Colors */
            --text-primary: #1e293b;
            --text-secondary: #475569;
            --text-light: #64748b;
            --text-muted: #94a3b8;
            
            /* Background */
            --bg-primary: #f8fafc;
            --bg-secondary: #ffffff;
            --bg-accent: #e8f4f8;
            
            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            
            /* Glass Effect */
            --glass-bg: rgba(255, 255, 255, 0.9);
            --glass-border: rgba(255, 255, 255, 0.18);
            
            /* Border Radius */
            --radius-sm: 6px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            
            /* Transitions */
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-fast: all 0.15s ease-out;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
            font-size: 14px;
            padding: 40px 24px;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Subtle background pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 25% 25%, rgba(15, 76, 117, 0.04) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(0, 168, 204, 0.03) 0%, transparent 50%);
            z-index: -1;
            pointer-events: none;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            background: var(--white);
            padding: 32px 0;
            box-shadow: var(--shadow-sm);
            border-bottom: 1px solid var(--gray-200);
            margin: -40px -24px 48px -24px;
        }

        .header-content {
            display: flex;
            align-items: center;
            gap: 20px;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
        }

        .header-logo {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--white);
            box-shadow: var(--shadow-md);
        }

        .header-text h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 4px;
        }

        .header-text p {
            font-size: 15px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        h2 {
            font-family: 'Poppins', sans-serif;
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 32px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            box-shadow: var(--shadow-lg);
            background: var(--white);
            border-radius: var(--radius-xl);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            animation: fadeInUp 0.6s ease-out 0.2s both;
            margin-bottom: 48px;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        thead th {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: var(--white);
            padding: 18px 20px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            text-align: left;
            font-size: 13px;
            position: relative;
        }

        thead th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        }

        tbody tr {
            background: var(--white);
            transition: var(--transition);
            border-bottom: 1px solid var(--gray-200);
        }

        tbody tr:hover {
            background-color: var(--bg-accent);
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        tbody td {
            padding: 18px 20px;
            vertical-align: middle;
            color: var(--text-primary);
            font-size: 15px;
        }

        tbody td:first-child {
            font-weight: 600;
            color: var(--primary-color);
        }

        .button {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: var(--white);
            border: none;
            padding: 10px 18px;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
            box-shadow: var(--shadow-md);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
        }

        .button:active {
            transform: translateY(0);
        }

        form {
            background: var(--white);
            max-width: 640px;
            margin: 48px auto;
            padding: 48px 50px;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--gray-200);
            animation: fadeInUp 0.6s ease-out;
        }

        label {
            display: block;
            margin: 20px 0 8px;
            font-weight: 600;
            color: var(--text-primary);
            font-size: 15px;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        select {
            width: 100%;
            padding: 14px 16px;
            font-size: 15px;
            border-radius: var(--radius-md);
            border: 1px solid var(--gray-300);
            transition: var(--transition);
            background: var(--white);
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(50, 130, 184, 0.1);
        }

        input[type="submit"] {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: var(--white);
            border: none;
            padding: 16px 24px;
            border-radius: var(--radius-md);
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            margin-top: 32px;
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
            box-shadow: var(--shadow-md);
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
        }

        input[type="submit"]:active {
            transform: translateY(0);
        }

        .message-box {
            background: linear-gradient(135deg, rgba(40, 167, 69, 0.1), rgba(40, 167, 69, 0.05));
            border: 1px solid rgba(40, 167, 69, 0.2);
            color: var(--success-color);
            padding: 16px 20px;
            border-radius: var(--radius-md);
            margin: 24px auto;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            animation: slideInDown 0.4s ease-out;
            max-width: 640px;
        }

        .message-box::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 18px;
        }

        @keyframes slideInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .back-home {
            margin-top: 32px;
            text-align: center;
        }

        .back-home a {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            border-radius: var(--radius-md);
            border: 1px solid var(--gray-200);
            background: var(--white);
        }

        .back-home a:hover {
            color: var(--accent-color);
            background: var(--bg-accent);
            border-color: var(--primary-light);
            transform: translateY(-1px);
        }

        /* Footer */
        .footer {
            background: var(--white);
            text-align: center;
            padding: 32px 0;
            margin-top: 64px;
            border-top: 1px solid var(--gray-200);
            color: var(--text-secondary);
        }

        .footer p {
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 20px 16px;
            }

            .header {
                margin: -20px -16px 32px -16px;
                padding: 24px 0;
            }

            .header-content {
                flex-direction: column;
                text-align: center;
                gap: 16px;
                padding: 0 16px;
            }

            .header-text h1 {
                font-size: 24px;
            }

            h2 {
                font-size: 28px;
            }

            table, thead th, tbody td {
                font-size: 13px;
                padding: 12px 14px;
            }

            form {
                margin: 32px auto;
                padding: 32px 24px;
            }
        }

        @media (max-width: 480px) {
            table {
                font-size: 12px;
            }
            
            thead th, tbody td {
                padding: 10px 8px;
            }
            
            .header-text h1 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="header-logo">
                <div class="header-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="header-text">
                    <h1>Patient List</h1>
                    <p>Manage and update patient records</p>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <table>
            <thead>
                <tr>
                    <th> ID</th>
                    <th> Name</th>
                    <th></i> Age</th>
                    <th> Gender</th>
                    <th> Admission Date</th>
                    <th> Ailment</th>
                    <th> Assigned Doctor</th>
                    <th> Action</th>
                </tr>
            </thead>
            <tbody>
            <% if (patientList != null && !patientList.isEmpty()) {
                for (Patient p : patientList) { %>
                <tr>
                    <td><%= p.getPatientID() %></td>
                    <td><%= p.getPatientName() %></td>
                    <td><%= p.getAge() %></td>
                    <td><%= p.getGender() %></td>
                    <td><%= p.getAdmissionDate() %></td>
                    <td><%= p.getAilment() %></td>
                    <td><%= p.getAssignedDoctor() %></td>
                    <td>
                        <a class="button" href="UpdatePatientServlet?patientID=<%= p.getPatientID() %>#updateForm">
                            <i class="fas fa-edit"></i> Update
                        </a>
                    </td>
                </tr>
            <% } 
            } else { %>
                <tr><td colspan="8" style="text-align:center; padding: 30px; color: var(--text-muted);">
                    <i class="fas fa-users" style="font-size: 24px; margin-bottom: 8px; display: block;"></i>
                    No patients found.
                </td></tr>
            <% } %>
            </tbody>
        </table>

        <% if (patientToUpdate != null) { %>
            <a id="updateForm"></a>
            <form action="UpdatePatientServlet" method="post">
                <div style="text-align: center; margin-bottom: 40px;">
                    <h2>Update Patient Details</h2>
                    <p style="color: var(--text-secondary); font-size: 16px;">Modify patient information below</p>
                </div>

                <input type="hidden" name="patientID" value="<%= patientToUpdate.getPatientID() %>" />

                <label for="patientName">Patient Name:</label>
                <input type="text" id="patientName" name="patientName" value="<%= patientToUpdate.getPatientName() %>" required placeholder="Enter patient's full name" />

                <label for="age">Age:</label>
                <input type="number" id="age" name="age" value="<%= patientToUpdate.getAge() %>" min="0" max="120" required placeholder="Enter age in years" />

                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="" disabled>Select gender</option>
                    <option value="Male" <%= "Male".equals(patientToUpdate.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(patientToUpdate.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(patientToUpdate.getGender()) ? "selected" : "" %>>Other</option>
                </select>

                <label for="admissionDate">Admission Date:</label>
                <input type="date" id="admissionDate" name="admissionDate" value="<%= patientToUpdate.getAdmissionDate() %>" required />

                <label for="ailment">Ailment:</label>
                <input type="text" id="ailment" name="ailment" value="<%= patientToUpdate.getAilment() %>" required placeholder="Enter patient's ailment" />

                <label for="assignedDoctor">Assigned Doctor:</label>
                <input type="text" id="assignedDoctor" name="assignedDoctor" value="<%= patientToUpdate.getAssignedDoctor() %>" required placeholder="Enter doctor's name" />

                <input type="submit" value="Update Patient" />
            </form>
        <% } %>

        <% if ("true".equals(updateSuccess)) { %>
            <div class="message-box">Patient details updated successfully!</div>
        <% } %>

        <% if ("true".equals(addSuccess)) { %>
            <div class="message-box">Patient added successfully!</div>
        <% } %>

        <div class="back-home">
            <a href="index.jsp">
                <i class="fas fa-arrow-left"></i>
                Back to Home
            </a>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Hospital Management System | Developed by Shivani Kamath</p>
        </div>
    </footer>

    <script>
        // Add form validation and enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const submitButton = this.querySelector('input[type="submit"]');
                    submitButton.style.background = 'linear-gradient(135deg, var(--accent-color), var(--primary-light))';
                    submitButton.value = 'Updating Patient...';
                    submitButton.disabled = true;
                });
            }
        });
    </script>
</body>
</html>