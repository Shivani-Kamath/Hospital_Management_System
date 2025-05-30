# 🏥 Hospital Management System

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

🎯 Project Purpose  
To provide a seamless platform for managing patient information through features including:

- Adding new patient records  
- Updating existing patient details  
- Deleting patient records  
- Viewing patient information  
- Generating detailed reports based on admission date, ailments, and assigned doctors

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

🗄️ Database Structure

```sql
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    AdmissionDate DATE,
    Ailment VARCHAR(255),
    AssignedDoctor VARCHAR(100)
);


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

📂 Project Structure

HospitalWebApp/
├── WebContent/
│   ├── index.jsp
│   ├── patientadd.jsp
│   ├── patientupdate.jsp
│   ├── patientdelete.jsp
│   ├── patientdisplay.jsp
│   ├── reports.jsp
│   ├── report_form.jsp
│   └── report_result.jsp
├── src/
│   ├── com/
│       ├── dao/
│       │   └── HospitalDAO.java
│       ├── model/
│       │   └── Patient.java
│       └── servlet/
│           ├── AddPatientServlet.java
│           ├── UpdatePatientServlet.java
│           ├── DeletePatientServlet.java
│           ├── DisplayPatientsServlet.java
│           ├── ReportServlet.java
│           └── ReportCriteriaServlet.java
└── WEB-INF/
    └── web.xml

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

🚀 Setup Instructions

🛢️ Database Setup
Create a database named hospital_db.

Execute the SQL script to create the Patients table inside the hospital_db database.

⚙️ Configure Database Connection
Open HospitalDAO.java.

Update the connection parameters to match your database credentials:

private String jdbcURL = "jdbc:mysql://localhost:3306/hospital_db";
private String jdbcUsername = "root";          
private String jdbcPassword = ""; 

🧩 Running the Application
Import the project into your IDE (Eclipse).

Configure Apache Tomcat or your preferred servlet container.

Deploy the project to the server.


