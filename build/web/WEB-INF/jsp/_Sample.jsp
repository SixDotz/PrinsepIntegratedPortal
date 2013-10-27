<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>
<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep  - SAMPLE      
    </s:layout-component>
    <s:layout-component name="html_header">
        <script type="text/javascript">
            $(document).ready(function() {
                $(".clickable").bind("click", function(){
                    var url = $(this).attr("value");
                    
                    alert(url);
                });
            });                
        </script>
    </s:layout-component>
    <s:layout-component name="FeaturedContent">
    </s:layout-component>
    <s:layout-component name="MainContent">
        <br/>
        <div class="clickable" value="Kimberly" style="cursor: pointer;; background-color: #005c83; margin-bottom: 20px; color: whitesmoke;">
            Click Me!!!
        </div>
        <div class="clickable" value="Leroy" style="cursor: pointer;; background-color: #005c83; margin-bottom: 20px; color: whitesmoke;">
            Click Me!!!
        </div>
        <div class="clickable" value="Joyce" style="cursor: pointer;; background-color: #005c83; margin-bottom: 20px; color: whitesmoke;">
            Click Me!!!
        </div>
    </s:layout-component>
</s:layout-render>