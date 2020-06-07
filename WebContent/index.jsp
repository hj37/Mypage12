<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Phase Shift by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
		<title>Giants 커뮤니티게시판</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
		 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
		
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		<%
			Document doc;
		
			Elements elements;
		
			Element element;
		
			Elements lis1;
			Elements lis2;

		%>
		
		
		
		
		
	</head>
	<body>

		<!-- Wrapper -->
			<div class="wrapper style1">

				<!-- Header -->
					<jsp:include page="header.jsp"/>

				<!-- Banner -->
					<div id="banner" class="container" style="width:150%">
						<p>롯데 자이언츠 하이라이트 영상</p>
						
						<section>
							<table class="table table-hover" id="tb" style="text-align:center; font-size:15px; margin-bottom: -15px; border: 1px solid white" bgcolor = "white">
							<%
								doc = Jsoup.connect("https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=%EB%A1%AF%EB%8D%B0+%ED%95%98%EC%9D%B4%EB%9D%BC%EC%9D%B4%ED%8A%B8").get();

								elements = doc.select("ul.vod_lst");

								element = elements.get(0);
							
								lis1 = element.select("li");
							
								lis2 = element.select("a");
								out.print("<tr>");
								for(Element e : lis1){
				 					out.print("<td><a href='"+e.select("a").attr("href")+"' style='display:block' target='_blank' ><img src='" + e.select("img").attr("src") + "' width='"+ 200 + "' height = '"+ 100 + "'></a>");
									out.print("<a href='"+e.select("a").attr("href")+"' style='display:block' target='_blank' >'"+e.select("a").text()+"' </a></td>");
									
								}
								out.print("</tr>");
							
							%>
							</table>
						</section>
					</div>

				<!-- Extra -->
					<div id="extra">
						<div class="container">
							<div class="row no-collapse-1">
								
								<section class="6u"> 
									<div class="box">
										<table class="table table-hover" id="tb" style="text-align:center; font-size:15px; margin-bottom: -15px; border: 1px solid white" bgcolor = "white">
										<% 
								
											doc = Jsoup.connect("https://sports.news.naver.com/kbaseball/index.nhn").get();

											elements = doc.select("ol.news_list");
										
											element = elements.get(0);
										
											lis1 = element.select("li");
											lis2 = element.select("a");
											
											out.print("이 시각 많이 본 프로야구 뉴스<br>"); 	
											for(Element e : lis1){
									 			for(int i = 0; i < 2; i++){
													if(i == 1){
														out.print("<td><a href='https://sports.news.naver.com/"+e.select("a").attr("href")+"'  target='_blank'>'"+e.select("a").text()+"'</a></td>");
													}else{
									 					out.print( "<tr><td>" + e.select("span.number").text() + "</td>");
													}
									 			}
									 			out.print("</tr>");
											}
											
											
										%>	
										</table>	
									</div>
								</section>
								<section class="6u"> 
									<div class="box">
										<p>커뮤니티 게시판 최다 조회순</p>
									
										<%
										BoardDAO dao = new BoardDAO();
										
										List<BoardBean> list = dao.getReadBoardList();		//최다 조회순 
										%>
	
										<table class="table table-hover" id="tb" style="text-align:center; font-size:15px; margin-bottom: -15px; border: 1px solid white" bgcolor = "white">
										<tr>
										    <th  scope="col">이름</th>
							    			<th  scope="col">제목</th>
							    			<th  scope="col">날짜</th>	    			
										    <th  scope="col">조회수</th>
									    </tr>
															
															
										
										<% 
										
											for(int i = 0; i < list.size(); i++){
									 			BoardBean bean = list.get(i);
										%>
										
										
											<tr>
							 				<td><%=bean.getName() %></td>
							 				<td><%=bean.getSubject() %></td>
										    <td><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate()) %></td>
										    <td><%=bean.getReadcount() %></td>		
										   </tr>
										<%
											}
										%>
										</table>
									</div>
								</section>
								
							
							</div>
						</div>
					</div>
<%
			doc = Jsoup.connect("https://www.koreabaseball.com/TeamRank/TeamRank.aspx").get();
			
			elements = doc.select("table.tData");
			
			element = elements.get(0);
			
			lis1 = element.select("th");
			lis2 = element.select("tbody");

		

%>

<br>

<div id="banner" class="container" style="margin-bottom: -10px">
						<section>
							<p>프로야구 실시간 순위</p>
						</section>
					</div>
			<!-- Main -->
					<div id="main" style="margin-left: 30px">
						<div class="container">
							<div class="row"> 
								
							
								
								<!-- Content -->
											<table class="table table-hover" id="tb" style="text-align:center; border: 1px solid white" bgcolor = "white">
											<tr>
<%
	for(Element e : lis1){
		out.print("<th>" + e.select("th").get(0).text() + "</th>");
	}
%>


											</tr>
											
<%
	for(Element e : lis2){
		out.print("<tr>");
		int cnt = 0;
		for(int i = 0 ; i < 120; i++){
			out.print("<td>" + e.select("td").get(i).text() + "</td>");
			cnt++;
			if(cnt % 12 == 0 && cnt != 0){
				out.print("</tr><tr>");
			}
		
		}
	}


%>																						
											</table>
								</div>
									<section>
										<ul class="style">
											<li class="fa fa-cogs">
												<h3>Integer ultrices</h3>
												<span>In posuere eleifend odio. Quisque semper augue mattis wisi. Maecenas ligula. Pellentesque viverra vulputate enim. Aliquam erat volutpat. Maecenas condimentum enim tincidunt risus accumsan.</span> </li>
											<li class="fa fa-road">
												<h3>Aliquam luctus</h3>
												<span>In posuere eleifend odio. Quisque semper augue mattis wisi. Maecenas ligula. Pellentesque viverra vulputate enim. Aliquam erat volutpat. Maecenas condimentum enim tincidunt risus accumsan.</span> </li>
										</ul>
									</section>
								</div>
							</div>
						</div>
					</div>

	</div>

	<!-- Footer -->
	
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    
   </body>
</html>
    