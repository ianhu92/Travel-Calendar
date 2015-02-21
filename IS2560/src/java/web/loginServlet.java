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
@WebServlet(urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//           
//            String email;
//            String pwd;
//            String first=null;
//            email=request.getParameter("email");
//            pwd=request.getParameter("pwd");
//
//            //System.out.print(email+pwd);
////            out.println("<!DOCTYPE html>");
////            out.println("<html>");
////            out.println("<head>");
////            out.println("<title>loginServlet</title>");
////            out.println("<link rel=\"stylesheet\" href=\"index.css\">");
////            out.println("</head>");
////            out.println("<body>");
//            
//            Connection con=null;
//            PreparedStatement ps=null;
//            ResultSet rs=null;
//            Class.forName("org.apache.derby.jdbc.ClientDriver");
//            con=DriverManager.getConnection("jdbc:derby://localhost:1527/IS2560_Final","IS2560","IS2560");
//            String sql=null;
//            sql="select * from users where email=? and password=?";
//            ps=con.prepareStatement(sql);
//            ps.setString(1, email);
//            ps.setString(2, pwd);
//            rs=ps.executeQuery();
//            
//            if(rs.next()){
//                first=rs.getString(1);
//                //out.println("<h1>Login Successfully!</h1>");
//                //out.println(first);
////                request.setAttribute("email", email);  
////                request.setAttribute("first", first); 
//            HttpSession session = request.getSession(true);
//            
//            session.setAttribute("email", email);
//            session.setAttribute("first",first);
//            
//                //request.getRequestDispatcher("account.jsp").forward(request, response);
//                response.sendRedirect("account.jsp");
//            } else{
//                out.print("<script>alert('Wrong email or password!');"
//                        + "window.history.back(-1);</script>");
////                out.println("<div class='title'><h1>Login Failure!</h1>");
////                out.println("Please click <a href='index.jsp'>HERE</a> to login again.</div>");
//            }
//
//            if(rs!=null)
//                rs.close();
//            if(con!=null)
//                con.close();
//
////            out.println("</body>");
////            out.println("</html>");
//        }
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
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String email;
            String pwd;
            String first = null;
            email = request.getParameter("email");
            pwd = request.getParameter("pwd");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/IS2560_Final", "IS2560", "IS2560");
            String sql = "select * from users where email=? and password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pwd);
            rs = ps.executeQuery();

            if (rs.next()) {
                first = rs.getString(1);
                //out.println("<h1>Login Successfully!</h1>");
                //out.println(first);
//                request.setAttribute("email", email);  
//                request.setAttribute("first", first); 
                HttpSession session = request.getSession(true);

                session.setAttribute("email", email);
                session.setAttribute("first", first);

                //request.getRequestDispatcher("account.jsp").forward(request, response);
                response.sendRedirect("account.jsp");
            } else {
                out.print("<script>alert('Wrong email or password!');"
                        + "window.history.back(-1);</script>");
//                out.println("<div class='title'><h1>Login Failure!</h1>");
//                out.println("Please click <a href='index.jsp'>HERE</a> to login again.</div>");
            }

            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
            processRequest(request, response);
//            out.println("</body>");
//            out.println("</html>");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
