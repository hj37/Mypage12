<%@page import="org.jsoup.nodes.Element"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset= UTF-8">
<title>Insert title here</title>


</head>
<body>
<%
		Document doc = Jsoup.connect("https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=%EB%A1%AF%EB%8D%B0+%ED%95%98%EC%9D%B4%EB%9D%BC%EC%9D%B4%ED%8A%B8").get();

		Elements elements = doc.select("ul.vod_lst");
		
		Element element = elements.get(0);
		
		Elements lis1 = element.select("li");
		Elements lis2 = element.select("a");


		for(Element e : lis1){
 					out.print("<img src='" + e.select("img").attr("src") + "' width='"+ 200 + "' height = '"+ 100 + "'>");
					out.print("<a href='"+e.select("a").attr("href")+"' style='display:block' >'"+e.select("a").text()+"' </a>");
					
		}


// 		for(Element e : lis2){
			
// 				out.print("<a href='https://sports.news.naver.com/"+e.attr("href")+"'>'"+e.text()+"'</a>");
			
			
// 		}
	
		
		

%>
</body>
</html>