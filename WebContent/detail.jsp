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
<title>商品介紹</title>
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
        #align_center{
            margin-top:100px;
            text-align:center;
        }
        #nav{
        	height:6.5%;
        }
	</style>
</head>
<body class="d-flex flex-column h-100">
	<!-- 標題導覽列 -->
	<header>
		<nav class="navbar navbar-expand navbar-dark fixed-top bg-dark" id="nav">
			<div class="container-fluid">
      			<div class="navbar">
      				<span class="navbar-brand">商品介紹</span>
      			</div>
    		</div>
		</nav>
	</header>
	<!-- 找出商品編號 -->
	<c:set var="itemID"/>
	<%
	Cookie[] cookies=request.getCookies();
	for(int i=0;i<cookies.length;i++){
		if(cookies[i].getName().equals("product")){
	    	pageContext.setAttribute("itemID",cookies[i].getValue());
	    	break;
	    }
	}
	%>
	<!-- 設定使用參數 -->
	<c:set var="imgsrc"/>
	<c:set var="orderID"/>
	<%
	String id=(String)pageContext.getAttribute("itemID");
	String src="images/pic"+id+".jpg";
	String order="order"+id;
	pageContext.setAttribute("imgsrc",src);
	pageContext.setAttribute("orderID",order);
	%>
	<!-- 載入資料庫 -->
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
	<c:forEach var="row" items="${result.rows}">
		<c:if test="${row.item_index==itemID}">
			<!-- 設定商品資訊變數 -->
			<c:set var="type" value="${row.type}"/>
			<c:set var="brand" value="${row.brand}"/>
			<c:set var="location" value="${row.location}"/>
			<c:set var="cost" value="${row.cost}"/>
			<c:set var="purchasetime" value="${row.purchasetime}"/>
			<c:set var="life_month" value="${row.life_month}"/>
			<c:set var="description" value="${row.description}"/>
			<c:set var="retire" value="${row.retire}"/>
		</c:if>
	</c:forEach>
	<!-- 顯示商品內容 -->
	<div class="container" id="align_center">
		<div class="row">
			<div class="col-12 col-lg-5"><!-- 顯示圖片 -->
				<img src="${imgsrc}" width="100%" height="95%" class="rounded">
			</div><!-- 對應到col-5 -->
			<div class="col-0 col-lg-1"></div><!-- 空白部分 -->
			<div class="col-12 col-lg-6"><!-- 顯示商品文字資訊 -->
				<%
				String description=(String)pageContext.getAttribute("description");
				out.println(description);
				%>
                <h3>平均租金計算</h3>
                <table class="table table-bordered">
                	<thead>
                    	<tr>
                        	<th scope="col">1個月</th>
                        	<th scope="col">6個月</th>
                        	<th scope="col">12個月</th>
                    	</tr>
                    </thead>
                    <tbody>
                        <tr>
                        	<th scope="row"><fmt:formatNumber value="${(cost/life_month)*1}" minFractionDigits="0" maxFractionDigits="0"/>元</th>
                          	<th scope="row"><fmt:formatNumber value="${(cost/life_month)*6}" minFractionDigits="0" maxFractionDigits="0"/>元</th>
                          	<th scope="row"><fmt:formatNumber value="${(cost/life_month)*12}" minFractionDigits="0" maxFractionDigits="0"/>元</th>              
                        </tr>
                    </tbody>
                </table>
			</div><!-- 對應到col-6 -->
		</div><!-- 對應到row -->
	</div><!-- 對應到align_center -->
	<br>
	<!-- 下方狀態列和相關按鈕 -->
	<div class="container">
		<div class="row page-section justify-content-center align-items-center">
			<div class="col-5" style="text-align:center;"><!-- 顯示出租狀態與隱藏加入購物車 -->
				<!-- 找出現在出租的最大時間 -->
				<c:set var="MaxEnd"/>
				<sql:query dataSource="${DataBase}" var="orderlist">
    				SELECT * FROM orderlist;
				</sql:query>
				<c:forEach var="orderlist_row" items="${orderlist.rows}">
					<c:if test="${orderlist_row.item_index==itemID}">
						<c:set var="ThisEnd" value="${orderlist_row.end}"/>
						<%
						String MaxEnd=(String)pageContext.getAttribute("MaxEnd");
						String ThisEnd=(String)pageContext.getAttribute("ThisEnd");
						SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
						if(MaxEnd.length()<1){
							pageContext.setAttribute("MaxEnd",ThisEnd);
						}
						else{
							try{
								/*把字串轉換成日期物件*/
								java.util.Date parsedMaxEnd=formatter.parse(MaxEnd);
					            java.util.Date parsedThisEnd=formatter.parse(ThisEnd);
					            /*把日期物件轉換成數字*/
					            long MaxEnd_millisecond=parsedMaxEnd.getTime();       
					            long ThisEnd_millisecond=parsedThisEnd.getTime();
					            if(ThisEnd_millisecond>MaxEnd_millisecond){
					            	pageContext.setAttribute("MaxEnd",ThisEnd);
					            }
							}
							catch (java.text.ParseException e) {
					            e.printStackTrace();
					        }
						}
						%>
						<c:remove var="ThisEnd"/>
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(MaxEnd)==0}"><!-- 對應到完全沒有出租的紀錄(ThisEnd全部都是空的) -->
					<%
					pageContext.setAttribute("MaxEnd","1996-07-22");
					%>
				</c:if>
				<!-- 定義出租狀態 -->
				<c:set var="status"/>
				<c:set var="now" value="<%=new java.util.Date()%>"/>
				<fmt:formatDate var="today" pattern="yyyy-MM-dd" value="${now}" />
				<%
				String MaxEnd=(String)pageContext.getAttribute("MaxEnd");
				String today=(String)pageContext.getAttribute("today");
				SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
				try{
					java.util.Date parsedMaxEnd=formatter.parse(MaxEnd);
		            java.util.Date parsedtoday=formatter.parse(today);
		            long MaxEnd_millisecond=parsedMaxEnd.getTime();
		            long today_millisecond=parsedtoday.getTime();
		            if(today_millisecond>MaxEnd_millisecond){
		            	pageContext.setAttribute("status","ok");/*出租狀態定義*/
		            }
		            else{
		            	pageContext.setAttribute("status","no");/*出租狀態定義*/
		            }
				}
				catch(java.text.ParseException e){
					e.printStackTrace();
				}
				%>
				<!-- 顯示出租狀態 -->
				<c:choose>
					<c:when test="${retire=='yes'}"><!-- 查詢報廢狀態 -->
						<h3 style="color:red;" align="center">出租狀態: 已報廢</h3>
					</c:when>
					<c:when test="${status=='ok'}">
						<h3 style="color:blue;" align="center">出租狀態: 可出租</h3>
					</c:when>
					<c:otherwise>
						<h4 style="color:red;" align="center">出租狀態: 出租中</h4>
						<h4 align="center">結束時間: ${MaxEnd}</h4>
					</c:otherwise>
				</c:choose>
			</div><!-- 對應到col-5 -->
			<div class="col-1"></div><!-- 空白部分 -->
			<div class="col-2" align="center">
				<button type="button" class="btn btn-warning" id="AddCart" onclick="javascript:AddCart();"><!-- 按下按鍵時就會觸發javascript函數AddCart -->
					<script>
            			function AddCart(){
            				/*點擊按鈕後就會新增cookie，並且跳出視窗提示使用者*/
            				document.cookie="${orderID}"+"="+"${itemID}";
            				/*sweetalert2彈跳視窗樣式*/
            				Swal.fire({
            					title:"已加入購物車",
            					icon:"success",
            					showConfirmButton:false,
            					timer:1500
            					});
                			/*window.alert("已加入購物車");*/
            			}
            		</script>
					加入購物車
				</button>
			</div><!-- 對應到col-2 -->
			<div class="col-2" align="center">
            	<button type="button" class="btn btn-warning" onclick="javascript:GoBack();">
            		<script>
            			function GoBack(){
            				window.location.assign("products.jsp");
            			}
            		</script>
            		繼續購物
            	</button>
            </div><!-- 對應到col-2 -->
            <div class="col-2" align="center">
            	<button type="button" class="btn btn-warning" onclick="javascript:ToCart();">
            		<script>
            			function ToCart(){
							window.location.assign("cart.jsp");
            			}
            		</script>
            		前往購物車
            	</button>
            </div><!-- 對應到col-2 -->
		</div><!-- 對應到row -->
	</div><!-- 對應到container -->
	<br>
	<script>
		var retire="${retire}";
		var hidebutton="${status}";
		if((retire=="yes")||(hidebutton=="no")){
			$(document).ready(function(){
				$("#AddCart").attr("disabled",true);/*如果狀態為已報廢或是出租中，那就把按鍵停用*/
    		});
		}
	</script>
</body>
</html>