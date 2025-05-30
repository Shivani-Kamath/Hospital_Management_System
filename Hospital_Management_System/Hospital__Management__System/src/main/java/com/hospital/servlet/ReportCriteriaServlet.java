package com.hospital.servlet;

import com.hospital.dao.HospitalDAO;
import com.hospital.model.Patient;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Stream;

@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {

    private HospitalDAO hospitalDAO;

    @Override
    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET to form page
        response.sendRedirect(request.getContextPath() + "/report_form.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String assignedDoctor = request.getParameter("assignedDoctor");
        String ailment = request.getParameter("ailment");
        String action = request.getParameter("action");

        try {
            List<Patient> filteredPatients = hospitalDAO.getPatientsByCriteria(fromDate, toDate, assignedDoctor, ailment);

            if ("downloadCsv".equalsIgnoreCase(action)) {
                // CSV download
                response.setContentType("text/csv");
                response.setHeader("Content-Disposition", "attachment; filename=\"patient_report.csv\"");

                String header = "Patient ID,Name,Age,Assigned Doctor,Ailment,Admission Date\n";
                response.getWriter().write(header);

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                for (Patient p : filteredPatients) {
                    String admissionDateStr = "";
                    if (p.getAdmissionDate() != null) {
                        admissionDateStr = sdf.format(p.getAdmissionDate());
                    }

                    String name = escapeCsv(p.getPatientName());
                    String doctor = escapeCsv(p.getAssignedDoctor());
                    String ailmentEscaped = escapeCsv(p.getAilment());

                    String row = String.format("%d,%s,%d,%s,%s,%s\n",
                            p.getPatientID(),
                            name,
                            p.getAge(),
                            doctor,
                            ailmentEscaped,
                            admissionDateStr);

                    response.getWriter().write(row);
                }
                response.getWriter().flush();

            } else if ("downloadPdf".equalsIgnoreCase(action)) {
                // PDF download using iText
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=\"patient_report.pdf\"");

                Document document = new Document(PageSize.A4);
                PdfWriter.getInstance(document, response.getOutputStream());

                document.open();

                // Title
                Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
                Paragraph title = new Paragraph("Patient Report", titleFont);
                title.setAlignment(Element.ALIGN_CENTER);
                title.setSpacingAfter(20);
                document.add(title);

                // Create table with 6 columns
                PdfPTable table = new PdfPTable(6);
                table.setWidthPercentage(100);
                table.setWidths(new float[] {1.5f, 3f, 1.5f, 3f, 3f, 2.5f});

                // Table headers
                Stream.of("Patient ID", "Name", "Age", "Assigned Doctor", "Ailment", "Admission Date")
                        .forEach(headerTitle -> {
                            PdfPCell header = new PdfPCell();
                            Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
                            header.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            header.setPhrase(new Phrase(headerTitle, headFont));
                            header.setHorizontalAlignment(Element.ALIGN_CENTER);
                            header.setPadding(5);
                            table.addCell(header);
                        });

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                for (Patient p : filteredPatients) {
                    table.addCell(String.valueOf(p.getPatientID()));
                    table.addCell(p.getPatientName() != null ? p.getPatientName() : "");
                    table.addCell(String.valueOf(p.getAge()));
                    table.addCell(p.getAssignedDoctor() != null ? p.getAssignedDoctor() : "");
                    table.addCell(p.getAilment() != null ? p.getAilment() : "");
                    String admissionDateStr = p.getAdmissionDate() != null ? sdf.format(p.getAdmissionDate()) : "";
                    table.addCell(admissionDateStr);
                }

                document.add(table);
                document.close();

            } else {
                // Normal display on JSP
                request.setAttribute("filteredPatients", filteredPatients);
                request.getRequestDispatcher("reports.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving filtered patients: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (DocumentException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating PDF report: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private String escapeCsv(String field) {
        if (field == null) {
            return "";
        }
        boolean containsSpecial = field.contains(",") || field.contains("\"") || field.contains("\n") || field.contains("\r");
        if (containsSpecial) {
            field = field.replace("\"", "\"\"");
            return "\"" + field + "\"";
        } else {
            return field;
        }
    }
}
