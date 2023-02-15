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
<title>會員註冊</title>
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
	<div class="container" id="registerform">
		<div class="row">
			<div class="col-1 col-md-3"></div><!-- 空白部分 -->
			<div class="col-10 col-md-6">
				<form action="register_check.jsp" method="post">
					<table class="table table-bordered">
						<tr>
							<td><h4>帳號</h4></td>
							<td>
								<div class="input-group">
									<input type="text" class="form-control" name="account" id="account" placeholder="請輸入帳號" pattern="[a-zA-Z0-9]{5,}" title="僅限五個字元以上英數組合" required>
								</div>
							</td>
						</tr>
						<tr>
							<td><h4>密碼</h4></td>
							<td>
								<div class="input-group">
									<input type="password" class="form-control" name="password" id="password" placeholder="請輸入密碼" pattern="[a-zA-Z0-9]{5,}" title="僅限五個字元以上英數組合" required>
								</div>
							</td>
						</tr>
						<tr>
							<td><h4>姓名</h4></td>
							<td>
								<div class="input-group">
									<input type="text" class="form-control" name="name" id="name" placeholder="請輸入姓名" required>
								</div>
							</td>
						</tr>
						<tr>
							<td><h4>電話</h4></td>
							<td>
								<div class="input-group">
									<input type="text" class="form-control" name="phone" id="phone" placeholder="請輸入手機號碼" pattern="[0-9]{10}" required>
								</div>
							</td>
						</tr>
						<tr>
							<td><h4>地址</h4></td>
							<td>
								<div class="input-group">
									<input type="text" class="form-control" name="address" id="address" placeholder="請輸入地址" required>
								</div>
							</td>
						</tr>
						<tr>
							<td><button type="reset" class="btn btn-outline-dark">重設</button></td>
							<td>
								<div class="input-group">
									<button type="button" class="btn btn-outline-dark" name="check" id="check">確認</button>
									<button type="reset" class="btn btn-outline-dark" id="cancel">取消</button>
									<button type="submit" class="btn btn-outline-dark" name="submit" id="submit">送出</button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="col-1 col-md-3"></div><!-- 空白部分 -->
		</div><!-- row -->
	</div><!-- container -->
	<script>
		$(document).ready(function(){
			$("#cancel").hide();          //一開始先把按鍵藏起來
			$("#submit").hide();
			$("#check").click(function(){ //按下確認時，再把按鈕顯示出來
				$("#cancel").toggle(500);
				$("#submit").toggle(500);
			});
		});
	</script>
</body>
</html>