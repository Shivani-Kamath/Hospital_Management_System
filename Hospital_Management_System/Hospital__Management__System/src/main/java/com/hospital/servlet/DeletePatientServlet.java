package com.hospital.servlet;

import com.hospital.dao.HospitalDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {

    private HospitalDAO hospitalDAO;

    @Override
    public void init() {
        hospitalDAO = new HospitalDAO(); // Initialize DAO on servlet startup
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String patientIdStr = request.getParameter("PatientID");
        String patientName = request.getParameter("PatientName");

        HttpSession session = request.getSession();

        // Check if both inputs are empty
        if ((patientIdStr == null || patientIdStr.trim().isEmpty()) &&
            (patientName == null || patientName.trim().isEmpty())) {
            session.setAttribute("error", "Please provide either Patient ID or Patient Name to delete.");
            response.sendRedirect("patientdelete.jsp");
            return;
        }

        try {
            boolean deleted = false;

            if (patientIdStr != null && !patientIdStr.trim().isEmpty()) {
                // Try deleting by ID
                try {
                    int patientID = Integer.parseInt(patientIdStr.trim());
                    deleted = hospitalDAO.deletePatient(patientID);

                    if (deleted) {
                        session.setAttribute("message", "Patient deleted successfully with ID: " + patientID);
                    } else {
                        session.setAttribute("error", "No patient found with ID: " + patientID);
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("error", "Invalid Patient ID format.");
                }

            } else if (patientName != null && !patientName.trim().isEmpty()) {
                // Delete by Name
                int deletedCount = hospitalDAO.deletePatientByName(patientName.trim());

                if (deletedCount > 0) {
                    session.setAttribute("message", "Deleted " + deletedCount + " patient(s) with name: " + patientName);
                } else {
                    session.setAttribute("error", "No patient found with name: " + patientName);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log for server-side debugging
            throw new ServletException("Database error occurred while deleting patient.", e);
        }

        // Redirect back to the form page
        response.sendRedirect("patientdelete.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Prevent deletion via GET method
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported for deletion.");
    }
}
