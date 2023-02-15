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
<title>付款資訊</title>
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
      				<span class="navbar-brand">續租</span>
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
	<!-- 讀取傳送參數 -->
	<c:set var="order_name" value="${param['Order_name']}"/>
	<c:set var="item_index" value="${param['Item_index']}"/>
	<c:set var="extend" value="${param['Extend']}"/> <!-- 選擇的延長時間 -->
	<c:set var="item_rent_time" value="${extend}"/>  <!-- 選擇的延長時間 -->
	<!-- 設置使用參數 -->
	<c:set var="ID_Value_list"/>
	<c:set var="int_extend"/>
	<c:set var="imageID"/>
	<c:set var="OriginalEnd"/>
	<c:set var="StartID"/>
	<%
	String id=(String)pageContext.getAttribute("item_index");
	String value=(String)pageContext.getAttribute("extend");
	int int_value=Integer.parseInt(value);
	String id_value=id+"="+value;
	pageContext.setAttribute("ID_Value_list",id_value);
	pageContext.setAttribute("int_extend",int_value);
	%>
	<!-- 讀取資料庫 -->
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
	<!-- 讀取商品資料表並設置價格參數 -->
	<c:set var="New" value="${1.5}"/>
	<c:set var="Old" value="${0.7}"/>
	<sql:query dataSource="${DataBase}" var="commodity">
    	SELECT * from commodity;
	</sql:query>
	<c:forEach var="row" items="${commodity.rows}">
		<c:if test="${row.item_index==item_index}">
			<c:set var="Cost" value="${row.cost}"/>
			<c:set var="Life_month" value="${row.Life_month}"/>
			<c:set var="Purchasetime" value="${row.purchasetime}"/>
			<%
			String item_index=(String)pageContext.getAttribute("item_index");
			String ImageID="images/pic"+item_index+".jpg";
			String startid="Start"+item_index;
			pageContext.setAttribute("imageID",ImageID);
			pageContext.setAttribute("StartID",startid);
			%>
		</c:if>
	</c:forEach>
	<!-- 讀取訂單資料表 -->
	<sql:query dataSource="${DataBase}" var="orderlist">
    	SELECT * from orderlist;
	</sql:query>
	<c:forEach var="row" items="${orderlist.rows}">
		<c:if test="${row.item_index==item_index}">
		<c:set var="ThisEnd" value="${row.end}"/>
		<!-- 新增起始時間要以最新訂單的結束時間當作起點，不然會跟舊的訂單時間重疊 -->
		<%
		String thisend=(String)pageContext.getAttribute("ThisEnd");
		pageContext.setAttribute("OriginalEnd",thisend);
		%>
		<c:set var="Start" value="${row.end}"/>
		</c:if>
	</c:forEach>
	<!-- 結束時間 -->
	<c:set var="month" value="${1000*60*60*24*30}"/>
	<fmt:parseDate type="both" value="${OriginalEnd}" var="parsedOriginal" pattern="yyyy-MM-dd"/>
	<c:set var="Endex" value="${parsedOriginal}"/>
	<c:set target="${Endex}" property="time" value="${Endex.time+month*int_extend}"/>
	<fmt:formatDate var="ExtendedEnd" value="${Endex}" pattern="yyyy-MM-dd"/>
	<!-- 計算價格 -->
<%!/*寫函數時記得加上!*/
	double rate(double New, double Old, int Life_month, String Purchasetime, String Now){
		long day=1000*60*60*24L;
		long month=day*30L;
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");/*格式化物件*/
		double rate=0.0;
		/*寫成函數時，要使用try,catch來處理字串轉換成時間時可能會出現的exception*/
		try {
			java.util.Date parsedPurchasetime=formatter.parse(Purchasetime);
			java.util.Date parsedNow=formatter.parse(Now);
			/*算出特定日期距離1970-01-01有幾微秒*/
			long Purchasetime_millisecond=parsedPurchasetime.getTime();
			long Now_millisecond=parsedNow.getTime();
			long Now_Pur_Diff_milli=Now_millisecond-Purchasetime_millisecond;
			/*把上面的微秒換成月*/
			double Now_Pur_Diff_month=(Now_Pur_Diff_milli/month);
			if(Now_millisecond<Purchasetime_millisecond){
				/*對應到現在的時間比購買時間還早，也就是錯誤的時間*/
				rate=0.0;
			}
			else if(Now_millisecond<Purchasetime_millisecond+Life_month*month){
				/*對應到現在的時間落在起始與結束時間之內*/
				rate=New-((New-Old)*Now_Pur_Diff_month)/Life_month;
			}
			else{
				/*對應到現在的時間比預期壽命還大，那就直接回傳最舊的費率*/
				rate=Old;
			}
		} 
		catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return rate;
	}
	double Summation(double New, double Old, int Cost, int Life_month, int item_rent_time, String Purchasetime, String Start){
		long month=1000*60*60*24*30L;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		double average=Cost/Life_month;
		double sum=0.0;
		try{
			java.util.Date purchasetime = formatter.parse(Purchasetime);
			java.util.Date start = formatter.parse(Start);
			long purchasemillisec = purchasetime.getTime();
			long startmillisec = start.getTime();
			for(int i=0;i<item_rent_time;i++){
				long nowmillisec=startmillisec+i*month;
				java.util.Date milli_to_date = new java.util.Date(nowmillisec);  
				String Now=formatter.format(milli_to_date);
				double rate_this_month=rate(New, Old, Life_month, Purchasetime, Now);
				sum=sum+average*rate_this_month;
			}
		}
		catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return sum;
	}
	%>
	<c:set var="ThisRent"/>
	<%
	double New=(double)pageContext.getAttribute("New");
	double Old=(double)pageContext.getAttribute("Old");
	int Cost=(int)pageContext.getAttribute("Cost");
	int Life_month=(int)pageContext.getAttribute("Life_month");
	String STRitem_rent_time=(String)pageContext.getAttribute("item_rent_time");
	int item_rent_time=Integer.parseInt(STRitem_rent_time);
	String Purchasetime=(String)pageContext.getAttribute("Purchasetime");
	String Start=(String)pageContext.getAttribute("OriginalEnd");/*原本的結束時間變成新的起始時間*/
	double money=Summation(New,Old,Cost,Life_month,item_rent_time,Purchasetime,Start);
	pageContext.setAttribute("ThisRent",money);
	%>
	<fmt:formatNumber var="ThisRentFinal" value="${ThisRent}" groupingUsed="false" minFractionDigits="0" maxFractionDigits="0"/>
	<!-- 畫面內容 -->
	<div class="container" id="div_all">
		<div class="row">
			<div class="col-12 col-md-6">
				<img src="${imageID}" width="95%" height="95%">
			</div><!-- col-md-6 -->
			<div class="col-12 col-md-6">
				<form action="payment_process.jsp" method="post">
					<table class="table">
						<tr>
							<td>商品編號</td>
							<td>${item_index}</td>
						</tr>
						<tr>
							<td>出租時間</td>
							<td>${item_rent_time}個月</td>
						</tr>
						<tr>
							<td>起始時間</td>
							<td>${OriginalEnd}</td>
						</tr>
						<tr>
							<td>結束時間</td>
							<td>${ExtendedEnd}</td>
						</tr>
						<tr>
							<td>商品價格</td>
							<td>${ThisRentFinal}元</td>
						</tr>
						<tr>
							<td>付款方式</td>
							<td>
								<select class="form-select" name="pay">
									<option value="mobile_payment">行動支付</option>
									<option value="credit_card">信用卡</option>
									<option value="store">超商繳費</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<button type="button" class="input-group btn btn-warning" onclick="javascript:Return();">
										<script>
											function Return(){
												window.location.assign("continue_order.jsp");
											}
										</script>
									重新選擇
									</button>
								</div>
							</td>
							<td>
								<div class="input-group">
									<button type="submit" class="input-group btn btn-success">付款</button>
								</div>
							</td>
						</tr>
					</table>
					<input type="hidden" name="${StartID}" value="${OriginalEnd}">
					<input type="hidden" name="ID_Value_list" value="${ID_Value_list}">
					<input type="hidden" name="price" value="${ThisRentFinal}">
				</form>
			</div><!-- col-md-6 -->
		</div><!-- row -->
	</div><!-- div_all -->
</body>
</html>