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
<title>續租頁面</title>
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
      				<span class="navbar-brand">續租</span>
        			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          				<li class="nav-item">
            				<a class="nav-link" aria-current="page" href="index.html">返回首頁</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="login.jsp">會員中心</a>
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
	<!-- 設置修改資訊 -->
	<c:set var="end"/>
	<c:set var="imageID"/>
	<c:set var="EndID"/>
	<!-- 讀取資料庫 -->
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
	<!-- 讀取訂單資料庫 -->
	<sql:query dataSource="${DataBase}" var="orderlist">
    	SELECT * from orderlist;
	</sql:query>
	<!-- 主畫面 -->
	<div class="container" id="div_all">
		<div class="row">
			<div class="col-12 col-md-12">
				<!-- 查詢本次售後服務訂單 -->
				<table class="table">
					<tr>
						<th>訂單編號</th>
						<th>商品編號</th>
						<th>出租時間</th>
						<th>起始時間</th>
						<th>結束時間</th>
						<th>出租金額</th>
					</tr>
					<c:forEach var="row" items="${orderlist.rows}">
						<c:if test="${(row.order_name==order_name)&&(row.item_index==item_index)}">
							<c:set var="ThisEnd" value="${row.end}"/>
							<%
							String item_index=(String)pageContext.getAttribute("item_index");
							String thisend=(String)pageContext.getAttribute("ThisEnd");
							String ImageID="images/pic"+item_index+".jpg";
							pageContext.setAttribute("end",thisend);
							pageContext.setAttribute("imageID",ImageID);
							%>
							<tr>
								<td>${row.order_name}</td>
								<td>${row.item_index}</td>
								<td>${row.item_rent_time}個月</td>
								<td>${row.start}</td>
								<td>${row.end}</td>
								<td>${row.price}元</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div><!-- col-12 -->
			<div class="col-12 col-md-6">
				<img src="${imageID}" width="95%" height="95%">
			</div><!-- col-md-6 -->
			<div class="col-12 col-md-6">
				<form action="continue_receive.jsp" method="post">
					<br>
					<table class="table">
						<tr>
							<td align="center">選擇延長時間</td>
							<td>
								<select class="form-select" name="Extend">
									<option value="1">一個月</option>
									<option value="6">六個月</option>
									<option value="12">一年</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<button type="reset" class="input-group btn btn-warning">重設</button>
								</div>
							</td>
							<td>
								<div class="input-group">
									<button type="submit" class="input-group btn btn-success">送出</button>
								</div>
							</td>
						</tr>
					</table>
					<input type="hidden" name="Order_name" value="${order_name}">
					<input type="hidden" name="Item_index" value="${item_index}">
				</form>
			</div><!-- col-md-6 -->
		</div><!-- row -->
	</div><!-- container -->
</body>
</html>