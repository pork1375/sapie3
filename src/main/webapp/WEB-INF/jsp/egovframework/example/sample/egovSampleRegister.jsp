<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery 그래프 차트 -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/deleteSample.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
        	if(!validateSampleVO(frm)){
                return;
            }else{
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addSample.do' : '/updateSample.do'}"/>";
                frm.submit();
            }
        }
        
        -->
  
        
        $(function(){
       	var itemId = $("#itemId").val();
       	var dealDate = $("#dealDate").val();
       	
   		console.log("첫번째출력");
    	$.ajax({
    	  dataType: "json",
    	  url:"testa.do",
    	  //data:"qwer",
    	  data: {
    		  'itemId' : itemId, // 컨트롤러 itemId 가져오기
    		  'dealDate' : dealDate // 컨트롤러 날짜 가져오기
    	  },
    	  success: function(wall) {
    		  console.log(wall); // 출력 확인
    		  //console.log(wall.qwer[0].dealDate); // 날짜
    		  
    		  var chartDrowFun = {
    		     	    chartDrow : function(){
    		     	        var chartData = '';
    		     	 
    		     	        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
    		     	        var chartDateformat     = 'yyyy년MM월dd일';
    		     	        //라인차트의 라인 수
    		     	        var chartLineCount    = 30;
    		     	        //컨트롤러 바 차트의 라인 수
    		     	        var controlLineCount    = 30;
    		     	 
    		     	 
    		     	        function drawDashboard() {
    		     	 
    		     	          var data = new google.visualization.DataTable();
    		     	          
    		     	          //그래프에 표시할 컬럼 추가
    		     	          data.addColumn('datetime' , '날짜');
    		     	          data.addColumn('number'   , '5일');
    		     	          data.addColumn('number'   , '10일');
    		     	          data.addColumn('number'   , '20일');
    		     	          data.addColumn('number'   , '60일');
    		     	          data.addColumn('number'   , '120일');
    		     	          data.addColumn('number'   , '종가');
    		     	 
    		     	          //그래프에 표시할 데이터
    		     	          var dataRow = [];
    		     	 
    		     	          for(var i = 0; i < wall['qwer'].length; i++) { //랜덤 데이터 생성
    		     	            var priceAvg5		= wall.qwer[i].priceAvg5;
    		     	            var priceAvg10		= wall.qwer[i].priceAvg10;
    		     	            var priceAvg20		= wall.qwer[i].priceAvg20;
    		     	            var priceAvg60		= wall.qwer[i].priceAvg60;
    		     	            var priceAvg120		= wall.qwer[i].priceAvg120;
    		     	            var priceClose		= wall.qwer[i].priceClose;
    		     	            var year	= wall.qwer[i].year; 
    		     	            var month	= wall.qwer[i].month; 
    		     	            var day		= wall.qwer[i].day;
    		     	            
    		     	         
    		     	            dataRow = [new Date(year, month, day), priceAvg5, priceAvg10, priceAvg20, priceAvg60, priceAvg120 ,priceClose];
    		     	            data.addRow(dataRow);
    		     	           
    		     	           /*console.log(priceOpen);
    		     	            console.log(year);
    		     	            console.log(month);
    		     	            console.log(day); */
    		     	          }
    		     	          
    		     	          
    		     	         /* for(var i = 0; i <= 60; i++){ //랜덤 데이터 생성
     		     	            var total   = Math.floor(Math.random() * 300) + 1;
     		     	            var man     = Math.floor(Math.random() * total) + 1;
     		     	            var woman   = total - man;
     		     	            var eee		= wall.qwer[i].priceOpen;
     		     	            dataRow = [new Date('2018', '09', i , '10'), eee];
     		     	            data.addRow(dataRow);
     		     	            console.log(eee);
     		     	          } */
    		     	 
    		     	 
    		     	            var chart = new google.visualization.ChartWrapper({
    		     	              chartType   : 'LineChart',
    		     	              containerId : 'lineChartArea', //라인 차트 생성할 영역
    		     	              options     : {
    		     	                              isStacked   : 'percent',
    		     	                              focusTarget : 'category',
    		     	                              height          : 500,
    		     	                              width              : '100%',
    		     	                              legend          : { position: "top", textStyle: {fontSize: 13}},
    		     	                              pointSize        : 5,
    		     	                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
    		     	                              hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
    		     	                                                                  years : {format: ['yyyy년']},
    		     	                                                                  months: {format: ['MM월']},
    		     	                                                                  days  : {format: ['dd일']},
    		     	                                                                  hours : {format: ['HH시']}}
    		     	                                                                },textStyle: {fontSize:12}},
    		     	                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
    		     	                animation        : {startup: true,duration: 1000,easing: 'in' },
    		     	                annotations    : {pattern: chartDateformat,
    		     	                                textStyle: {
    		     	                                fontSize: 15,
    		     	                                bold: true,
    		     	                                italic: true,
    		     	                                color: '#871b47',
    		     	                                auraColor: '#d799ae',
    		     	                                opacity: 0.8,
    		     	                                pattern: chartDateformat
    		     	                              }
    		     	                            }
    		     	              }
    		     	            });
    		     	 
    		     	            var control = new google.visualization.ControlWrapper({
    		     	              controlType: 'ChartRangeFilter',
    		     	              containerId: 'controlsArea',  //control bar를 생성할 영역
    		     	              options: {
    		     	                  ui:{
    		     	                        chartType: 'LineChart',
    		     	                        chartOptions: {
    		     	                        chartArea: {'width': '60%','height' : 80},
    		     	                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
    		     	                            gridlines:{count:controlLineCount,units: {
    		     	                                  years : {format: ['yyyy년']},
    		     	                                  months: {format: ['MM월']},
    		     	                                  days  : {format: ['dd일']},
    		     	                                  hours : {format: ['HH시']}}
    		     	                            }}
    		     	                        }
    		     	                  },
    		     	                    filterColumnIndex: 0
    		     	                }
    		     	            });
    		     	 
    		     	            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
    		     	            date_formatter.format(data, 0);
    		     	 
    		     	            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
    		     	            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
    		     	            dashboard.bind([control], [chart]);
    		     	            dashboard.draw(data);
    		     	 
    		     	        }
    		     	          google.charts.setOnLoadCallback(drawDashboard);
    		     	 
    		     	      }
    		     	    }
    		  
    		  
    		  $(document).ready(function(){
    	     	  google.charts.load('current', {'packages':['line','controls']});
    	     	  chartDrowFun.chartDrow(); //chartDrow() 실행
    	     	}); 
    		  
    		  
    	  },
    	  error : function(e) {
    	  	console.log(e);
    	  }
    	});
        });
    	
/*     $(document).ready(function(){
    
    });   */

        
        
     // 차트 시작--------------------------------
     
    // 차트 종료------------------------------------
     	 
      	

    </script>
    

    
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
<input type="hidden" id="itemId" value="${sampleVO.itemId}"/>
<input type="hidden" id="dealDate" value="${sampleVO.dealDate}"/> 
<%-- <fmt:formatDate id="dealDate" value="${sampleVO.dealDate}" pattern="yyyy-MM-dd" /> --%>

${sampleVO.itemId}
${sampleVO.dealDate}

    <div id="Line_Controls_Chart">
      라인 차트 생성할 영역
          <div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
      컨트롤바를 생성할 영역
          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
        </div> 
        

</body>
</html>