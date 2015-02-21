<%-- 
    Document   : checkfriendrequest
    Created on : 2014-12-6, 14:17:02
    Author     : zhaojun
--%>
<%@page import="juz21.DBBean" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Message check</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">  
        <link rel="stylesheet" href="./css/account.css">    
        <script src="js/jquery-1.11.1.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script>
            function agreeadd(from,to,status) {
                var xmlHttp = new XMLHttpRequest();
                if (xmlHttp==null)
                 {
                     alert("Browser does not support HTTP Request");
                     return;
                 }
                if(status=="agree"){
                    var url="agreeadd";
                    url=url+"?from="+from+"&to="+to;
                }
               
                
                else {
                    var url="disagreeadd";
                    url=url+"?from="+from+"&to="+to;
                }
                    
                xmlHttp.onreadystatechange=function()
                {
                    stateChange(xmlHttp);
                };
                xmlHttp.open("GET",url,false);
                xmlHttp.send(null);
                
                location.reload();
            }
            function stateChange(xmlhttp)
            { 
                if (xmlhttp.readyState==4 || xmlhttp.readyState=="complete")
                { 
                    //$("#"+div).html("request sent");
//                    document.getElementById(div).innerHTML("request sent");

                } 
            }

        </script>
        <% if (session.getAttribute("email") == null) {session.setAttribute("email", "wil@pitt.edu");}String email = session.getAttribute("email").toString();
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
            
            <div class="row clearfix">
		<div class="col-md-12 column">
			<div class="row clearfix">
                            <div class="col-md-3 column">
				</div>
                                    <div class="col-md-5 column">
                                        <%
                                            if (newreq != 0){
                                        %>
					<table class="table">
                                            <thead>
                                                <tr><th>Request from</th><th>Agree</th><th>Disagree</th></tr>
                                            </thead>
<!--        <h1>Messages</h1>
        <ul class="nav nav-tabs" role="tablist">
            <li id="unread" role="presentation" class="active"><a href="#">Unread</a></li>
            <li id="read" role="presentation"><a href="#">Read</a></li>
        </ul>
        <div>-->
                                        <% 
                                                String[] friendrequest = DBBean.showfriendrequest(email);
                                                int i;
                                                for (i=0; i<newreq;i++){
                                        %>
                                                <tr>
                                                    <td><%=friendrequest[i]%></td>
                                                    <td><input type="button" class="btn btn-primary" onclick="agreeadd('<%=friendrequest[i]%>','<%=session.getAttribute("email")%>','agree')" value="Agree"/></td>
                                                    <td><input type="button" class="btn btn-primary" onclick="agreeadd('<%=friendrequest[i]%>','<%=session.getAttribute("email")%>','disagree')" value="DisAgree"/></td>
                                                </tr>
                                        <%      }
                                            }else {
                                        %>
                                        <tr>You do not have new friend request yet</tr>
                                            <%}%>
                                    </table>
                                    </div>
				<div class="col-md-4 column">
                            </div>
			</div>
		</div>
	</div>
    </body>
</html>
