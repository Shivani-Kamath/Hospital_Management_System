<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delete Patient</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        /* Professional Medical Color Palette - Same as addPatient.jsp */
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

    /* Message Styles */
    .success-message, .error-message, .info-message {
        padding: 16px 20px;
        border-radius: var(--radius-md);
        margin-bottom: 24px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 12px;
        animation: slideInDown 0.4s ease-out;
    }

    .success-message {
        background: linear-gradient(135deg, rgba(40, 167, 69, 0.1), rgba(40, 167, 69, 0.05));
        border: 1px solid rgba(40, 167, 69, 0.2);
        color: var(--success-color);
    }

    .error-message {
        background: linear-gradient(135deg, rgba(50, 130, 184, 0.1), rgba(50, 130, 184, 0.05));
        border: 1px solid rgba(50, 130, 184, 0.2);
        color: var(--primary-color);
    }

    .info-message {
        background: linear-gradient(135deg, rgba(23, 162, 184, 0.1), rgba(23, 162, 184, 0.05));
        border: 1px solid rgba(23, 162, 184, 0.2);
        color: var(--info-color);
    }

    .success-message i, .error-message i, .info-message i {
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

    input[type="text"] {
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

    input:focus {
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

    /* Info Text */
    .info-text {
        background: var(--bg-accent);
        padding: 16px 20px;
        border-radius: var(--radius-md);
        margin-top: 24px;
        text-align: center;
        color: var(--text-secondary);
        font-size: 14px;
        border: 1px solid rgba(50, 130, 184, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .info-text i {
        color: var(--info-color);
        font-size: 16px;
    }

    /* OR Divider */
    .or-divider {
        position: relative;
        text-align: center;
        margin: 24px 0;
        color: var(--text-muted);
        font-size: 14px;
        font-weight: 500;
    }

    .or-divider::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 0;
        right: 0;
        height: 1px;
        background: var(--gray-200);
        z-index: 1;
    }

    .or-divider span {
        background: var(--white);
        padding: 0 16px;
        position: relative;
        z-index: 2;
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

<script>
    function validateForm() {
        const patientID = document.getElementById('PatientID').value.trim();
        const patientName = document.getElementById('PatientName').value.trim();

        if (!patientID && !patientName) {
            // Create a custom styled alert using the theme colors
            showCustomAlert('Please enter either Patient ID or Patient Name to delete a record.');
            return false;
        }
        return true;
    }

    function showCustomAlert(message) {
        // Create temporary alert div
        const alertDiv = document.createElement('div');
        alertDiv.className = 'info-message';
        alertDiv.style.position = 'fixed';
        alertDiv.style.top = '20px';
        alertDiv.style.left = '50%';
        alertDiv.style.transform = 'translateX(-50%)';
        alertDiv.style.zIndex = '1000';
        alertDiv.style.maxWidth = '400px';
        alertDiv.innerHTML = `<i class="fas fa-info-circle"></i><span>${message}</span>`;
        
        document.body.appendChild(alertDiv);
        
        // Remove after 3 seconds
        setTimeout(() => {
            alertDiv.remove();
        }, 3000);
    }
</script>
</head>

<body class="loading">
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="header-logo">
                    <div class="header-icon">
                        <i class="fas fa-user-minus"></i>
                    </div>
                    <div class="header-text">
                        <h1>Delete Patient</h1>
                        <p>Remove patient records from the system</p>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="form-container">
        <div class="form-header">
            <h2>Patient Removal</h2>
            <p>Enter patient details to remove from database</p>
        </div>

        <%
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        if (message != null) {
        %>
        <div class="success-message">
            <i class="fas fa-check-circle"></i>
            <span><%= message %></span>
        </div>
        <%
            session.removeAttribute("message");
        }
        if (error != null) {
        %>
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            <span><%= error %></span>
        </div>
        <%
            session.removeAttribute("error");
        }
        %>

        <form action="${pageContext.request.contextPath}/DeletePatientServlet" method="post" onsubmit="return validateForm()">
            <label for="PatientID">Patient ID:</label>
            <input type="text" name="PatientID" id="PatientID" placeholder="Enter Patient ID" autocomplete="off">

            <div class="or-divider">
                <span>OR</span>
            </div>

            <label for="PatientName">Patient Name:</label>
            <input type="text" name="PatientName" id="PatientName" placeholder="Enter Patient Name" autocomplete="off">

            <input type="submit" value="Delete Patient">
        </form>

        <div class="info-text">
            <i class="fas fa-info-circle"></i>
            <span>Please enter either Patient ID or Patient Name to delete a record</span>
        </div>

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
            if (validateForm()) {
                submitButton.style.background = 'linear-gradient(135deg, var(--accent-color), var(--primary-light))';
                submitButton.value = 'Deleting Patient...';
                submitButton.disabled = true;
            }
        });
    </script>
</body>
</html>