package com.hospital.servlet;

import com.hospital.dao.HospitalDAO;


import com.hospital.model.Patient;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;  // Add this import
import java.util.List;
import javax.servlet.annotation.WebServlet;


@WebServlet("/DisplayPatientsServlet")
public class DisplayPatientsServlet extends HttpServlet {
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


            RequestDispatcher dispatcher = request.getRequestDispatcher("patientdisplay.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error while fetching patients", e);
        }
    }
}
