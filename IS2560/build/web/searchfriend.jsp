<%@page import="juz21.DBBean" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Friend</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">    
        <link rel="stylesheet" href="./css/account.css">
        <script src="js/jquery-1.11.1.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script>
            function addFriend(from,to) {
                var xmlHttp = new XMLHttpRequest();
                if (xmlHttp==null)
                 {
                     alert("Browser does not support HTTP Request");
                     return;
                 }
                    var url="addFriend";
                    url=url+"?from="+from+"&to="+to;
                    
                xmlHttp.onreadystatechange=function()
                {
//                    stateChange(xmlHttp,to);
                };
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
                
                alert("Send request success!");
                location.reload();
            }
            function stateChange(xmlhttp, div)
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
            String fname = request.getParameter("friendname");
            String[][] user = DBBean.findFriend(fname,email);
            String[][] recommend = DBBean.recommendfriend(email);
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
                    <div class="row">
                        <div class="col-md-4 column">
				</div>
                        <form class="navbar-form navbar-left" role="search" action="searchfriend.jsp" method="post">
                            <div class="form-group">
                              <input type="text" name="friendname" class="form-control" placeholder="Search People">
                            </div>
                            <button type="submit" class="btn btn-default">Submit</button>
                         </form>
                    </div>
			<div class="row clearfix">
                            <div class="col-md-3 column">
				</div>
                                    <div class="col-md-5 column">
                                        <%
                                                if (recommend != null) {
                                        %>
                                        We recommend these people who live in the same city for you:
					<table class="table">
                                            <tr><th>Email</th><th>First Name</th><th>Last Name</th><th>Add</th></tr>
                                            <% 
                                                    for(int i=0;i<recommend.length;i++) {
                                                    out.println("<tr><td>"+ recommend[i][2]+"</td>");
                                                    out.println("<td>"+ recommend[i][0]+"</td>");
                                                    out.println("<td>" +recommend[i][1]+ "</td>");
                                                    
                                            %>        
                                            <td><input type="button" class="btn btn-primary" onclick="addFriend('<%=session.getAttribute("email")%>','<%=recommend[i][2]%>')" value="Add"/></td></tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%if (fname != null) {%>
                                        Your search result:
                                        <%
                                                    if (user != null) {
                                        %>
                                            <table class="table">
                                            <tr><th>Email</th><th>First Name</th><th>Last Name</th><th>Add</th></tr>
                                            
                                                <% 
                                                for(int i=0;i<user.length;i++) {
                                                    out.println("<tr><td>"+ user[i][2]+"</td>");
                                                    out.println("<td>"+ user[i][0]+"</td>");
                                                    out.println("<td>" +user[i][1]+ "</td>");
                                            %>
                                        <td><input type="button" class="btn btn-primary" onclick="addFriend('<%=user[i][2]%>','<%=session.getAttribute("email")%>')" value="Add"/></td></tr>
                                            <%
                                                }
                                            %>
                                        </table>
                                        <%}else {%>
                                        Sorry, cannot find people, try a different name.
                                        <%}
                                        }
                                        %>
                                        </div>
				<div class="col-md-4 column">
                            </div>
			</div>
		</div>
        </div>
        </div>
    </body>
</html>
