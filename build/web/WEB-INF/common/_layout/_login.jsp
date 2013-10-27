<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@ page import="app.model.*" %>
<%@ page import="java.net.*" %>
<div id="fb-root"></div>
<script type="text/javascript">
    //Setup Facebook SDK
    window.fbAsyncInit = function() {
        // init the FB JS SDK
        FB.init({
            appId: '533479690066021', // App ID from the app dashboard
            channelUrl: '${pageContext.request.contextPath}/content/html/channel.html', // Channel file for x-domain comms
            status: true, // Check Facebook Login status
            xfbml: true                                                             // Look for social plugins on the page
        });

        // Additional initialization code such as adding Event Listeners goes here
    };

    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {
            return;
        }
        js = d.createElement(s);
        js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    //JQuery Method
    $(document).ready(function() {
        $("#btnLogin").bind("click", function() {
            FB.login(function(response) {
                if (response.authResponse) {
                    console.log('Welcome!  Fetching your information.... ');
                    FB.api('/me', function(response) {
                        var currentUrl = '<%=URLEncoder.encode(request.getAttribute("javax.servlet.forward.request_uri").toString())%>';
                        
                        window.location = "${pageContext.request.contextPath}/Login.action?facebookId=" + response.id + "&currentUrl="+currentUrl;
                        //window.location = "${pageContext.request.contextPath}/Login.action?index=&facebookName="+response.name;
                    });
                } else {
                    console.log('User cancelled login or did not fully authorize.');
                }
            });
            
            return false;
        });
    });
</script>        
<%
    boolean isLoggedIn = false;
    if (session.getAttribute("user") == null) {
        isLoggedIn = false;
%>
<ul id="ulUnauthenticated" class="nav pull-right" style="padding-right: 50px; padding-top: 20px;">
    <li>
        <a id="btnLogin" href="#">            
            <img src="${pageContext.request.contextPath}/content/images/login_fb2.jpg" style="cursor: pointer;"/>
        </a>
    </li>
</ul>
<%
} else {
    isLoggedIn = true;
    User user = (User) session.getAttribute("user");
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#btnLogout").bind("click", function() {
            //FB.logout(function(response) {
            // user is now logged out of facebook, so invalidate the user's sessions
            window.location = "${pageContext.request.contextPath}/Logout.action";
            //});            
        });
    });
</script>
<ul id="ulAuthenticated" class="nav pull-right" style="padding-right: 38px">
    <li>
        <a href="#">
            <h5 style="float:left;">Welcome <%=user.getFullName()%></h5>
        </a>
    </li>
    <li>        
        <s:link beanclass="app.action.LoginActionBean" event="logout">
            <button id="btnLogout" type="link" class="btn btn-link"><i class="icon-off"></i> Logout</button>
        </s:link>
    </li>
</ul>
<%
    }
%>



