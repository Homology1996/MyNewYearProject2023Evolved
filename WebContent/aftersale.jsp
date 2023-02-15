<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.net.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%><!-- JSP時間轉換格式 -->
<%@ page import="java.lang.Math"%><!-- 處理long類型計算的套件 -->
<!-- 引入JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="h-100">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>售後服務</title>
	<!-- 引用Bootstrap -->
	<link rel="stylesheet" href="assets/dist/css/bootstrap.min.css">
	<script src="assets/dist/js/bootstrap.bundle.min.js"></script>
	<!-- 引用jQuery -->
	<script src="scripts/jquery.min.js"></script>
	<script src="scripts/jquery.cookie.js"></script>
	<!-- 引用外部javascript -->
	<script src="scripts/GetCookie.js"></script>
	<script src="scripts/SetCookie.js"></script>
	<!-- 下拉式選單 -->
	<script src="scripts/popper.min.js"></script>
	<!-- Bootstrap時間挑選器 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
	<!-- 彈跳視窗樣式 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="sweetalert2.all.min.js"></script>
	<style>
		body{
			background-color:rgba(225,245,241,0.947);
			/*
            background-image:url("images/back.png");
            background-size:cover;
            background-repeat:repeat no-repeat;
            */
        }
        #div_all{
        	margin-top:75px;
        }
	</style>
</head>
<body class="d-flex flex-column h-100">
	<!-- 標題導覽列 -->
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<div class="container-fluid">
      			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        			<span class="navbar-toggler-icon"></span>
      			</button>
      			<div class="collapse navbar-collapse" id="navbarCollapse">
      				<span class="navbar-brand">售後服務</span>
        			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          				<li class="nav-item">
            				<a class="nav-link" aria-current="page" href="index.html">返回首頁</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="login.jsp">會員中心</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="products.jsp">前往商城</a>
          				</li>
        			</ul>
      			</div><!-- collapse -->
    		</div><!-- container-fluid -->
		</nav>
	</header>
	<!-- 讀取訂單與商品編號 -->
	<c:set var="order_item"/>
	<%
	Cookie[] cookies=request.getCookies();
	for(int i=0;i<cookies.length;i++){
		if(cookies[i].getName().contains("after")){   
			pageContext.setAttribute("order_item",cookies[i].getValue());
		}
	}
	%>
	<c:set var="array" value="${fn:split(order_item,'_')}"/>
	<c:set var="order_name" value="${array[0]}"/>
	<c:set var="item_index" value="${array[1]}"/>
	<!-- 載入資料庫 -->
	<c:set var="DataBaseName" value="newyear"/>
	<c:set var="DataBaseUserAccount" value="newyear"/>
	<c:set var="DataBaseUserPassword" value="newyear"/>
	<c:set var="DataBaseURL"/>
	<%
	String name=(String)pageContext.getAttribute("DataBaseName");
	String url="jdbc:mysql://localhost:3306/"+name;
	pageContext.setAttribute("DataBaseURL",url);
	%>
	<sql:setDataSource var="DataBase" driver="com.mysql.cj.jdbc.Driver"
	url="${DataBaseURL}" user="${DataBaseUserAccount}" password="${DataBaseUserPassword}"/>
	<!-- 查詢商品資料表 -->
	<sql:query dataSource="${DataBase}" var="commodity">
    	SELECT * FROM commodity;
	</sql:query>
	<!-- 查詢訂單資料表 -->
	<sql:query dataSource="${DataBase}" var="orderlist">
    	SELECT * FROM orderlist;
	</sql:query>
	<div class="container" id="div_all">
		<div class="row">
			<!-- 左邊圖片 -->
			<div class="col-12 col-md-6">
				<c:forEach var="row" items="${commodity.rows}">
					<c:if test="${row.item_index==item_index}">
						<c:set var="imgsrc"/>
						<%
						String id=(String)pageContext.getAttribute("item_index");
						String src="images/pic"+id+".jpg";
						pageContext.setAttribute("imgsrc",src);
						%>
						<img src="${imgsrc}" width="100%" height="95%" class="rounded">
					</c:if>
				</c:forEach>
			</div><!-- col-md-6 -->
			<!-- 右邊文字說明 -->
			<div class="col-12 col-md-6 pt-auto">
				<c:forEach var="row" items="${orderlist.rows}">
					<c:if test="${(row.order_name==order_name)&&(row.item_index==item_index)}">
						<c:set var="start" value="${row.start}"/>
						<c:set var="end" value="${row.end}"/>
						<br>
						<table class="table">
							<tr>
								<td>訂單編號</td>
								<td>${row.order_name}</td>
							</tr>
							<tr>
								<td>商品編號</td>
								<td>${row.item_index}</td>
							</tr>
							<tr>
								<td>出租時間</td>
								<td>${row.item_rent_time}個月</td>
							</tr>
							<tr>
								<td>起始時間</td>
								<td>${row.start}</td>
							</tr>
							<tr>
								<td>結束時間</td>
								<td>${row.end}</td>
							</tr>
							<tr>
								<td>出租金額</td>
								<td>${row.price}元</td>
							</tr>
						</table>
					</c:if>
				</c:forEach>
			</div><!-- col-md-6 -->
			<!-- 下方按鈕 -->
			<div class="col-12 col-md-12"><br></div>
			<div class="col-12 col-md-12">
				<div class="container" align="center">
        			<div class="row">
        				<div class="col-4">
          					<button type="button" class="btn btn-outline-dark" id="repair_button" onclick="javascript:repair();">
              					<script>
                  					function repair(){
                      					window.location.assign("repair.jsp");
                  					}
             					</script>
              					<h1>修繕</h1>
          					</button>
       					</div><!--col-4-->
        				<div class="col-4">
        					<button type="button" class="btn btn-outline-dark" id="continue_button" onclick="javascript:continue_order();">
            					<script>
                					function continue_order(){
                    					window.location.assign("continue_order.jsp");
                					}
            					</script>
             					<h1>續租</h1>
        					</button>
      					</div><!--col-4-->
         				<div class="col-4">
            				<button type="button" class="btn btn-outline-dark" id="withdraw_button" onclick="javascript:withdraw();">
                				<script>
                    				function withdraw(){
                        				window.location.assign("withdraw.jsp");
                    				}
                				</script>
                				<h1>退租</h1>
            				</button>
          				</div><!--col-4-->
        			</div><!--row-->
    			</div><!--container-->
			</div><!-- col-md-12 -->
		</div><!-- row -->
	</div><!-- container -->
	<!-- 比對今天與訂單的起始結束日期，並決定是否能續租或是修繕 -->
	<c:set var="repair_status"/>
	<c:set var="continue_status"/>
	<c:set var="now" value="<%=new java.util.Date()%>" /><!-- 獲取今天的日期 -->
	<fmt:formatDate var="today" pattern="yyyy-MM-dd" value="${now}" />
	<!-- 尋找該商品是否有下一筆訂單 -->
	<c:forEach var="row" items="${orderlist.rows}">
		<c:if test="${row.item_index==item_index}">
			<c:set var="MaxStart" value="${row.start}"/>
			<c:set var="MaxOrdername" value="${row.order_name}"/>
		</c:if>
	</c:forEach>
	<%
	String start=(String)pageContext.getAttribute("start");
	String end=(String)pageContext.getAttribute("end");
	String today=(String)pageContext.getAttribute("today");
	String maxstart=(String)pageContext.getAttribute("MaxStart");
	SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
	try{
		java.util.Date parsedStart=formatter.parse(start);
		java.util.Date parsedEnd=formatter.parse(end);
		java.util.Date parsedToday=formatter.parse(today);
		java.util.Date parsedMaxstart=formatter.parse(maxstart);
		long Start_millisecond=parsedStart.getTime();
		long End_millisecond=parsedEnd.getTime();
		long Today_millisecond=parsedToday.getTime();
		long Maxstart_millisecond=parsedMaxstart.getTime();
		if((Today_millisecond>=Start_millisecond)&&(Today_millisecond<End_millisecond)){
			pageContext.setAttribute("continue_status","yes");
			/*進行中的訂單才能續租*/
			pageContext.setAttribute("repair_status","yes");
			/*進行中的訂單才能修繕*/
		}
		else{
			pageContext.setAttribute("continue_status","no");
			/*未進行的訂單，或是已過期的訂單，就不能續租*/
			pageContext.setAttribute("repair_status","no");
			/*未進行的訂單，或是已過期的訂單，就不能修繕*/
		}
		if(Today_millisecond<Maxstart_millisecond){
			pageContext.setAttribute("continue_status","no");
			/*如果還有下一筆訂單，就不能續租*/
		}
	}
	catch (java.text.ParseException e) {
		e.printStackTrace();
	}									
	%>
	<!-- 找出是否有下一筆訂單，並決定是否能退租 -->
	<c:choose>
		<c:when test="${order_name==MaxOrdername}">
			<c:set var="withdraw_status" value="yes"/>
		</c:when>
		<c:otherwise>
			<c:set var="withdraw_status" value="no"/>
		</c:otherwise>
	</c:choose>
	<!-- 關閉按鈕 -->
	<script>
		var repair_status="${repair_status}";
		var continue_status="${continue_status}";
		var withdraw_status="${withdraw_status}";
		if(repair_status=="no"){
			$(document).ready(function(){
				$("#repair_button").attr("disabled",true);
    		});
		}
		if(continue_status=="no"){
			$(document).ready(function(){
				$("#continue_button").attr("disabled",true);
    		});
		}
		if(withdraw_status=="no"){
			$(document).ready(function(){
				$("#withdraw_button").attr("disabled",true);
    		});
		}
	</script>
</body>
</html>