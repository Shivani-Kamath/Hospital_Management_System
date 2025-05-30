<%@ page import="java.util.List, com.hospital.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Filtered Patient Records</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
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
        margin: 0;
        padding: 40px 10px;
        display: flex;
        justify-content: center;
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

    h2 {
        text-align: center;
        color: var(--primary-color);
        font-family: 'Poppins', sans-serif;
        font-weight: 700;
        font-size: 2.2rem;
        margin-bottom: 30px;
        letter-spacing: 1px;
    }

    table {
        width: 100%;
        max-width: 900px;
        margin: 0 auto 40px auto;
        border-collapse: separate;
        border-spacing: 0;
        box-shadow: var(--shadow-lg);
        background: var(--white);
        border-radius: var(--radius-xl);
        overflow: hidden;
        border: 1px solid var(--gray-200);
    }

    thead th {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        color: var(--white);
        padding: 16px 18px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        text-align: left;
        font-size: 13px;
    }

    tbody tr {
        background: var(--white);
        transition: var(--transition);
        border-bottom: 1px solid var(--gray-200);
    }

    tbody tr:hover {
        background-color: var(--bg-accent);
        transform: translateY(-1px);
    }

    tbody tr:last-child {
        border-bottom: none;
    }

    tbody td {
        padding: 16px 18px;
        vertical-align: middle;
        color: var(--text-primary);
        font-size: 1rem;
    }

    tbody td:first-child {
        font-weight: 600;
        color: var(--primary-color);
    }

    p.no-data {
        max-width: 900px;
        margin: 0 auto 40px auto;
        font-style: italic;
        color: var(--text-light);
        font-size: 1.2rem;
        text-align: center;
        background: var(--white);
        padding: 60px 40px;
        border-radius: var(--radius-xl);
        box-shadow: var(--shadow-lg);
        border: 1px solid var(--gray-200);
    }

    .back-link {
        text-align: center;
        margin-bottom: 30px;
    }

    .back-link a,
    .back-link button {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        color: var(--white);
        border: none;
        padding: 16px 24px;
        border-radius: var(--radius-md);
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        margin: 0 10px;
        transition: var(--transition);
        font-family: 'Inter', sans-serif;
        box-shadow: var(--shadow-md);
        text-decoration: none;
        display: inline-block;
    }

    .back-link a:hover,
    .back-link button:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
        background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
    }

    .back-link a:active,
    .back-link button:active {
        transform: translateY(0);
    }

    @media (max-width: 600px) {
        table, thead th, tbody td {
            font-size: 0.9rem;
            padding: 10px 12px;
        }
        h2 {
            font-size: 1.7rem;
        }
        .back-link a, .back-link button {
            padding: 14px 20px;
            font-size: 15px;
            margin: 5px;
        }
    }
</style>



</head>
<body>

<div>
    <h2>Filtered Patient Records</h2>

    <%
        List<Patient> patients = (List<Patient>) request.getAttribute("patientList");
        if (patients != null && !patients.isEmpty()) {
    %>
    <div id="reportContent">
        <table id="patientTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Admission Date</th>
                <th>Ailment</th>
                <th>Assigned Doctor</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Patient p : patients) {
            %>
            <tr>
                <td><%= p.getPatientID() %></td>
                <td><%= p.getPatientName() %></td>
                <td><%= p.getAge() %></td>
                <td><%= p.getGender() %></td>
                <td><%= p.getAdmissionDate() != null ? p.getAdmissionDate() : "N/A" %></td>
                <td><%= p.getAilment() != null ? p.getAilment() : "N/A" %></td>
                <td><%= p.getAssignedDoctor() != null ? p.getAssignedDoctor() : "N/A" %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <%
        } else {
    %>
    <p class="no-data">No patients found matching the criteria.</p>
    <%
        }
    %>

    <div class="back-link">
        <a href="<%= request.getContextPath() %>/report_form.jsp">Back to Report Form</a>
        <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
        
        <button onclick="downloadPDF()">Download PDF</button>
    </div>
</div>

<script>
    async function downloadPDF() {
        const element = document.getElementById("reportContent");
        const canvas = await html2canvas(element);
        const imgData = canvas.toDataURL("image/png");

        const { jsPDF } = window.jspdf;
        const pdf = new jsPDF("p", "mm", "a4");

        const pageWidth = pdf.internal.pageSize.getWidth();
        const pageHeight = pdf.internal.pageSize.getHeight();
        const imgProps = pdf.getImageProperties(imgData);
	
        const ratio = imgProps.width / imgProps.height;
        const imgHeight = pageWidth / ratio;

        pdf.addImage(imgData, 'PNG', 10, 20, pageWidth - 20, imgHeight);
        pdf.save("Filtered_Patient_Records.pdf");
    }
</script>

</body>
</html>