/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var length;
window.onload = function () {
    document.forms[0].reset();
    var today = new Date();
    var month = today.getMonth() + 1; //January is 0!
    var year = today.getFullYear();
    document.getElementById("backToday").setAttribute("onclick", "getDays(" + year + "," + month + ");");
    getDays(year, month);
};
function getXMLHttpRequest() {
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
}
function getDays(year, month) {
    clearHighlight();
    var xmlhttp = getXMLHttpRequest();
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
        {
            document.getElementById("yearLabel").innerHTML = year;
            switch (month) {
                case 1:
                    document.getElementById("monthLabel").innerHTML = "January";
                    document.getElementById("monthLabel").className = "1";
                    break;
                case 2:
                    document.getElementById("monthLabel").innerHTML = "Febuary";
                    document.getElementById("monthLabel").className = "2";
                    break;
                case 3:
                    document.getElementById("monthLabel").innerHTML = "March";
                    document.getElementById("monthLabel").className = "3";
                    break;
                case 4:
                    document.getElementById("monthLabel").innerHTML = "April";
                    document.getElementById("monthLabel").className = "4";
                    break;
                case 5:
                    document.getElementById("monthLabel").innerHTML = "May";
                    document.getElementById("monthLabel").className = "5";
                    break;
                case 6:
                    document.getElementById("monthLabel").innerHTML = "June";
                    document.getElementById("monthLabel").className = "6";
                    break;
                case 7:
                    document.getElementById("monthLabel").innerHTML = "July";
                    document.getElementById("monthLabel").className = "7";
                    break;
                case 8:
                    document.getElementById("monthLabel").innerHTML = "August";
                    document.getElementById("monthLabel").className = "8";
                    break;
                case 9:
                    document.getElementById("monthLabel").innerHTML = "September";
                    document.getElementById("monthLabel").className = "9";
                    break;
                case 10:
                    document.getElementById("monthLabel").innerHTML = "October";
                    document.getElementById("monthLabel").className = "10";
                    break;
                case 11:
                    document.getElementById("monthLabel").innerHTML = "November";
                    document.getElementById("monthLabel").className = "11";
                    break;
                case 12:
                    document.getElementById("monthLabel").innerHTML = "December";
                    document.getElementById("monthLabel").className = "12";
                    break;
                default:
                    alert("wrong month");
                    break;
            }
            document.getElementById("backOneYear").setAttribute("onclick", "getDays(" + (year - 1) + "," + month + ")");
            if (month !== 1)
                document.getElementById("backOneMonth").setAttribute("onclick", "getDays(" + year + "," + (month - 1) + ")");
            else
                document.getElementById("backOneMonth").setAttribute("onclick", "getDays(" + (year - 1) + "," + 12 + ")");
            if (month !== 12)
                document.getElementById("ForwardOneMonth").setAttribute("onclick", "getDays(" + year + "," + (month + 1) + ")");
            else
                document.getElementById("ForwardOneMonth").setAttribute("onclick", "getDays(" + (year + 1) + "," + 1 + ")");
            document.getElementById("ForwardOneYear").setAttribute("onclick", "getDays(" + (year + 1) + "," + month + ")");
            var xmlDoc = xmlhttp.responseXML;
            var x = xmlDoc.getElementsByTagName("dayOfFirstDay");
            dayOfFirstDay = x[0].childNodes[0].nodeValue;
            x = xmlDoc.getElementsByTagName("numberOfLastDay");
            var numberOfLastDay = x[0].childNodes[0].nodeValue;
            x = xmlDoc.getElementsByTagName("numberOfLastDayOfLastMonth");
            var numberOfLastDayOfLastMonth = x[0].childNodes[0].nodeValue;
            setDay(dayOfFirstDay, numberOfLastDay, numberOfLastDayOfLastMonth, month);
            getEvents();
        }
    };
    xmlhttp.open("GET", "getDays?month=" + month + "&year=" + year, false);
    xmlhttp.send();
}
function setDay(dayOfFirstDay, numberOfLastDay, numberOfLastDayOfLastMonth, month) {
    var i = 1;
    var j = 1;
    var dayNumber = 1;
    var year = parseInt(document.getElementById("yearLabel").innerHTML);
    var today = new Date();

    //set day into calendar
    for (i = 1; i <= 6; i++) {
        if (j > 7) {
            j = 1;
        }
        if (i === 6) {
            if (dayNumber > numberOfLastDay) {
                document.getElementById("week6").style.display = "none";
            }
            else {
                document.getElementById("week6").style.display = "table-row";
            }
        }
        for (; j <= 7; j++) {
            if (i === 1 && j < dayOfFirstDay) {//days int previous month
                document.getElementById("day" + i + j).firstChild.innerHTML = numberOfLastDayOfLastMonth - (dayOfFirstDay - j) + 1;
                document.getElementById("day" + i + j).className = "td notThisMonth";
                document.getElementById("day" + i + j).title = "move back one month";
                if (month === 1)
                    document.getElementById("day" + i + j).setAttribute("onclick", "getDays(" + (year - 1) + ",12);");
                else
                    document.getElementById("day" + i + j).setAttribute("onclick", "getDays(" + year + "," + (month - 1) + ");");
            }
            else {
                if (dayNumber <= numberOfLastDay) {//days in this month
                    document.getElementById("day" + i + j).firstChild.innerHTML = dayNumber;
                    document.getElementById("day" + i + j).className = "td ThisMonth";
                    document.getElementById("day" + i + j).setAttribute("onclick", "highlightDay(" + dayNumber + ");");
                    document.getElementById("day" + i + j).title = "";
                    if (today.getFullYear() === year && (today.getMonth() + 1) === month && dayNumber === today.getDate()) {
                        highlightDay(today.getDate());
                        //document.getElementById("day" + i + j).style.backgroundColor = "#e5ecf0";
                    }
                }
                else {//days in next month
                    document.getElementById("day" + i + j).firstChild.innerHTML = dayNumber - numberOfLastDay;
                    document.getElementById("day" + i + j).className = "td notThisMonth";
                    document.getElementById("day" + i + j).title = "move forward one month";
                    if (month === 12)
                        document.getElementById("day" + i + j).setAttribute("onclick", "getDays(" + (year + 1) + ",1);");
                    else
                        document.getElementById("day" + i + j).setAttribute("onclick", "getDays(" + year + "," + (month + 1) + ");");
                }
                dayNumber++;
            }
        }
    }
}
function highlightDay(day) {
    var year = parseInt(document.getElementById("yearLabel").innerHTML);
    var month = parseInt(document.getElementById("monthLabel").className);
    var today = new Date();
    var nowHour = today.getHours();
    var nowMinute = today.getMinutes();
    //if (todayYear === year && todayMonth === month) {
    for (var a = document.getElementById("startYearSelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && parseInt(a.value) === year) {
            a.selected = "selected";
            break;
        }
    }
    for (var a = document.getElementById("startMonthSelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && parseInt(a.value) === month) {
            a.selected = "selected";
            break;
        }
    }
    for (var a = document.getElementById("startDaySelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && parseInt(a.value) === day) {
            a.selected = "selected";
            break;
        }
    }
    for (var a = document.getElementById("startHourSelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && parseInt(a.value) === nowHour) {
            a.selected = "selected";
            break;
        }
    }
    for (var a = document.getElementById("startMinuteSelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && Math.abs(parseInt(a.value) - nowMinute) <= 5 && Math.abs(parseInt(a.value) - nowMinute + 5) <= 5) {
            a.selected = "selected";
            break;
        }
    }
    /*for (var a = document.getElementById("endYearSelect").firstChild; a !== null; a = a.nextSibling) {
     if (a.nodeType === 1 && parseInt(a.value) === year) {
     a.selected = "selected";
     break;
     }
     }
     for (var a = document.getElementById("endMonthSelect").firstChild; a !== null; a = a.nextSibling) {
     if (a.nodeType === 1 && parseInt(a.value) === month) {
     a.selected = "selected";
     break;
     }
     }
     for (var a = document.getElementById("endDaySelect").firstChild; a !== null; a = a.nextSibling) {
     if (a.nodeType === 1 && parseInt(a.value) === day) {
     a.selected = "selected";
     break;
     }
     }*/
    for (var a = document.getElementById("endHourSelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && parseInt(a.value) === nowHour) {
            if (nowHour === 23)
                a.selected = "selected";
            else
                a.nextSibling.nextSibling.selected = "selected";
            break;
        }
    }
    for (var a = document.getElementById("endMinuteSelect").firstChild; a !== null; a = a.nextSibling) {
        if (a.nodeType === 1 && Math.abs(parseInt(a.value) - nowMinute) <= 5 && Math.abs(parseInt(a.value) - nowMinute + 5) <= 5) {
            a.selected = "selected";
            break;
        }
    }
    for (var i = 1; i <= 6; i++) {
        for (var j = 1; j <= 7; j++) {
            if (parseInt(document.getElementById("day" + i + j).firstChild.innerHTML) === day && document.getElementById("day" + i + j).className === "td ThisMonth")
                highlight(i, j);
        }
    }
}
function highlight(i, j) {
    clearHighlight();
    document.getElementById("day" + i + j).className += " selected";
}
function clearHighlight() {
    for (var i = 1; i <= 6; i++)
        for (var j = 1; j <= 7; j++) {
            if (document.getElementById("day" + i + j).className.indexOf("notThisMonth") > 0)
                document.getElementById("day" + i + j).className = "td notThisMonth";
            else
                document.getElementById("day" + i + j).className = "td ThisMonth";
        }
}
function showAddEventBox() {
    document.getElementById("addEventBox").style.display = "block";
}

//change days options if changed year or month
function changeMonthOrYear(string) {
    var yearSelect = document.getElementById(string + "YearSelect");
    var year = yearSelect.options[yearSelect.selectedIndex].value;
    var monthSelect = document.getElementById(string + "MonthSelect");
    var month = monthSelect.options[monthSelect.selectedIndex].text;
    var lastDay = document.getElementById(string + "DaySelect").lastChild.previousSibling.value;
    var correctDay = calculateDay(year, month);
    var originalDay = parseInt(lastDay);
    if (originalDay < correctDay) {
        for (var i = 1; i <= (correctDay - originalDay); i++) {
            var optionNode = document.createElement("option");
            optionNode.value = originalDay + i;
            optionNode.innerHTML = originalDay + i;
            document.getElementById(string + "DaySelect").appendChild(optionNode);
        }
    }
    else if (originalDay > correctDay) {
        for (var i = 1; i <= (originalDay - correctDay); i++) {
            var a = document.getElementById(string + "DaySelect").lastChild;
            while (a.nodeType !== 1)
                a = a.previousSibling;
            document.getElementById(string + "DaySelect").removeChild(a);
        }
    }
}
function calculateDay(year, month) {
    var result = 0;
    if (month === "January" || month === "March" || month === "May" || month === "July" || month === "August" || month === "October" || month === "December")
        result = 31;
    else if (month === "April" || month === "June" || month === "September" || month === "November")
        result = 30;
    else if (month === "Febuary") {
        if (year % 4 === 0 && year % 100 !== 0 || year % 400 === 0)
            result = 29;
        else
            result = 28;
    }
    else {
        alert("What month?");
        return -1;
    }
    return result;
}

function getCity(state, id) {
    var xmlhttp = getXMLHttpRequest();
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
        {
            document.getElementById(id).innerHTML = "";
            var parser = new DOMParser();
            var xmlDoc = parser.parseFromString(xmlhttp.responseText, "application/xml");
            //var xmlDoc = xmlhttp.responseXML;
            var x = xmlDoc.getElementsByTagName("city");
            for (var i = 0; i < x.length; i++) {
                var optionNode = document.createElement("option");
                optionNode.value = x[i].childNodes[0].nodeValue;
                optionNode.innerHTML = x[i].childNodes[0].nodeValue;
                document.getElementById(id).appendChild(optionNode);
            }
        }
    };
    xmlhttp.open("GET", "getLocation?state=" + state, false);
    xmlhttp.send();
}
function addEvent() {
    //start validating
    var eventTitle = document.getElementById("eventTitle").value;
    if (!document.getElementById("citySelect").hasChildNodes()) {
        alert("please provide all information.");
        retrun;
    }
    var city = document.getElementById("citySelect").options[document.getElementById("citySelect").selectedIndex].value;
    var state = document.getElementById("stateSelect").options[document.getElementById("stateSelect").selectedIndex].value;
    if (eventTitle === "" || city === "" || state === "") {
        alert("please provide all information.");
        retrun;
    }
    var startYear = parseInt(document.getElementById("startYearSelect").options[document.getElementById("startYearSelect").selectedIndex].value);
    var startMonth = parseInt(document.getElementById("startMonthSelect").options[document.getElementById("startMonthSelect").selectedIndex].value);
    var startDay = parseInt(document.getElementById("startDaySelect").options[document.getElementById("startDaySelect").selectedIndex].value);
    var startHour = parseInt(document.getElementById("startHourSelect").options[document.getElementById("startHourSelect").selectedIndex].value);
    var startMinute = parseInt(document.getElementById("startMinuteSelect").options[document.getElementById("startMinuteSelect").selectedIndex].value);
    //var endYear = parseInt(document.getElementById("endYearSelect").options[document.getElementById("endYearSelect").selectedIndex].value);
    //var endMonth = parseInt(document.getElementById("endMonthSelect").options[document.getElementById("endMonthSelect").selectedIndex].value);
    //var endDay = parseInt(document.getElementById("endDaySelect").options[document.getElementById("endDaySelect").selectedIndex].value);
    var endHour = parseInt(document.getElementById("endHourSelect").options[document.getElementById("endHourSelect").selectedIndex].value);
    var endMinute = parseInt(document.getElementById("endMinuteSelect").options[document.getElementById("endMinuteSelect").selectedIndex].value);
    var endYear = startYear;
    var endMonth = startMonth;
    var endDay = startDay;
    var startDate = new Date();
    var endDate = new Date();
    startDate.setFullYear(startYear);
    startDate.setMonth(startMonth);
    startDate.setDate(startDay);
    startDate.setHours(startHour);
    startDate.setMinutes(startMinute);
    endDate.setFullYear(endYear);
    endDate.setMonth(endMonth);
    endDate.setDate(endDay);
    endDate.setHours(endHour);
    endDate.setMinutes(endMinute);
    if (startDate >= endDate) {
        alert("End Date must be after Start Date.");
        return;
    }
    //end validating
    var xmlhttp = getXMLHttpRequest();
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
        {
            alert(xmlhttp.responseText);
            getEvents();
        }
    };
    xmlhttp.open("POST", "addEvent", false);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("eventTitle=" + eventTitle + "&city=" + city + "&state=" + state + "&startYear=" + startYear + "&startMonth=" + startMonth + "&startDay="
            + startDay + "&startHour=" + startHour + "&startMinute=" + startMinute + "&endYear=" + endYear + "&endMonth=" + endMonth + "&endDay=" + endDay
            + "&endHour=" + endHour + "&endMinute=" + endMinute);
}
function getEvents() {
    for (var i = 1; i <= 6; i++)
        for (var j = 1; j <= 7; j++)
            document.getElementById("day" + i + j).lastChild.innerHTML = "";
    document.getElementById("showEventBoxList").innerHTML = "";
    var xmlhttp = getXMLHttpRequest();
    var year = parseInt(document.getElementById("yearLabel").innerHTML);
    var month = parseInt(document.getElementById("monthLabel").className);
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
        {
            //alert(xmlhttp.responseText);
            var parser = new DOMParser();
            var xmlDoc = parser.parseFromString(xmlhttp.responseText, "application/xml");
            //var xmlDoc = xmlhttp.responseXML;

            var x = xmlDoc.getElementsByTagName("event");
            var count = 0;
            length = x.length;
            for (count = 0; count < x.length; count++) {
                var li = document.createElement("li");
                var p = document.createElement("p");
                p.innerHTML = x[count].childNodes[0].innerHTML;
                p.style.border = "1px solid";
                p.style.width = "80px";
                p.style.cursor = "pointer";
                p.setAttribute("onclick", "displayShowEventBox(" + count + ")");
                li.appendChild(p);
                var p = document.createElement("p");
                p.innerHTML = x[count].childNodes[8].innerHTML;
                p.style.display = "none";
                p.id = "eventid" + count;
                li.appendChild(p);
                var showEventBox = document.getElementById("showEventBox").cloneNode(true);
                //li.appendChild(showEventBox);
                document.getElementById("showEventBoxList").appendChild(showEventBox);
                showEventBox.id += count;
                //showEventBox.style.display = "block";
                showEventBox.className = "showEventBox";
                for (var child = showEventBox.firstChild; child !== null; child = child.nextSibling) {
                    if (child.nodeType === 1 && child.id !== null) {
                        child.id += count;
                    }
                }

                var day = parseInt(x[count].childNodes[3].innerHTML);
                for (var i = 1; i <= 6; i++)
                    for (var j = 1; j <= 7; j++) {
                        if (parseInt(document.getElementById("day" + i + j).firstChild.innerHTML) === day
                                && (document.getElementById("day" + i + j).className === "td ThisMonth"
                                        || document.getElementById("day" + i + j).className === "td ThisMonth selected")) {
                            document.getElementById("day" + i + j).lastChild.appendChild(li);
                            for (var a = document.getElementById("showStateSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && a.value === x[count].childNodes[2].innerHTML) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            document.getElementById("showStateSelect" + count).setAttribute("onchange", "getCity(this.options[this.selectedIndex].value,'citySelect" + count + "'");
                            getCity(x[count].childNodes[2].innerHTML, "showCitySelect" + count);
                            document.getElementById("showEventTitle" + count).value = x[count].childNodes[0].innerHTML;
                            for (var a = document.getElementById("showCitySelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && a.value === x[count].childNodes[1].innerHTML) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showStartYearSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === year) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showStartMonthSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === month) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showStartDaySelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === day) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showStartHourSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === parseInt(x[count].childNodes[4].innerHTML)) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showStartMinuteSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === parseInt(x[count].childNodes[5].innerHTML)) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showEndHourSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === parseInt(x[count].childNodes[6].innerHTML)) {
                                    a.nextSibling.nextSibling.selected = "selected";
                                    break;
                                }
                            }
                            for (var a = document.getElementById("showEndMinuteSelect" + count).firstChild; a !== null; a = a.nextSibling) {
                                if (a.nodeType === 1 && parseInt(a.value) === parseInt(x[count].childNodes[7].innerHTML)) {
                                    a.selected = "selected";
                                    break;
                                }
                            }
                        }
                    }
            }
        }
    };
    xmlhttp.open("GET", "getEvents?month=" + month + "&year=" + year, false);
    xmlhttp.send();
}
function deleteEvent(showEventBox) {
    var count = showEventBox.id.substring(12);
    var xmlhttp = getXMLHttpRequest();
    var eventid = document.getElementById("eventid" + count).innerHTML;
    if (!confirm("Are you sure to delete event?"))
        return;
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
        {
            alert(xmlhttp.responseText);
            getEvents();
        }
    };

    xmlhttp.open("GET", "deleteEvent?eventid=" + eventid, false);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send();
}
function displayShowEventBox(count) {
    for (var i = 0; i < length; i++) {
        if (document.getElementById("showEventBox" + i) !== null)
            document.getElementById("showEventBox" + i).style.display = 'none';
        else
            break;
    }
    document.getElementById("showEventBox" + count).style.display = 'block';
}