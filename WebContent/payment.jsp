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
<title>付款頁面</title>
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
      				<span class="navbar-brand">購物車</span>
        			<ul class="navbar-nav me-auto mb-0 mb-md-0">
          				<li class="nav-item">
            				<a class="nav-link" aria-current="page" href="index.html">返回首頁</a>
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
	<!-- 設定使用參數 -->
	<c:set var="id_Value_list"/><!-- 商品編號與租期 -->
	<c:set var="Price" value="${0}"/> <!-- 總金額 -->
	<!-- 讀取表單送出資訊 -->
	<%
	Enumeration<String> ParameterNames=request.getParameterNames();/*讀取多個送出結果*/
	while(ParameterNames.hasMoreElements()){
		String Id_value_list=(String)pageContext.getAttribute("id_Value_list");
		String ParameterName=(String)ParameterNames.nextElement();
		String ParameterValue=request.getParameter(ParameterName);
		Id_value_list=Id_value_list+","+ParameterName.substring(5)+"="+ParameterValue;
		pageContext.setAttribute("id_Value_list",Id_value_list);
	}
	/*刪除開頭的逗號*/
	String Id_value_list=(String)pageContext.getAttribute("id_Value_list");
	if(Id_value_list.length()>1){  /*1代表這個字串只有一個開頭的逗號*/
		Id_value_list=Id_value_list.substring(1);
		pageContext.setAttribute("id_Value_list",Id_value_list);
	}
	/*最後輸出的結果為:商品編號=幾個月,商品編號=起始時間,...*/
	%>
	<!-- 把表單送的資料拆開來 -->
	<c:set var="ID_Value_list"/>
	<c:set var="Start_ID_list"/>
	<c:forTokens var="name" delims="," items="${id_Value_list}">
		<c:choose>
			<c:when test="${fn:contains(name,'-')}">
				<%
				String start_id_list=(String)pageContext.getAttribute("Start_ID_list");
				String name=(String)pageContext.getAttribute("name");
				String alter=start_id_list+","+name;
				pageContext.setAttribute("Start_ID_list",alter);
				%>
			</c:when>
			<c:otherwise>
				<%
				String Myid_value_list=(String)pageContext.getAttribute("ID_Value_list");
				String name=(String)pageContext.getAttribute("name");
				String alter=Myid_value_list+","+name;
				pageContext.setAttribute("ID_Value_list",alter);
				%>
			</c:otherwise>
		</c:choose>
	</c:forTokens>
	<c:choose>
		<c:when test="${ID_Value_list.length()<4}"><!-- 如果遇到購物車都沒選就來按結帳，就使用此情況 -->
			<script>
				Swal.fire({
   	  				title:"空的購物車不能結帳喔~",
   	  				icon:"error",
   	  				confirmButtonColor:"#3085d6",
   	  				confirmButtonText:"返回商品總覽"
   				}).then((result) => {
   	  				if (true) {
   	  					window.location.assign("products.jsp");
   	  				}
   				});
			</script>
		</c:when>
		<c:otherwise>
			<!-- 去除開頭的逗號 -->
			<%
			String Myid_value_list=(String)pageContext.getAttribute("ID_Value_list");
			String Mystart_id_list=(String)pageContext.getAttribute("Start_ID_list");
			String id_value_delete_head=Myid_value_list.substring(1);
			String start_id_delete_head=Mystart_id_list.substring(1);
			pageContext.setAttribute("ID_Value_list",id_value_delete_head);
			pageContext.setAttribute("Start_ID_list",start_id_delete_head);
			%>
			<!-- 表單部分 -->
			<form action="payment_process.jsp" method="post">
				<div class="container" id="div_all">
					<div class="row">
						<c:forTokens var="Item_Value" delims="," items="${ID_Value_list}"><!-- 先把項目清單拆開來 -->
							<c:set var="array" value="${fn:split(Item_Value,'=')}"/>
							<c:set var="ID" value="${array[0]}"/>    <!-- 商品編號 -->
							<c:set var="Value" value="${array[1]}"/> <!-- 租期 -->
							<c:set var="InfoID"/>                    <!-- jQuery使用的id選擇器 -->
							<c:set var="PicID"/>                     <!-- jQuery使用的id選擇器 -->
							<c:set var="ImgID"/>                     <!-- 引用的圖片路徑 -->
							<c:set var="StartID"/>                   <!-- 接收購物車送出的起始時間變數 -->
							<%
							String id=(String)pageContext.getAttribute("ID");
							String value=(String)pageContext.getAttribute("Value");
							String infoid="info"+id;
							String picid="pic"+id;
							String imgid="images/pic"+id+".jpg";
							String startid="Start"+id;
							pageContext.setAttribute("InfoID",infoid);
							pageContext.setAttribute("PicID",picid);
							pageContext.setAttribute("ImgID",imgid);
							pageContext.setAttribute("StartID",startid);
							%>
							<div class="col-12 col-md-6" id="${PicID}">
								<img src="${ImgID}" width="95%" height="95%">
							</div>
							<div class="col-12 col-md-6" id="${InfoID}" align="center">
								<br>
								<h3>商品編號 : ${ID}</h3>
								<br>
								<h4>租期 : ${Value} 個月</h4>
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
								<!-- 租金部分 -->
								<c:forEach var="row" items="${result.rows}">
									<c:if test="${row.item_index==Integer.parseInt(ID)}">
										<c:forTokens var="name" delims="," items="${Start_ID_list}">
											<c:set var="array" value="${fn:split(name,'=')}"/>
											<c:if test="${array[0]==row.item_index}">
												<br>
												<h5>起始時間 : ${array[1]}</h5>
												<!-- 使用折舊費率計算租金 -->
												<c:set var="New" value="${1.5}"/>
												<c:set var="Old" value="${0.7}"/>
												<c:set var="Cost" value="${row.cost}"/>
												<c:set var="Life_month" value="${row.Life_month}"/>
												<c:set var="item_rent_time"/>
												<c:forEach var="picklist" items="${ID_Value_list}">
													<c:set var="myarray" value="${fn:split(picklist,'=')}"/>
													<c:set var="array_name" value="${myarray[0]}"/>
													<c:set var="array_value" value="${myarray[1]}"/>
													<c:if test="${myarray[0]==row.item_index}">
														<%
														String str_item_rent_time=(String)pageContext.getAttribute("array_value");
														long ToLong=(long)Integer.parseInt(str_item_rent_time);
														int ToInt=Math.toIntExact(ToLong);/*把long轉換成int*/
														pageContext.setAttribute("item_rent_time",ToInt);
														%>
													</c:if>
												</c:forEach>
												<c:set var="Purchasetime" value="${row.purchasetime}"/>
												<c:set var="Start" value="${array[1]}"/>
												<!-- 顯示結束時間 -->
												<c:set var="month" value="${1000*60*60*24*30}"/>
												<fmt:parseDate type="both" value="${Start}" var="parsedStart" pattern="yyyy-MM-dd"/>
												<c:set var="End" value="${parsedStart}"/>
												<c:set target="${End}" property="time" value="${End.time+month*item_rent_time}"/>
												<h5>結束時間 : <fmt:formatDate value="${End}" pattern="yyyy-MM-dd" /></h5>
												<c:set var="ThisRent"/>
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
												<%
												double New=(double)pageContext.getAttribute("New");
												double Old=(double)pageContext.getAttribute("Old");
												int Cost=(int)pageContext.getAttribute("Cost");
												int Life_month=(int)pageContext.getAttribute("Life_month");
												int item_rent_time=(int)pageContext.getAttribute("item_rent_time");
												String Purchasetime=(String)pageContext.getAttribute("Purchasetime");
												String Start=(String)pageContext.getAttribute("Start");
												double money=Summation(New,Old,Cost,Life_month,item_rent_time,Purchasetime,Start);
												pageContext.setAttribute("ThisRent",money);
												%>
												<fmt:formatNumber var="ThisRentFinal" value="${ThisRent}" groupingUsed="false" minFractionDigits="0" maxFractionDigits="0"/>
												<br>
												<h4>商品價格 : ${ThisRentFinal} 元</h4>
												<!-- 計算總金額 -->
												<%
												long Price=(long)pageContext.getAttribute("Price");
												String STRThisRentFinal=(String)pageContext.getAttribute("ThisRentFinal");
												long ThisRentFinal=(long)Integer.parseInt(STRThisRentFinal);
												Price+=ThisRentFinal;
												pageContext.setAttribute("Price",Price);
												%>
												<!-- 表單送出的變數。用來記錄幾號商品從何時開始承租 -->
												<input type="hidden" name="${StartID}" value="${Start}">
											</c:if>
										</c:forTokens>
									</c:if>
								</c:forEach>
								<br>
								<button type="button" class="btn btn-dark">租賃條約</button>
								<script>
									$(document).ready(function(){
										$(".btn-dark").click(function(){
											Swal.fire({
												title:"<h1 align='center'>租賃條約</h1>",
												icon:"info",
												html:
													"<h3><span style='font-weight:bold;'>本服務內容</span></h3>"+
													"<p>在租賃期間內，凡參與本服務之顧客得享有以下服務：</p>"+
													"<p>1、組裝服務</p>"+
													"<p>於租賃合約開始前協助安排一次家具組裝服務，並於租賃合約終止後自租賃地點收回租賃家具。於租賃家具送達並完成全部組裝之日，會與顧客共同確認商品狀態並拍照存檔以完成驗收手續。</p>"+
													"<p>2、維修替換服務</p>"+
													"<p>如有任何租賃家具之維修需求，請透過官方網站通知服務人員辦理，以確保家具以正確方式維修及拆組。</p>"+
													"<p>3、額外收費事項：</p>"+
													"<p>以上組裝服務不包含運送/回收等其他服務費用，請於簽訂合約時，繳納運費之款項</p>"+
													"<h3><span style='font-weight:bold;'>租賃家具使用與損害賠償</span></h3>"+
													"<p></p>"+
													"<p>1、妥善使用</p>"+
													"<p>租賃期間內，顧客應對租賃家具保管、使用盡善良管理人之注意責任，並按商品使用及保養手冊內容，正確使用及維護租賃家具，顧客如故意或過失侵害之財產與權利應負損害賠償之責。</p>"+
													"<p>2、租賃家具人為損害賠償</p>"+
													"<p>租賃期間相關人為損壞，顧客須負賠償責任，並應立即向本公司報修。</p>"+
													"<h3><span style='font-weight:bold;'>品質及保證</span></h3>"+
													"<p>1、品質及爭議判定</p>"+
													"<p>本服務租賃家具為顧客自選之標準優質商品，如有任何相關租賃家具品質、損壞或使用等爭議發生時，其適用之保固條件、損壞原因判定，悉由家具產品製造商提供之方案設計及判定為最終標準。</p>"+
													"<p>2、同級品替換</p>"+
													"<p>原指定品牌家具、耗材或飾品等如因故無法替換時，本公司得以提供同級品替換或逕減收相關費用等方式向顧客履行或延續本服務。</p>"+
													"<h3><span style='font-weight:bold;'>租賃家具返還</span></h3>"+
													"<p>租賃合約期滿或終止時，顧客應恢復租賃家具外觀、功能及配件完整，並合於正常使用之狀態，且不得殘留異味(含煙味)、髒污、文字、記號或破損。顧客返還租賃家具時，如有上述情況，本公司得報價向顧客收取清潔費或修復費用。<p>",
												confirmButtonText:"我同意",
												confirmButtonColor:"#3085d6"
											});
										});
									});
								</script>
							</div><!-- 對應到InfoID -->
							<c:remove var="ID"/>
							<c:remove var="Value"/>
							<c:remove var="InfoID"/>
							<c:remove var="PicID"/>
							<c:remove var="ImgID"/>
							<c:remove var="StartID"/>
							<div class="col-12"><br></div>
						</c:forTokens>
					</div><!-- 對應到row -->
				</div><!-- 對應到div_all -->
				<!-- 下方按鈕 -->
				<div class="container">
					<div class="row page-section justify-content-center align-items-center">
						<div class="col-12 col-md-8" align="center">												
							<table class="table">
								<tr>
									<td><h3>總金額</h3></td>
									<td><h3>${Price} 元</h3></td>
								</tr>
								<tr>
									<td><h3>付款方式</h3></td>
									<td>
										<select class="form-select" name="pay">
											<option selected value="0" id="noselect">請選擇</option>
											<option value="mobile_payment">行動支付</option>
											<option value="credit_card">信用卡</option>
											<option value="store">超商繳費</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<button type="reset" class="btn btn-warning" onclick="javascript:Return();">
											<script>
												function Return(){
													window.location.assign("cart.jsp");
												}
											</script>
											重新選擇
										</button>
									</td>
									<td>
										<button type="submit" class="btn btn-success">付款</button>
									</td>
								</tr>
							</table>						
						</div><!-- 對應到col-12 -->
					</div>
				</div><!-- 對應到container -->
				<input type="hidden" name="ID_Value_list" value="${ID_Value_list}">
				<input type="hidden" name="price" value="${Price}"><!-- 在表單裡面用來記錄價錢的項目 -->
			</form>
			<br>
			<script>
				$(document).ready(function(){
					$("#noselect").attr("disabled",true);/*停用相同class的功能，這裡用來停止選項的功能*/
				});
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>