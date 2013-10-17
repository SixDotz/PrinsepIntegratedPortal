<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<!DOCTYPE html>

<s:layout-definition>
    <html lang="en">
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <title>
                <s:layout-component name="TitleContent" />
            </title>

            <link href="/favicon.ico" rel="shortcut icon" type="image/x-icon" />

            <meta name="viewport" content="width=device-width" />

            <!--Stylesheets-->
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/bootstrap.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/kendo.common.min.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/kendo.bootstrap.min.css'/>
            <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/content/css/site.css'/>
            <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Oswald'/>

            <!--Scripts-->
            <script src="${pageContext.request.contextPath}/scripts/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/scripts/kendo.web.min.js"></script>
            <script src="${pageContext.request.contextPath}/scripts/modernizr-2.6.2.js"></script>            
            
            <!--Custom Scripts-->
            <script type="text/javascript">
                $(document).ready(function() {
                    $("#lnkNotif").kendoTooltip({
                        width: 280,
                        
                        position: "bottom",
                        filter: "a",
                        autoHide: false,
                        showOn: "click",
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
                        content: "<img style='float: left; padding-right: 10px;' src='${pageContext.request.contextPath}/content/images/profile/tommy.jpeg' alt='' height='50px' width='50px'/><div style='font-size: 9pt; text-align:left;'><b>Tommy Lee</b> is going to the Soccer match.<br/><br/>Posted 15 minutes ago.</div><br/><div style='padding-bottom:2px; margin-top:5px; padding-top:5px; border-top-width:1px; border-top-style:solid; border-top-color:#01175b;'><a href='${pageContext.request.contextPath}/Notification.action'>See All</a></div>"
                    });
                    
                    $("#lnkNotif").bind("click", function() {
                        return false;
                     });
                });
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
                    text-align: left;
                }
            </style>
            <s:layout-component name="html_header" /> 
        </head>
        <body>
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
                                    if(session.getAttribute("user") != null){
                                %>
                                <li id="lnkNotif"><a href="#">Notifications</a></li>
                                <%
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
                </footer>
            </div>
        </body>
    </html>    
</s:layout-definition>