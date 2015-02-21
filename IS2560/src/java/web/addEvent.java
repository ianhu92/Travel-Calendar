/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ian
 */
public class addEvent extends HttpServlet {

    private Connection conn;
    private Statement st;
    private ResultSet rs = null;

    public void init() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            String connectionURL = "jdbc:derby://localhost:1527/IS2560_Final";
            conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String eventTitle = request.getParameter("eventTitle");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        if ("".equals(eventTitle) || "".equals(city) || "".equals(state)) {
            out.print("please provide all information.");
            processRequest(request, response);
            return;
        }
        int startYear = Integer.parseInt(request.getParameter("startYear"));
        int startMonth = Integer.parseInt(request.getParameter("startMonth"));
        int startDay = Integer.parseInt(request.getParameter("startDay"));
        int startHour = Integer.parseInt(request.getParameter("startHour"));
        int startMinute = Integer.parseInt(request.getParameter("startMinute"));
        int endYear = Integer.parseInt(request.getParameter("endYear"));
        int endMonth = Integer.parseInt(request.getParameter("endMonth"));
        int endDay = Integer.parseInt(request.getParameter("endDay"));
        int endHour = Integer.parseInt(request.getParameter("endHour"));
        int endMinute = Integer.parseInt(request.getParameter("endMinute"));
        endYear = startYear;
        endMonth = startMonth;
        endDay = startDay;
        Date startDate = new java.util.Date(startYear, (startMonth - 1), startDay, startHour, startMinute);
        Date endDate = new java.util.Date(endYear, (endMonth - 1), endDay, endHour, endMinute);
        if (startDate.compareTo(endDate) >= 0) {
            out.print("End Date must be after Start Date.");
            processRequest(request, response);
            return;
        }

        String startDateString = startYear + "-" + startMonth + "-" + startDay;
        String startTimeString = startHour + ":" + startMinute + ":00";
        String endDateString = endYear + "-" + endMonth + "-" + endDay;
        String endTimeString = endHour + ":" + endMinute + ":00";
        HttpSession session = request.getSession(true);
        String email = (String) session.getAttribute("email");
        //email = "a@a.com";
        try {
            st = conn.createStatement();
            String sql = "insert into event (eventTitle,city,state,startdate,starttime,enddate,endtime,email) "
                    + "values ('" + eventTitle + "','" + city + "','" + state + "','" + startDateString + "','" + startTimeString + "','" + endDateString + "','" + endTimeString + "','" + email + "')";
            if (st.executeUpdate(sql) < 0) {
                out.print("add event failed.");
            } else {
                out.print("add event succeed");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }

        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
