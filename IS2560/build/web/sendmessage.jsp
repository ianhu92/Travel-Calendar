<%-- 
    Document   : sendmessage
    Created on : 2014-12-5, 23:52:46
    Author     : zhaojun
--%>

<%@page import="juz21.DBBean" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Send Message</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/account.css"> 
        <script src="js/jquery-1.11.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <% if (session.getAttribute("email") == null) {session.setAttribute("email", "juz21@pitt.edu");}String email = session.getAttribute("email").toString();
            int newmess = DBBean.countunreadmessage(email);
            int newreq = DBBean.countfriendrequest(email);
        %>
        <script>
            function showModal1(){
               $('#myModal1').modal('show');
               showFriend("","<%=email%>");
            }
            function showFriend(fname,uname)
            {   
                var xmlHttp1 = new XMLHttpRequest();
                if (xmlHttp1==null)
                 {
                     alert ("Browser does not support HTTP Request");
                     return;
                 }
                var url="selectfriend";
                url=url+"?fname="+fname+"&uname="+uname;
                xmlHttp1.onreadystatechange=function()
                {
                    stateChange(xmlHttp1,"friendList");
                };
                xmlHttp1.open("GET",url,true);
                xmlHttp1.send(null);
            }
            function stateChange(xmlhttp, div)
            { 
                if (xmlhttp.readyState==4 || xmlhttp.readyState=="complete")
                 { 
                    document.getElementById(div).innerHTML=xmlhttp.responseText ;
                 } 
            }
            function selectFriend(Btn){
//                alert($("#fl"+Btn).children().first().text());
                document.getElementById("friend").value = $("#fl"+Btn).children().first().text();
            }
            function success() {
                alert("Success!");
            }
        </script>
    </head>
    <body>
        
            <div class="title">
            <h1>Travel Calender</h1>
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
                <div class="col-md-4 column">
		</div>
                <div class="col-md-5 column">
                    <h4>Send Message</h4>
                    <form role="form" action="sendMessage" method="POST">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Send to</label>
                            <input type="email" name="touser"  class="form-control" id="friend" placeholder="Enter email" onfocus="showModal1()">
                        </div>
            <!--            <p>Title: <input type="text" name="title" /></p>-->
                        <div class="form-group">
                            <label>Title</label>
                            <input type="text" class="form-control" name="title"  placeholder="Title">
                        </div>
                        <div class="form-group">
                            <label>Content</label>
                            <textarea class="form-control" rows="7" name="content"  placeholder="Please input here"></textarea>
                        </div>
                        <input type="hidden" name="fromuser" value="<%=email%>"/>
                        <button type="submit" class="btn btn-primary" onclick="success()">Submit</button>
                        <a href='checkunreadmessage.jsp'>cancel</a>
                    </form>
                </div>
                <div class="col-md-3 column">
		</div>
            </div>
                <div class="modal fade large" id="myModal1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">Friend List</h4>
                            </div>
                            <div class="modal-body" align="center">
                                <div>
                                <div class="col-sm-10 col-sm-offset-1">
                                    <form>
                                        <div class="input-group">
                                          <input type="text" class="form-control" placeholder="Input Customer Name" onkeyup="showFriend(this.value,'<%=email%>')">

                                        </div>
                                    </form>
                                </div>    


                                <div class="col-sm-10 col-sm-offset-1" style="margin-top: 5%">
                                    <table class="table table-bordered" id="friendList" style="margin-top: 5%">


                                    </table>
                                </div>
                            </div>
                            </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
