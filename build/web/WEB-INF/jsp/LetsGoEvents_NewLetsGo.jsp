<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@ page import="app.viewmodel.*"%>

<script type="text/javascript">
    function resetNewLetsGoForm() {
        $('#inputCategory').data("kendoDropDownList").select(0);

        $(':input', '#frmCreateLetsGo')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('checked')
                .removeAttr('selected');
        
        $("#frmCreateLetsGo").kendoValidator().data("kendoValidator").hideMessages();
    }

    $(document).ready(function() {
        var windNotify = $("#windNotify").kendoWindow({
            title: "Notification",
            modal: true,
            pinned: true,
            position: {top: 250, left: 450}
        });

        var validator = $("#frmCreateLetsGo").kendoValidator().data("kendoValidator"),
                status = $(".status");

        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth(); //January is 0!
        var yyyy = today.getFullYear();
        var hh = today.getHours();
        
        var min = today.getMinutes();
        if(min >= 30){
            hh += 1;
            min = 0;
        }
        else{
            min = 30;
        }
        
        $("#inputDate").kendoDatePicker({
            min: new Date(yyyy, mm, dd),
            change: function(){  
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth(); //January is 0!
                var yyyy = today.getFullYear();
                var hh = today.getHours();
                
                var input = this.value();
                var idd = input.getDate();
                var imm = input.getMonth(); //January is 0!
                var iyyyy = input.getFullYear();
                
                var d1 = dd+mm+yyyy;
                var d2 = idd+imm+iyyyy;
                
                var min = today.getMinutes();
                if(min >= 30){
                    hh += 1;
                    min = 0;
                }
                else{
                    min = 30;
                }
                
                if(d1 == d2){
                    $("#inputTime").data("kendoTimePicker").min(new Date(yyyy, mm, dd, hh, min, 0));
                }
                else{
                    $("#inputTime").data("kendoTimePicker").min(this.value());
                }
            }
        });

        $("#inputTime").kendoTimePicker({
            min: new Date(yyyy, mm, dd, hh, min, 0)
        });

        $("#inputCategory").kendoDropDownList();

        $("#inputMaxCap").kendoNumericTextBox({
            min: 0,
            decimals: 0,
            step: 1,
            format: '#'
        });

        //$("#inputPhoto").kendoUpload({
        //    multiple: false,
        //    template: kendo.template($('#fileTemplate').html()),
        //    async: {
        //       saveUrl: "save",
        //        removeUrl: "remove",
        //        autoUpload: false
        //    }
        //});

        $("#btnSubmitNewLetsGoCreate").bind("click", function(e) {
            //Prevent the default form submit
            e.preventDefault();

            //Check if form fields entered are valid
            if (validator.validate()) {
                //Mask the form and overlay with a loading model
                $("#windCreateEvent").isLoading({
                    text: "Loading",
                    position: "overlay"
                });

                //Get the url to post the form data to
                var action = this.form.action + '?_eventName=' + this.name;

                //Form data from the login form
                var params = $(this.form).serialize();

                //Post data to actionbean for processing
                $.post(action, params, function(data) {
                    //Check return message and update ui
                    if (data != "") {
                        //Split the string

                        //Get new LetsGoID
                        $("#btnViewDetails").attr("value", data);
                        
                        //Get event name from textbox

                        //Get PhotoUrl

                        //Close create lets go window
                        $("#windCreateEvent").data("kendoWindow").close();

                        //Show confirmation of event created
                        windNotify.data("kendoWindow").open();

                        $("#windCreateEvent").isLoading("hide");
                    }
                    else {
                        alert("failed");
                    }
                });
            }
        });
        
        $("#btnReset").bind("click", function(){
            resetNewLetsGoForm();
        });

        $("#btnCancel").bind("click", function() {
            //$(this).closest('form').find("input[type=text], textarea").val("");
            $("#windCreateEvent").data("kendoWindow").close();
        });

        $("#btnBackToHome").bind("click", function() {
            window.location = "${pageContext.request.contextPath}";
        });

        $("#btnViewDetails").bind("click", function() {
            window.location = "${pageContext.request.contextPath}/LetsGoEventsDetails.action?LetsGo=" + this.value;
        });
    });
</script>
<style type="text/css">
    .formlblpad{
        margin-top: 15px;
    }

    .formctrlpad input{
        height: 25px;
    }

    .k-select{
        padding-top:2px;
    }
    .mandatory{
        color:#C90D00;
        font-size:14pt;
    }
</style>
<div id="container" style="position:relative; background: rgba(0,0,0,0.5)"></div>
<s:form id="frmCreateLetsGo" beanclass="app.action.LetsGoEventsNewActionBean" enctype="multipart/form-data">
    <div  style="max-height:400px; overflow:auto;">
        <ul class="forms forms2 formsul" style="margin-right: 20px;">
            <li>
                <label class="control-label" for="inputTitle">Title:<b class="mandatory">*</b></label>
                <div class="controls formctrlpad">
                    <input id="title" style="width:100%" name="newLetsGoForm.title" type="text" 
                           placeholder="Name of the outing" required validationMessage="Please enter an outing name." />
                </div>
            </li>
            <li>
                <label class="control-label" for="inputCategory">Category:<b class="mandatory">*</b></label>
                <div class="controls formctrlpad">
                    <select id="inputCategory" style="width:205px;" name="newLetsGoForm.category"
                            required data-required-msg="Please select outing categpory">
                        <option value="1" selected="true">BBQ</option>
                        <option value="2">Sports</option>
                        <option value="3">Camp</option>
                        <option value="4">Others</option>
                    </select>
                </div>
            </li>
            <li>
                <label class="control-label" for="inputDate">Date:<b class="mandatory">*</b></label>
                <div class="controls formctrlpad">
                    <input id="inputDate" style="width:205px;" name="newLetsGoForm.date" type="date" 
                           placeholder="Outing date" required data-required-msg="Please select the outing date"/>
                    <span class="k-invalid-msg" data-for="newLetsGoForm.date"></span>
                </div>
            </li>
            <li>
                <label class="control-label" for="inputTime">Time:<b class="mandatory">*</b></label>
                <div class="controls formctrlpad">
                    <input id="inputTime" style="width:205px;" name="newLetsGoForm.time" type="time"
                           placeholder="Outing time" required data-required-msg="Please select the outing time"/>
                    <span class="k-invalid-msg" data-for="newLetsGoForm.time"></span>
                </div>
            </li>            
        </ul>
        <ul class="forms forms2 formsul">
            <li>
                <label class="control-label" for="inputVenue">Venue:<b class="mandatory">*</b></label>
                <div class="controls formctrlpad">
                    <input id="inputVenue" name="newLetsGoForm.venue" class="k-input" type="text"
                           placeholder="Where are we going?" required data-required-msg="Please enter the outing venue"/>
                </div>
            </li>
            <li>
                <label class="control-label" for="inputContact">Contact Number:<b class="mandatory">*</b></label>
                <div class="controls formctrlpad">
                    <input id="inputContact" name="newLetsGoForm.contact" class="k-input" type="tel"
                           placeholder="Contact number" required data-required-msg="Please enter your contact number"/>
                </div>
            </li>
            <li>
                <label class="control-label" for="inputMaxCap">Max Capacity:</label>
                <div class="controls formctrlpad" >
                    <input id="inputMaxCap" style="width: 100%;" name="newLetsGoForm.capacity" type="number"
                           placeholder="Max no. of attendees if any" />
                </div>
            </li>
            <li>
                <label class="control-label" for="inputPhoto">Outing Photo:</label>
                <div class="controls formctrlpad">
                    
                    <input id="inputPhoto" type="file" name="newLetsGoForm.photoUrl" style="width:100%"/>
                    
                    
                </div>
            </li>
        </ul>
        <ul class="forms" style="text-align:left; margin-left: 10px; margin-top: 10px; width: 435px;">
            <li>
                <label class="control-label" for="inputDetails">Details:<b class="mandatory">*</b></label>
                <div class="controls">
                    <textarea id="inputDetails" name="newLetsGoForm.details" class="k-input" rows="3" style="width:100%"
                              placeholder="Outing details" required data-required-msg="Please enter outing details"></textarea>
                </div>
            </li>            
        </ul>
    </div>
    <ul class="forms form-actions" style="text-align:right; margin: 0; width: 425px;">
        <li>
            <button id="btnSubmitNewLetsGoCreate" name="createLetsGo" type="button" class="btn btn-primary"><i class="icon-star icon-white"></i> Create Outing</button>
            <button id="btnReset" type="button" class="btn"><i class="icon-refresh"></i> Reset</button>
            <button id="btnCancel" type="button" class="btn"><i class="icon-remove"></i> Cancel</button>        
        </li>
    </ul>
</s:form>
<div id="windNotify" style="text-align:center;">
    <h3>Outing successfully created.</h3>
    <button id="btnBackToHome" type="button" class="btn btn-primary" align="right">Back to Home</button>
    <button id="btnViewDetails" type="button" class="btn" align="right" value="0">Go To Outing Page</button>
</div>