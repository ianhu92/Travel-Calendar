<%-- 
    Document   : index
    Created on : Dec 1, 2014, 1:04:07 AM
    Author     : yuezhao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>index | Travel Calender</title>
        <link rel="stylesheet" href="./css/index.css">  
        <script type="text/javascript">
            function checkL(loginform) {
                if(window.loginform.email.value===""){
                    alert("Email address can't be empty!");
                    window.loginform.email.focus();
                    return false;
                }
                else if(window.loginform.pwd.value===""){
                    alert("Password can't be empty!");
                    window.loginform.pwd.focus();
                    return false;
                }
                
            }
            
            function checkR(registform) {
                if(window.registform.first.value===""){
                    alert("First name can't be empty!");
                    window.registform.first.focus();
                    return false;
                }
                if(window.registform.last.value===""){
                    alert("Last name can't be empty!");
                    window.registform.last.focus();
                    return false;
                }
                else if(window.registform.email.value===""){
                    alert("Email address can't be empty!");
                    window.registform.email.focus();
                    return false;
                }
                else if(window.registform.pwd1.value===""){
                    alert("Password can't be empty!");
                    window.registform.pwd1.focus();
                    return false;
                }
                else if(window.registform.pwd1.value !== window.registform.pwd2.value){
                    alert("Passwords you entered are not equal!");
                    window.registform.pwd1.focus();
                    return false;
                } 
               
           
        }
            
        
        </script>
        <%
            session.removeAttribute("email");
            session.removeAttribute("first");
            //session.removeAttribute("pwd");
        %>
    </head>
    <body>
        <div class="title">
            <h1>Welcome to Travel Calendar</h1>
            
        </div>
        <div class="container">
            <div class="login">
                <h2>Registered Customers</h2>
                <form action="loginServlet" method="post" name="loginform">
                    <table>
                        <tr>
                            <td>Email address</td>
                            <td><input type="text" name="email"></td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td><input type="password" name="pwd"></td>
                        </tr>
                        <tr>
                            <td><input type="submit" value="Sign In" onclick="return checkL(loginform)"
                                       ></td>
                        </tr>
                       
                    </table>
                </form>
                
            </div>
            <div class="regist">
                <h2>New Customers</h2>
                <form action="registServlet" method="post" name="registform">
                    <table>
                        <tr>
                            <td>First name</td>
                            <td><input type="text" name="first"> </td>
                        </tr>
                        <tr>
                            <td>Last name</td>
                            <td><input type="text" name="last"> </td>
                        </tr>
                        <tr>
                            <td>Email address</td>
                            <td><input type="email" name="email"></td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td><input type="password" name="pwd1"> </td>
                        </tr>
                        <tr>
                            <td>Confirm Password</td>
                            <td><input type="password" name="pwd2"> </td>
                        </tr>
                        
                        <tr>
                            <td><input type="submit" value="Sign Up" onclick="return checkR(registform)"
                                       ></td>
                        </tr>
                        
                    </table>
                    
                </form>
            </div>
        </div>
        
    </body>
</html>
