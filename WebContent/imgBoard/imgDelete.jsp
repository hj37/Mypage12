<%@page import="java.io.File"%>
<%@page import="img.ImgDTO"%>
<%@page import="img.ImgDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	ServletContext context = request.getServletContext();
	String imagePath = context.getRealPath("image");
	
	
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	ImgDAO dao = new ImgDAO();
	ImgDTO dto = dao.getFileBoard(num);
	File file = new File(imagePath + dto.getFileName());
	file.delete();
	File file2 = new File(imagePath + dto.getFileRealName());
	file2.delete();
	dao.imgdeleteBoard(num);
%>
<script type="text/javascript">
	alert("삭제가 완료되었습니다.");
	location.href = "imgboard.jsp?";				
	
</script>


<body>

</body>
</html>