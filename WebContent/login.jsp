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
<title>會員登入</title>
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
        #loginform{
        	margin-top:20%;
        }
	</style>
</head>
<body class="d-flex flex-column h-100">
	<!-- 讀取資料庫裏面的會員帳號與密碼 -->
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
    	SELECT account,password from member;
	</sql:query>
	<!-- 用cookie來檢查會員是否已經登入 -->
	<c:forEach var="row" items="${result.rows}">
		<script>                                                 
			var Row_account=String("${row.account}");            /*利用expression language，把JSTL的變數傳遞到Javascript*/
			var Row_password=String("${row.password}");          /*利用expression language，把JSTL的變數傳遞到Javascript*/
			if(Row_password==GetCookieValueByName(Row_account)){ /*檢查密碼的時候就會同時一起檢查帳號*/
				window.location.assign("member.jsp");
			}
		</script>
	</c:forEach>
	<!-- 標題導覽列 -->
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<div class="container-fluid text-light">
				<span class="navbar-brand">會員登入</span>
      			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          			<li class="nav-item">
            			<a class="nav-link" href="index.html">回到首頁</a>
          			</li>
        		</ul>
    		</div><!-- container-fluid -->
		</nav>
	</header>
	<div class="container" id="loginform" align="center">
		<div class="row">
			<div class="col-1 col-md-3"></div><!-- 空白部分 -->
			<div class="col-10 col-md-6">
				<form action="login_verify.jsp" method="get">
					<table class="table">
						<tr>
							<td><h4>帳號</h4></td>
							<td>
								<div class="input-group">
									<input type="text" class="form-control" style="width:70%;" name="account" placeholder="請輸入帳號">
								</div>
							</td>
						</tr><!-- 第一列 -->
						<tr>
							<td><h4>密碼</h4></td>
							<td>
								<div class="input-group">
									<input type="password" class="form-control" style="width:70%;" name="password" placeholder="請輸入密碼">
								</div>
							</td>
						</tr><!-- 第二列 -->
						<tr>
							<td><button type="reset" class="btn btn-outline-dark">重設</button></td>
							<td>
								<button type="submit" class="btn btn-outline-dark" name="submit" id="submit">登入</button>&nbsp;&nbsp;
								<input type="checkbox" class="btn-check" name="remember_me" value="yes" id="btn-check-outlined" autocomplete="off">
								<label class="btn btn-outline-primary" for="btn-check-outlined">記住我</label>
							</td>
						</tr><!-- 第三列 -->
						<tr>
							<td><a href="error.html" class="link-primary">忘記密碼</a></td>
							<td><a href="register.jsp" class="link-primary">沒有會員？前往註冊</a></td>
						</tr><!-- 第四列 -->
					</table>
				</form>
			</div>
			<div class="col-1 col-md-3"></div><!-- 空白部分 -->
		</div><!-- row -->
	</div><!-- container -->
</body>
</html>