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
<title>資料修改中</title>
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
	<c:set var="revise_account" value="${param['revise_account']}"/>
	<c:set var="revise_name" value="${param['revise_name']}"/>
	<c:set var="revise_phone" value="${param['revise_phone']}"/>
	<c:set var="revise_address" value="${param['revise_address']}"/>
	<c:set var="revise_password" value="${param['revise_password']}"/>
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
	<c:if test="${fn:length(revise_name)>0}">
		<sql:update dataSource="${DataBase}" var="update">
			UPDATE member SET name="<c:out value="${revise_name}"/>" WHERE account="<c:out value="${revise_account}"/>";
		</sql:update>
	</c:if>
	<c:if test="${fn:length(revise_phone)>0}">
		<sql:update dataSource="${DataBase}" var="update">
			UPDATE member SET phone="<c:out value="${revise_phone}"/>" WHERE account="<c:out value="${revise_account}"/>";
		</sql:update>
	</c:if>
	<c:if test="${fn:length(revise_address)>0}">
		<sql:update dataSource="${DataBase}" var="update">
			UPDATE member SET address="<c:out value="${revise_address}"/>" WHERE account="<c:out value="${revise_account}"/>";
		</sql:update>
	</c:if>
	<c:if test="${fn:length(revise_password)>0}">
		<sql:update dataSource="${DataBase}" var="update">
			UPDATE member SET password="<c:out value="${revise_password}"/>" WHERE account="<c:out value="${revise_account}"/>";
		</sql:update>
	</c:if>
	<script>
		Swal.fire({
			title:"修改成功",
			icon:"success",
			showCancelButton:false,
			confirmButtonColor:"#3085d6",
			confirmButtonText:"返回首頁"
		}).then((result) => {
			if (true) {
				window.location.assign("index.html");
			}
		})
	</script>
</body>
</html>