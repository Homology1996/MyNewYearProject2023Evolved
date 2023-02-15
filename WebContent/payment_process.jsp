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
<title>付款處理中</title>
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
	<!-- 找出最大訂單名稱MaxOrderName -->
	<sql:query dataSource="${DataBase}" var="orderlist">
    	SELECT * FROM orderlist;
	</sql:query>
	<c:set var="MaxOrderName" value="order1"/><!-- MaxOrderName會比現有的order_name多1 -->
	<c:forEach var="row" items="${orderlist.rows}">
		<c:set var="ordername" value="${row.order_name}"/>
		<%
		String maxname=(String)pageContext.getAttribute("MaxOrderName");
		String maxid=maxname.substring(5);/*取出數字字串部分*/
		int max=Integer.parseInt(maxid);  /*把字串轉成數字*/
		String ordername=(String)pageContext.getAttribute("ordername");
		String orderid=ordername.substring(5);
		int order=Integer.parseInt(orderid);
		if(max<=order){
			int NEXT=order+1;
			String maxorder="order"+Integer.toString(NEXT);
			pageContext.setAttribute("MaxOrderName",maxorder);
		}
		%>
		<c:remove var="ordername"/>
	</c:forEach>
	<!-- 確認登入帳號 -->
	<sql:query dataSource="${DataBase}" var="member">
    	SELECT * FROM member;
	</sql:query>
	<c:set var="LoginAccount"/>
	<c:set var="LoginPassword"/>
	<c:set var="LoginAddress"/>
	<c:forEach var="row" items="${member.rows}">
		<c:set var="row_account" value="${row.account}"/>
		<c:set var="row_password" value="${row.password}"/>
		<c:set var="row_address" value="${row.address}"/>
		<%
		String Row_account=(String)pageContext.getAttribute("row_account");
		String Row_password=(String)pageContext.getAttribute("row_password");
		String Row_address=(String)pageContext.getAttribute("row_address");
		Cookie[] cookies=request.getCookies();
		for(int i=0;i<cookies.length;i++){
	    	if((cookies[i].getName().equals(Row_account))&&(cookies[i].getValue().equals(Row_password))){
	    		pageContext.setAttribute("LoginAccount",Row_account);
	    		pageContext.setAttribute("LoginPassword",Row_password);
	    		pageContext.setAttribute("LoginAddress",Row_address);
	    		break;
	    	}
	    	else{
	    	}
	    }
		%>
		<c:remove var="row_account"/>
		<c:remove var="row_password"/>
		<c:remove var="row_address"/>
	</c:forEach>
	<!-- 更改會員訂單資訊 -->
	<c:forEach var="row" items="${member.rows}">
		<c:if test="${(row.account==LoginAccount)&&(row.password==LoginPassword)}">
			<c:set var="order_id" value="${row.order_names}"/>
			<c:set var="Original_order_id" value="${row.order_names}"/><!-- 紀錄原本訂單資料 -->
			<c:choose>
				<c:when test="${fn:length(row.order_names)==0}"><!-- 會員的訂單紀錄為空 -->
					<sql:update dataSource="${DataBase}" var="update">
						UPDATE member SET order_names="${MaxOrderName}" WHERE account="${LoginAccount}";
					</sql:update>
				</c:when>
				<c:otherwise>
					<c:set var="order"/>
					<%
					String order_id=(String)pageContext.getAttribute("order_id");
					String maxname=(String)pageContext.getAttribute("MaxOrderName");
					String order=order_id+","+maxname;
					pageContext.setAttribute("order",order);
					%>
					<sql:update dataSource="${DataBase}" var="update">
						UPDATE member SET order_names="${order}" WHERE account="${LoginAccount}";
					</sql:update>
					<c:remove var="order"/>
				</c:otherwise>
			</c:choose>
			<c:remove var="order_id"/>
		</c:if>
	</c:forEach>
	<!-- 新增訂單資料表資訊 -->        
	<c:set var="ID_Value_list" value="${param['ID_Value_list']}"/>
	<c:forTokens var="ID_Value" delims="," items="${ID_Value_list}">
		<sql:query dataSource="${DataBase}" var="orderlist">
    		SELECT * FROM orderlist;
		</sql:query>
		<c:set var="OrderlistMaxIndex" value="${fn:length(orderlist.rows)}"/><!-- 新增資料後長度會改變，所以要放進迴圈裏面，每次都要查詢 -->
		<c:set var="array" value="${fn:split(ID_Value,'=')}"/>
		<c:set var="array_0" value="${array[0]}"/> <!-- 商品編號 -->
		<c:set var="array_1" value="${array[1]}"/> <!-- 商品租期 -->
		<c:set var="item_index"/>                  <!-- 商品編號 -->
		<c:set var="item_rent_time"/>              <!-- 商品租期 -->
		<!-- 找出item_index以及item_rent_time -->
		<%
		String id=(String)pageContext.getAttribute("array_0");
		String rent=(String)pageContext.getAttribute("array_1");
		int int_id=Integer.parseInt(id);
		int int_rent=Integer.parseInt(rent);
		pageContext.setAttribute("item_index",int_id);
		pageContext.setAttribute("item_rent_time",int_rent);
		%>
		<!-- 新增資料 -->
		<sql:update dataSource="${DataBase}" var="insert">
   				INSERT INTO orderlist VALUES 
   				(<c:out value='${OrderlistMaxIndex+1}'/>,"<c:out value='${LoginAccount}'/>"
   				,"<c:out value='${LoginAddress}'/>","<c:out value='${MaxOrderName}'/>"
   				,<c:out value='${item_index}'/>,<c:out value='${item_rent_time}'/>
   				,"","",0);
		</sql:update>
	</c:forTokens>	
	<!-- 讀取商品最大編號 -->
	<sql:query dataSource="${DataBase}" var="commodity">
    	SELECT item_index FROM commodity;
	</sql:query>
	<c:set var="CommodityMaxID" value="${fn:length(commodity.rows)}"/>
	<!-- 修改訂單的起始時間 -->
	<c:forEach var="i" begin="1" end="${CommodityMaxID}" step="1">
		<c:set var="paramName"/><!-- 尋找起始時間的變數名稱 -->
		<%
		int i=(int)pageContext.getAttribute("i");
		String str_i=String.valueOf(i);
		String param_name="Start"+str_i;
		pageContext.setAttribute("paramName",param_name);
		%>
		<c:if test="${fn:length(param[paramName])>0}"><!-- 如果有找到起始時間變數，就能修改資料 -->
			<sql:update dataSource="${DataBase}" var="update">
				UPDATE orderlist SET start="${param[paramName]}" WHERE order_name="${MaxOrderName}" AND item_index=${i};
			</sql:update>
		</c:if>
	</c:forEach>
	<!-- 修改訂單結束時間以及新增價錢 -->
	<c:forTokens var="ID_Value" delims="," items="${ID_Value_list}">
		<sql:query dataSource="${DataBase}" var="orderlist">
    		SELECT * FROM orderlist;
		</sql:query>
		<c:set var="array" value="${fn:split(ID_Value,'=')}"/>
		<c:set var="array_0" value="${array[0]}"/> <!-- 商品編號 -->
		<c:set var="array_1" value="${array[1]}"/> <!-- 商品租期 -->
		<c:set var="item_index"/>                  <!-- 商品編號 -->
		<c:set var="item_rent_time"/>              <!-- 商品租期 -->
		<!-- 找出item_index以及item_rent_time -->
		<%
		String id=(String)pageContext.getAttribute("array_0");
		String rent=(String)pageContext.getAttribute("array_1");
		int int_id=Integer.parseInt(id);
		int int_rent=Integer.parseInt(rent);
		pageContext.setAttribute("item_index",int_id);
		pageContext.setAttribute("item_rent_time",int_rent);
		%>
		<c:forEach var="row" items="${orderlist.rows}">
			<c:if test="${(row.order_name==MaxOrderName)&&(row.item_index==item_index)}">
				<c:set var="month" value="${1000*60*60*24*30}"/>
				<c:set var="count" value="${item_rent_time}"/>
				<c:set var="start" value="${row.start}"/>
				<fmt:parseDate type="both" value="${start}" var="parsedStart" pattern="yyyy-MM-dd"/>
				<c:set var="end" value="${parsedStart}"/>
				<c:set target="${end}" property="time" value="${end.time+month*count}"/>
				<fmt:formatDate var="formattedEnd" value="${end}" pattern="yyyy-MM-dd"/>
				<sql:update dataSource="${DataBase}" var="update">
					UPDATE orderlist SET end="${formattedEnd}" WHERE order_name="${MaxOrderName}" AND item_index=${item_index};
				</sql:update>
				<!-- 新增價錢 -->
				<sql:query dataSource="${DataBase}" var="commodity">
    				SELECT * FROM commodity;
				</sql:query>
				<c:forEach var="row" items="${commodity.rows}">
					<c:if test="${row.item_index==item_index}">
						<c:set var="AddNew" value="${1.5}"/>
						<c:set var="AddOld" value="${0.7}"/>
						<c:set var="AddCost" value="${row.cost}"/>
						<c:set var="AddLife_month" value="${row.life_month}"/>
						<c:set var="Additem_rent_time" value="${count}"/>
						<c:set var="AddPurchasetime" value="${row.purchasetime}"/>
						<c:set var="AddStart" value="${start}"/>
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
						double New=(double)pageContext.getAttribute("AddNew");
						double Old=(double)pageContext.getAttribute("AddOld");
						int Cost=(int)pageContext.getAttribute("AddCost");
						int Life_month=(int)pageContext.getAttribute("AddLife_month");
						int item_rent_time=(int)pageContext.getAttribute("Additem_rent_time");
						String Purchasetime=(String)pageContext.getAttribute("AddPurchasetime");
						String Start=(String)pageContext.getAttribute("AddStart");
						double money=Summation(New,Old,Cost,Life_month,item_rent_time,Purchasetime,Start);
						pageContext.setAttribute("ThisRent",money);
						%>
						<fmt:formatNumber var="money" groupingUsed="false" value="${ThisRent}" minFractionDigits="0" maxFractionDigits="0"/>
						<sql:update dataSource="${DataBase}" var="update">
							UPDATE orderlist SET price="${money}" WHERE order_name="${MaxOrderName}" AND item_index=${item_index};
						</sql:update>
					</c:if>
				</c:forEach>
			</c:if>
		</c:forEach>
	</c:forTokens>
	<!-- 畫面顯示 -->
	<c:set var="pay" value="${param['pay']}"/><!-- 付款方式 -->
	<c:choose>
		<c:when test="${(pay=='mobile_payment')||(pay=='credit_card')||(pay=='store')}">
			<script>
				/*完成付款後，清空cookie*/
				var CommodityMaxID=Number("${CommodityMaxID}");
				$(document).ready(function(){
					for(var id=1;id<=CommodityMaxID;id++){
					$.removeCookie("order"+String(id));
					}
					$.removeCookie("product");
					$.removeCookie("select");
					$.removeCookie("after");
				});
				Swal.fire({
	  				title:"付款成功",
	  				icon:"success",
	  				showCancelButton:false,
	  				confirmButtonText:"返回會員中心",
	  				confirmButtonColor:"#3085d6"
				}).then((result) => {
	  				if (true) {
	  					window.location.assign("member.jsp");
	  				}
				});
			</script>
		</c:when>
		<c:otherwise>
			<!-- 沒有選擇付款方式，所以把會員的訂單資料重設為原本的樣子 -->
			<sql:query dataSource="${DataBase}" var="member">
    			SELECT * FROM member;
			</sql:query>
			<c:forEach var="row" items="${member.rows}">
				<c:if test="${(row.account==LoginAccount)&&(row.password==LoginPassword)}">
					<sql:update dataSource="${DataBase}" var="update">
						UPDATE member SET order_names="${Original_order_id}" WHERE account="${LoginAccount}";
					</sql:update>
				</c:if>
			</c:forEach>
			<!-- 沒有選擇付款方式，刪除訂單資料庫裡面新增的資料 -->
			<sql:update dataSource="${DataBase}" var="delete">
				DELETE FROM orderlist WHERE order_name="${MaxOrderName}";
			</sql:update>
			<script>
				Swal.fire({
  					title:"請重新選擇付款方式",
  					icon:"error",
  					showCancelButton:false,
  					confirmButtonText:"返回購物車",
  					confirmButtonColor:"#dd3333"
				}).then((result) => {
  					if (true) {
  						window.location.assign("cart.jsp");
  					}
				});
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>