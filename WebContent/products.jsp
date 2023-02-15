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
<title>商品總覽</title>
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
	<!-- 標題導覽列 -->
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<div class="container-fluid">
      			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        			<span class="navbar-toggler-icon"></span>
      			</button>
      			<div class="collapse navbar-collapse" id="navbarCollapse">
      				<span class="navbar-brand">商品總覽</span>
        			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          				<li class="nav-item">
            				<a class="nav-link" aria-current="page" href="index.html">返回首頁</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="login.jsp">會員中心</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="cart.jsp">前往購物車</a>
          				</li>
        			</ul>
       				<div class="dropdown me-2">
						<button type="button" class="btn btn-outline-light dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">種類</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" id="ul_button1">
 							<li>
   								<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection1();"><!-- 點擊超連結時順便增加cookie -->
   									<script>
   										function AddSelection1(){
    										document.cookie="select=bed";
    									}
    								</script>
    							床
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection2();">
    								<script>
    									function AddSelection2(){
    										document.cookie="select=table";
    									}
    								</script>
    							桌子
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection3();">
    								<script>
    									function AddSelection3(){
    										document.cookie="select=refrigerator";
    									}
    								</script>
    							冰箱
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection4();">
    								<script>
    									function AddSelection4(){
    										document.cookie="select=television";
    									}
    								</script>
    							電視
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection5();">
    								<script>
    									function AddSelection5(){
    										document.cookie="select=air_conditioner";
    									}
    								</script>
    							冷氣
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection6();">
    								<script>
    									function AddSelection6(){
    										document.cookie="select=laundry_machine";
    									}
    								</script>
    							洗衣機
    							</a>
    						</li>
  						</ul>
					</div><!-- dropdown me-2 -->
					<div class="dropdown me-5">
  						<button type="button" class="btn btn-outline-light dropdown-toggle" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">價格</button>
	  					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2" id="ul_button2">
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection7();">
    								<script>
    									function AddSelection7(){
    										document.cookie="select=low_price";
    									}
    								</script>
	    						低價位(250元以下)
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection8();">
    								<script>
    									function AddSelection8(){
    										document.cookie="select=medium_price";
    									}
	    							</script>
    							中價位(250~500元)
    							</a>
    						</li>
    						<li>
    							<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection9();">
    								<script>
    									function AddSelection9(){
    										document.cookie="select=high_price";
    									}
 	   							</script>
    							高價位(500元以上)
    							</a>
    						</li>
  						</ul>
					</div><!-- dropdown me-5 -->
					<div class="me-5"></div>
      			</div><!-- collapse -->
    		</div><!-- container-fluid -->
		</nav>
	</header>
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
	<!-- 查詢商品資料表 -->
	<sql:query dataSource="${DataBase}" var="result">
    	SELECT * FROM commodity;
	</sql:query>
	<!-- 顯示商品圖片 -->
    <div class="container" id="div_all">
    	<div class="row">
    		<c:forEach var="row" items="${result.rows}">
    			<c:set var="i" value="${row.item_index}"/>
				<c:set var="pic"/>
				<c:set var="picid"/>
				<%
				String id=Integer.toString((int)pageContext.getAttribute("i"));/*商品的index是整數，讀取物件時要先強制轉型成整數，然後再轉成字串*/
				String Pic="images/pic"+id+".jpg";
				String Picid="pic"+id;
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
			</c:forEach>
    	</div>
    </div>
    <script>
    	/*使用jQuery與Bootstrap來控制下拉選單*/
    	$(document).ready(function(){
        	$("#dropdownMenuButton1").click(function(){
            	$("#ul_button1").toggle(500);
        	});
        	$("#dropdownMenuButton2").click(function(){
            	$("#ul_button2").toggle(500);
        	});
    	});
    </script>
</body>
</html>