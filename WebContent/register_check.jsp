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
<title>資訊確認</title>
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
        #registerform{
        	margin-top:15%;
        }
	</style>
</head>
<body class="d-flex flex-column h-100">
	<!-- 載入會員資料庫 -->
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
    <sql:query dataSource="${DataBase}" var="result">
    	SELECT * FROM member;
	</sql:query>
	<!-- 設定表單傳送變數 -->
	<c:set var="account" value="${param['account']}"/>
	<c:set var="password" value="${param['password']}"/>
	<c:set var="name" value="${param['name']}"/>
	<c:set var="phone" value="${param['phone']}"/>
	<c:set var="address" value="${param['address']}"/>
	<!-- 檢查帳號是否已註冊 -->
	<c:forEach var="row" items="${result.rows}">
		<c:if test="${account==row.account}">
			<script>
				window.alert("帳號已被註冊，返回註冊頁面");
				window.location.assign("register.jsp");
			</script>
		</c:if>
	</c:forEach>
	<!-- 標題導覽列 -->
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<div class="container-fluid text-light">
				<span class="navbar-brand">會員註冊</span>
      			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          			<li class="nav-item">
            			<a class="nav-link" href="index.html">回到首頁</a>
          			</li>
        		</ul>
    		</div><!-- container-fluid -->
		</nav>
	</header>
	<!-- 顯示傳送資料 -->
	<div class="container" id="registerform">
		<div class="row">
			<div class="col-1 col-md-3"></div><!-- 空白部分 -->
			<div class="col-10 col-md-6">
				<form action="register_add_member.jsp" method="post">
					<h3 align="center">輸入資訊確認</h3>
					<table class="table table-bordered">
						<tr>
							<td><h4>帳號</h4></td>
							<td><h4>${account}</h4></td>
						</tr>
						<tr>
							<td><h4>密碼</h4></td>
							<td><h4>${password}</h4></td>
						</tr>
						<tr>
							<td><h4>姓名</h4></td>
							<td><h4>${name}</h4></td>
						</tr>
						<tr>
							<td><h4>電話</h4></td>
							<td><h4>${phone}</h4></td>
						</tr>
						<tr>
							<td><h4>地址</h4></td>
							<td><h4>${address}</h4></td>
						</tr>
						<tr>
							<td>
								<button type="button" class="btn btn-outline-dark" onclick="javascript:GoBack();">
									<script>
										function GoBack(){
											window.location.assign("register.jsp");
										}
									</script>
									重新輸入
								</button>
							</td>
							<td>
								<div class="input-group">
									<button type="button" class="btn btn-outline-dark" name="check" id="check">確認</button>
									<button type="submit" class="btn btn-outline-dark" name="submit" id="submit">送出</button>
								</div>
							</td>
						</tr>
					</table>
					<input type="hidden" name="account" value="${account}">		<!-- 在表單裡面用來記錄送出的項目 -->
					<input type="hidden" name="password" value="${password}">	<!-- 在表單裡面用來記錄送出的項目 -->
					<input type="hidden" name="name" value="${name}">			<!-- 在表單裡面用來記錄送出的項目 -->
					<input type="hidden" name="phone" value="${phone}">			<!-- 在表單裡面用來記錄送出的項目 -->
					<input type="hidden" name="address" value="${address}">		<!-- 在表單裡面用來記錄送出的項目 -->
				</form>
			</div>
			<div class="col-1 col-md-3"></div><!-- 空白部分 -->
		</div><!-- row -->
	</div><!-- container -->
	<script>
		$(document).ready(function(){         
			$("#submit").hide();
			$("#check").click(function(){
				$("#submit").toggle(500);
			});
		});
	</script>
</body>
</html>