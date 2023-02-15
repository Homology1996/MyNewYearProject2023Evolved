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
<title>會員中心</title>
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
        #member{
        	margin-top:85px;
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
      				<span class="navbar-brand">會員中心</span>
        			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          				<li class="nav-item">
            				<a class="nav-link" aria-current="page" href="index.html">返回首頁</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="products.jsp">前往商城</a>
          				</li>
          				<li class="nav-item">
            				<a class="nav-link" href="cart.jsp">前往購物車</a>
          				</li>
        			</ul>
        			<div class="me-0">
        				<button type="button" class="btn btn-outline-secondary" onclick="javascript:Logout();">
            				<script>
								function Logout(){
									var CookieArray=document.cookie.split(";");
						   			for(var index=0;index<CookieArray.length;index++){
						        		var SPLIT=CookieArray[index].split("=");
						        		var cookieName=SPLIT[0];
						        		DeleteCookieByName(cookieName);
						        		$.removeCookie(cookieName);/*使用jQuery移除cookie*/
						    		}
						   			Swal.fire({
						   	  			title:"會員已登出",
						   	  			icon:"success",
						   	  			confirmButtonColor:"#3085d6",
						   	  			confirmButtonText:"返回首頁"
						   			}).then((result) => {
						   	  			if (result.isConfirmed) {
						   	  				window.location.assign("index.html");
						   	  			}
						   			})
								}
							</script>
            				會員登出
            			</button>
        			</div>
      			</div><!-- collapse -->
    		</div><!-- container-fluid -->
		</nav>
	</header>
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
    	SELECT * from member;
	</sql:query>
	<c:set var="LoginAccount"/>
	<c:set var="LoginPassword"/>
	<c:forEach var="row" items="${result.rows}">
		<c:set var="row_account" value="${row.account}"/>
		<c:set var="row_password" value="${row.password}"/>
		<%
		String Row_account=(String)pageContext.getAttribute("row_account");
		String Row_password=(String)pageContext.getAttribute("row_password");
		Cookie[] cookies=request.getCookies();/*如果用email當作帳號，則會出現錯誤*/
		/*A cookie header was received [123@gmail.com=S123456789] that contained an invalid cookie. That cookie will be ignored.*/
		for(int i=0;i<cookies.length;i++){
	    	if((cookies[i].getName().equals(Row_account))&&(cookies[i].getValue().equals(Row_password))){
	    		pageContext.setAttribute("LoginAccount",Row_account);
	    		pageContext.setAttribute("LoginPassword",Row_password);
	    		break;
	    	}
	    	else{
	    	}
	    }
		%>
	</c:forEach>
	<!-- 顯示畫面內容 -->
	<div class="container" id="member">
		<main>
			<div class="container table-responsive-md">
				<table class="table table-hover">
					<!-- 會員資料 -->
					<tr>
						<th>會員姓名</th>
						<th>手機號碼</th>
						<th>地址</th>
						<th>帳號</th>
						<th>密碼</th>
						<th>訂單編號</th>
					</tr>
					<c:forEach var="row" items="${result.rows}">
						<c:if test="${row.account==LoginAccount}">
							<tr>
								<td>${row.name}</td>
								<td>${row.phone}</td>
								<td>${row.address}</td>
								<td>${row.account}</td>
								<td>${row.password}</td>
								<td>
									<c:forTokens var="ordername" delims="," items="${row.order_names}">
										<c:out value="${ordername}"/><br>
									</c:forTokens>
								</td>
								<td>
									<form action="revise.jsp" method="get">
										<input type="hidden" name="account" value="${LoginAccount}">
										<button type="submit" class="btn btn-outline-dark" onclick="javascript:Revise();">
											<script>
												function Revise(){
													window.location.assign("revise.jsp");
												}
											</script>
											資料修改
										</button>
									</form>
								</td>
							</tr>
						</c:if>
					</c:forEach>
					<!-- 訂單資料 -->
					<sql:query dataSource="${DataBase}" var="orderlist">
    					SELECT * from orderlist;
					</sql:query>
					<tr>
						<th>訂單編號</th>
						<th>商品編號</th>
						<th>出租時間</th>
						<th>起始時間</th>
						<th>結束時間</th>
						<th>出租金額</th>
					</tr>
					<c:forEach var="row" items="${orderlist.rows}">
						<c:if test="${row.account==LoginAccount}">
							<tr>
								<td>${row.order_name}</td>
								<td>${row.item_index}</td>
								<td>${row.item_rent_time}個月</td>
								<td>${row.start}</td>
								<td>${row.end}</td>
								<td>${row.price}元</td>
								<!-- 售後服務按鈕 -->
								<td>
									<c:set var="aftersale_order" value="${row.order_name}"/>
									<c:set var="aftersale_item" value="${row.item_index}"/>
									<c:set var="aftervalue"/>
									<%
									String aftersale_order=(String)pageContext.getAttribute("aftersale_order");
									int aftersale_item=(int)pageContext.getAttribute("aftersale_item");
									String STRaftersale_item=Integer.toString(aftersale_item);
									String funcvalue=aftersale_order+"_"+STRaftersale_item;
									pageContext.setAttribute("aftervalue",funcvalue);
									%>
									<button type="button" class="btn btn-outline-dark" id="${aftervalue}">售後服務</button>
									<script>
										$(document).ready(function(){
											$("#"+"${aftervalue}").click(function(){
												document.cookie="after="+"${aftervalue}";
												window.location.assign("aftersale.jsp");
											});
										});
									</script>
								</td>
								<!-- 檢查是否過期並決定是否隱藏按鈕 -->
								<c:set var="expire"/>
								<c:set var="end" value="${row.end}"/>
								<c:set var="now" value="<%=new java.util.Date()%>"/>
								<fmt:formatDate var="today" pattern="yyyy-MM-dd" value="${now}"/>
								<%
								String end=(String)pageContext.getAttribute("end");
								String today=(String)pageContext.getAttribute("today");
								SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
								try{
									java.util.Date parsedend=formatter.parse(end);
		            				java.util.Date parsedtoday=formatter.parse(today);
		            				long end_millisecond=parsedend.getTime();
		           					long today_millisecond=parsedtoday.getTime();
		            				if(today_millisecond>=end_millisecond){
		            					pageContext.setAttribute("expire","yes");
		            				}
		            				else{
		            					pageContext.setAttribute("expire","no");
		            				}
								}
								catch(java.text.ParseException e){
									e.printStackTrace();
								}
								%>
							</tr>
							<script>
								var expire="${expire}";
								if(expire=="yes"){
									$(document).ready(function(){
										$("#"+"${aftervalue}").hide();
									});
								}
							</script>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</main>
	</div><!-- container -->
	<br>
</body>
</html>