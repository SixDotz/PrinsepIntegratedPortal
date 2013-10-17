<script type="text/javascript">
    $(document).ready(function() {
        var windNotify = $("#windNotify").kendoWindow({
            title: "Notification",
            modal: true,
            pinned: true,
            position: { top: 250, left: 450 }
        });
        
        $("#inputDate").kendoDatePicker();

        $("#inputTime").kendoTimePicker();

        $("#inputCategory").kendoDropDownList();

        $("#inputMaxCap").kendoNumericTextBox({
            min: 0
        });

        $("#inputPhoto").kendoUpload({
            multiple: false
        });
        
        $("#btnCreate").bind("click", function(){
            $("#windCreateEvent").data("kendoWindow").close();
            windNotify.data("kendoWindow").open();
        });
        
        $("#btnReset").bind("click", function(){
            $(this).closest('form').find("input[type=text], textarea").val("");
        });
        
        $("#btnCancel").bind("click", function(){
            //$(this).closest('form').find("input[type=text], textarea").val("");
            $("#windCreateEvent").data("kendoWindow").close();
        });
        
        $("#btnBackToHome").bind("click", function(){
            window.location = "${pageContext.request.contextPath}";
        });
        
        $("#btnViewDetails").bind("click", function(){
            window.location = "${pageContext.request.contextPath}/EventsDetails.action";
        });
    });
</script>
        
<form class="form-horizontal">
    <table>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label" for="inputTitle">Title:</label>
                    <div class="controls formctrlpad">
                        <input type="text" id="inputTitle" class="k-input" placeholder="Event Title">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputCategory">Category:</label>
                    <div class="controls">
                        <select id="inputCategory" style="width:205px;">
                            <option>BBQ</option>
                            <option>Camps</option>
                            <option>Sports</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputDate">Date:</label>
                    <div class="controls">
                        <input type="text" id="inputDate" placeholder="Date" style="width:205px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputTime">Time:</label>
                    <div class="controls">
                        <input type="text" id="inputTime" placeholder="Time" style="width:205px;">
                    </div>
                </div>
                <div class="control-group formctrlpad">
                    <label class="control-label" for="inputVenue">Venue:</label>
                    <div class="controls">
                        <input type="text" class="k-input" id="inputVenue" placeholder="Venue">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputMaxCap">Max Capacity:</label>
                    <div class="controls">
                        <input type="text" id="inputMaxCap" placeholder="0" style="width:205px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputDetails">Details:</label>
                    <div class="controls">
                        <textarea id="inputDetails" class="k-input" placeholder="Details" rows="3"></textarea>
                    </div>
                </div>
            </td>
            <td style="vertical-align: top">
                <div class="control-group formctrlpad">
                    <label class="control-label" for="inputContact">Contact:</label>
                    <div class="controls">
                        <input type="text" id="inputContact" class="k-input" placeholder="Contact">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label formlblpad" for="inputPhoto">Photo:</label>
                    <div class="controls" style="vertical-align: top; padding-top:0;">
                        <input type="file" name="file" id="inputPhoto" placeholder="Photo" style="width:100px">
                    </div>
                </div>
				
                <div id="windInviteFriends" style="padding-left: 100px">
                     <label class="control-label formlblpad" style="text-align: left">Invite Friends:</label><br/>
                <div class="input-append">
                    <span class="add-on"><i class="icon-search"></i></span>
                    <input class="span2" id="prependedInput" type="text" placeholder="Search By Name" style="height:30px; width: 250px"/>
                </div>            
                <div style="height: 150px; width: 250px; overflow-y: scroll; border:2px solid #ccc; padding:10px;">
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
            </td>
        </tr>
    </table>
    <div class="form-actions" style="text-align:right;">
        <button id="btnCreate" type="button" class="btn btn-primary"><i class=" icon-ok icon-white"></i> Create Event</button>
        <button id="btnReset" type="button" class="btn"><i class="icon-refresh"></i> Reset</button>
        <button id="btnCancel" type="button" class="btn"><i class="icon-remove"></i> Cancel</button>        
    </div>
</form>
<div id="windNotify" style="text-align:center;">
    <h3>Soccer event successfully created.</h3>
    <button id="btnBackToHome" type="button" class="btn btn-primary" align="right">Back to Home</button>
    <button id="btnViewDetails" type="button" class="btn" align="right">View Event Details</button>
</div>