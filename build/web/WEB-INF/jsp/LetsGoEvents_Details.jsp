<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="org.apache.commons.lang3.time.DateFormatUtils"%>
<%@page import="java.util.*"%>
<%@page import="app.model.*"%>
<%@page import="app.model.enumeration.*" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <%User user = (User) session.getAttribute("user");%>

    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep  - Events - Invites      
    </s:layout-component>
    <s:layout-component name="html_header">
        <script type="text/javascript">
            var currentItems = [];
            $(document).ready(function() {
                $("#btnJoinUnjoin").bind("click", function(e) {
                    e.preventDefault();

                    //Save button in variable for later reference
                    var button = this;

                    //Post to server the new status
                    var action = "${pageContext.request.contextPath}/LetsGoEventsDetails.action?joinUnjoin=";

                    var eventID = "${actionBean.letsGoEvent.eventID}";
                    var organizerID = "${actionBean.letsGoEvent.eventOrganizer.userID}";
                    var details = $("#hdetails").val();
                    var rsvpStatus = $("#hRsvpStatus").val();

                    $.post(action, {"eventId": eventId, "organizerId": organizerId, "details": details, "rsvpStatus": rsvpStatus}, function(data) {
                        //Check return message and update ui
                        if (data == "success") {
                            if (button.name == "JOIN") {
                                //Change the button name
                                button.name = "UNJOIN";

                                //Change the button css, icon and text
                                $(button).addClass("btn-warning");
                                $(button).removeClass("btn-success");
                                $(button).html("<i class='icon-minus icon-white'></i> Unjoin");

                                //Change the details text
                                var originalText = $("#hdetails").val();
                                var newText = originalText.replace("joined", "unjoined");
                                $("#hdetails").val(newText);

                                //Change the rsvp status in the hidden field (to change: take from enum)
                                $("#hRsvpStatus").val("<%=Enum_EventAttendee_Status.not_going.toString()%>");
                            }
                            else {
                                //Change the button name
                                button.name = "JOIN";

                                //Change the button css, icon and text
                                $(button).addClass("btn-success");
                                $(button).removeClass("btn-warning");
                                $(button).html("<i class='icon-plus icon-white'></i> Join");

                                //Change the details text
                                var originalText = $("#hdetails").val();
                                var newText = originalText.replace("unjoined", "joined");
                                $("#hdetails").val(newText);

                                //Change the rsvpstatus in the hidden field (to change: take from enum)
                                $("#hRsvpStatus").val("<%=Enum_EventAttendee_Status.going.toString()%>");
                            }
                        }
                    });
                });

                $("#panelbar").kendoPanelBar({
                    expandMode: "single"
                });

                var windConfirmInvite = $("#windConfirmInvite").kendoWindow({
                    title: "Residents invited",
                    modal: true,
                    pinned: true,
                    visible: false,
                    position: {top: 120, left: 500}
                });

                var windInviteFriends = $("#windInviteFriends").kendoWindow({
                    title: "Invite Residents",
                    modal: true,
                    pinned: true,
                    visible: false,
                    position: {top: 120, left: 500},
                    close: function(e) {
                        var multiSelect = $("#invitees").data("kendoMultiSelect");
                        multiSelect.value(new Array());
                    }
                });

                $("#btnInvites").bind("click", function() {
                    var dialog = windInviteFriends.data("kendoWindow");
                    dialog.toFront();
                    dialog.open();
                });

                $("#btnGoToEvents").bind("click", function() {
                    window.location = "${pageContext.request.contextPath}/LetsGoEvents.action";
                });

                $("#btnConfirmInviteOk").bind("click", function() {
                    var dialog2 = windConfirmInvite.data("kendoWindow");
                    dialog2.toFront();
                    dialog2.close();
                });

                $("#btnSubmit").bind("click", function(e) {
                    e.preventDefault();

                    //Get the url to post the form data to
                    var action = this.form.action + '?_eventName=' + this.name;

                    //Form data from the login form
                    var invitees = $("#invitees").data("kendoMultiSelect").value();
                    var eventID = '${pageContext.request.getParameter("LetsGo")}';
                    var organizerID = '${actionBean.letsGoEvent.eventOrganizer.userID}';
                    var eventTitle = '${actionBean.letsGoEvent.title}';

                    //Post data to actionbean for processing
                    $.post(action, {"invitees": invitees, "eventID": eventID, "organizerID": organizerID, "eventTitle": eventTitle}, function(data) {
                        //Check return message and update ui
                        if (data == "success") {
                            //Clear initial list
                            $("#listInvitedResidents").empty();

                            //Populate list to display
                            for (var i = 0; i < invitees.length; i++) {
                                var data = ds.view();
                                for (var j = 0; j < data.length; j++) {
                                    if (data[j].UserID == invitees[i]) {
                                        $("#listInvitedResidents").append("<li>" + data[j].FullName + "</li>");
                                        break;
                                    }
                                }
                            }

                            //Hide Invite Window
                            var dialog = windInviteFriends.data("kendoWindow");
                            dialog.close();

                            //Show success window
                            var dialog2 = windConfirmInvite.data("kendoWindow");
                            dialog2.toFront();
                            dialog2.open();
                        }
                        else {

                        }
                    });

                    //Prevent default action
                    return false;
                });

                $("#btnCancel").bind("click", function() {
                    var dialog = windInviteFriends.data("kendoWindow");
                    dialog.close();
                });

                $("#btnPostComment").bind("click", function() {
                    $("frmPostComment").submit(function(event) {
                    });
                });

                $(".lnkLikeUnLike").bind("click", function() {
                    var link = $(this);
                    var commentId = link.attr("value");
                    var status = link.attr("status");

                    $.post("${pageContext.request.contextPath}/LetsGoEventsDetails.action?commentId=" + commentId + "&status=" + status + "&updateLikeUnlike=", function(event) {
                        if (event == "success") {
                            if (status == "like") {
                                $(link).attr("status", "unlike");
                                $(link).html("<i class='icon-thumbs-down'></i> Unlike");
                            }
                            else {
                                $(link).attr("status", "like");
                                $(link).html("<i class='icon-thumbs-up'></i> Like");
                            }
                        }
                    });
                    return false;
                });

                //Invite Friends
                var ds = new kendo.data.DataSource({
                    transport: {
                        read: {
                            dataType: "jsonp",
                            url: "UserList.action",
                        }
                    }
                });

                $("#lstFriends").kendoListView({
                    dataSource: ds,
                    template: '<div><img class="tag-image" src=\"#: Photo #\" alt=\"#: FullName #\" />' +
                            '<strong>#: FullName #</strong></div>',
                    selectable: "single",
                    change: function(e) {
                        var data = ds.view(),
                                selected = $.map(this.select(), function(item) {
                            return data[$(item).index()].UserID;
                        });

                        var values = $("#invitees").data("kendoMultiSelect").value().slice();

                        var match = false;

                        var testValues = values.toString().split(",")

                        for (var i = 0; i < testValues.length; i++) {

                            if (selected + 0 === testValues[i] + 0) {
                                match = true;
                            }
                        }

                        if (!match) {
                            $.merge(values, [selected]);
                            $("#invitees").data("kendoMultiSelect").value(values);
                        }
                    }
                });

                $("#invitees").kendoMultiSelect({
                    dataTextField: "FullName",
                    dataValueField: "UserID",
                    tagTemplate: '<img class="tag-image" src=\"#: Photo #\" alt=\"#: FullName #\" />' +
                            '<strong>#: FullName #</strong>',
                    dataSource: ds,
                    height: 300,
                    open: function(e) {
                        e.preventDefault();
                    },
                    change: function(e) {
                        var value = this.value();
                        var multiSelect = $("#invitees").data("kendoMultiSelect");

                        multiSelect.value(value());
                    },
                });

                var invitees = $("#invitees").data("kendoMultiSelect");
                invitees.wrapper.attr("id", "invitees-wrapper");

                $(".k-multiselect-wrap").children("input.k-input").attr('readonly', "readonly");
            });
        </script>
        <style type="text/css">
            .eventDetailsTitle{
                padding-right: 20px;
                padding-bottom: 20px;
                vertical-align: top;
            }
            .eventDetailsValue{
                padding-left: 20px;
                padding-bottom: 20px;
                border-left-width: 3px;
                border-left-color: #eeeeee;
                border-left-style: solid;
            }
            .teamMate img {
                margin: 5px 15px 5px 5px;
                border: 1px solid #ccc;
            }
            .inviteLabel{
                text-align: left;
                padding-right: 20px;
                padding-bottom: 20px;
            }
            .invitePlus{
                text-align: center;
                padding-bottom: 20px;
            }

            #windInviteFriends{
                padding: 3px 20px 10px 10px;
                width: 300px;
            }

            .tag-image {
                width: auto;
                height: 18px;
                margin-right: 5px;
                vertical-align: top;
            }

            #invitees-list .k-item {
                overflow: hidden; /* clear floated images */
            }
            #invitees-list img {
                -moz-box-shadow: 0 0 2px rgba(0,0,0,.4);
                -webkit-box-shadow: 0 0 2px rgba(0,0,0,.4);
                box-shadow: 0 0 2px rgba(0,0,0,.4);
                float: left;
                margin: 5px 20px 5px 0;
            }
            #invitees-list h3 {
                margin: 30px 0 10px 0;
                font-size: 2em;
                color: black;
                padding-top: 10px;
            }

            #lstFriends div{
                cursor: pointer;
            }
        </style>
    </s:layout-component>
    <s:layout-component name="FeaturedContent">
        <s:useActionBean beanclass="app.action.LetsGoEventsDetailsActionBean" var="details"/>
        <div class="topdiv">
            <button id="btnGoToEvents" class="btn btn-info"><i class="icon-calendar icon-white"></i> Go to All Lets Go Outing</button>
            <%
                if (user != null) {
            %>
            <button id="btnInvites" class="btn btn-inverse"><i class="icon-user icon-white"></i> Invite Residents</button>
            <%
                if (user.getUserID() == details.getLetsGoEvent().getEventOrganizer().getUserID()) {
            %>
            <button id="btnEditEvent" class="btn btn-primary"><i class="icon-pencil icon-white"></i> Edit Outing</button>
            <button id="btnCancelEvent" class="btn btn-Danger"><i class="icon-trash icon-white"></i> Delete Outing</button>
            <%                    }
            %>
            <input type="hidden" id="hRsvpStatus" name="rsvpStatus" value="<%=StringEscapeUtils.escapeHtml4((String) session.getServletContext().getAttribute("RSVPSTATUS"))%>"/>
            <input type="hidden" id="hdetails" name="details" value="<%=StringEscapeUtils.escapeHtml4("eventDetails")%>"/>
            <%
                }
            %>
        </div>
        <div id="windInviteFriends" style="width:500px">
            <s:form beanclass="app.action.LetsGoEventsDetailsActionBean" method="post" class="form-search">
                <div style="width:100%;">
                    <select id="invitees" multiple="multiple" data-placeholder="Select friends to invite..."></select>
                </div> 
                <div>
                    <div id ="lstFriends"></div>
                </div>
                <div style="text-align:right; height: 10px; vertical-align: middle; padding-top: 20px;">
                    <button id="btnSubmit" type="submit" class="btn btn-primary" name="inviteResidents"><i class=" icon-ok icon-white"></i> Invite Residents</button>
                    <button id="btnCancel" type="button" class="btn"><i class="icon-remove"></i> Cancel</button>
                </div>
            </s:form>
        </div>
        <div id="windConfirmInvite" style="padding-left:0; padding-top:0.58em; padding-right:0; padding-bottom:0;">
            <div style="padding:0 10px 10px 10px">
                <h4>An invitation has been sent to the following residents:</h4>
                <ul id="listInvitedResidents">
                </ul> 
            </div>

            <div class="forms form-actions" style="text-align:right; margin: 0; width:91.6%">
                <button id="btnConfirmInviteOk" type="button" class="btn btn-primary" align="right">Ok</button>
            </div>            
        </div>
        <hr/>
    </s:layout-component>
    <s:layout-component name="MainContent">
        <s:useActionBean beanclass="app.action.LetsGoEventsDetailsActionBean" var="details"/>
        <% String rsvpStatus = (String) session.getServletContext().getAttribute("RSVPSTATUS");%>
        <div class="row">
            <div class="span12" style="margin-left: 20px">
                <div>
                    <h3>
                        <%=StringEscapeUtils.escapeHtml4(details.getLetsGoEvent().getTitle())%>
                        <%
                            if (user != null) {
                                if (user.getUserID() != details.getLetsGoEvent().getEventOrganizer().getUserID()) {
                                    if (!rsvpStatus.equals(Enum_EventAttendee_Status.going.toString())) {
                                        //Display join button
                        %>
                        <button id="btnJoinUnjoin" class="btn btn-success"><i class="icon-plus icon-white"></i> Join</button>
                        <%
                            if (rsvpStatus.equals(Enum_EventAttendee_Status.pending.toString())) {
                                //Display message to user informing him/her that he/she has been invited
                                //TODO: FOR NEXT ITERATION
                        %>
                        <%                            }
                        } else {
                            //Display unjoin button                                        
                        %>
                        <button id="btnJoinUnjoin" class="btn btn-warning"><i class="icon-minus icon-white"></i> Unjoin</button>
                        <%                                    }
                                }
                            }
                        %>
                        <%=rsvpStatus%>
                    </h3> 
                </div>
                <div>
                    <table>
                        <tr>
                            <td style="vertical-align: top;">
                                <img src="${pageContext.request.contextPath}/content/images/letsgoevents/${actionBean.letsGoEvent.eventPhotoUrl}" alt="" width='180px' style="float:left; padding-right: 0px; margin-right: 0"/>                               
                            </td>
                            <td rowspan="2" style="vertical-align: top; padding-left: 40px; padding-right: 40px">
                                <table>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Created by</label></td>
                                        <td class="eventDetailsValue">
                                            <%=StringEscapeUtils.escapeHtml4(details.getLetsGoEvent().getEventOrganizer().getFullName())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">When</label></td>
                                        <td class="eventDetailsValue">
                                            <%=StringEscapeUtils.escapeHtml4(DateFormatUtils.format(details.getLetsGoEvent().getEventStartDateTime(), "dd MMM yyyy, hh:mma"))%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Where</label></td>
                                        <td class="eventDetailsValue"><%=StringEscapeUtils.escapeHtml4(details.getLetsGoEvent().getVenue())%></td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Contact</label></td>
                                        <td class="eventDetailsValue">
                                            <%=StringEscapeUtils.escapeHtml4(details.getLetsGoEvent().getContact())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Details</label></td>
                                        <td class="eventDetailsValue">
                                            <%=StringEscapeUtils.escapeHtml4(details.getLetsGoEvent().getDetails())%>
                                        </td>
                                    </tr>
                                    <!--<tr>
                                        <td>RSVP STATUS</td>
                                        <td><%=rsvpStatus%></td>
                                    </tr>-->
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 20px;">
                                <ul id="panelbar">
                                    <li class="k-state-active">
                                        <%
                                            ArrayList<LetsGoEventAttendee> goingList = new ArrayList<LetsGoEventAttendee>();
                                            HashMap<Integer, LetsGoEventAttendee> attendees = details.getLetsGoEvent().getInvitees();
                                            HashMap<Integer, User> userHash = (HashMap<Integer, User>) session.getAttribute("USERHASH");
                                            Iterator itr = attendees.values().iterator();

                                            int goingCount = 0;

                                            while (itr.hasNext()) {
                                                LetsGoEventAttendee lgeAttendee = (LetsGoEventAttendee) itr.next();

                                                if (lgeAttendee.getRsvpStatus().equals(Enum_EventAttendee_Status.going.toString())) {
                                                    goingCount++;
                                                    goingList.add(lgeAttendee);
                                                }
                                            }
                                        %>
                                        <span class="k-link k-state-selected">Going (<%=goingCount%>)</span>
                                        <div style="padding: 10px;">
                                            <%
                                                for (LetsGoEventAttendee going : goingList) {
                                                    int attendeeID = going.getUser().getUserID();
                                            %>
                                            <div class="teamMate">                                                
                                                <h5>
                                                    <img src="<%=userHash.get(attendeeID).getFacebookProfilePhotoUrl()%>" alt="<%=StringEscapeUtils.escapeHtml4(going.getUser().getFullName())%>" class="img-circle" height="20px" width="20px" /><%=StringEscapeUtils.escapeHtml4(going.getUser().getFullName())%>
                                                </h5>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <div style="text-align: right;">
                                                <%
                                                    if (goingCount > 3) {
                                                %>
                                                <a href="#">View All</a>
                                                <%                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                    <hr/>
                    <%
                        if (user != null) {
                    %>
                    <div class="controls" style="vertical-align: top; padding-top:0;">
                        <s:form id="frmPostComment" beanclass="app.action.LetsGoEventsDetailsActionBean">
                            <textarea id="inputDetails" name="comments" class="k-input" style="width: 80%" placeholder="Leave a comment..." rows="3"></textarea>
                            <s:hidden name="LetsGo">${pageContext.request.getParameter("LetsGo")}</s:hidden>
                            <s:hidden name="postComment"></s:hidden>
                                <button id="btnPostComment" class="btn btn-primary" style="margin-top: 30px"><i class="icon-globe icon-white"></i> Post</button>
                        </s:form>
                    </div>
                    <%                        }
                    %>
                    <div>
                        <h4><i class="icon-comment"></i> Comments</h4>
                        <%
                            ArrayList<LetsGoEventComment> eventComment = (ArrayList<LetsGoEventComment>) session.getServletContext().getAttribute("COMMENT");

                            boolean isLike = false;
                            for (LetsGoEventComment comment : eventComment) {
                                isLike = false;
                                if (user != null && comment.getLiker() != null) {
                                    if (comment.getLiker().getUserID() == user.getUserID()) {
                                        isLike = true;
                                    }
                                }
                                User commenter = userHash.get(comment.getUserID().getUserID());
                        %>
                        <div class="hero-unit">
                            <table>
                                <tr>
                                    <td>
                                        <!--<img style="padding-right: 10px; padding-top: 5px;" src='${pageContext.request.contextPath}/content/images/profile/sudip.png' alt='' height='80px' width='80px'/>-->
                                        <img style="padding-right: 10px; padding-top: 5px;" src='<%=commenter.getFacebookProfilePhotoUrl()%>' alt='' height='80px' width='80px'/>
                                    </td>
                                    <td style="padding-top: 20px;">
                                        <div style="font-size: 10pt;">
                                            <strong><%=commenter.getFullName()%>&nbsp;&nbsp;&nbsp;&nbsp;</strong><i class="icon-time"></i> Posted on <%=StringEscapeUtils.escapeHtml4(DateFormatUtils.format(comment.getCreatedDateTime(), "dd MMM yyyy, hh:mma"))%></label>
                                            <p>
                                                <br/><%= comment.getComment()%>
                                                <%
                                                    if (user != null) {
                                                        if (isLike) {
                                                %>
                                                <br/><br/><a href="#" class="lnkLikeUnLike" value="<%=comment.getCommentID()%>" status="unlike"><i class='icon-thumbs-down'></i> Unlike</a>
                                                <% } else {%>
                                                <br/><br/><a href="#" class="lnkLikeUnLike" value="<%=comment.getCommentID()%>" status="like"><i class='icon-thumbs-up'></i> Like</a>
                                                <% }
                                                    }%>
                                            </p>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <% }//end for loop %>
                    </div>
                </div>
            </div>
        </s:layout-component>
    </s:layout-render>