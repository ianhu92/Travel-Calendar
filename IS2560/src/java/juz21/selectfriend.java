/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juz21;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author zhaojun
 */
public class selectfriend extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String fname = request.getParameter("fname");
        System.out.println(fname);
        String uname = request.getParameter("uname");
        System.out.println(fname);
        String[][] selectname = DBBean.selectFriend(fname, uname);
//        PrintWriter out = response.getWriter();
//        out.println(uname);
//        out.println(selectname);
        if(selectname != null){
            int len = selectname.length;
            System.out.println(len);
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                for (int i=0; i < len; i++){     
                    out.println("<tr id =fl"+i+">");
                    out.println("<td class=\"col-sm-5\">"+selectname[i][2]+"</td>");
                    out.println("<td class=\"col-sm-5\">"+selectname[i][0]+"</td>");
                    out.println("<td class=\"col-sm-5\">"+selectname[i][1]+"</td>");
                    out.println("<td class=\"col-sm-2\"><button class=\"btn btn-default\" type=\"button\" data-dismiss=\"modal\" onclick=\"selectFriend("+i+")\">Select</button></td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
        }
        else{
            try (PrintWriter out = response.getWriter()) {
                out.println("Sorry, cannot find your friend");
            }
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(selectfriend.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(selectfriend.class.getName()).log(Level.SEVERE, null, ex);
        }
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
