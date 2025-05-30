<%@ page import="java.util.List, com.hospital.model.Patient, java.text.SimpleDateFormat" %>
<%
    List<Patient> patients = (List<Patient>) request.getAttribute("filteredPatients");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 8px 12px;
            text-align: left;
        }
        th {
            background-color: #f0f0f0;
        }
        caption {
            caption-side: top;
            font-weight: bold;
            margin-bottom: 8px;
            font-size: 1.2em;
        }
        .btn-container {
            margin-bottom: 20px;
        }
        .btn-container form {
            display: inline-block;
            margin-right: 10px;
        }
        button {
            padding: 8px 16px;
            font-size: 1em;
            cursor: pointer;
        }
        a.back-link {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #0066cc;
        }
        a.back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Patient Report Results</h2>

<% if (patients != null && !patients.isEmpty()) { %>

    <div class="btn-container">
        <!-- Download CSV form -->
        <form method="post" action="<%= request.getContextPath() %>/ReportCriteriaServlet">
            <%-- Keep the filter parameters as hidden fields so they are passed again --%>
            <input type="hidden" name="fromDate" value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">
            <input type="hidden" name="toDate" value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">
            <input type="hidden" name="assignedDoctor" value="<%= request.getParameter("assignedDoctor") != null ? request.getParameter("assignedDoctor") : "" %>">
            <input type="hidden" name="ailment" value="<%= request.getParameter("ailment") != null ? request.getParameter("ailment") : "" %>">
            <input type="hidden" name="action" value="downloadCsv">
            <button type="submit">Download CSV</button>
        </form>

        <!-- Download PDF form -->
        <form method="post" action="<%= request.getContextPath() %>/ReportCriteriaServlet">
            <input type="hidden" name="fromDate" value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">
            <input type="hidden" name="toDate" value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">
            <input type="hidden" name="assignedDoctor" value="<%= request.getParameter("assignedDoctor") != null ? request.getParameter("assignedDoctor") : "" %>">
            <input type="hidden" name="ailment" value="<%= request.getParameter("ailment") != null ? request.getParameter("ailment") : "" %>">
            <input type="hidden" name="action" value="downloadPdf">
            <button type="submit">Download PDF</button>
        </form>
    </div>

    <table id="patientTable" aria-describedby="caption">
        <caption>List of Patients Matching Criteria</caption>
        <thead>
            <tr>
                <th scope="col">Patient ID</th>
                <th scope="col">Name</th>
                <th scope="col">Age</th>
                <th scope="col">Gender</th>
                <th scope="col">Admission Date</th>
                <th scope="col">Ailment</th>
                <th scope="col">Assigned Doctor</th>
            </tr>
        </thead>
        <tbody>
            <% for (Patient p : patients) { %>
                <tr>
                    <td><%= p.getPatientID() %></td>
                    <td><%= p.getPatientName() != null ? p.getPatientName() : "N/A" %></td>
                    <td><%= p.getAge() %></td>
                    <td><%= p.getGender() != null ? p.getGender() : "N/A" %></td>
                    <td><%= p.getAdmissionDate() != null ? sdf.format(p.getAdmissionDate()) : "N/A" %></td>
                    <td><%= p.getAilment() != null ? p.getAilment() : "N/A" %></td>
                    <td><%= p.getAssignedDoctor() != null ? p.getAssignedDoctor() : "N/A" %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

<% } else { %>
    <p>No patient records found.</p>
<% } %>

<a href="<%= request.getContextPath() %>/report_form.jsp" class="back-link">← Back to Report Form</a>

</body>
</html>
