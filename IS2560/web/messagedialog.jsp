<%-- 
    Document   : messagedetail
    Created on : 2014-12-6, 11:10:19
    Author     : zhaojun
--%>

<%@page import="juz21.DBBean" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Message Dialog</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/account.css">
        <script src="js/jquery-1.11.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <% if (session.getAttribute("email") == null) {session.setAttribute("email", "juz21@pitt.edu");}String email = session.getAttribute("email").toString();%>
    </head>
    <body>
        <% 
        int newmess = DBBean.countunreadmessage(email);
        int newreq = DBBean.countfriendrequest(email);
        String from = request.getParameter("from");  
        String title = request.getParameter("title");
        String time = request.getParameter("time");
        %>
        <div class="title">
            <h1>Travel Calendar</h1>
            <%  String first=(String)request.getSession().getAttribute("first");
                first=(String)request.getSession().getAttribute("first");%>
            
        </div>
        <div class="navi">
            <ul>
                <!--<li><a href="home.jsp">Home Page</a></li>-->
                <li><a href="account.jsp">Account</a></li>
                <li><a href="calendar.jsp">Travel Calendar</a></li>
                    <!--<li><a href="map.jsp">Map</a></li>-->
                <li><a href="searchfriend.jsp">Search</a></li>
                <li><a href="checkunreadmessage.jsp">Message <span class="badge"><%=newmess%></span></a></li>
                <li><a href="checkfriendrequest.jsp">New Friend <span class="badge"><%=newreq%></span></a></li>
                <li><a href="#" ><%=first%></a></li>
                <li><a href="logout">Log Out</a></li>
            </ul>     
        </div>
               
        <div class="container">
            
            <div class="col-md-12 column">
                <div class="row">
                <div class="col-md-3 column">
		</div>
                <div class="col-md-6 column">
                <ul class="nav nav-pills" role="tablist">
                    <li role="presentation"><a href="checkunreadmessage.jsp">Unread Messages</a></li>
                    <li role="presentation"><a href="checkreadmessage.jsp">Already has been read</a></li>
                </ul>
                </div>
                <div class="col-md-3 column">
		</div>
                </div>
                <%   
                    Object[][] mess = DBBean.selectmessagefrom(from,email,title);
                %>
                <div class="row">
                    <div class="col-md-12 column">
                        <br/>
                        <br/>
                    </div>
                </div>
                <div class="row">
                <div class="col-md-3 column">
		</div>
                <div class="col-md-6 column">
                    <div class="panel panel-default">
                        <div class="panel-heading">Title:<strong><%=mess[0][1]%></strong></div>
                        <div class="panel-body">
                            <%=mess[0][2]%>
                        </div>
                        <div class="panel-footer"><%=from%>  said to you on <span><%=mess[0][3]%></div>
                    </div>
                </div>
                <div class="col-md-3 column">
		</div>
                </div>
            </div>
        </div>
    </body>
</html>
