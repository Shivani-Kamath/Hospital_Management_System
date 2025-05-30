package com.hospital.servlet;

import com.hospital.dao.HospitalDAO;
import com.hospital.model.Patient;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/UpdatePatientServlet")
public class UpdatePatientServlet extends HttpServlet {

    private HospitalDAO hospitalDAO;

    @Override
    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Patient> patientList = hospitalDAO.getAllPatients();
            request.setAttribute("patientList", patientList);

            String idParam = request.getParameter("patientID");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int patientID = Integer.parseInt(idParam);
                    Patient patientToUpdate = hospitalDAO.getPatientById(patientID);
                    request.setAttribute("patientToUpdate", patientToUpdate);
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid patient ID format.");
                }
            }

            request.getRequestDispatcher("patientupdate.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int patientID = Integer.parseInt(request.getParameter("patientID"));
            String patientName = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String admissionDate = request.getParameter("admissionDate");
            String ailment = request.getParameter("ailment");
            String assignedDoctor = request.getParameter("assignedDoctor");

            Patient patient = new Patient();
            patient.setPatientID(patientID);
            patient.setPatientName(patientName);
            patient.setAge(age);
            patient.setGender(gender);
            patient.setAdmissionDate(admissionDate);
            patient.setAilment(ailment);
            patient.setAssignedDoctor(assignedDoctor);

            hospitalDAO.updatePatient(patient);

            response.sendRedirect("UpdatePatientServlet?updateSuccess=true");


        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input format: " + e.getMessage());
            request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating patient: " + e.getMessage());
            request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
        }
    }
}
