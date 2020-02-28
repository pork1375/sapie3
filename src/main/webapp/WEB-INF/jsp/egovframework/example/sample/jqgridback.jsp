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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/ui.jqgrid.css'/>"/>

<script type="text/javascript" src="css/egovframework/js/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="css/egovframework/js/jquery.jqGrid.min.js"></script>




<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title.sample" /></title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<style>
.dis-none {
display: none;
}
#dynamicTable {
display: none;
width: 800px;
height: 350px;
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
   
   
   // 일 주 월 라디오버튼 calender 버튼 클릭 시 이벤트 발생
   $("input:radio[name=calender]").click(function() {
		var calender = $(this).val();		// 버튼의 값을 가져온다.
		var _itemId = $("#itemId").val();	// itemid 값을 가져온다.

		// 버튼을 클릭 시 call에 담긴 매개변수를 가져온다. 그런데 calender='aaa' 디폴트값이 위의 버튼클릭시 값을 새로 가져와서 
		// 다른버튼을 클릭 하면 새로운 값이 들어간다.
		call(_itemId, calender);	
		
		// alert(calender); // 버튼 클릭시 값이 들어가는지 확인
   });
}); 
   
   


         
// onClick 클릭 시 itemId 만 받아오고 calender는 디폴트 값으로 onClick 할때 값을 안넘겨줘도 된다.
function call(itemId) {
        $("#itemId").val(itemId);
       $('#dynamicTable').show();
   
       
	  var _dealDate = $("#dealDate").val();
	  var _itemId = $("#itemId").val();
	  
//console.log("calender ::: ", calender);
console.log("_itemId ::: ", _itemId);
console.log("_dealDate ::: ", _dealDate);

	  $.ajax({
		  dataType:"json",
		  url:"testa.do",
    	   data: {
    		  'itemId' : _itemId, // 컨트롤러 itemId 가져오기
    		  'dealDate' : _dealDate, // 컨트롤러 날짜 가져오기
    		 // 'calender' : calender // 컨트롤러 일 주 월 가져오기
    	  }, 
		  success: function(wall) {
			  //console.log(wall); // 출력 확인
			  // gridtable(wall);
			  
			  
			  var html = '';	
			  
			  for(var i = 0; i < wall['qwer'].length; i++) {
					html += '<tr>';
					html += '<td>'+wall.qwer[i].dealDate+'</td>';
					html += '<td>'+wall.qwer[i].priceClose+'</td>';
					html += '<td>'+wall.qwer[i].priceAvg5+'</td>';
					html += '<td>'+wall.qwer[i].priceAvg10+'</td>';
					html += '<td>'+wall.qwer[i].priceAvg20+'</td>';
					html += '<td>'+wall.qwer[i].priceAvg60+'</td>';
					html += '<td>'+wall.qwer[i].volume+'</td>';
					html += '<td>'+wall.qwer[i].volumeAvg5+'</td>';
					html += '<td>'+wall.qwer[i].volumeAvg20+'</td>';
					html += '<td>'+wall.qwer[i].volumeAvg60+'</td>';
					html += '</tr>';
				}
		  
			  
				$("#dynamicTbody").empty();
				$("#dynamicTbody").append(html);

			  

			  //drawChart1(wall);	// 그래프 차트
			  //drawChart2(wall);	// 라인 차트
			  //drawChart3(wall);	// 콤보 차트
			  
			  //$("#chartArea").removeClass("dis-none");
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
	    var chartDateformat     = 'yyyy년MM월dd일';
        
        
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
        var chart1 = new google.visualization.LineChart(document.getElementById('chart_div1'));
        chart1.draw(data1, options1);
      
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
                hAxis : {format: chartDateformat},
			  };
          
          // Instantiate and draw our chart, passing in some options.
          var chart2 = new google.visualization.ColumnChart(document.getElementById('chart_div2'));
          chart2.draw(data2, options2);
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
			
	         data3.addColumn('string' , '날짜');
	         data3.addColumn('number'   , '거래량이동평균60');
	         data3.addColumn('number'   , '거래량');
			
	         var dataRow = [];
	         
	         for(var i = 0; i <wall['qwer'].length; i++) {
	             var volumeAvg60		= wall.qwer[i].volumeAvg60;
	             var volume				= wall.qwer[i].volume;
	             var year				= wall.qwer[i].year; 
	             var month				= wall.qwer[i].month; 
	             var day				= wall.qwer[i].day;
	             var dealDate			= wall.qwer[i].dealDate;
	             
	          
	             dataRow = [dealDate, volumeAvg60, volume];
	             data3.addRow(dataRow);
	           }
	         
		
			var options3 = {
					title : '거래량...???',
					vAxis: {title: 'Cups'},
					hAxis : {format: chartDateformat},
					seriesType: 'bars',
					series: {0: {type: 'line'}},
				};
			
			var chart3 = new google.visualization.ComboChart(document.getElementById('chart_div3'));
	        chart3.draw(data3, options3);
			
		}
  
		
		/* function googleChartCall(data, options, divId) {
			var chart = new google.visualization.ComboChart(document.getElementById(divId));
			chart.draw(data, options);
			//반응형 그래프 출력 - 반응형 그래프를 원하지 않을 시 제거하거나 주석처리 하세요.
	        window.addEventListener('resize', function() { chart.draw(data, options); }, false);
		} */
		
		
		/* function findSubject(){
			 var rrr = document.getElementsByName("subject");
			 alert(rrr);
		} */

		   $.ajax({
			  dataType:"json",
			  url:"testb.do",
	    	   data: 'rewq', 
			  success: function(bio) {
				  // console.log(bio); // 출력 확인
				  gridtable(bio);
			  },
				  error : function(e) {
			    	  	console.log(e);
			    	  }
			  }); 
        
        
 function gridtable(bio) {

       // 변수 선언
       var i, max, myData, grid = $("#list2");

       // grid 설정
       grid.jqGrid({
           datatype: 'json',
           height: 'auto',
           colNames:['dealDate','itemName', 'priceOpen', 'priceHigh','priceLow','priceClose','compared3','fluctuation','volume'],
           colModel:[
               {name:'dealDate',index:'dealDate', width:75, align:"center",sorttype:"date"},
               {name:'itemName',index:'itemName', width:75, align:"right",sorttype:"spring"},
               {name:'priceOpen',index:'priceOpen', width:85, align:"right",sorttype:"spring"},
               {name:'priceHigh',index:'priceHigh', width:85, align:"right",sorttype:"spring"},
               {name:'priceLow',index:'priceLow', width:85, align:"right",sorttype:"spring"},
               {name:'priceClose',index:'priceClose', width:85, align:"right",sorttype:"spring"},
               {name:'compared3',index:'compared3', width:85,align:"right",sorttype:"spring"},
               {name:'fluctuation',index:'fluctuation', width:85,align:"right",sorttype:"spring"},
               {name:'volume',index:'volumeAvg60', width:85,align:"right",sorttype:"spring"},
           ],
           multiselect: true,
           caption: "Manipulating Array Data"
       });

       myData = bio;
       console.log(myData);

       // 데이터 추가
       for( i=0, max = myData['rewq'].length ; i<=max ; i++ ){
           grid.jqGrid('addRowData', i+1, myData['rewq'][i]);
       }
   }




    </script>

</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<table id="list2"></table><!-- ajax로 만든 리스트 -->
<div id="pager2"></div>

 <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
        <input type="hidden" name="selectedId" /> 
        <input type="hidden" id="itemId"  />
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
        			</tr><!-- <fmt:formatNumber value="${result.priceOpen}" pattern="#,###,###" /> -->

        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr onClick="call('<c:out value="${result.itemId}"/>');">
            				<td align="center" class="listtd"><c:out value="${result.itemId}"/></td>   
            				<td align="center" class="listtd"><c:out value="${result.itemName}"/></td> 
            				<%-- <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.itemId}"/>','<c:out value="${result.dealDate}"/>')"><c:out value="${result.itemName}"/></a></td> --%>
            				<td align="center" class="listtd"><fmt:formatNumber value="${result.priceOpen}" pattern="#,###,###" /></td>
            				<td align="center" class="listtd"><fmt:formatNumber value="${result.priceHigh}" pattern="#,###,###" /></td>
            				<td align="center" class="listtd"><fmt:formatNumber value="${result.priceLow}" pattern="#,###,###" /></td>
            				<td align="center" class="listtd"><fmt:formatNumber value="${result.priceClose}" pattern="#,###,###" /></td>
             				<c:if test="${result.compared3 > 0}"><!-- 전일대비 -->
				            	<td align="center" class="listtd" style="color:red;"><fmt:formatNumber value="${result.compared3}" pattern="#,###,###" /></td>
			            	</c:if>
			            	<c:if test="${result.compared3 < 0}">
				            	<td align="center" class="listtd" style="color:blue;"><fmt:formatNumber value="${result.compared3}" pattern="#,###,###" /></td>
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
<!--    
<div id="chartArea" class="dis-none" style="text-align: left;">
	<label><input type="radio" name="calender" value="aaa" checked>일</input></label>
	<label><input type="radio" name="calender" value="bbb">주</input></label>
	<label><input type="radio" name="calender" value="ccc">월</input></label>
	 <input type="radio" name="asdf" value="asdf" onClick="call('d');">월</input> 
</div> -->

<!-- 구글 차트 -->
<!-- 구글 막대 차트 -->
<!-- <div id="chart_div1"></div>
<div id="chart_div2"></div>
<div id="chart_div3"></div> -->


<!-- 
<div class="content">
	<table border="1" width="600" height="200">
			<tr>
				<th rowspan="2">거래일</th>
				<th rowspan="2">종가</th>
				<th colspan="4">가격이동평균</th>
				<th rowspan="2">거래량</th>
				<th colspan="6">거래량이동평균</th>
			</tr>
			<tr>
				<th>5일</th>
				<th>10일</th>
				<th>20일</th>
				<th>60일</th>
				<th>5일</th>
				<th>20일</th>
				<th>60일</th>
			</tr>
			<tr>
				<td>거래일</td>
				<td>종가</td>
				<td>5일</td>
				<td>10일</td>
				<td>20일</td>
				<td>60일</td>
				<td>거래량</td>
				<td>5일</td>
				<td>20일</td>
				<td>60일</td>
			</tr>
	</table>
</div>
 -->
 
 
<div>
	<table style="border: 1px;" id="dynamicTable">
		 <thead>
			 <tr>
				<th rowspan="2">거래일</th>
				<th rowspan="2">종가</th>
				<th colspan="4">가격이동평균</th>
				<th rowspan="2">거래량</th>
				<th colspan="6">거래량이동평균</th>
			</tr>
			<tr>
				<th>5일</th>
				<th>10일</th>
				<th>20일</th>
				<th>60일</th>
				<th>5일</th>
				<th>20일</th>
				<th>60일</th>
			</tr>
		 </thead>
	 <tbody id="dynamicTbody">
	 
	 
	</tbody>
	</table>
</div>





 
</body>
</html>
