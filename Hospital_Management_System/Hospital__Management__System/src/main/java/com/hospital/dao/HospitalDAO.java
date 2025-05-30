package com.hospital.dao;

import com.hospital.model.Patient;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HospitalDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/hospital_db"; 
    private String jdbcUsername = "root"; 
    private String jdbcPassword = ""; 

    private static final String INSERT_PATIENT_SQL = "INSERT INTO patients "
            + "(PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?)";

    private static final String UPDATE_PATIENT_SQL = "UPDATE patients SET "
            + "PatientName = ?, Age = ?, Gender = ?, AdmissionDate = ?, Ailment = ?, AssignedDoctor = ? "
            + "WHERE PatientID = ?";

    private static final String DELETE_PATIENT_SQL = "DELETE FROM patients WHERE PatientID = ?";

    private static final String SELECT_ALL_PATIENTS_SQL = "SELECT * FROM patients";

    private static final String SELECT_PATIENT_BY_ID_SQL = "SELECT * FROM patients WHERE PatientID = ?";

    public HospitalDAO() {}

    protected Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            System.out.println("Database connection established.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException(e);
        }
        return connection;
    }

    public void insertPatient(Patient patient) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PATIENT_SQL)) {

            preparedStatement.setString(1, patient.getPatientName());
            preparedStatement.setInt(2, patient.getAge());
            preparedStatement.setString(3, patient.getGender());

            java.sql.Date admissionDate = null;
            if (patient.getAdmissionDate() != null && !patient.getAdmissionDate().isEmpty()) {
                admissionDate = java.sql.Date.valueOf(patient.getAdmissionDate());
            }
            preparedStatement.setDate(4, admissionDate);

            preparedStatement.setString(5, patient.getAilment());
            preparedStatement.setString(6, patient.getAssignedDoctor());

            int rowsInserted = preparedStatement.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);

        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }

    public void updatePatient(Patient patient) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PATIENT_SQL)) {

            preparedStatement.setString(1, patient.getPatientName());
            preparedStatement.setInt(2, patient.getAge());
            preparedStatement.setString(3, patient.getGender());

            java.sql.Date admissionDate = null;
            if (patient.getAdmissionDate() != null && !patient.getAdmissionDate().isEmpty()) {
                admissionDate = java.sql.Date.valueOf(patient.getAdmissionDate());
            }
            preparedStatement.setDate(4, admissionDate);

            preparedStatement.setString(5, patient.getAilment());
            preparedStatement.setString(6, patient.getAssignedDoctor());

            preparedStatement.setInt(7, patient.getPatientID());

            int rowsUpdated = preparedStatement.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);

        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }


    public int deletePatientByName(String patientName) throws SQLException {
        String sql = "DELETE FROM patients WHERE PatientName = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, patientName);

            int rowsDeleted = preparedStatement.executeUpdate();
            System.out.println("Rows deleted by name: " + rowsDeleted);
            return rowsDeleted;
        }
    }

    public boolean deletePatient(int patientId) throws SQLException {
        String sql = "DELETE FROM patients WHERE PatientID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, patientId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public boolean patientExists(int patientId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM patients WHERE PatientID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, patientId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public boolean patientExistsByName(String patientName) throws SQLException {
        String sql = "SELECT COUNT(*) FROM patients WHERE PatientName = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, patientName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }




    public List<Patient> getAllPatients() throws SQLException {
        List<Patient> patients = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PATIENTS_SQL);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("PatientID");
                String name = rs.getString("PatientName");
                int age = rs.getInt("Age");
                String gender = rs.getString("Gender");
                Date admissionDateObj = rs.getDate("AdmissionDate");
                String admissionDate = admissionDateObj != null ? admissionDateObj.toString() : null;
                String ailment = rs.getString("Ailment");
                String assignedDoctor = rs.getString("AssignedDoctor");

                Patient patient = new Patient(id, name, age, gender, admissionDate, ailment, assignedDoctor);
                patients.add(patient);
            }
        }
        return patients;
    }

    /**
     * Updated getPatientsByCriteria with partial matching on assignedDoctor and ailment.
     */
    public List<Patient> getPatientsByCriteria(String fromDate, String toDate, String assignedDoctor, String ailment) throws SQLException {
        List<Patient> patients = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM patients WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql.append(" AND AdmissionDate >= ?");
            parameters.add(java.sql.Date.valueOf(fromDate));
        }
        if (toDate != null && !toDate.trim().isEmpty()) {
            sql.append(" AND AdmissionDate <= ?");
            parameters.add(java.sql.Date.valueOf(toDate));
        }
        if (assignedDoctor != null && !assignedDoctor.trim().isEmpty()) {
            sql.append(" AND AssignedDoctor LIKE ?");
            parameters.add("%" + assignedDoctor + "%");  // Partial match
        }
        if (ailment != null && !ailment.trim().isEmpty()) {
            sql.append(" AND Ailment LIKE ?");
            parameters.add("%" + ailment + "%");  // Partial match
        }

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                preparedStatement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("PatientID");
                    String name = rs.getString("PatientName");
                    int age = rs.getInt("Age");
                    String gender = rs.getString("Gender");
                    Date admissionDateObj = rs.getDate("AdmissionDate");
                    String admissionDate = admissionDateObj != null ? admissionDateObj.toString() : null;
                    String patientAilment = rs.getString("Ailment");
                    String doctor = rs.getString("AssignedDoctor");

                    Patient patient = new Patient(id, name, age, gender, admissionDate, patientAilment, doctor);
                    patients.add(patient);
                }
            }
        }
        return patients;
    }

    public Patient getPatientById(int patientID) throws SQLException {
        Patient patient = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PATIENT_BY_ID_SQL)) {

            preparedStatement.setInt(1, patientID);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("PatientName");
                    int age = rs.getInt("Age");
                    String gender = rs.getString("Gender");
                    Date admissionDateObj = rs.getDate("AdmissionDate");
                    String admissionDate = admissionDateObj != null ? admissionDateObj.toString() : null;
                    String ailment = rs.getString("Ailment");
                    String assignedDoctor = rs.getString("AssignedDoctor");

                    patient = new Patient(patientID, name, age, gender, admissionDate, ailment, assignedDoctor);
                }
            }
        }
        return patient;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
