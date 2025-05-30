	package com.hospital.servlet;
	
	import com.hospital.dao.HospitalDAO;
	import com.hospital.model.Patient;
	
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.*;
	import java.io.IOException;
	import java.sql.SQLException;
	import java.util.List;
	
	@WebServlet("/ReportServlet")
	public class ReportServlet extends HttpServlet {
	
	    private HospitalDAO hospitalDAO;
	
	    @Override
	    public void init() {
	        hospitalDAO = new HospitalDAO();
	    }
	
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        // Forward to filter form
	        request.getRequestDispatcher("report_form.jsp").forward(request, response);
	    }
	
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	
	        String fromDate = request.getParameter("fromDate");
	        String toDate = request.getParameter("toDate");
	        String assignedDoctor = request.getParameter("assignedDoctor");
	        String ailment = request.getParameter("ailment");
	
	        try {
	            List<Patient> patientList = hospitalDAO.getPatientsByCriteria(fromDate, toDate, assignedDoctor, ailment);
	            request.setAttribute("patientList", patientList);
	            request.getRequestDispatcher("report_result.jsp").forward(request, response);
	        } catch (SQLException e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "Error retrieving patient report data: " + e.getMessage());
	            request.getRequestDispatcher("error.jsp").forward(request, response);
	        }
	    }
	}
