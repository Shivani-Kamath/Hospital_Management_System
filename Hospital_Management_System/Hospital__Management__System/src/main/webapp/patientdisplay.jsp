<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Patient" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Patient Records</title>
    <style>
        :root {
          --primary-color: #6A9FB5;
          --accent-color: #0f4c75;
          --header-bg: #0f4c75;
          --text-light: #f0f4f8;
          --text-dark: #2C3E50;
          --success-bg: #EAF4FB;
          --success-text: #4F7C8A;
          --card-bg: #ffffff;
          --card-shadow: rgba(100, 149, 237, 0.15);
          --footer-bg: #E3F2F9;
          --footer-text: #2C3E50;
          --sky-blue: #3498db;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, var(--success-bg), var(--footer-bg));
            color: var(--text-dark);
            margin: 0;
            padding: 40px 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--header-bg);
            font-weight: 700;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 12px 25px var(--card-shadow);
            padding: 30px 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 18px var(--card-shadow);
        }

        th, td {
            padding: 14px 20px;
            text-align: center;
            border-bottom: 1px solid #e1e8f0;
            font-size: 15px;
            color: var(--accent-color);
        }

        th {
            background-color: var(--header-bg);
            color: var(--text-light);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        tr:hover {
            background-color: var(--success-bg);
            transition: background-color 0.3s ease;
        }

        p.no-data {
            text-align: center;
            color: #e74c3c;
            font-weight: 600;
            font-size: 18px;
        }

        /* Back to Home button styling */
        .back-home-btn {
            margin: 30px auto 0 auto;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            border-radius: 8px;
            background-color: var(--card-bg);
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
            text-align: center;
        }
        .back-home-btn:hover {
            background-color: var(--primary-color);
            color: var(--text-light);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
                width: 95%;
            }

            th, td {
                padding: 10px 8px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Patient Records</h1>

    <%
        List<Patient> patientList = (List<Patient>) request.getAttribute("patientList");
        if (patientList == null || patientList.isEmpty()) {
    %>
        <p class="no-data">No patients found.</p>
    <%
        } else {
    %>
        <table>
            <thead>
            <tr>
                <th>Patient ID</th>
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
                for (Patient patient : patientList) {
            %>
            <tr>
                <td><%= patient.getPatientID() %></td>
                <td><%= patient.getPatientName() %></td>
                <td><%= patient.getAge() %></td>
                <td><%= patient.getGender() %></td>
                <td><%= patient.getAdmissionDate() %></td>
                <td><%= patient.getAilment() %></td>
                <td><%= patient.getAssignedDoctor() %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    <%
        }
    %>
</div>

<!-- Back to Home button -->
<a href="${pageContext.request.contextPath}/index.jsp" class="back-home-btn">&#8592; Back to Home</a>

</body>
</html>
