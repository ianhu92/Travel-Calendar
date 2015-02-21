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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet(name = "registServlet", urlPatterns = {"/registServlet"})
public class registServlet extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String first=request.getParameter("first");
            String last=request.getParameter("last");
            String email=request.getParameter("email");
            String pwd=request.getParameter("pwd1");
            
            
            
            Connection con=null;
            PreparedStatement ps=null;
            Statement st=null;
            ResultSet rs=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con=DriverManager.getConnection("jdbc:derby://localhost:1527/IS2560_Final","IS2560","IS2560");
            String sql0=null;
            sql0="select * from users where email=?";
            ps=con.prepareStatement(sql0);
            ps.setString(1, email);
            rs=ps.executeQuery();
            
            if(rs.next()){
                out.print("<script>alert('The email has been registered!');"
                        + "window.history.back(-1);</script>");
                
                //out.println("<div class='title'><h1>Register Failure!</h1>");
                //out.println("<div class='title'><h1>The email has been registered!</h1>");
                //out.println("Please click <a href='index.jsp'>HERE</a> to register again.</div>");
            } else {
            /*
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>registServlet</title>");  
            out.println("<link rel='stylesheet' href='./css/index.css'>");
            out.println("</head>");
            out.println("<body>");   
             */   
            String sql="insert into users(firstname,lastname,email,password) values('"+first+"','"+last+"','"+email+"','"+pwd+"')";
            st=con.createStatement();
            boolean rc=st.execute(sql);
            if(!rc){
                
            HttpSession session = request.getSession(true);
            session.setAttribute("email", email);
            session.setAttribute("first",first);
            
                //out.println("<h1>Register Successfully!</h1>");
                //request.getRequestDispatcher("account.jsp").forward(request, response);
            response.sendRedirect("account.jsp");
            } else{
                out.print("<script>alert('Register Failure!');"
                        + "window.history.back(-1);</script>");
                //out.println("<div class='title'><h1>Register Failure!</h1>");
                //out.println("Please click <a href='index.jsp'>HERE</a> to register again.</div>");
            }
            if(st!=null)
                st.close();
////            if(rs!=null)
////                rs.close();
            if(con!=null)
                con.close();
//            out.println("</body>");
//            out.println("</html>");
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(registServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(registServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(registServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(registServlet.class.getName()).log(Level.SEVERE, null, ex);
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
