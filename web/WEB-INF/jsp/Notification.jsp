<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>

<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep  - NOTIFICATIONS      
    </s:layout-component>
    <s:layout-component name="html_header">
        <script type="text/javascript">
            $(function() {
                var dataSource = new kendo.data.DataSource({
                    transport: {
                        read: {
                            url: "http://www.smuprinsep.com:8001/PrinsepIntegratedPortal/Notification.action?getJsonNotifications=",
                            dataType: "jsonp"
                        }
                    },
                    pageSize: 5
                });

                $("#pager").kendoPager({
                    dataSource: dataSource
                });

                $("#listView").kendoListView({
                    dataSource: dataSource,
                    template: kendo.template($("#template").html())
                });
            });
        </script>

        <style scoped>
            #listView {
                padding: 10px;
                margin-bottom: -1px;
                min-width: 555px;
            }
        </style>
    </s:layout-component>
    <s:layout-component name="FeaturedContent">
        <div class="row">
            <div class="span8">
                <h3>My Notifications</h3>
            </div>
        </div>
    </s:layout-component>
    <s:layout-component name="MainContent">
        <div class="demo-section">
            <div id="listView"></div>
            <div id="pager" class="k-pager-wrap"></div>
        </div>

        <script type="text/x-kendo-template" id="template">
            <div class="product">
                <h6>#:Description#</h6>
                <p>#:PostedOn#</p>
            </div>
            <hr/>
        </script>
    </s:layout-component>
</s:layout-render>