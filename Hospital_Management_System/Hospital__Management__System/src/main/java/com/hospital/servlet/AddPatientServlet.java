package com.hospital.servlet;

import com.hospital.dao.HospitalDAO;
import com.hospital.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {

    private HospitalDAO hospitalDAO;

    @Override
    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String patientName = request.getParameter("PatientName");
        String ageParam = request.getParameter("Age");
        String gender = request.getParameter("Gender");
        String admissionDate = request.getParameter("AdmissionDate");
        String ailment = request.getParameter("Ailment");
        String assignedDoctor = request.getParameter("AssignedDoctor");

        if (patientName == null || patientName.trim().isEmpty() ||
            ageParam == null || ageParam.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty()) {

            String error = "Patient name, age, and gender are required.";
            response.sendRedirect("patientadd.jsp?error=" + java.net.URLEncoder.encode(error, "UTF-8"));
            return;
        }

        int age;
        try {
            age = Integer.parseInt(ageParam.trim());
        } catch (NumberFormatException e) {
            String error = "Invalid age: must be a number.";
            response.sendRedirect("patientadd.jsp?error=" + java.net.URLEncoder.encode(error, "UTF-8"));
            return;
        }

        Patient patient = new Patient(
            patientName.trim(), age, gender.trim(),
            admissionDate != null ? admissionDate.trim() : "",
            ailment != null ? ailment.trim() : "",
            assignedDoctor != null ? assignedDoctor.trim() : ""
        );

        try {
            hospitalDAO.insertPatient(patient);
            String successMessage = "Patient added successfully!";
            response.sendRedirect("patientadd.jsp?msg=" + java.net.URLEncoder.encode(successMessage, "UTF-8"));
        } catch (SQLException e) {
            e.printStackTrace();
            String error = "Error while inserting patient.";
            response.sendRedirect("patientadd.jsp?error=" + java.net.URLEncoder.encode(error, "UTF-8"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported");
    }
}
