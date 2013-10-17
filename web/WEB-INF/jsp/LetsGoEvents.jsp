<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>

<%@page import="java.util.ArrayList" %>
<%@page import="app.model.*" %>

<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep - EVENTS      
    </s:layout-component>
    <s:layout-component name="html_header">
        <script type="text/javascript">
            $(document).ready(function(){
                $("#btnCreateLetsGo").bind("click", function() {
                    var dialog = windCreateEvent.data("kendoWindow");
                    dialog.toFront();
                    dialog.open();
                });
                
                var windCreateEvent = $("#windCreateEvent").kendoWindow({
                    title: "Create New Let's Go Event",
                    modal: true,
                    pinned: true,
                    position: { top: 50, left:350 }
                });
                
                $(".k-window").hide();                               
                $(".k-overlay").hide();

                $("#subnavigation").children(".btn").click(function(){
                    //Reset CSS to unselected for all elements
                    $("#subnavigation button").removeClass('btn-info');
                    $("#subnavigation i").removeClass('icon-white');
                    
                    //Toggle Css Class as per selected button
                    $(this).addClass('btn-info');
                    $(this).children("i").addClass('icon-white');
                    
                    //Show hide / filter recent event list
                    var btnId = $(this).attr("id");
                    if(btnId != "btnAllEvents"){                                               
                        //Hide Recent Events segment
                        $("#divRecent").hide(500);
                    }
                    else{
                        $("#divRecent").show(500);
                    }
                    
                    //Filter 2nd Section
                    switch(btnId){
                        case "btnAllEvents":
                            //Change title
                            $("#FullListHeader").html("All Events");
                            
                            //Show all events
                            $("#divFullListing").children(".event").show(500);
                            break;
                    
                        case "btnInvites":
                            //Change title
                            $("#FullListHeader").html("My Invites");
                            
                            //Reset (hide all first)
                            $("#divFullListing").children(".event").hide(500);
                            
                            //Show div marked with invited class
                            $("#divFullListing").children(".invited").show(500);
                            break;

                        case "btnMyEvents":
                            //Change title
                            $("#FullListHeader").html("My Initiated Outing");
                            
                            //Reset (hide all first)
                            $("#divFullListing").children(".event").hide(500);
                            
                            //Show div marked with MyEvent class
                            $("#divFullListing").children(".myEvent").show(500);
                            break;

                        case "btnAttending":
                            //Change title
                            $("#FullListHeader").html("Let's Go Outings I'm Attending");
                            
                            //Reset (hide all first)
                            $("#divFullListing").children(".event").hide(500);
                            
                            //Show div marked with attending class
                            $("#divFullListing").children(".attending").show(500);
                            break;
                    }
                });
                
                $("#recEvent1").kendoTooltip({
                    width: 150,
                        
                    position: "right",
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
                    content:"<div>\n\
                    <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person A.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Mary Tay</h5><br/>\n\
                    <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person B.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Tommy Lee</h5><br/>\n\
                    <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person C.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Jin Wen</h5><br/>\n\
                    </div>"
                    });
                    
                 $("#btnJoin1").bind("click", function(){
                     
                 });
                 
                 $("#btnJoin2").bind("click", function(){
                     
                 });
                 
                 $("#btnViewDetails1").bind("click", function(){
                     //window.location = "${pageContext.request.contextPath}/LetsGoEventsDetails.action";
                 });
                 
                 $("#btnViewDetails2").bind("click", function(){
                     //window.location = "${pageContext.request.contextPath}/LetsGoEventsDetails.action";
                 });

                 $("#recEvent1").bind("click", function() {
                    return false;
                 });
                 
                 $("#recEvent2").bind("click", function() {
                    return false;
                 });
                    
                 $("#recEvent2").kendoTooltip({
                        width: 150,
                        
                        position: "right",
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
                        content:"<div>\n\
                        <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person A.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Mary Tay</h5><br/>\n\
                        <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person B.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Tommy Lee</h5><br/>\n\
                        <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person C.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Jin Wen</h5><br/>\n\
                        </div>"
                    });
            });
        </script>
        <style type="text/css">
            .formlblpad{
                margin-top: 15px;
            }
            
            .formctrlpad input{
                height: 30px;
            }
        </style>
    </s:layout-component>
    <s:layout-component name="FeaturedContent">         
        <div class="topdiv" >            
            <div id="subnavigation" class="btn-group">  
                <button id="btnAllEvents" class="btn btn-info"><i class="icon-calendar icon-white"></i> All Events</button>
                <button id="btnInvites" class="btn"><i class="icon-user"></i> Invites</button>
                <button id="btnMyEvents" class="btn"><i class="icon-calendar"></i> My Initiated Outings</button>
                <button id="btnAttending" class="btn"><i class="icon-bell"></i> Attending</button>
            </div>
            <div style="float:right;">
                <button id="btnCreateLetsGo" class="btn btn-primary"><i class="icon-plus icon-white"></i> Create Let's Go Event</button>
            </div>
        </div>
        <div id="windCreateEvent">
            <jsp:include page="/WEB-INF/jsp/LetsGoEvents_NewLetsGo.jsp" />
        </div>
        <hr/>
    </s:layout-component>
    <s:layout-component name="MainContent">
        <%
            ArrayList<LetsGoEvent> events = (ArrayList<LetsGoEvent>)session.getServletContext().getAttribute("EVENTS");
            User user = (User)session.getServletContext().getAttribute("user");
        %>
        <div class="row">
            <div class="span12" style="margin-left: 20px">
                <div id="divRecent">
                    <div>
                        <h3>Recent Events Created</h3>
                    </div>
                    <%
                        //Populate the most recent events here
                        for(LetsGoEvent event : events){
                            //if(event.)
                        }
                    %>
                    <div class="hero-unit">                        
                        <div>
                            <h4>Percy Jackson Movie Outing</h4>
                            <div>
                                <img src="${pageContext.request.contextPath}/content/images/letsgoevents/percyjackson.jpg" alt="" height='110px' width='110px' style="float:left; padding-right: 15px"/>
                                <div id="recEvent1" style="float:left;">
                                    <p style="font-size: 10pt">
                                        By Amy Poh
                                        <br/>20th Sept 2013, 7:00pm
                                        <br/>The Cathay 
                                        <br/><a href="#">3 going</a>
                                    </p>
                                    <button id="btnMyEvents" class="btn btn-primary btn-small"><i class="icon-plus icon-white"></i> Join Event</button>
                                    <button id="btnViewDetails1" class="btn btn-small">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="hero-unit">                        
                        <div>
                            <h4>Percy Jackson Movie Outing</h4>
                            <div>
                                <img src="${pageContext.request.contextPath}/content/images/letsgoevents/percyjackson.jpg" alt="" height='110px' width='110px' style="float:left; padding-right: 15px"/>
                                <div id="recEvent1" style="float:left;">
                                    <p style="font-size: 10pt">
                                        By Amy Poh
                                        <br/>20th Sept 2013, 7:00pm
                                        <br/>The Cathay 
                                        <br/><a href="#">3 going</a>
                                    </p>
                                    <button id="btnMyEvents" class="btn btn-primary btn-small"><i class="icon-plus icon-white"></i> Join Event</button>
                                    <button id="btnViewDetails1" class="btn btn-small">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                    <hr/>
                </div>
                <div style="width:100%">
                    <h3 id="FullListHeader" style="float: left;">All Events</h3>
                    <div style="float: right; padding-right: 80px">
                        <h5 style="padding:0 0 0 0; margin: 0 0 0 0" >Year:</h5>
                        <select id="year" style="width:80px;">
                            <option>2013</option>
                            <option>2012</option>
                            <option>2011</option>
                            <option>2010</option>
                        </select> 
                    </div>
                    <div style="float: right; padding-right: 10px">
                        <h5 style="padding:0 0 0 0; margin: 0 0 0 0" >Month:</h5>
                        <select id="year" style="width:80px;">
                            <option>Jan</option>
                            <option>Feb</option>
                            <option>Mar</option>
                            <option>Apr</option>
                            <option>May</option>
                            <option>Jun</option>
                            <option>Jul</option>
                            <option>Aug</option>
                            <option>Sep</option>
                            <option>Oct</option>
                            <option>Nov</option>
                            <option>Dec</option>
                        </select> 
                    </div>
                    <div style="float: right; padding-right: 10px">
                        <h5 style="padding:0 0 0 0; margin: 0 0 0 0" >Category:</h5>
                        <select id="year" style="width:100px;">
                            <option>All</option>
                            <option>BBQ</option>
                            <option>Camps</option>
                            <option>Sports</option>
                        </select> 
                    </div>
                </div>
                <%
                    String css = null;
                    LetsGoEventAttendee attendee = null;

                    //Populate the full listing here
                    for(LetsGoEvent event : events){
                        css = "event ";
                        /*
                        if(event.getEventOrganizer().getUserID() == user.getUserID()){
                            css += "myEvent ";
                        }
                        else{
                            attendee = event.getInvitees().get(user.getUserID());

                            if(attendee != null){
                                css += "invited ";

                                if(attendee.getRsvpStatus() == "Going"){
                                    css += "attending ";
                                }
                            }
                        }
                        */
                %>
                <div id="divFullListing" class="hero-unit event attending">                   
                    <h4><%=event.getTitle()%></h4>
                    <div>
                        <img src="${pageContext.request.contextPath}/content/images/letsgoevents/percyjackson.jpg" alt="" height='110px' width='110px' style="float:left; padding-right: 15px"/>
                        <div id="recEvent2" style="float:left;">
                            <p style="font-size: 10pt">
                                By Amy Poh
                                <br/><%=event.getEventStartDateTime() %>
                                <br/><%=event.getVenue() %>
                                <br/><a href="#">3 going</a>
                            </p>
                            <button id="btnMyEvents" class="btn btn-primary btn-small"><i class="icon-plus icon-white"></i> Join Event</button>
                            <button id="btnViewDetails2" class="btn btn-small">View Details</button>
                        </div>
                    </div>
                </div>
                <%            
                        }
                %>
            </div>
        </div>
    </s:layout-component>
</s:layout-render>