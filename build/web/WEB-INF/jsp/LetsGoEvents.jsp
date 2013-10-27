<%@page import="org.apache.commons.lang3.time.DateFormatUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>

<%@page import="java.util.*" %>
<%@page import="app.model.*" %>
<%@page import="app.model.enumeration.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="org.apache.commons.lang3.time.DateFormatUtils"%>

<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep - EVENTS      
    </s:layout-component>
    <s:layout-component name="html_header">
        <script type="text/javascript">
            $(document).ready(function() {
                //Bind Create Lets Go event button to click event
                $("#btnCreateLetsGo").bind("click", function() {
                    $("#windCreateEvent").show();
                    var dialog = windCreateEvent.data("kendoWindow");
                    dialog.toFront();
                    dialog.open();
                });

                //Make form in window model popup
                var windCreateEvent = $("#windCreateEvent").kendoWindow({
                    title: "Create New Let's Go Outing",
                    modal: true,
                    pinned: true,
                    width: 465,
                    resizable: false,
                    visible: false,
                    position: {top: 50, left: 450},
                    close: function() {
                        //Reset the form
                        resetNewLetsGoForm();
                    }
                });

                //Fix for hiding model pop up Create event form on load
                $(".k-window").hide();
                $(".k-overlay").hide();

                //Toggle Sub navigation (show & hide events based on section selected)
                $("#subnavigation").children(".btn").click(function() {
                    //Reset CSS to unselected for all elements
                    $("#subnavigation button").removeClass('btn-info');
                    $("#subnavigation i").removeClass('icon-white');

                    //Toggle Css Class as per selected button
                    $(this).addClass('btn-info');
                    $(this).children("i").addClass('icon-white');

                    //Show hide / filter recent event list
                    var btnId = $(this).attr("id");
                    if (btnId != "btnAllEvents") {
                        //Hide Recent Events segment
                        $("#divRecent").hide(500);
                    }
                    else {
                        $("#divRecent").show(500);
                    }

                    //Filter 2nd Section
                    switch (btnId) {
                        case "btnAllEvents":
                            //Change title
                            $("#FullListHeader").html("All Events");

                            //Set hiddenfield value
                            $("#hfSubNav").val("hero-unit");
                            break;

                        case "btnInvites":
                            //Change title
                            $("#FullListHeader").html("My Invites");

                            //Set hiddenfield value
                            $("#hfSubNav").val("invited");
                            break;

                        case "btnMyEvents":
                            //Change title
                            $("#FullListHeader").html("My Initiated Outing");

                            //Set hiddenfield value
                            $("#hfSubNav").val("myEvent");
                            break;

                        case "btnAttending":
                            //Change title
                            $("#FullListHeader").html("Let's Go Outings I'm Attending");

                            //Set hiddenfield value
                            $("#hfSubNav").val("attending");
                            break;
                    }
                    // Filter where applicable
                    reFilter();
                });

                // Filter algorithm starts here
                function reFilter() {
                    //Reset (hide all first)
                    $("#divFullListing").children().hide();

                    //Get classes
                    var filter = $("#hfSubNav").val();
                    var year = $("#ddlYear option:selected").val();
                    var mth = $("#ddlMth option:selected").val();
                    var cat = $("#ddlCat option:selected").val();

                    if ($('#' + "ddlCat" + ' option:selected').text() == "All")
                        cat = "";

                    if ($('#' + "ddlMth" + ' option:selected').text() == "All")
                        mth = "";

                    if ($('#' + "ddlYear" + ' option:selected').text() == "All")
                        year = "";

                    //Show div marked with as per marked class
                    var classes = "." + filter + year + mth + cat;

                    $(classes).show(200);

                }
                //Section 2 DDL filters
                $(".ddlFilters").change(function() {
                    reFilter();
                });
                // Filter algorithm ends here

                //Tooltip
                $("#recEvent1").bind("click", function() {
                    return false;
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
                    content: "<div>\n\
                    <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person A.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Mary Tay</h5><br/>\n\
                    <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person B.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Tommy Lee</h5><br/>\n\
                    <img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person C.jpg' alt='' height='30px' width='30px'/><h5 align='center'>Jin Wen</h5><br/>\n\
                    </div>"
                });

                $(".JOIN").bind("click", function(e) {
                    //Prevent the default behavior of the button - form post
                    e.preventDefault();

                    //Save button in variable for later reference
                    var button = this;

                    //Get the url to post the form data to
                    var action = this.form.action + '?_eventName=' + this.name;

                    //Form data from the login form
                    var params = $(this.form).serialize();

                    var parent = $(button).attr("value");

                    //Post data to actionbean for processing
                    $.post(action, params, function(data) {
                        //Check return message and update ui
                        if (data == "success") {
                            if (button.name == "JOIN") {
                                //Change the button name
                                button.name = "UNJOIN";

                                //Change the button css, icon and text
                                $(button).addClass("btn-inverse");
                                $(button).removeClass("btn-primary");
                                $(button).html("<i class='icon-minus icon-white'></i> Unjoin");

                                $("#dAllEvents" + parent).addClass("attending");
                                $("#dRecEvents" + parent).addClass("attending");

                                //Change the details text
                                var originalText = $("#hdetails" + button.value).val();
                                var newText = originalText.replace("joined", "unjoined");
                                $("#hdetails" + button.value).val(newText);

                                //Change the rsvp status in the hidden field (to change: take from enum)
                                $("#hRsvpStatus" + button.value).val("<%=Enum_EventAttendee_Status.not_going.toString()%>");
                            }
                            else {
                                //Change the button name
                                button.name = "JOIN";

                                //Change the button css, icon and text
                                $(button).addClass("btn-primary");
                                $(button).removeClass("btn-inverse");
                                $(button).html("<i class='icon-plus icon-white'></i> Join");

                                //Remove attending css selector
                                $("#dAllEvents" + parent).removeClass("attending");
                                $("#dRecEvents" + parent).removeClass("attending");

                                //Change the details text
                                var originalText = $("#hdetails" + button.value).val();
                                var newText = originalText.replace("unjoined", "joined");
                                $("#hdetails" + button.value).val(newText);

                                //Change the rsvpstatus in the hidden field (to change: take from enum)
                                $("#hRsvpStatus" + button.value).val("<%=Enum_EventAttendee_Status.going.toString()%>");
                            }

                            reFilter();
                        }
                    });
                });
            });
        </script>        
    </s:layout-component>
    <s:layout-component name="FeaturedContent"> 
        <div class="topdiv" style="position: fixed; width: 862px; background-color: white; padding: 20px 76px 20px 0; top: 100px">            
            <div id="subnavigation" class="btn-group">  
                <button id="btnAllEvents" class="btn btn-info"><i class="icon-calendar icon-white"></i> All Outings</button>
                <%
                    if ((User) session.getAttribute("user") != null) {
                %>
                <button id="btnInvites" class="btn"><i class="icon-user"></i> Invites</button>
                <button id="btnMyEvents" class="btn"><i class="icon-calendar"></i> My Initiated Outings</button>
                <button id="btnAttending" class="btn"><i class="icon-bell"></i> Outings I Have Joined</button>
                <%
                    }
                %>
                <input id="hfSubNav" type="hidden" value="hero-unit"/>
            </div>
            <div style="float:right;">
                <button id="btnCreateLetsGo" class="btn btn-primary"><i class="icon-plus icon-white"></i> Create Let's Go Outing</button>
            </div>
        </div>
        <div id="windCreateEvent" class="borderlessWindow" style="display:none; padding-left:0; padding-top:0.58em; padding-right:0; padding-bottom:0;">
            <jsp:include page="/WEB-INF/jsp/LetsGoEvents_NewLetsGo.jsp" />
        </div>
        <hr/>
    </s:layout-component>
    <s:layout-component name="MainContent">
        <%
            ArrayList<LetsGoEvent> events = (ArrayList<LetsGoEvent>)session.getServletContext().getAttribute("EVENTS");
            ArrayList<LetsGoEventAttendee> attendeeList = (ArrayList<LetsGoEventAttendee>)session.getServletContext().getAttribute("ATTENDEE");
            User user = (User)session.getAttribute("user");
        %>
        <div class="row" style="margin-top: 60px;">
            <div class="span12" style="margin-left: 20px">
                <div style="position: fixed; width: 862px; background-color: white; padding: 0 76px 20px 0; top: 190px">
                    <h3 id="FullListHeader" style="float: left;">All Outings</h3>
                    <div style="float: right;">
                        <h5 style="padding:0 0 0 0; margin: 0 0 0 0" >Year:</h5>
                        <select id="ddlYear" class="ddlFilters" style="width:80px;">
                            <option value=".year113 .year112 .year111 .year110" selected="true">All</option>
                            <option value=".year113">2013</option>
                            <option value=".year112">2012</option>
                            <option value=".year111">2011</option>
                            <option value=".year110">2010</option>
                        </select> 
                    </div>
                    <div style="float: right; padding-right: 10px">
                        <h5 style="padding:0 0 0 0; margin: 0 0 0 0" >Month:</h5>
                        <select id="ddlMth" class="ddlFilters" style="width:80px;">
                            <option value=".month0 .month1 .month2 .month3 .month4 .month5 .month6 .month7 .month8 .month9 .month10 .month11" selected="true">All</option>
                            <option value=".month0">Jan</option>
                            <option value=".month1">Feb</option>
                            <option value=".month2">Mar</option>
                            <option value=".month3">Apr</option>
                            <option value=".month4">May</option>
                            <option value=".month5">Jun</option>
                            <option value=".month6">Jul</option>
                            <option value=".month7">Aug</option>
                            <option value=".month8">Sep</option>
                            <option value=".month9">Oct</option>
                            <option value=".month10">Nov</option>
                            <option value=".month11">Dec</option>
                        </select> 
                    </div>
                    <div style="float: right; padding-right: 10px">
                        <h5 style="padding:0 0 0 0; margin: 0 0 0 0" >Category:</h5>
                        <select id="ddlCat" class="ddlFilters" style="width:100px;">
                            <option value=" .cat1 .cat2 .cat3 .cat4" selected="true">All</option>
                            <option value=".cat1">BBQ</option>
                            <option value=".cat3">Camps</option>
                            <option value=".cat2">Sports</option>
                            <option value=".cat4">Others</option>
                        </select> 
                    </div>
                </div>
                <div id="divFullListing" style="margin-top: 60px">
                    <%
                        String css = "";
                        LetsGoEventAttendee attendee = null;
                        String rsvpStatus = "";
                        String eventDetails = "";
                        String divID = "";

                        //Populate the full listing here
                        for(LetsGoEvent event : events){
                            divID = "dAllEvents" + event.getEventID();
                        
                            css = "";
                        
                            css+= " year" + event.getEventStartDateTime().getYear();
                            css+= " month" + event.getEventStartDateTime().getMonth();
                            css+= " cat" + event.getCategory().getCategoryID();
                        
                            if(user != null){
                                if(event.getEventOrganizer().getUserID() == user.getUserID()){
                                    css += " myEvent";
                                }
                                else{
                                    attendee = event.getInvitees().get(user.getUserID());

                                    if(attendee != null){
                                        css += " invited";

                                        if(attendee.getRsvpStatus().equals(Enum_EventAttendee_Status.going.toString())){
                                            css += " attending";
                                        }
                                    }
                                
                                    //Get RSVP Status
                                    String status = "";
                                    for(LetsGoEventAttendee lgeAttendee : attendeeList){
                                        if (lgeAttendee.getLetsGoEventID()== event.getEventID()&& lgeAttendee.getUser().getUserID() == user.getUserID()){
                                            if (lgeAttendee.getRsvpStatus().equals(Enum_EventAttendee_Status.going.toString())){
                                                rsvpStatus = Enum_EventAttendee_Status.not_going.toString();
                                                status = "unjoined";
                                            }
                                            else if(lgeAttendee.getRsvpStatus().equals(Enum_EventAttendee_Status.not_going.toString()) || lgeAttendee.getRsvpStatus().equals(Enum_EventAttendee_Status.pending.toString())){
                                                rsvpStatus = Enum_EventAttendee_Status.going.toString();
                                                status = "joined";
                                            }
                                            break;
                                        }
                                       else if (lgeAttendee.getLetsGoEventID()!= event.getEventID() || lgeAttendee.getUser().getUserID() != user.getUserID()){
                                            rsvpStatus = Enum_EventAttendee_Status.going.toString();     
                                            status = "joined";
                                        }
                                    }
                                    //Event details
                                    eventDetails = user.getFullName() + " has "+status +" " + event.getTitle() + ".";
                                }
                            }                        
                    %>
                    <div id="<%=divID%>" class="hero-unit<%=css %>">                   
                        <h4><%=StringEscapeUtils.escapeHtml4(event.getTitle())%></h4>
                        <div>
                            <img src="${pageContext.request.contextPath}/content/images/letsgoevents/<%=StringEscapeUtils.escapeHtml4(event.getEventPhotoUrl()) %>" alt="" height='110px' width='110px' style="float:left; padding-right: 15px"/>
                            <div style="float:left;">
                                <p id="lge<%=event.getEventID()%>" style="font-size: 10pt">                                    
                                    By <%=StringEscapeUtils.escapeHtml4(event.getEventOrganizer().getFullName())%>
                                    <br/><%=StringEscapeUtils.escapeHtml4(DateFormatUtils.format(event.getEventStartDateTime(), "dd MMM yyyy, hh:mma")) %>
                                    <br/><%=event.getVenue() %>
                                    <!--
                                   <br/><a href="#"><%=event.getInvitees().size() %> going</a>
                                    -->
                                </p>                                
                                <%
                                    if(user != null && user.getUserID()!= event.getEventOrganizer().getUserID()){
                                %>
                                <s:form id="frmJoinEvent<%=event.getEventID()%>" beanclass="app.action.LetsGoEventsActionBean" style="float: right;">
                                    <s:hidden name="eventId" value="<%=event.getEventID()%>"/>
                                    <input type="hidden" id="organizerId<%=event.getEventID()%>" name="organizerId" value="<%=event.getEventOrganizer().getUserID()%>"/>
                                    <input type="hidden" id="hRsvpStatus<%=event.getEventID()%>" name="rsvpStatus" value="<%=StringEscapeUtils.escapeHtml4(rsvpStatus)%>"/>
                                    <input type="hidden" id="hdetails<%=event.getEventID()%>" name="details" value="<%=StringEscapeUtils.escapeHtml4(eventDetails)%>"/>
                                    <s:hidden name="join" />
                                    <% 
                                        String btnText = "";
                                        String btnName = "";
                                        String btnCss = "";
                                        if(rsvpStatus.equals(Enum_EventAttendee_Status.going.toString())){
                                            btnName = "JOIN";
                                            btnCss="btn-primary";
                                            btnText = "<i class='icon-plus icon-white'></i> Join";
                                        }
                                        else{
                                            btnName = "UNJOIN";
                                            btnCss="btn-inverse";
                                            btnText = "<i class='icon-minus icon-white'></i> Unjoin";
                                        }
                                    %>
                                    <button id="btnJoin<%=event.getEventID()%>" name="<%=btnName%>" value="<%=event.getEventID()%>" class="btn <%=btnCss%> btn-small JOIN"><%=btnText%></button>                                
                                    <button id="btnViewDetails<%=event.getEventID()%>" class="btn btn-small">View Details</button>
                                </s:form>
                                <% 
                                     }
                                     else{
                                %> 
                                <button id="btnViewDetails<%=event.getEventID()%>" class="btn btn-small">View Details</button>
                                <% } %>
                                <script>
                                    $(document).ready(function() {
                                        $("#btnViewDetails<%=event.getEventID()%>").bind("click", function() {
                                            window.location.replace("LetsGoEventsDetails.action?LetsGo=" + <%=event.getEventID()%>);
                                            return false;
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                        <script>
                            $(document).ready(function() {
                                $("#lge<%=event.getEventID()%>").bind("click", function() {
                                    return false;
                                });
                            });
                        </script>
                        <%
                            if(event.getInvitees().size()>0){
                                StringBuilder sb = new StringBuilder();
                                sb.append("<div>");

                                LetsGoEventAttendee lgeAttendee;
                                Iterator i = event.getInvitees().values().iterator();
                                while(i.hasNext()){
                                    lgeAttendee = (LetsGoEventAttendee)i.next();
                                    //sb.append("<img style='float: left; padding-left: 10px;' align='left' src='${pageContext.request.contextPath}/content/images/profile/Person A.jpg' alt='' height='30px' width='30px'/>");
                                    sb.append("<h6 align='left'>");
                                    sb.append(lgeAttendee.getUser().getFullName());
                                    sb.append("</h6>");
                                }

                                sb.append("</div>"); 
                        %>
                        <script type="text/javascript">
                            $(document).ready(function() {
                                $("#lge<%=event.getEventID()%>").kendoTooltip({
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
                                    content: "<%=sb.toString()%>"
                                });
                            });
                        </script>  
                        <%            
                                    }
                        %>
                    </div>
                    <%
                            }
                    %>
                </div>
            </div>
        </div>
    </s:layout-component>
</s:layout-render>