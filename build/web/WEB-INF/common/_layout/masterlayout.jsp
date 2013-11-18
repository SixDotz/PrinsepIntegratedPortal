<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@page import="org.apache.commons.lang3.time.DateFormatUtils"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<!DOCTYPE html>
<%@page import="java.util.*" %>
<%@page import="app.model.*" %>
<%@page import="java.io.*" %>
<%@page import="java.text.*" %>
<s:layout-definition>
    <html lang="en">
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <title>
                <s:layout-component name="TitleContent" />
            </title>

            <link href="/favicon.ico" rel="shortcut icon" type="image/x-icon" />

            <!--Stylesheets-->
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/bootstrap.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/kendo.common.min.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/kendo.bootstrap.min.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/site.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/notificationicon.css'/>
            <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Oswald'/>

            <!--Scripts-->
            <script src="${pageContext.request.contextPath}/scripts/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/scripts/jquery.isloading.min.js"></script>  
            <script src="${pageContext.request.contextPath}/scripts/kendo.web.min.js"></script>
            <script src="${pageContext.request.contextPath}/scripts/modernizr-2.6.2.js"></script>            

            <!--Custom Scripts-->
            <script type="text/javascript">
                function redirectNotif(url){
                    //alert(url);
                    window.location = url;
                }
            </script>
            <style type="text/css">
                .k-tooltip-content {
                    vertical-align: middle;
                }
                .k-tooltip-content img,
                .k-tooltip-content p {
                    float: left;
                }
                .k-tooltip-content p {
                    font-size: 1.4em;
                    padding: 20px;
                    width: 160px;
                    text-align: center;
                }
            </style>
            <s:layout-component name="html_header" /> 
        </head>
        <body>
            <%
                int noOfNewNotifications = 0;
                
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a");
                User user = (User) session.getAttribute("user");
                
                if (user != null) {
                    StringBuilder sb = new StringBuilder();
                    StringBuilder sb2 = new StringBuilder();
                    ArrayList<Notification> notifications = (ArrayList<Notification>) (session.getServletContext().getAttribute("NOTIFICATIONS"));

                    if (notifications != null && !notifications.isEmpty()) {
                        sb.append("<div>");
                        sb.append("<h5 align='center'>Your recent notifications</h5>");

                        Iterator<Notification> it = notifications.iterator();
                        
                        HashMap<Integer, User> userHash = (HashMap<Integer, User>) session.getAttribute("USERHASH");

                        while (it.hasNext()) {
                            sb.append("<hr style='border-top:0.5px' />");
                            Notification notification = it.next();
                            Date createdDateTime = notification.getCreatedDateTime();
                            String bDateFormat = formatter.format(createdDateTime);
                            
                            sb.append("<div align='left' class='notificationLnk'");
                            sb.append(" onClick='redirectNotif(&quot;");
                            sb.append(notification.getRedirectUrl());
                            sb.append("&quot;);'");
                            sb.append("'");
                            sb.append(" style='cursor: pointer; padding-left:10px;");
                            
                            if (notification.isRead() == false) {
                                noOfNewNotifications++;
                                sb.append(" color:black; font-weight:bold; font-size:14px;'>");
                            } else {
                                sb.append("'>");
                            }

                            sb.append("<img class='img-circle' style='float: left;' align='left' src='" + userHash.get(notification.getSentByUser().getUserID()).getFacebookProfilePhotoUrl() + "' alt='' height='30px' width='30px'/>");
                            sb.append("<div>");
                            sb.append(notification.getDescription() + "</br>"); 
                            sb.append("<b style='font-size: 11px;'><i class='icon-time'></i> Posted on " + bDateFormat + "</b>");
                            sb.append("</div>");
                            sb.append("</div>");

                            //Build string of notification id
                            sb2.append(notification.getNotificationID() + ",");
                        }

                        sb.append("</div>");
                        sb.append("<hr />");
                        sb.append("<a href='" + request.getContextPath() + "/Notification.action'>See All</a>");
                    }
                    else{
                        sb.append("<h5>You have no notifications.</h5>");
                    }
            %>
            <script type="text/javascript">
                function onShow(e) {
                    var action = "${pageContext.request.contextPath}/Notification.action?read=<%=sb2.toString()%>&markNotificationsRead=";

                    //Hide little unread notification count when update is successful
                    $("#noti_Container").css("display", "none");

                    //Call actionbean to update notification read
                    $.post(action, function(data) {

                    });
                }

                $(document).ready(function() {
                    $("#lnkNotif").kendoTooltip({
                        width: 350,
                        position: "bottom",
                        filter: "a",
                        autoHide: false,
                        showOn: "click",
                        show: onShow,
                        animation: {
                            open: {
                                effects: "fade:in",
                                duration: 500
                            },
                            close: {
                                effects: "fade:out",
                                duration: 300
                            }
                        },
                        content: "<%=sb.toString()%>"
                    });

                    $("#alnkNotif").bind("onClick", function() {
                        return false;
                    });
                });
            </script>
            <%
                }
            %>
            <div class="navbar navbar navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="${pageContext.request.contextPath}" class='brand' style="z-index: -1;">
                            <img src="${pageContext.request.contextPath}/content/images/logo.png" alt="SMU Hostel @ Prinsep"/>                            
                        </a> 
                        <div class="nav-collapse collapse">
                            <jsp:include page="/WEB-INF/common/_layout/_login.jsp" />                            
                        </div>
                        <br/>
                        <div style="padding-top: 40px;">                            
                            <ul class="nav" style="font-size:18pt; font-family: 'Oswald'; ">
                                <li><a href="${pageContext.request.contextPath}">Home</a></li>
                                <li id="lnkEvents"><a href="${pageContext.request.contextPath}/HostelEvents.action">Hostel Events</a></li>
                                <li id="lnkEvents"><a href="${pageContext.request.contextPath}/LetsGoEvents.action">Let's Go Outings</a></li>
                                    <%
                                        if (session.getAttribute("user") != null) {
                                    %>
                                <li id="lnkNotif"><a href="#">Notifications</a></li>    
                                    <%
                                        if (noOfNewNotifications > 0) {
                                    %>
                                <div id ="noti_Container" style="position: absolute; top:5px; left: 565px; color: red; font-size: 18px; font-weight:bold;"> 
                                    <div class="noti_bubble"><%=noOfNewNotifications%></div>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" style="padding-top: 60px;">
                <s:layout-component name="FeaturedContent" />  
                <section class="content-wrapper main-content clear-fix">
                    <s:layout-component name="MainContent" /> 
                </section>
                <hr />
                <footer>
                    <p>&copy; 2013 - Singapore Management University Hostel @ Prinsep</p>
                     <%=new Date()%>
                </footer>
            </div>
        </body>
    </html>    
</s:layout-definition>