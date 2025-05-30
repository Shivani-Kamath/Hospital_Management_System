<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Patient</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        /* Professional Medical Color Palette - Same as index.jsp */
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
        padding: 0 24px;
    }

    /* Header */
    .header {
        background: var(--white);
        padding: 32px 0;
        box-shadow: var(--shadow-sm);
        border-bottom: 1px solid var(--gray-200);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .header-content {
        display: flex;
        align-items: center;
        gap: 20px;
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

    /* Form Container */
    .form-container {
        background: var(--white);
        max-width: 640px;
        margin: 48px auto;
        padding: 48px 50px;
        border-radius: var(--radius-xl);
        box-shadow: var(--shadow-lg);
        border: 1px solid var(--gray-200);
        animation: fadeInUp 0.6s ease-out;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .form-header {
        text-align: center;
        margin-bottom: 40px;
    }

    .form-header h2 {
        font-family: 'Poppins', sans-serif;
        font-size: 32px;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 12px;
    }

    .form-header p {
        font-size: 16px;
        color: var(--text-secondary);
    }

    /* Success Message */
    .success-message {
        background: linear-gradient(135deg, rgba(40, 167, 69, 0.1), rgba(40, 167, 69, 0.05));
        border: 1px solid rgba(40, 167, 69, 0.2);
        color: var(--success-color);
        padding: 16px 20px;
        border-radius: var(--radius-md);
        margin-bottom: 24px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 12px;
        animation: slideInDown 0.4s ease-out;
    }

    .success-message i {
        font-size: 18px;
    }

    @keyframes slideInDown {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Form Elements */
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

    /* Back to Home */
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
        .container {
            padding: 0 16px;
        }

        .header {
            padding: 24px 0;
        }

        .header-content {
            flex-direction: column;
            text-align: center;
            gap: 16px;
        }

        .header-text h1 {
            font-size: 24px;
        }

        .form-container {
            margin: 32px auto;
            padding: 32px 24px;
        }

        .form-header h2 {
            font-size: 28px;
        }
    }

    /* Loading Animation */
    .loading {
        opacity: 0;
        animation: fadeIn 0.8s ease-out 0.3s forwards;
    }

    @keyframes fadeIn {
        to { opacity: 1; }
    }
</style>
</head>
<body class="loading">
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="header-logo">
                    <div class="header-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="header-text">
                        <h1>Add New Patient</h1>
                        <p>Register new patients in the system</p>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="form-container">
        <div class="form-header">
            <h2>Patient Information</h2>
            <p>Enter comprehensive patient details for registration</p>
        </div>

        <%
        String msg = request.getParameter("msg");
        if (msg != null && !msg.trim().isEmpty()) {
        %>
        <div class="success-message">
            <i class="fas fa-check-circle"></i>
            <span><%= msg %></span>
        </div>
        <%
        }
        %>

        <form action="<%= request.getContextPath() %>/AddPatientServlet" method="post">
            <label for="PatientName">Patient Name:</label>
            <input type="text" name="PatientName" id="PatientName" required placeholder="Enter patient's full name">

            <label for="Age">Age:</label>
            <input type="number" name="Age" id="Age" required min="0" max="120" placeholder="Enter age in years">

            <label for="Gender">Gender:</label>
            <select name="Gender" id="Gender" required>
                <option value="" disabled selected>Select gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <label for="AdmissionDate">Admission Date:</label>
            <input type="date" name="AdmissionDate" id="AdmissionDate" required max="<%= LocalDate.now() %>">

            <label for="Ailment">Ailment:</label>
            <input type="text" name="Ailment" id="Ailment" required placeholder="Enter patient's ailment">

            <label for="AssignedDoctor">Assigned Doctor:</label>
            <input type="text" name="AssignedDoctor" id="AssignedDoctor" required placeholder="Enter doctor's name">

            <input type="submit" value="Add Patient">
        </form>

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
        // Add loading animation
        window.addEventListener('load', () => {
            document.body.classList.remove('loading');
        });

        // Add form validation and enhancement
        document.querySelector('form').addEventListener('submit', function(e) {
            const submitButton = this.querySelector('input[type="submit"]');
            submitButton.style.background = 'linear-gradient(135deg, var(--accent-color), var(--primary-light))';
            submitButton.value = 'Adding Patient...';
            submitButton.disabled = true;
        });
    </script>
</body>
</html>