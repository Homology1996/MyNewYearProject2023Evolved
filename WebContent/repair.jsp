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
<title>修繕頁面</title>
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
      				<span class="navbar-brand">修繕</span>
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
			<!-- 下方文字區塊 -->
			<div class="col-12 col-md-12"><br></div>
			<div class="col-12 col-md-12">
				<form action="repair_content.jsp" method="post">
					<table class="table table-borderless">
						<tr>
							<td><h3>請輸入修繕內容</h3></td>
						</tr>
						<tr>
							<td>
								<div class="form-control">
								<textarea name="content" class="form-control" rows="10" cols="50"></textarea>
								</div>
							</td>
							<td>
								<div class="input-group">
									<button type="reset" class="input-group btn btn-warning">重設</button>
								</div>
								<div class="input-group">
									<button type="submit" class="input-group btn btn-success">送出</button>
								</div>
							</td>
						</tr>
					</table>
					<input type="hidden" name="Order_name" value="${order_name}">
					<input type="hidden" name="Item_index" value="${item_index}">
				</form>
			</div><!-- col-md-12 -->
		</div><!-- row -->
	</div><!-- container -->
</body>
</html>