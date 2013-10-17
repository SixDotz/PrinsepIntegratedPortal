<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld"%>

<s:layout-render name="/WEB-INF/common/_layout/masterlayout.jsp">
    <s:layout-component name="TitleContent">
        SMU Hostel @ Prinsep        
    </s:layout-component>
    <s:layout-component name="html_header">
        <script src="${pageContext.request.contextPath}/scripts/jquery.carouFredSel.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                // create Calendar from div HTML element
                $("#calendar").kendoCalendar();
                
                //Create on click event for each carousel image
                <c:forEach items="${actionBean.hostelEventHighlights}" var="hostelEvent" varStatus="loop">
                    $('#img${hostelEvent.hostelEventID}').click(function(){$('#foo1').trigger('slideTo',[${loop.index},{fx:'fade', duration:600}]);});
                </c:forEach>
                
                //Create Master Carousel
                $("#foo1").carouFredSel({
                    circular: true,
                    infinite: true,
                    auto: false,
                    height: 289
                });
                
                //Create secondary Carousel
                $("#foo2").carouFredSel({
                    circular: false,
                    infinite: false,
                    auto: false,
                    height: 180,
                    prev: {	
                        button: "#foo2_prev",
                        key: "left"
                    },
                    next: { 
                        button: "#foo2_next",
                        key: "right"
                    },
                    pagination	: "#foo2_pag"
                });

            });
        </script>
        <style type='text/css'>
            .carouselImg{
                cursor: pointer;
            }
            
            .BigCarouselDisplay{
                border-color: #003399;
                border-width: 5px;
            }
            
            #background {
                width: 254px;
                height: 250px;
                margin: 30px;
                padding: 69px 0 0 11px;
                background: url('${pageContext.request.contextPath}/content/images/calendar.png') transparent no-repeat 0 0;
            }
                                        
            #calendar {
                width: 241px;
            }
        </style>
    </s:layout-component>
    <s:layout-component name="FeaturedContent"> 
        <div class="image_carousel">
            <div id="foo1">
                <c:forEach items="${actionBean.hostelEventHighlights}" var="hostelEvent">
                    <div class='BigCarouselDisplay'>
                        <img src="${pageContext.request.contextPath}/content/images/carousel/${hostelEvent.eventLargePhotoUrl}" alt="${hostelEvent.eventTitle}" width="827px" height="260px"/>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="image_carousel">
            <div id="foo2">
                <c:forEach items="${actionBean.hostelEventHighlights}" var="hostelEvent">
                    <img id="img${hostelEvent.hostelEventID}" class='carouselImg' src="${pageContext.request.contextPath}/content/images/carousel/${hostelEvent.eventSmallPhotoUrl}" alt="${hostelEvent.eventTitle}" width="181" height="140" />
                </c:forEach>
            </div>
            <div class="clearfix"></div>
            <a class="prev" id="foo2_prev" href="#"><span>prev</span></a>
            <a class="next" id="foo2_next" href="#"><span>next</span></a>
            <div class="pagination" id="foo2_pag"></div>
        </div>
        <hr/>
    </s:layout-component>
    <s:layout-component name="MainContent"> 
        <div class="row">
            <div class="span8">
                <h2>Newsfeed</h2>
			<div class="fb-like-box" data-href="http://www.facebook.com/SMUResidencesPrinsep" data-width="600" data-height="500" data-colorscheme="light" data-show-faces="false" data-header="false" data-stream="true" data-show-border="false"></div>
            </div>
            <div class="span4">
                <h2>Hostel Wide Events</h2>                
                <div id="example" class="k-content">
                    <div id="background" style="margin:0px">
                        <div id="calendar"></div>
                    </div>
                    <style scoped>                        
                    </style>
                </div> 
                <hr/>
                <h2>Let's Go Events</h2>
                <table>
                    <tr>
                        <td rowspan="99" style="padding-right: 10px;">
                            <img src="${pageContext.request.contextPath}/content/images/letsgoevents/percyjackson_small.jpg" alt=""/>
                        </td>
                        <td>
                            <p>
                                <a href="${pageContext.request.contextPath}/EventsDetails.action">
                                    <strong>Percy Jackson Movie Outing</strong>
                                </a>                                
                            </p>
                            <p>                                    
                                By Amy<br/>20th Sept 2013, 7:00pm
                                <br/>The Cathay
                            </p>                              
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </s:layout-component> 
</s:layout-render>
