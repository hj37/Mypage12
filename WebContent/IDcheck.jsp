<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/member.css" rel="stylesheet">

<title>Insert title here</title>

	<script type="text/javascript">
	
	function result(){
		opener.document.fr.idDuplication.value = "idcheck";
		opener.document.fr.id.value = document.nfr.chkid.value;
		window.close();
	}
	</script>

</head>
<body>
<br><br>
<%
	String id = request.getParameter("chkid");

	MemberDAO mdao = new MemberDAO();
	
	int check = mdao.idCheck(id);
	
	if(check==1){
		out.println("이미 사용중인 ID입니다.");
	}else{
		out.println("사용가능한 ID입니다.");
%>
		<%--사용가능한 ID이면 사용함 버튼을 눌러서 부모창에 사용가능한 ID뿌려주기  --%>
		
	 	<input type="button" value="사용하기" class="idchk_btn" onclick="result();">
	 	
<%	
	}

%>

	<br><br>
	<form action="IDcheck.jsp" method="post" name="nfr">
		아이디 : <input type="text" name="chkid" id="chkid" value="<%=id%>">
		<input type="submit" value="중복확인" class="idchk_btn">
	</form>


</body>
</html>