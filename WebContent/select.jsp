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
<title>篩選結果</title>
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
        	margin-top:80px;
        }
	</style>
</head>
<body class="d-flex flex-column h-100">
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<div class="container-fluid">
      			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        			<span class="navbar-toggler-icon"></span>
      			</button>
      			<div class="collapse navbar-collapse" id="navbarCollapse">
      				<span class="navbar-brand">租俱網</span>
        			<ul class="navbar-nav me-auto mb-0 mb-md-0">
        				<li class="nav-item">
            				<a class="nav-link" href="index.html">返回首頁</a>
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
	<!-- 找出挑選的選項 -->
	<c:set var="selection"/>
	<%
	Cookie[] cookies=request.getCookies();
	for(int i=0;i<cookies.length;i++){
    	if(cookies[i].getName().equals("select")){
    		pageContext.setAttribute("selection",cookies[i].getValue());
    		break;
    	}
    }
	%>
	<c:set var="word"/>
	<c:choose>
		<c:when test="${selection=='bed'}">
			<%
			pageContext.setAttribute("word","床");
			%>
		</c:when>
		<c:when test="${selection=='table'}">
			<%
			pageContext.setAttribute("word","桌子");
			%>
		</c:when>
		<c:when test="${selection=='refrigerator'}">
			<%
			pageContext.setAttribute("word","冰箱");
			%>
		</c:when>
		<c:when test="${selection=='television'}">
			<%
			pageContext.setAttribute("word","電視");
			%>
		</c:when>
		<c:when test="${selection=='air_conditioner'}">
			<%
			pageContext.setAttribute("word","冷氣");
			%>
		</c:when>
		<c:when test="${selection=='laundry_machine'}">
			<%
			pageContext.setAttribute("word","洗衣機");
			%>
		</c:when>
		<c:when test="${selection=='low_price'}">
			<%
			pageContext.setAttribute("word","低價位");
			%>
		</c:when>
		<c:when test="${selection=='medium_price'}">
			<%
			pageContext.setAttribute("word","中價位");
			%>
		</c:when>
		<c:when test="${selection=='high_price'}">
			<%
			pageContext.setAttribute("word","高價位");
			%>
		</c:when>
		<c:otherwise>
			<script>
				window.location.assign("error.jsp");
			</script>
		</c:otherwise>
	</c:choose>
	<!-- 資料庫連線 -->
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
	<!-- 顯示畫面 -->
	<div class="container" id="div_all">
		<div class="row">
			<!-- 根據篩選條件來查詢商品資料表 -->
			<c:choose>
				<c:when test="${word=='床'||word=='桌子'||word=='冰箱'||word=='電視'||word=='冷氣'||word=='洗衣機'}">
					<sql:query dataSource="${DataBase}" var="result">
    					SELECT * FROM commodity WHERE type="${selection}";
					</sql:query>
				</c:when>
				<c:when test="${word=='低價位'}">
					<sql:query dataSource="${DataBase}" var="result">
    					SELECT * FROM commodity WHERE cost/life_month>=0 AND cost/life_month<250;
					</sql:query>
				</c:when>
				<c:when test="${word=='中價位'}">
					<sql:query dataSource="${DataBase}" var="result">
    					SELECT * FROM commodity WHERE cost/life_month>=250 AND cost/life_month<500;
					</sql:query>
				</c:when>
				<c:when test="${word=='高價位'}">
					<sql:query dataSource="${DataBase}" var="result">
    					SELECT * FROM commodity WHERE cost/life_month>=500;
					</sql:query>
				</c:when>
				<c:otherwise>
					<script>
						window.location.assign("error.html");
					</script>
				</c:otherwise>
			</c:choose>
			<c:forEach var="row" items="${result.rows}">
				<c:set var="i" value="${row.item_index}"/>
				<c:set var="pic"/>
				<c:set var="picid"/>
				<%
				String num=String.valueOf(pageContext.getAttribute("i"));/*這裡把整數i轉換成字串*/
				String Pic="images/pic"+num+".jpg";
				String Picid="pic"+num;
				pageContext.setAttribute("pic",Pic);
				pageContext.setAttribute("picid",Picid);
				%>
				<div class="col-12 col-md-6 col-xl-4">
					<a href="detail.jsp">
						<img src="${pic}" width="90%" height="90%" class="rounded" id="${picid}">
					</a>
				</div>
				<script>
					$(document).ready(function(){
			        	$("#"+"${picid}").click(function(){
			            	document.cookie="product="+"${i}";
			        	});
			    	});
				</script>
				<c:remove var="i"/>
				<c:remove var="pic"/>
				<c:remove var="picid"/>
			</c:forEach>
		</div><!-- row -->
	</div><!-- div-all -->
</body>
</html>