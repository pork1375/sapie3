<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script><!-- 달력 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script><!-- 구글 차트 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title.sample" /></title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<style>
.dis-none {
display: none;
}
#content_pop {float: none;}
#content_pop:after {content:""; display:block; clear:both;}
</style>

    
    
    <script type="text/javaScript">
      
        /* 글 수정 화면 function */
        function fn_egov_select(itemId, dealDate) {
        	document.listForm.selectedId.value = itemId;
        	document.listForm.searchCondition2.value = dealDate;
           	document.listForm.action = "<c:url value='/updateSampleView.do'/>"; 
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addSample.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        

        
        // 달력
$(function(){
   $("#dealDate").datepicker({
   	 dateFormat: 'yymmdd' 
   	,dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'] // 요일의 한글 형식.
   	, monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
   	, showButtonPanel: true // 캘린더 하단에 버튼 패널을 표시한다. 
   	, currentText: '오늘 날짜' // 오늘 날짜로 이동하는 버튼 패널
   	, closeText: '닫기'  // 닫기 버튼 패널
   	,changeMonth: true // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
   	,changeYear: true // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
   });
   
   
   $("input:radio[name=subject]").click(function(){
		var calender = $(this).val();
		alert(calender);
   });
})
         
        
function call(itemId, dealDate, calender='일'){
	  // alert(itemId +","+dealDate);
console.log("calender ::: ", calender);
	  $.ajax({
		  dataType:"json",
		  url:"testa.do",
    	   data: {
    		  'itemId' : itemId, // 컨트롤러 itemId 가져오기
    		  'dealDate' : dealDate, // 컨트롤러 날짜 가져오기
    		  'calender' : calender // 컨트롤러 일 주 월 가져오기
    	  }, 
		  success: function(wall) {
			  console.log(wall.qwer); // 출력 확인
			  drawChart1(wall);	// 그래프 차트
			  drawChart2(wall);	// 라인 차트
			  drawChart3(wall);	// 콤보 차트
			  
			  $("#chartArea").removeClass("dis-none");
			  //$("#chartArea").addClass("dis-none2");
			  //console.log(wall.qwer[0].itemId); // 아이디 출력
		  },
		  error : function(e) {
	    	  	console.log(e);
	    	  }
	  });
}
        
        
        
// 구글 차트 
      google.charts.load('current', {'packages':['corechart']});
     /// google.charts.setOnLoadCallback(drawChart);

          function drawChart1(wall) {
    
        // Create the data table.
        var data1 = new google.visualization.DataTable();
        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
	    var chartDateformat     = 'yyyy넨MM월dd일';
        
        
     // 컬럼 추가
        //data1.addColumn('string', 'Topping');
        //data1.addColumn('number', 'Slices');
        //data1.addColumn('number'   , '5일');
        
        /* var dataRow = [];
        
        for(var i = 0; i < wall['qwer'].length; i++) {
        	var priceAvg5		= wall.qwer[i].priceAvg5;
        	
        dataRow = [priceAvg5];
        data1.addRow(dataRow);
        console.log(priceAvg5);
        	
        } */
        
        
         //그래프에 표시할 컬럼 추가
         
         data1.addColumn('datetime' , '날짜');
         data1.addColumn('number'   , '5일');
         data1.addColumn('number'   , '10일');
         data1.addColumn('number'   , '20일');
         data1.addColumn('number'   , '60일'); 
         data1.addColumn('number'   , '120일');
         data1.addColumn('number'   , '종가');

         //그래프에 표시할 데이터
         var dataRow = [];

         for(var i = 0; i < wall['qwer'].length; i++) { //랜덤 데이터 생성
           var priceAvg5		= wall.qwer[i].priceAvg5;
           var priceAvg10		= wall.qwer[i].priceAvg10;
           var priceAvg20		= wall.qwer[i].priceAvg20;
           var priceAvg60		= wall.qwer[i].priceAvg60;
           var priceAvg120		= wall.qwer[i].priceAvg120;
           var priceClose		= wall.qwer[i].priceClose;
           var year				= wall.qwer[i].year; 
           var month			= wall.qwer[i].month; 
           var day				= wall.qwer[i].day;
           
        
           dataRow = [new Date(year+","+month+","+day), priceAvg5, priceAvg10, priceAvg20, priceAvg60, priceAvg120 ,priceClose];
           data1.addRow(dataRow);
         }
        
        // Set chart options
        var options1 = {
        		title:'종가',
                width:'100%',
                height:500,
                hAxis : {format: chartDateformat},
                
            };
        
        // Instantiate and draw our chart, passing in some options.
        googleChartCall(data1, options1, 'chart_div1');
      
    }
          
          
      function drawChart2(wall) {
          // Create the data table.
          var data2 = new google.visualization.DataTable();
          //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
  	      var chartDateformat     = 'yyyy년MM월';
          
          
          /* data2.addColumn('string', 'Topping');
          data2.addColumn('number', 'Slices');
          data2.addRows([
            ['10대', 3],
            ['20대', 1],
            ['30대', 1],
            ['40대', 1],
            ['50대이상', 1],
          ]); */
          
          
          data2.addColumn('datetime' , '날짜');
          data2.addColumn('number'   , '5일');
          data2.addColumn('number'   , '20일');
          data2.addColumn('number'   , '60일'); 
          data2.addColumn('number'   , '120일');
          data2.addColumn('number'   , '거래량');

          //그래프에 표시할 데이터
          var dataRow = [];

          for(var i = 0; i < wall['qwer'].length; i++) { //랜덤 데이터 생성
            var volumeAvg5		= wall.qwer[i].volumeAvg5;
            var volumeAvg20		= wall.qwer[i].volumeAvg20;
            var volumeAvg60		= wall.qwer[i].volumeAvg60;
            var volumeAvg120		= wall.qwer[i].volumeAvg120;
            var volume		= wall.qwer[i].volume;
            var year	= wall.qwer[i].year; 
            var month	= wall.qwer[i].month; 
            var day		= wall.qwer[i].day;
            
         
            dataRow = [new Date(year+","+month+","+day), volumeAvg5, volumeAvg20, volumeAvg60, volumeAvg120, volume];
            data2.addRow(dataRow);
          }
          
          // Set chart options
          var options2 ={ 
				title:'거래량',
                width:'100%',
                height:500,
                pieHole: 0.4,
                hAxis : {format: chartDateformat}
			  };
          
          // Instantiate and draw our chart, passing in some options.
          googleChartCall(data2, options2, 'chart_div2');
      }  
		
      
		function drawChart3(wall) {
			
/* 			for(var i = 0; i < wall['qwer'].length; i++) {
	            var volumeAvg5		= wall.qwer[i].volumeAvg5;
	            var volumeAvg20		= wall.qwer[i].volumeAvg20;
				var volumeAvg60		= wall.qwer[i].volumeAvg60;
				var volume		= wall.qwer[i].volume;
	           var year	= wall.qwer[i].year; 
	           var month	= wall.qwer[i].month; 
	           var day		= wall.qwer[i].day;
	           var dealDate		= wall.qwer[i].dealDate;
				
			var data3 = google.visualization.arrayToDataTable([
					['Month', '거래량', '거래량 60일'],
					[Date(day), volume, volumeAvg5 ],
				]);
			
					console.log(volume);
			} */
			
			var data3 = new google.visualization.DataTable();
			//날짜형식 변경하고 싶으시면 이 부분 수정하세요.
		    var chartDateformat     = 'yyyy년MM월';
			
	         data3.addColumn('datetime' , '날짜');
	         data3.addColumn('number'   , '거래량이동평균60');
	         data3.addColumn('number'   , '거래량');
			
	         var dataRow = [];
	         
	         for(var i = 0; i <wall['qwer'].length; i++){
	             var volumeAvg60		= wall.qwer[i].volumeAvg60;
	             var volume				= wall.qwer[i].volume;
	             var year				= wall.qwer[i].year; 
	             var month				= wall.qwer[i].month; 
	             var day				= wall.qwer[i].day;
	             
	          
	             dataRow = [new Date(year+","+month+","+day), volumeAvg60, volume];
	             data3.addRow(dataRow);
	           }
	         
		
			var options3 = {
					title : '거래량...???',
					vAxis: {title: 'Cups'},
					hAxis: {title: 'Month'}, 
					seriesType: 'bars',
					series: {0: {type: 'line'}},
					hAxis : {format: chartDateformat}
				};
			
			googleChartCall(data3, options3,'chart_div3');
			
		}
  
		
		function googleChartCall(data, options, divId){
			var chart = new google.visualization.ComboChart(document.getElementById(divId));
			chart.draw(data, options);
			//반응형 그래프 출력 - 반응형 그래프를 원하지 않을 시 제거하거나 주석처리 하세요.
	        window.addEventListener('resize', function() { chart.draw(data, options); }, false);
		}
		
		
		/* function findSubject(){
			 var rrr = document.getElementsByName("subject");
			 alert(rrr);
		} */

        
        

    </script>

</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
 <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
        <input type="hidden" name="selectedId" /> 
        
       <%--  <input type="hidden" name="searchCondition2" value="${ searchVO.searchCondition2 }"/> --%>

        <div id="content_pop">
        	<!-- 타이틀 -->
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="list.sample" /></li>
        		</ul>
        	</div>
        	<!-- // 타이틀 -->
        	<div id="search">
        		<ul>
        			<li>
        			<!-- <input type="text" name="searchCondition2" id="dealDate"/> -->
        			<form:input path="searchCondition2" id="dealDate" /><!-- 달력 -->
        			
        			 
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="2" label="종목코드/명" />
        				</form:select>
        			</li>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                    </li>
        			<li>
        	            <span class="btn_blue_l">
        	                <a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
        	            </span>
        	        </li>
                </ul>
        	</div>
        	<!-- List -->
        	<div id="table">
        		<table width="100%" border="0" cellpadding="0" cellspacing="0">
        			<caption style="visibility:hidden"></caption>
        			<%-- <colgroup>
        				<col width="40"/>
        				<col width="100"/>
        				<col width="150"/>
        				<col width="80"/>
        				<col width="?"/>
        				<col width="60"/>
        			</colgroup> --%>
        			<tr>
        				<th align="center"><spring:message code="title.sample.item_id" /></th>
        				<th align="center"><spring:message code="title.sample.item_name" /></th>
        				<th align="center"><spring:message code="title.sample.price_open" /></th>
        				<th align="center"><spring:message code="title.sample.price_high" /></th>
        				<th align="center"><spring:message code="title.sample.price_low" /></th>
        				<th align="center"><spring:message code="title.sample.price_close" /></th>
        				<th align="center"><spring:message code="title.sample.previous" /></th>
        				<th align="center"><spring:message code="title.sample.rate" /></th>
        				<th align="center"><spring:message code="title.sample.volume" /></th>
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr onClick="call('<c:out value="${result.itemId}"/>','<c:out value="${result.dealDate}"/>');">
            				<td align="center" class="listtd"><c:out value="${result.itemId}"/></td>   
            				<td align="center" class="listtd"><c:out value="${result.itemName}"/></td> 
            				<%-- <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.itemId}"/>','<c:out value="${result.dealDate}"/>')"><c:out value="${result.itemName}"/></a></td> --%>
            				<td align="center" class="listtd"><c:out value="${result.priceOpen}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.priceHigh}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.priceLow}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.priceClose}"/>&nbsp;</td>
             				<c:if test="${result.compared3 > 0}"><!-- 전일대비 -->
				            	<td align="center" class="listtd" style="color:red;"><c:out value="${result.compared3}"/>&nbsp;</td>
			            	</c:if>
			            	<c:if test="${result.compared3 < 0}">
				            	<td align="center" class="listtd" style="color:blue;"><c:out value="${result.compared3}"/>&nbsp;</td>
			            	</c:if>
			            	<c:if test="${result.compared3 == 0}">
				            	<td align="center" class="listtd"><c:out value="0"/>&nbsp;</td>
			            	</c:if>
			            	
            				<c:if test="${result.fluctuation > 0}"><!-- 등락률 -->
				            	<td align="center" class="listtd" style="color:red;"><c:out value="${result.fluctuation}"/>&nbsp;</td>
			            	</c:if>
			            	<c:if test="${result.fluctuation < 0}">
				            	<td align="center" class="listtd" style="color:blue;"><c:out value="${result.fluctuation}"/>&nbsp;</td>
			            	 </c:if>
			            	<c:if test="${result.fluctuation eq '0.00'}">
				            	<td align="center" class="listtd"><c:out value="0"/></td>
			            	</c:if> 
			            	<td align="center" class="listtd"><c:out value="${result.volume}"/>&nbsp;</td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        	

    </div>
    </form:form>
    날짜 : <c:out value="${ searchVO.searchCondition2 }"/>
    
<div id="chartArea" class="dis-none" style="text-align: left;">
	<input type="radio" name="subject" value="일">일</input>
	<input type="radio" name="subject" value="주">주</input>
	<input type="radio" name="subject" value="월">월</input>
</div>
<!-- 구글 차트 -->
<!-- 구글 막대 차트 -->
    <div id="chart_div1"></div>
    <div id="chart_div2"></div>
    <div id="chart_div3"></div>



</body>
</html>
