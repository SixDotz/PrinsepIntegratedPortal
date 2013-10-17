<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep  - Events - Invites      
    </s:layout-component>
    <s:layout-component name="html_header">
        <script type="text/javascript">
            $(document).ready(function() {
                $("#panelbar").kendoPanelBar({
                    expandMode: "single"
                });
                
                var windInviteFriends = $("#windInviteFriends").kendoWindow({
                    title: "Invite Friends",
                    modal: true,
                    pinned: true,
                    position: { top: 120, left:500 }
                });
                
                $(".k-window").hide();                               
                $(".k-overlay").hide();
                
                $("#btnInvites").bind("click", function(){
                    var dialog = windInviteFriends.data("kendoWindow");
                    dialog.toFront();
                    dialog.open();
                });
                
                $("#btnGoToEvents").bind("click", function(){
                    window.location = "${pageContext.request.contextPath}/Events.action";
                });
                
                $("#btnSubmit").bind("click", function(){
                    var dialog = windInviteFriends.data("kendoWindow");
                    dialog.close();
                });
                
                $("#btnCancel").bind("click", function(){
                    var dialog = windInviteFriends.data("kendoWindow");
                    dialog.close();
                });                
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
                padding: 3px 20px 10px 10px
            }
        </style>
    </s:layout-component>
    <s:layout-component name="FeaturedContent">
        <div class="topdiv">
            <button id="btnGoToEvents" class="btn btn-info"><i class="icon-calendar icon-white"></i> Go to All Events</button>
            <button id="btnEditEvent" class="btn btn-primary"><i class="icon-pencil icon-white"></i> Edit Event</button>
            <button id="btnInvites" class="btn btn-inverse"><i class="icon-user icon-white"></i> Invite Friends</button>
            <button id="btnCancelEvent" class="btn btn-Danger"><i class="icon-trash icon-white"></i> Delete Event</button>
        </div>
        <div id="windInviteFriends">
            <form class="form-search">
                <div class="input-append">
                    <span class="add-on"><i class="icon-search"></i></span>
                    <input class="span2" id="prependedInput" type="text" placeholder="Search By Name" style="height:30px; width: 400px"/>
                </div>            
                <div style="height: 150px; overflow-y: scroll; border:2px solid #ccc; padding:10px;">
                    <table>
                        <tr>
                            <td class="inviteLabel">Johnny Lee</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                        <tr>
                            <td class="inviteLabel">Yvonne Tan</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                        <tr>
                            <td class="inviteLabel">Terrance Lim</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                        <tr>
                            <td class="inviteLabel">Johnny Lim</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                        <tr>
                            <td class="inviteLabel">Amanda Lim</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                        <tr>
                            <td class="inviteLabel">Tommy Lim</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                        <tr>
                            <td class="inviteLabel">Clarence Lim</td>
                            <td class="invitePlus"><button type="button" class="btn"><i class="icon-plus"></i></button></td>
                        </tr>
                    </table>
                </div> 
                <div style="text-align:right; height: 10px; vertical-align: middle; padding-top: 20px;">
                    <button id="btnSubmit" type="submit" class="btn btn-primary"><i class=" icon-ok icon-white"></i> Invite Friends</button>
                    <button id="btnCancel" type="button" class="btn"><i class="icon-remove"></i> Cancel</button>
                </div>
            </form>
        </div>
        <hr/>
    </s:layout-component>
    <s:layout-component name="MainContent">
        <div class="row">
            <div class="span12" style="margin-left: 20px">
                <div>
                    <h3>Soccer Match</h3>
                </div>
                <div>
                    <table>
                        <tr>
                            <td style="vertical-align: top;">
                                <img src="${pageContext.request.contextPath}/content/images/letsgoevents/normal_cage2.jpg" alt="" height='250px' width='250px' style="float:left; padding-right: 15px"/>                               
                            </td>
                            <td rowspan="2" style="vertical-align: top; padding-left: 40px; padding-right: 40px">
                                <table>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Created by</label></td>
                                        <td class="eventDetailsValue">John Wirawan</td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">When</label></td>
                                        <td class="eventDetailsValue">28 September 2013 at 10:00AM</td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Where</label></td>
                                        <td class="eventDetailsValue">The Cage @ Kallang</td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Contact</label></td>
                                        <td class="eventDetailsValue">
                                            93573218
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventDetailsTitle"><label class="control-label">Details</label></td>
                                        <td class="eventDetailsValue">
                                            Please RSVP by 15 Sept 2013
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 20px;">
                                <ul id="panelbar">
                                    <li class="k-state-active">
                                        <span class="k-link k-state-selected">3 Going</span>
                                        <div style="padding: 10px;">
                                            <div class="teamMate">
                                                <img src="${pageContext.request.contextPath}/content/images/profile/john.jpg" alt="John Wirawan" height="20px" width="20px" />
                                                John Wirawan
                                            </div>
                                            <div class="teamMate">
                                                <img src="${pageContext.request.contextPath}/content/images/profile/Benjamin.jpg" alt="Benjamin Lim" height="20px" width="20px" />
                                                Benjamin Lim
                                            </div>
                                            <div class="teamMate">
                                                <img src="${pageContext.request.contextPath}/content/images/profile/Jasmine.jpg" alt="Jasmine Tan" height="20px" width="20px" />
                                                Jasmine Tan
                                            </div>
                                            <div style="text-align: right;">
                                                <a href="#">View All</a>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                    <hr/>
                    <div class="controls" style="vertical-align: top; padding-top:0;">
                        <textarea id="inputDetails" class="k-input" style="width: 80%" placeholder="Leave a comment..." rows="3"></textarea>
                        <button id="btnCancelEvent" class="btn btn-primary" style="margin-top: 30px"><i class="icon-globe icon-white"></i> Post</button>
                    </div>
                    <div>
                        <h4><i class="icon-comment"></i> Comments</h4>
                        <div class="hero-unit">
                            <table>
                                <tr>
                                    <td>
                                        <img style="padding-right: 10px; padding-top: 5px;" src='${pageContext.request.contextPath}/content/images/profile/sudip.png' alt='' height='80px' width='80px'/>
                                    </td>
                                    <td style="padding-top: 20px;">
                                        <div style="font-size: 10pt;">
                                        <strong>Sudip Roy&nbsp;&nbsp;&nbsp;&nbsp;</strong><i class="icon-time"></i> Posted 1 hour ago</label>
                                        <p>
                                            <br/>I have 4 friends not from our hostel who would like to join.
                                            <br/><br/><a href="#"><i class="icon-thumbs-up"></i> Like</a>
                                        </p>
                                    </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="hero-unit">
                            <table>
                                <tr>
                                    <td>
                                        <img style="padding-right: 10px; padding-top: 5px;" src='${pageContext.request.contextPath}/content/images/profile/subir.jpg' alt='' height='80px' width='80px'/>
                                    </td>
                                    <td style="padding-top: 20px;">
                                        <div style="font-size: 10pt;">
                                        <strong>Subir Roy&nbsp;&nbsp;&nbsp;&nbsp;</strong><i class="icon-time"></i> Posted 2 hours ago</label>
                                        <p>
                                            <br/>Looking forward to the movie!! Oh yeah!!!
                                            <br/><br/><a href="#"><i class="icon-thumbs-down"></i> unlike</a>
                                        </p>
                                    </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="hero-unit">
                            <table>
                                <tr>
                                    <td>
                                        <img style="padding-right: 10px; padding-top: 5px;" src='${pageContext.request.contextPath}/content/images/profile/john.jpg' alt='' height='80px' width='80px'/>
                                    </td>
                                    <td style="padding-top: 20px;">
                                        <div style="font-size: 10pt;">
                                        <strong>John Wirawan&nbsp;&nbsp;&nbsp;&nbsp;</strong><i class="icon-time"></i> Posted 3 hour ago</label>
                                        <p>
                                            <br/>Come on folks!!! Don't so stress leh!! Let's Chill out!!!
                                            <br/><br/><a href="#"><i class="icon-thumbs-up"></i> Like</a>&nbsp;&nbsp;<a href="#"><i class="icon-trash"></i> Delete</a>
                                        </p>
                                    </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
            </div>
        </div>
    </s:layout-component>
</s:layout-render>