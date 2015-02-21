<%-- 
    Document   : home
    Created on : Dec 8, 2014, 1:51:19 AM
    Author     : yuezhao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calendar | Travel Calendar</title>
        <link rel="stylesheet" href="./css/account.css">  
        <link rel="stylesheet" type="text/css" href="css/calendar.css"/>
        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <script type="text/javascript" src="js/calendar.js"></script>
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
            <% String first = (String) request.getSession().getAttribute("first");%>
            <p><%=first%>
                <a href="l">Log Out</a></p>
        </div>
        <div class="navi">
            <ul>
                <li><a href="account.jsp">Account</a></li>
                <li><a href="calendar.jsp">Travel Calendar</a></li>
                <!--<li><a href="map.jsp">Map</a></li>-->
                <li><a href="searchfriend.jsp">Search</a></li>
                <li><a href="checkunreadmessage.jsp">Message <span class="badge"></span></a></li>
                <li><a href="checkfriendrequest.jsp">New Friend <span class="badge">    </span></a></li>
            </ul>

        </div>
        <div class="container">
            <form id="main">
                <div id="tableHeader">
                    <a id="backToday" class="operation">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Go back today&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    <a id="backOneYear" title="move back one year" onclick="getDays(2013, 12);"><img id="leftYear" src="img/leftDoubleArrowCalendar.png" alt="move back one year"/></a>
                    <a id="backOneMonth" title="move back one month" onclick="getDays(2014, 11);"><img id="leftMonth" src="img/leftArrowCalendar.png" alt="move back one month"/></a>
                    <div id="headerLabel">
                        <span id="yearLabel">2014</span>
                        <span id="monthLabel">December</span>
                    </div>
                    <a id="ForwardOneMonth" title="move forward one month" onclick="getDays(2015, 1);"><img id="rightYear" src="img/rightArrowCalendar.png" alt="move forward one month"/></a>
                    <a id="ForwardOneYear" title="move forward one year" onclick="getDays(2015, 12);"><img id="rightMonth" src="img/rightDoubleArrowCalendar.png" alt="move forward one year"/></a>
                    <a id="addEventPlus" class="operation" onclick="showAddEventBox();">&nbsp;Add event on selected day&nbsp;</a>
                    <div id="addEventBox">
                        <span>Event Title:</span><input id="eventTitle" class="eventInput"/><br/>
                        <span>Location:&nbsp;&nbsp;&nbsp;City:</span>
                        <select id="citySelect"><option value="">choose state-></option></select>
                        State: <select id="stateSelect" onselect="" onchange="getCity(this.options[this.selectedIndex].value, 'citySelect')">
                            <option>&nbsp;&nbsp;</option>
                            <option value="AL">AL</option>
                            <option value="AK">AK</option>
                            <option value="AZ">AZ</option>
                            <option value="AR">AR</option>
                            <option value="CA">CA</option>
                            <option value="CO">CO</option>
                            <option value="DE">DE</option>
                            <option value="FL">FL</option>
                            <option value="GA">GA</option>
                            <option value="HI">HI</option>
                            <option value="ID">ID</option>
                            <option value="IL">IL</option>
                            <option value="IN">IN</option>
                            <option value="IA">IA</option>
                            <option value="KS">KS</option>
                            <option value="KY">KY</option>
                            <option value="LA">LA</option>
                            <option value="ME">ME</option>
                            <option value="MD">MD</option>
                            <option value="MA">MA</option>
                            <option value="MI">MI</option>
                            <option value="MN">MN</option>
                            <option value="MS">MS</option>
                            <option value="MO">MO</option>
                            <option value="MT">MT</option>
                            <option value="NE">NE</option>
                            <option value="NV">NV</option>
                            <option value="OH">OH</option>
                            <option value="OK">OK</option>
                            <option value="OR">OR</option>
                            <option value="PA">PA</option>
                            <option value="TN">TN</option>
                            <option value="TX">TX</option>
                            <option value="UT">UT</option>
                            <option value="VT">VT</option>
                            <option value="VA">VA</option>
                            <option value="WA">WA</option>
                            <option value="WI">WI</option>
                            <option value="WY">WY</option>
                        </select><br/>
                        <span>Start Time:&nbsp;</span><select id="startYearSelect" onchange="changeMonthOrYear('start');">
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                            <option value="2018">2018</option>
                            <option value="2017">2017</option>
                            <option value="2016">2016</option>
                            <option value="2015">2015</option>
                            <option value="2014">2014</option>
                            <option value="2013">2013</option>
                            <option value="2012">2012</option>
                            <option value="2011">2011</option>
                            <option value="2010">2010</option>
                            <option value="2009">2009</option>
                            <option value="2008">2008</option>
                            <option value="2007">2007</option>
                            <option value="2006">2006</option>
                            <option value="2005">2005</option>
                            <option value="2004">2004</option>
                            <option value="2003">2003</option>
                            <option value="2002">2002</option>
                            <option value="2001">2001</option>
                            <option value="2000">2000</option>
                            <option value="1999">1999</option>
                            <option value="1998">1998</option>
                            <option value="1997">1997</option>
                            <option value="1996">1996</option>
                            <option value="1995">1995</option>
                            <option value="1994">1994</option>
                        </select><select id="startMonthSelect" onchange="changeMonthOrYear('start');">
                            <option value="1">January</option>
                            <option value="2">Febuary</option>
                            <option value="3">March</option>
                            <option value="4">April</option>
                            <option value="5">May</option>
                            <option value="6">June</option>
                            <option value="7">July</option>
                            <option value="8">August</option>
                            <option value="9">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select><select id="startDaySelect">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="10">10</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select>&nbsp;
                        <select id="startHourSelect">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                        </select><select id="startMinuteSelect">
                            <option value="00">00</option>
                            <option value="05">05</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="30">30</option>
                            <option value="35">35</option>
                            <option value="40">40</option>
                            <option value="45">45</option>
                            <option value="50">50</option>
                            <option value="55">55</option>
                        </select>
                        <br/>
                        <span>End Time:</span><!--<select id="endYearSelect" onchange="changeMonthOrYear('end');">
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                            <option value="2018">2018</option>
                            <option value="2017">2017</option>
                            <option value="2016">2016</option>
                            <option value="2015">2015</option>
                            <option value="2014">2014</option>
                        </select><select id="endMonthSelect" onchange="changeMonthOrYear('end');">
                            <option value="1">January</option>
                            <option value="2">Febuary</option>
                            <option value="3">March</option>
                            <option value="4">April</option>
                            <option value="5">May</option>
                            <option value="6">June</option>
                            <option value="7">July</option>
                            <option value="8">August</option>
                            <option value="9">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select><select id="endDaySelect">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="10">10</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select>&nbsp;-->
                        <select id="endHourSelect" style="margin-left:218px;">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                        </select><select id="endMinuteSelect">
                            <option value="00">00</option>
                            <option value="05">05</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="30">30</option>
                            <option value="35">35</option>
                            <option value="40">40</option>
                            <option value="45">45</option>
                            <option value="50">50</option>
                            <option value="55">55</option>
                        </select><br/>
                        <input type="button" value="Add Event" onclick="addEvent();"/><input type="button" id="closeEventBox" class="closeEventBox" onclick="this.parentNode.style.display = 'none'" value="Close"/>
                    </div>
                </div>
                <table id="calender">
                    <tbody>
                        <tr>
                            <th><p>Sunday</p></th>
                    <th><p>Monday</p></th>
                    <th><p>Tuesday</p></th>
                    <th><p>Wednesday</p></th>
                    <th><p>Thrusday</p></th>
                    <th><p>Friday</p></th>
                    <th><p>Saturday</p></th>
                    </tr>
                    <tr id="week1">
                        <td id="day11" class="td"><p> </p><ul></ul></td>
                        <td id="day12" class="td"><p> </p><ul></ul></td>
                        <td id="day13" class="td"><p> </p><ul></ul></td>
                        <td id="day14" class="td"><p> </p><ul></ul></td>
                        <td id="day15" class="td"><p> </p><ul></ul></td>
                        <td id="day16" class="td"><p> </p><ul></ul></td>
                        <td id="day17" class="td"><p> </p><ul></ul></td>
                    </tr>
                    <tr id="week2">
                        <td id="day21" class="td"><p> </p><ul></ul></td>
                        <td id="day22" class="td"><p> </p><ul></ul></td>
                        <td id="day23" class="td"><p> </p><ul></ul></td>
                        <td id="day24" class="td"><p> </p><ul></ul></td>
                        <td id="day25" class="td"><p> </p><ul></ul></td>
                        <td id="day26" class="td"><p> </p><ul></ul></td>
                        <td id="day27" class="td"><p> </p><ul></ul></td>
                    </tr>
                    <tr id="week3">
                        <td id="day31" class="td"><p> </p><ul></ul></td>
                        <td id="day32" class="td"><p> </p><ul></ul></td>
                        <td id="day33" class="td"><p> </p><ul></ul></td>
                        <td id="day34" class="td"><p> </p><ul></ul></td>
                        <td id="day35" class="td"><p> </p><ul></ul></td>
                        <td id="day36" class="td"><p> </p><ul></ul></td>
                        <td id="day37" class="td"><p> </p><ul></ul></td>
                    </tr>
                    <tr id="week4">
                        <td id="day41" class="td"><p> </p><ul></ul></td>
                        <td id="day42" class="td"><p> </p><ul></ul></td>
                        <td id="day43" class="td"><p> </p><ul></ul></td>
                        <td id="day44" class="td"><p> </p><ul></ul></td>
                        <td id="day45" class="td"><p> </p><ul></ul></td>
                        <td id="day46" class="td"><p> </p><ul></ul></td>
                        <td id="day47" class="td"><p> </p><ul></ul></td>
                    </tr>
                    <tr id="week5">
                        <td id="day51" class="td"><p> </p><ul></ul></td>
                        <td id="day52" class="td"><p> </p><ul></ul></td>
                        <td id="day53" class="td"><p> </p><ul></ul></td>
                        <td id="day54" class="td"><p> </p><ul></ul></td>
                        <td id="day55" class="td"><p> </p><ul></ul></td>
                        <td id="day56" class="td"><p> </p><ul></ul></td>
                        <td id="day57" class="td"><p> </p><ul></ul></td>
                    </tr>
                    <tr id="week6">
                        <td id="day61" class="td"><p> </p><ul></ul></td>
                        <td id="day62" class="td"><p> </p><ul></ul></td>
                        <td id="day63" class="td"><p> </p><ul></ul></td>
                        <td id="day64" class="td"><p> </p><ul></ul></td>
                        <td id="day65" class="td"><p> </p><ul></ul></td>
                        <td id="day66" class="td"><p> </p><ul></ul></td>
                        <td id="day67" class="td"><p> </p><ul></ul></td>
                    </tr>
                    </tbody>
                </table>
                <div id="showEventBoxList"></div>
                <div id="showEventBox" style="display:none;border:1px solid;padding:10px">
                    <span>Event Title:</span><input id="showEventTitle" class="eventInput" style="width:262px"/><br/>
                    <span>Location:&nbsp;&nbsp;&nbsp;City:</span>
                    <select id="showCitySelect"></select>
                    State: <select id="showStateSelect" onselect="" onchange="getCity(this.options[this.selectedIndex].value, 'showEventTitle')">
                        <option>&nbsp;&nbsp;</option>
                        <option value="AL">AL</option>
                        <option value="AK">AK</option>
                        <option value="AZ">AZ</option>
                        <option value="AR">AR</option>
                        <option value="CA">CA</option>
                        <option value="CO">CO</option>
                        <option value="DE">DE</option>
                        <option value="FL">FL</option>
                        <option value="GA">GA</option>
                        <option value="HI">HI</option>
                        <option value="ID">ID</option>
                        <option value="IL">IL</option>
                        <option value="IN">IN</option>
                        <option value="IA">IA</option>
                        <option value="KS">KS</option>
                        <option value="KY">KY</option>
                        <option value="LA">LA</option>
                        <option value="ME">ME</option>
                        <option value="MD">MD</option>
                        <option value="MA">MA</option>
                        <option value="MI">MI</option>
                        <option value="MN">MN</option>
                        <option value="MS">MS</option>
                        <option value="MO">MO</option>
                        <option value="MT">MT</option>
                        <option value="NE">NE</option>
                        <option value="NV">NV</option>
                        <option value="OH">OH</option>
                        <option value="OK">OK</option>
                        <option value="OR">OR</option>
                        <option value="PA">PA</option>
                        <option value="TN">TN</option>
                        <option value="TX">TX</option>
                        <option value="UT">UT</option>
                        <option value="VT">VT</option>
                        <option value="VA">VA</option>
                        <option value="WA">WA</option>
                        <option value="WI">WI</option>
                        <option value="WY">WY</option>
                    </select><br/>
                    <span>Start Time:&nbsp;</span><select id="showStartYearSelect" onchange="changeMonthOrYear('start');">
                        <option value="2024">2024</option>
                        <option value="2023">2023</option>
                        <option value="2022">2022</option>
                        <option value="2021">2021</option>
                        <option value="2020">2020</option>
                        <option value="2019">2019</option>
                        <option value="2018">2018</option>
                        <option value="2017">2017</option>
                        <option value="2016">2016</option>
                        <option value="2015">2015</option>
                        <option value="2014">2014</option>
                        <option value="2013">2013</option>
                        <option value="2012">2012</option>
                        <option value="2011">2011</option>
                        <option value="2010">2010</option>
                        <option value="2009">2009</option>
                        <option value="2008">2008</option>
                        <option value="2007">2007</option>
                        <option value="2006">2006</option>
                        <option value="2005">2005</option>
                        <option value="2004">2004</option>
                        <option value="2003">2003</option>
                        <option value="2002">2002</option>
                        <option value="2001">2001</option>
                        <option value="2000">2000</option>
                        <option value="1999">1999</option>
                        <option value="1998">1998</option>
                        <option value="1997">1997</option>
                        <option value="1996">1996</option>
                        <option value="1995">1995</option>
                        <option value="1994">1994</option>
                    </select><select id="showStartMonthSelect" onchange="changeMonthOrYear('start');">
                        <option value="1">January</option>
                        <option value="2">Febuary</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select><select id="showStartDaySelect">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="10">10</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                    </select>
                    <select id="showStartHourSelect">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                    </select><select id="showStartMinuteSelect">
                        <option value="00">00</option>
                        <option value="05">05</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="25">25</option>
                        <option value="30">30</option>
                        <option value="35">35</option>
                        <option value="40">40</option>
                        <option value="45">45</option>
                        <option value="50">50</option>
                        <option value="55">55</option>
                    </select>
                    <br/>
                    <span>End Time:</span><select id="showEndHourSelect" style="margin-left:218px;">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                    </select><select id="showEndMinuteSelect">
                        <option value="00">00</option>
                        <option value="05">05</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="25">25</option>
                        <option value="30">30</option>
                        <option value="35">35</option>
                        <option value="40">40</option>
                        <option value="45">45</option>
                        <option value="50">50</option>
                        <option value="55">55</option>
                    </select><br/>
                    <input type="button" value="Delete Event" onclick="deleteEvent(this.parentNode);"/><input type="button" class="closeEventBox" onclick="this.parentNode.style.display = 'none'" value="Close"/><br/>
                </div>
                <!--<input type="button" onclick="getDays(2014,12);"/>-->
            </form>
        </div>
    </body>
</html>
