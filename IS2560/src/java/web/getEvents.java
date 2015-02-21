/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ian
 */
public class getEvents extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        int year = Integer.parseInt(request.getParameter("year"));
        int month = Integer.parseInt(request.getParameter("month"));
        Calendar calendar = new GregorianCalendar(year, month - 1, 1);
        int numberOfLastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        HttpSession session = request.getSession(true);
        String email = (String) session.getAttribute("email");
        //String email = "a@a.com";
        try {
            st = conn.createStatement();
            String sql = "select * from event where startdate >= '" + year + "-" + month + "-01' and startdate <= '" + year + "-" + month + "-" + numberOfLastDay + "' and email='" + email + "'";
            //out.print(sql);
            rs = st.executeQuery(sql);

            out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?><node>");
            while (rs.next()) {
                out.print("<event><eventtitle>" + rs.getString("eventtitle") + "</eventtitle><city>" + rs.getString("city") + "</city>"
                        + "<state>" + rs.getString("state") + "</state><day>" + rs.getString("startdate").substring(8) + "</day>"
                        +"<starthour>"+rs.getString("starttime").substring(0,1)+"</starthour><startminute>"+rs.getString("starttime").substring(3,4)+"</startminute>"
                        +"<endhour>"+rs.getString("endtime").substring(0,1)+"</endhour><endminute>"+rs.getString("endtime").substring(3,4)+"</endminute>"
                        +"<eventid>"+rs.getString("eventid")+"</eventid></event>");
            }
            rs.close();
            out.print("</node>");
        } catch (SQLException se) {
            se.printStackTrace();
        }
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
