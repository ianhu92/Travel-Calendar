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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yuezhao
 */
@WebServlet(name = "accountServlet", urlPatterns = {"/accountServlet"})
public class accountServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(true);
            String email=(String)session.getAttribute("email");
            
            String gender=request.getParameter("gender");
            String birthday=request.getParameter("birthday");
            String blood=request.getParameter("blood");
            String residence=request.getParameter("residence");
            String mobile=request.getParameter("mobile");
            //String status=request.getParameter("status");
            //String profile=request.getParameter("profile");
            

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>profileServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>"+gender+birthday+blood+mobile+"</h1>");
            
            Connection con=null;
            Statement st=null;
//            PreparedStatement ps=null;
//            ResultSet rs=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con=DriverManager.getConnection("jdbc:derby://localhost:1527/IS2560_Final","IS2560","IS2560");
            out.print("database connect successful"+email);
            String sql="update  users "
                    + "set gender='"+gender+"',birthday='"+birthday+"',blood='"+blood+"',mobile='"+mobile+"',"
                    + "residence='"+residence+"' where email='"+email+"'";
            st=con.createStatement();
            //st.execute(sql);
            boolean rc= !st.execute(sql);
            out.print(rc);

            if(true){
                session.setAttribute("gender", gender);
                out.println("<h1>Edit Successfully!</h1>");
                response.sendRedirect("account.jsp");
                //request.getRequestDispatcher("account.jsp").forward(request, response);
            } else{
                out.println("<h1>Edit Failure!</h2>");
            }
            if(st!=null)
                st.close();
//            if(rs!=null)
//                rs.close();
            if(con!=null)
                con.close();
            
            out.println("<h1></h1>");
            out.println("</body>");
            out.println("</html>");
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
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(accountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(accountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
