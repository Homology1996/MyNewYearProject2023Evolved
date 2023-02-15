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
<title>新增會員資料</title>
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
	</style>
</head>
<body class="d-flex flex-column h-100">
	<!-- 蒐集表單送出資訊 -->
	<c:set var="Account" value="${param['account']}"/>
	<c:set var="Password" value="${param['password']}"/>
	<c:set var="Name" value="${param['name']}"/>
	<c:set var="Phone" value="${param['phone']}"/>
	<c:set var="Address" value="${param['address']}"/>
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
	<!-- 找出最大的會員id -->
	<sql:query dataSource="${DataBase}" var="MaxID">
    	SELECT member_index from member;
	</sql:query>
	<c:set var="MaxIndex" value="${fn:length(MaxID.rows)}"/><!-- 會員編號是從0號開始，所以找出來的長度會比編號多1 -->
	<!-- 移除舊有資料 -->
	<sql:update dataSource="${DataBase}" var="Delete">
		DELETE FROM member WHERE account="<c:out value='${Account}'/>";
	</sql:update>
	<!-- 新增註冊資料 -->
	<sql:update dataSource="${DataBase}" var="Insert">
		INSERT INTO member VALUES 
		("<c:out value='${MaxIndex}'/>","<c:out value='${Name}'/>","<c:out value='${Phone}'/>","<c:out value='${Address}'/>"
		,"<c:out value='${Account}'/>","<c:out value='${Password}'/>","");
	</sql:update>
	<!-- 新增使用者登入cookie並且跳轉至會員中心 -->
	<script>
		var account="${Account}";
		var password="${Password}";
		document.cookie=account+"="+password;
		window.location.assign("member.jsp");
	</script>
</body>
</html>