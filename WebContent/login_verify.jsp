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
<title>登入驗證</title>
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
	<!-- 連線至資料庫 -->
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
	<!-- 接收表單傳送資料 -->
	<c:set var="param_account" value="${param['account']}"/>  		<!-- 由於編碼問題，所以要特別訂一個變數來儲存內容 -->
	<c:set var="param_password" value="${param['password']}"/>		<!-- 由於編碼問題，所以要特別訂一個變數來儲存內容 -->
	<c:set var="param_remember_me" value="${param['remember_me']}"/><!-- 由於編碼問題，所以要特別訂一個變數來儲存內容 -->
	<!-- 驗證輸入資料 -->
	<c:forEach var="row" items="${result.rows}">
		<c:set var="row_account" value="${row.account}"/>			<!-- 由於編碼問題，所以要特別訂一個變數來儲存內容 -->
		<c:set var="row_password" value="${row.password}"/>			<!-- 由於編碼問題，所以要特別訂一個變數來儲存內容 -->
		<!-- 如果有選擇記住我，那麼cookie的存留時間就設定成一天 -->
		<c:if test="${(param_account==row_account)&&(param_password==row_password)&&(param_remember_me=='yes')}">
			<script>
				/*讀取資料時需要加上強制轉型*/
				var account=String("<%=request.getParameter("account")%>");
				var password=String("<%=request.getParameter("password")%>");
				document.cookie=account+"="+password+";max-age=86400;";
				window.location.assign("member.jsp");
			</script>
		</c:if>
		<!-- 如果沒選擇記住我，那麼cookie在關閉瀏覽器後便消失 -->
		<c:if test="${(param_account==row_account)&&(param_password==row_password)}">
			<script>
				/*讀取資料時需要加上強制轉型*/
				var account=String("<%=request.getParameter("account")%>");
				var password=String("<%=request.getParameter("password")%>");
				document.cookie=account+"="+password;
				window.location.assign("member.jsp");
			</script>
		</c:if>
	</c:forEach>
	<script>
		/*如果前面的迴圈執行完都沒有符合條件才會執行此區域*/
		Swal.fire({
  			title:"登入失敗",
  			/*text:"返回登入畫面",*/
  			icon:"error",
  			showCancelButton:false,
  			confirmButtonColor:"#dd3333",
  			cancelButtonColor:"#3085d6",
  			confirmButtonText:"返回登入畫面"
		}).then((result) => {
  			if (true) {
  				window.location.assign("login.jsp");
  			}
		})
	</script>
</body>
</html>