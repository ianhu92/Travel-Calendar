<%-- 
    Document   : checkmessage
    Created on : 2014-12-5, 21:39:32
    Author     : zhaojun
--%>

<%@page import="juz21.DBBean" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Message check</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/account.css"> 
        <script src="js/jquery-1.11.1.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <% if (session.getAttribute("email") == null) {session.setAttribute("email", "wil@pitt.edu");}String email = session.getAttribute("email").toString();
            int num = DBBean.countunreadmessage(email);
            int newmess = DBBean.countunreadmessage(email);
            int newreq = DBBean.countfriendrequest(email);
        %>
    </head>
    <body>
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
                <div class="col-md-3 column">
		</div>
                <div class="col-md-6 column">
                <ul class="nav nav-pills" role="tablist">
                    <li role="presentation" class="active"><a href="checkunreadmessage.jsp">Unread Messages</a></li>
                    <li role="presentation"><a href="checkreadmessage.jsp">Already has been read</a></li>
                    <li role="presentation"><a href="sendmessage.jsp">Send message</a></li>
                </ul>
                <div class="col-md-3 column">
		</div>
                <div  class="row">
                    <table class="table">
                        <thead>
                            <tr><th>From</th><th>title</th><th>sent time</th></tr>
                        </thead>
                <% 
                    
                    Object[][] mess = DBBean.showunreadmessage(email);
                    if (mess != null) {
                        int i;
                        for (i=0; i<num;i++){
                %>

                <tr>
                    <td><a href="messagedialog.jsp?from=<%=mess[i][0]%>&title=<%=mess[i][1]%>&time=<%=mess[i][3]%>"><strong><%=mess[i][0]%></strong><br/></a></td>
                    <td><a href="messagedialog.jsp?from=<%=mess[i][0]%>&title=<%=mess[i][1]%>&time=<%=mess[i][3]%>"><strong><%=mess[i][1]%></strong><br/></a></td>
                    <td><span><%=mess[i][3]%></span></td>
                </tr>
                <%      }
                    }else{
                %>
                    You has no message
                    <%}%>
                    </table>
                </div>
                </div>
            </div>
        </div>
    </body>
</html>
