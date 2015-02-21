<%-- 
    Document   : profile
    Created on : Dec 1, 2014, 1:07:01 AM
    Author     : yuezhao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="juz21.DBBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account | Travel Calendar</title>
        <%

            String email=(String)request.getSession().getAttribute("email");
            String first=(String)request.getSession().getAttribute("first");
            int newmess = DBBean.countunreadmessage(email);
            int newreq = DBBean.countfriendrequest(email);
            String gender;
            //out.print(email);
          
            Connection con=null;
            PreparedStatement ps=null;
            ResultSet rs=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con=DriverManager.getConnection("jdbc:derby://localhost:1527/IS2560_Final","IS2560","IS2560");
            String sql=null;
            sql="select * from users where email=?";
            ps=con.prepareStatement(sql);
            ps.setString(1, email);
            rs=ps.executeQuery();
            if(rs.next()){
                gender=rs.getString(5);
                session.setAttribute("gender", gender);
                //out.print(gender);
            }
        %>
        <link rel="stylesheet" href="./css/account.css"> 
        <!--<link href="./css/bootstrap.css" rel="stylesheet">-->
        <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
        <script src="./js/jquery.js"></script>
	<script src="./js/bootstrap-dropdown.js"></script>
	<script src="./js/application.js"></script>
        <style>
            .title p{
                float: right;
                margin-top: 45px;
                margin-right: 5px;
            }
            .title a{
                text-decoration: none;
                color: graytext;
                font-size: 15px;
                padding-left: 10px;
            }
        </style>
    </head>
    <body>
        
        <div class="title">
            <h1>Travel Calendar</h1>
            <% first=(String)request.getSession().getAttribute("first");%>
            <p><%=first%>
                <a href="logout">Log Out</a></p>
        </div>
        <div class="navi">
            <ul>
                <!--<li><a href="home.jsp">Home Page</a></li>-->
                <li><a href="account.jsp">Account</a></li>
                <li><a href="calendar.jsp">Travel Calendar</a></li>
<!--                <li><a href="">Friends</a></li>-->
                <!--<li><a href="map.jsp">Map</a></li>-->
                <li><a href="searchfriend.jsp">Search</a></li>
                <li><a href="checkunreadmessage.jsp">Message <span class="badge"><%=newmess%></span></a></li>
                <li><a href="checkfriendrequest.jsp">New Friend <span class="badge"><%=newreq%></span></a></li>
                
            </ul>     
        </div>
        <div class="container">
            <div class="left">
            <div class="photo">
                <%
                    out.print("<h2 style='margin-left:5px;'>Hi, "+first+"</h2>");
                    gender=(String)request.getSession().getAttribute("gender");

                    //out.print(gender);

                    String iurl;
                    if (gender!=null){
                    //if(true){iurl="image/Female.png";
                        if(gender.equals("Female")){iurl="image/Female.png";}
                        else {iurl="image/Male.png";}
                    } else {iurl="image/Male.png";}
                    out.print("<img src='"+iurl+"' alt='profile'>");
                    //out.println("<img src='./image/"+iurl+".png' alt='profile'>");
                %>
            
            </div>
         <!--   <div class="choice">
                
                <ul>
                    <li><a href="account.jsp">Account</a></li>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="privacy.jsp">Privacy</a></li>
                    
                </ul>
            </div>-->
            </div>
            <div class="info">
                <h2>Personal profile<a href="accountEdit.jsp">Edit</a></h2>
                <%
                    rs=ps.executeQuery();
                    while(rs.next()){
                %>
                    <table>
                        <tr>
                            
                            <td>First name</td>
                            <td><%out.print(rs.getString(1));%></td>
                        </tr>
                        <tr>
                            <td>Last name</td>
                            <td><%out.print(rs.getString(2));%></td>
                        </tr>
                        <tr>
                            <td>Email address</td>
                            <td><%out.print(rs.getString(3));%></td>
                        </tr>
                        <tr>
                            <td>Gender</td>
                            <td><%
                            //gender=(String)request.getSession().getAttribute("gender");
                            String ge=rs.getString(5);
                            if(ge==null){
                                ge="";
                            }
                            out.print(ge);%></td>
                        </tr>
                        <tr>
                            <td>Birthday</td>
                            <td><%
                            String bi=rs.getString(6);
                            if(bi==null){
                                bi="";
                            }
                            out.print(bi);%></td>
                        </tr>
                        <tr>
                            <td>Blood Type</td>
                            <td><%
                            String bl=rs.getString(7);
                            if(bl==null){
                                bl="";
                            }
                            out.print(bl);%></td>
                        </tr>
                        <tr>
                            <td>Mobile</td>
                            <td><%
                            String mo=rs.getString(8);
                            if(mo==null){
                                mo="";
                            }
                            out.print(mo);%></td>    
                        </tr>
                        <tr>
                            <td>Residence</td>
                            <td><%
                            String resi=rs.getString(9);
                            if(resi==null){
                                resi="";
                            }
                            out.print(resi);%></td>
                        </tr>
                        
                </table>
                <% }       
                %>
            </div>
        </div>
    </body>
</html>
