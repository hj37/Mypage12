package sec01.ex01;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import rvboard.rvboardDAO;
import rvboard.rvboardDTO;

//json7.jsp로 부터 요청 받는 서블릿 
@WebServlet("/json3")
public class JsonServlet3 extends HttpServlet{

	//doGet , doPost 메소드 오버라이딩
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doHandle(req, resp);
		}

		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doHandle(req, resp);
		}
		//클라이언트가 GET방식으로 요청하든 POST전송방식으로 요청하든 무조건 호출되는 메소드 
		protected void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
			
			
			//한글처리
			req.setCharacterEncoding("UTF-8");
			//클라이언트의 웹브라우저로 응답(내보낼,출력)할 데이터 MIME-TYPE설정
			resp.setContentType("text/html;charset=utf-8");
			//클라이언트의 웹브라우저를 거쳐 json6.jsp의 $.ajax()메소드로 응답메세지를 전달 하기 위한
			//출력 스트림 통로 준비
			PrintWriter out = resp.getWriter();

			rvboardDTO dto = new rvboardDTO();
			String jsonInfo = req.getParameter("jsonInfo");	//content내용 받아옴 
			rvboardDAO dao = new rvboardDAO();
			JSONObject totalObject = new JSONObject();
			
			rvboardDTO rvdto = new rvboardDTO();
			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject)jsonParser.parse(jsonInfo);
				dto.setContent((String)jsonObject.get("comment"));
				System.out.println(dto.getContent());
				dto.setT_name((String)jsonObject.get("t_name"));
				System.out.println(dto.getT_name());
				dto.setRef(Integer.parseInt(jsonObject.get("ref").toString()));
				System.out.println(dto.getRef());
				dto.setName((String)jsonObject.get("name"));
				dao.insertrvboard(dto);
				
				dto = dao.getrvBoard(dto.getT_name(), dto.getRef());
				
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("comment", dto.getContent());
				jsonObj.put("name",dto.getName());
				jsonObj.put("num",dto.getNum());
				jsonObj.put("ref",dto.getRef());
				
				java.sql.Timestamp day = dto.getReg();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
				jsonObj.put("reg",sdf.format(day));
				jsonObj.put("t_name",dto.getT_name());
				
				JSONArray jsonArray1 = new JSONArray(); 
				jsonArray1.add(jsonObj);
				
				totalObject.put("members", jsonArray1);
				
				jsonInfo = totalObject.toString();
				
				System.out.print(jsonInfo);
				out.print(jsonInfo);

				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
}

/*
	JsonServlet2.java 서블릿 파일 입니다
	
	
	----------------JSONObject객체 내부에  JSONArray배열의 정보를 저장하는 과정--------------
	
	1. memberInfo로  JSONObject객체를 생성 한후  회원정보를 name/value 쌍으로 저장

	2. membersArray의 JSONArray객체를 생성한후 회원정보를 저장한 JSONObject객체를 차례대로 저장

	3. membersArray의  배열에  회원정보를 저장한 후  totalObject로  JSONObject객체를 생성하여
	   name에는 자바스크립트에서 접근할 때사용하는 이름은 members를,
	   value에는  membersArray를 최종적으로 저장




*/





