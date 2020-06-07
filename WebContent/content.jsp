<%@page import="rvboard.rvboardDAO"%>
<%@page import="rvboard.rvboardDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
 <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>로그인 화면</title>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
 
    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
 
	<script src="js/jquery.min.js"></script> 
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
			<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
 <script type="text/javascript">
    	//웹브라우저가 json1.jsp의 HTML코드를 모두 로딩 했을떄... function(){}함수가 실행되게 선언
    	$(function(){
    			// id속성값이 checkJson인 <a>영역을 선택해서 가져와서 
    			// 클릭하는 행위(이벤트)를 등록함.
    			// -> 사용자가 <a>요소를 클릭하는 순간? function(){}<---이벤트처리기 함수가 자동으로 수행됨
    			$("#checkJson").click(function(){
    				var comment = document.commentForm.content.value;
    				var num = document.commentForm.num.value;
    				var name = document.commentForm.name.value;
					var _jsonInfo = '{"comment":"'+comment+'","t_name":"board","ref":"'+num+'","name":"'+name+'"}';

    				$.ajax({
    							type : "post",
    							async : false,
    							url : "<%=request.getContextPath()%>/json3",
    							data:{
									jsonInfo : _jsonInfo
    							},
  							success : function(data,textStatus){
    								
    								//서버페이지인? 서블릿에서 응답한 data매개변수 값은 
    								//JSONObject객체 형태의 문자열이다.
    								
    								//참고 : JSONObject객체형태의 문자열을 파싱해서 
    								//      JSONObject객체로 변환한다.
    								var jsonInfo = JSON.parse(data);
    								
    								var memberInfo = "";
    								
    								for(var i  in jsonInfo.members){
    									
    									memberInfo += "<tr><td>" + jsonInfo.members[i].num + "</td>";
    									memberInfo += "<td>" + jsonInfo.members[i].name + "</td>";
    									memberInfo += "<td>" + jsonInfo.members[i].comment + "</td>";
    									memberInfo += "<td>" + jsonInfo.members[i].reg + "</td>";
    									memberInfo += "<td><button name = 'button' type='button'>삭제</button></td></tr>";

    								}
    								    								
    								$("#tr").append(memberInfo + "<br>");
    								
    								
    							},
    							error : function(){
    								alert("통신에러가 발생했습니다.");
    							}
    					   });
    				
    				
    			});
    	});    
    </script>


		
				 
	<style type="text/css">
#container {
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	table-layout: fixed;
	
}
#table_search {
	margin: auto;
	width: 50%;
}

#tb td,#tb th{
	padding-top: 1.25em;
	padding-bottom: 1.25em;
}


</style>

		
		
</head>



<%
	/*글 상세보기 페이지 */
	//notice.jsp페이지에서 글제목을 클릭해서 전달하여 넘어온 num,pageNum 한글처리 
	request.setCharacterEncoding("UTF-8");

	//notice.jsp페이지에서 글제목을 클릭해서 전달하여 넘어온 num, pageNum 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	//BoardDAO 객체 생성 bdao
	BoardDAO dao = new BoardDAO();
	
	//조회수 1증가
	dao.updateReadCount(num); 	//메소드 먼저 만들자 
	
	//상세내용을 볼 글에 대한 글번호를 넘겨서 DB로부터 글정보(BoardBean객체) 가져오기
	BoardBean boardBean = dao.getBoard(num);
	String name = "";
	int DBnum = boardBean.getNum();
	int DBReadcount = boardBean.getReadcount();
	String DBName = boardBean.getName(); //작성자
	Timestamp DBDate = boardBean.getDate();	//작성일
	String DBSubject = boardBean.getSubject(); // 글제목 
	String DBContent = "";	//글내용 
	//글내용이 존재 한다면  // 내용 엔터 처리 
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("\r\n","<br/>");
	}
	int DBRe_ref = boardBean.getRe_ref(); //답변 
	int DBRe_lev = boardBean.getRe_lev(); //
	int DBRe_seq = boardBean.getRe_seq(); //
	List<rvboardDTO> list = null;
	rvboardDAO rvdao = new rvboardDAO();
	String _day = "";
%>

<!-- Wrapper -->
			<div class="wrapper style1">
				<!-- Header -->
						<jsp:include page="header.jsp"/>
					
					
							<!-- Banner -->
					<div id="banner" class="container">
						<section>
							<p><a href="board.jsp">롯데 자이언츠 커뮤니티 게시판</a></p>
						</section>
					</div>

<div class="container">
	<div class="row">
	<table class="table table-hover" id="tb" style="text-align:center; border: 1px solid white;" bgcolor = "white">
	<thead>
				<tr>
					<th colspan="3" style="background-color:#eeeeee; text-align: center;">게시판 글보기 양식 </th>
				</tr>
	</thead>
	<tbody>	
	<tr>
		<td style="width:20%;">글제목</td>
		<td colspan="2"><%=DBSubject %></td>
	</tr>
	<tr>
		<td>글번호</td>
		<td colspan="2"><%=DBnum %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td colspan="2"><%=DBReadcount %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td colspan="2"><%=DBName %></td>
	</tr>
	<tr>
		<td>작성일</td>
		<td colspan="2"><%=DBDate %></td>
	</tr>
	<tr>
		<td>글내용</td>
		<td colspan="2" style="min-height: 200px; text-align: left"><%=DBContent %></td>
	</tr>
	<%-- <tr>
		<td style="width:20%;">글번호 </td>
		<td colspan="2"><%=DBnum %></td>
		<th scope="col">조회수</th>
		<td><%=DBReadcount %></td>
	</tr>
	<tr>
		<th scope="col">작성일</th>
		<td><%=DBDate %></td>
	</tr> --%>
</tbody>
</table>
</div>
</div>
<div id = "table_search" style="text-align: center">
<%
//각각 페이지에서.. 로그인후 이동해 올때.. 세션 id 전달받기 
String id = (String)session.getAttribute("id");
//세션값이 있으면, 수정, 삭제, 답글쓰기 버튼 보이게 설정
if(id!= null){
%>
<input type="button" value="글수정" class="btn" onclick="location.href='update.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
<% 
name = (String)session.getAttribute("name");


list = rvdao.getrvboard("board", num);
}
%>
<input type="button" value="목록보기" class="btn" onclick="location.href='board.jsp?pageNum=<%=pageNum%>'">
</div>
<br><br>


<div class="container">
	<div class="row" style="margin-bottom: -16px;">
	<table class="table table-hover" id="tc" style="text-align:center; border: 1px solid white;" bgcolor = "white">
	
	<thead>
				<tr>
					<th colspan="6" style="background-color:#eeeeee; text-align: center;">댓글</th>
				</tr>
	</thead>	
<% 
	if(list.size() > 0){
		for(int i = 0; i < list.size(); i++){
		rvboardDTO dto = list.get(i);
		
		
		java.sql.Timestamp day = dto.getReg();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		_day = sdf.format(day);
		
%>
	<tbody>
	<tr>
		<td><%=dto.getNum()%></td>	
		<td><%=dto.getName() %>	</td>
		<td><%=dto.getContent() %></td>
		<td><%=_day %></td>
	</tr>
	</tbody>
<%
		}
	}
%>
	</table>
	</div>
</div>

<div class="container">
	<div class="row">
	<table class="table table-hover"  style="text-align:center; border: 1px solid white;" bgcolor = "white">
	<tbody id = "tr">
	
	
	</tbody>
	</table>
	</div>
</div>

<div class="container">
	<div class="row">
	<form name = commentForm method="post">
	<table class="table table-hover" id="tx" style="text-align:center; border: 1px solid white;" bgcolor = "white">
		<tbody>	
			<tr>
			<td>댓글달기</td>
			<td  colspan="2"><textarea name="content" rows="5" cols="40" placeholder="댓글을 입력해주세요."></textarea></td>
			</tr>	
					
		</tbody>
	</table>	
		<input type="hidden" name="name" value=<%=name%>>
		
		<input type="hidden" name="num" value=<%=num%>>
		<input type="button" class = "button alt" id="checkJson"  style="cursor: pointer;" value="댓글등록" > <br>
	</form>
	</div>
</div>	


</div>
<!-- Copyright -->
			<jsp:include page="bottom.jsp"/>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>