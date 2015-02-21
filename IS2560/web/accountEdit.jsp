<%@page import="juz21.DBBean" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Edit | Travel Calendar</title>
        <script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="./css/account.css">  
        <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    </head>
    <body>
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
        <div class="title">
            <h1>Travel Calendar</h1>
            <%String first=(String)request.getSession().getAttribute("first");
            String email = session.getAttribute("email").toString();
            int newmess = DBBean.countunreadmessage(email);
            int newreq = DBBean.countfriendrequest(email);
            %>
            
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
            <div class="left">
            <div class="photo">
                <%
                    out.print("<h2 style='margin-left:5px;'>Hi, "+first+"</h2>");
                    String gender=(String)request.getSession().getAttribute("gender");

                    //out.print(gender);

                    String iurl;
                    if (gender!=null){
                    //if(true){iurl="./image/female.png";}
                    if(gender.equals("Female")){iurl="./image/Female.png";}
                    else {iurl="./image/Male.png";}}
                    else {iurl="./image/Male.png";}
                    out.print("<img src='"+iurl+"' alt='profile'>");
                    //out.println("<img src='./image/"+iurl+".png' alt='profile'>");
                %>
            </div>
            <!--
            <div class="choice">
                <ul>
                    <li><a href="account.jsp">Account</a></li>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="privacy.jsp">Privacy</a></li>
                </ul>
            </div>
            -->
            </div>
            <div class="info">
                <h2>Edit your account</h2>
                <form action="accountServlet" method="post">
                    <table>
                        <tr>
                            <td>Gender</td>
                            <td><select name="gender">
                                    <option>Male</option>
                                    <option>Female</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Birthday</td>
                            <td><input type="date" id="myDate" name="birthday"></td>
                        </tr>
                        <tr>
                            <td>Blood Type</td>
                            <td><select name="blood">
                                    <option>A</option>
                                    <option>B</option>
                                    <option>AB</option>
                                    <option>O</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Mobile</td>
                            <td><input type="tel" name="mobile"></td>    
                        </tr>
                        <tr>
                            <td>Residence</td>
                            <td><input type="text" name="residence"></td>
                        </tr>
                        
                        <tr>
                            <td><input type="submit" value="Submit" style="width:100px;font-size: 30px;"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>
