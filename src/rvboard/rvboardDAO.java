package rvboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;


public class rvboardDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//커넥션풀(DataSource)을 얻은 후 ConnecionDB접속
		private Connection getConnection() throws Exception{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
			//커넥션풀에 존재하는 커넥션 얻기
			Connection con = ds.getConnection();
			//커넥션 반환
			return con;
		}
		
		public void insertrvboard(rvboardDTO dto) {
			String sql = "";
			int num = 0; //글번호 증가 
			
			try {
				con = getConnection(); //DB연결
				//새 글 추가시 글번호 구해오기 
				//board테이블에 글이 없는 경우 : 글번호 1
				//board테이블에 글이 존재하는 경우 : 최근 글 번호 + 1
				//SQL문 만들기
				sql = "select max(num) from rvboard"; //가장 큰 글번호 검색 
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery(); //검색 후 값 얻기 
				
				if(rs.next()) {//가장 큰 글번호가 검색되면 
					//가장 큰 글번호에 + 1한 글번호를 ? 새글의 글번호로 사용하기 위해 저장 
					num = rs.getInt("max(num)") + 1; //가장 최신 번호 검색하기 위해 
					//column 이름이 바뀜 1로 적어도 됨 
				}else {
					num  = 1; //board테이블에 글이 저장되어 있지 않다면 새 글 추가시 1을 사용하기 위함 
				}
				
				//insert SQL문만들기 
				sql = "insert into rvboard(num,name,content,"
						+ "reg,t_name,ref)"
						+ "values(?,?,?,now(),?,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dto.getName());
				pstmt.setString(3, dto.getContent());
				pstmt.setString(4, dto.getT_name());
				pstmt.setInt(5, dto.getRef());
			
				pstmt.executeUpdate();	//insert실
				
			}catch (Exception e) {
				System.out.println("insertrvboard메서드 내부에서 예외발생하였습니다:" +e.getMessage());
			}finally {
				try {
					if(rs != null) {rs.close();}
					if(pstmt != null) {pstmt.close();}
					if(con != null) {con.close();}
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			
		}
		
		
		//글 하나의 정보를 검색하여 글정보를 제공해주는 메소드 
		public List<rvboardDTO> getrvboard(String t_name,int ref) {
				

			//매개변수로 전달 받은 글 번호에 해당하는 글을 검색해서 저장할 BoardDto객체 생성
			
			List<rvboardDTO> boardList = new ArrayList<rvboardDTO>();
			try {
				//커넥션풀로 커넥션 얻기(DB접속) 
				con = getConnection();
				
				//매개변수로 전달 받은 글번호에 해당 되는 글 하나의 정보를 검색하는 SELECT구문 만들기 
				String sql = "select * from rvboard where t_name = ? and ref = ? order by num ";	
				//?기호 해당되는 값을 제외한 나머지 SELECT문장을 저장한? PreparedStatement실행 객체 얻기
				pstmt = con.prepareStatement(sql);
				//?기호에 해당되는 글번호를 설정
				pstmt.setString(1, t_name);
				pstmt.setInt(2, ref);
				//SELECT구문 실행한 후 검색된 글 하나의 정보를 ResultSet에 저장 후 반환 받기
				rs = pstmt.executeQuery();
				
				//ResultSet임시 저장소에 검색한 데이터(글 하나의 정보)가 존재하면?
				while(rs.next()) {
					rvboardDTO dto = new rvboardDTO();
					//ResultSet에서 검색한 글의 정보들을 꺼내와서 BoardDto객체의 각 변수에 저장  
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setContent(rs.getString("content"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setT_name(rs.getString("t_name"));
					dto.setRef(rs.getInt("ref"));
					
					boardList.add(dto);
				}
				
			} catch (Exception e) {
				
				System.out.println("getrvboard메소드 내부에서 오류 : " + e.getMessage());
				
			}finally {
				if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(con != null) try{con.close();}catch(Exception e) {e.printStackTrace();}
			}
			
			return boardList;	//DB로부터 검색한 하나의 글정보를 BoardDto객체에 저장 후 Update.jsp로 반환

		}
		
		
		//글 하나의 정보를 검색하여 글정보를 제공해주는 메소드 
		public rvboardDTO getrvBoard(String t_name,int ref) {
				

			//매개변수로 전달 받은 글 번호에 해당하는 글을 검색해서 저장할 BoardDto객체 생성
			rvboardDTO dto = new rvboardDTO();
			int num = 0;
			try {
				//커넥션풀로 커넥션 얻기(DB접속) 
				con = getConnection();
				
				//매개변수로 전달 받은 글번호에 해당 되는 글 하나의 정보를 검색하는 SELECT구문 만들기 
				String sql = "select max(num) from rvboard where t_name = ? and ref = ?";	
				//?기호 해당되는 값을 제외한 나머지 SELECT문장을 저장한? PreparedStatement실행 객체 얻기
				pstmt = con.prepareStatement(sql);
				//?기호에 해당되는 글번호를 설정
				pstmt.setString(1, t_name);
				System.out.println(t_name);
				pstmt.setInt(2,ref);
				System.out.println(ref);
				//SELECT구문 실행한 후 검색된 글 하나의 정보를 ResultSet에 저장 후 반환 받기
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					System.out.println("찾았습니다.");
					num = rs.getInt("max(num)");
					System.out.println(num);
				}else {
					System.out.println("못 찾았습니다.");
				}
				
				String sql2 = "select * from rvboard where num = ?";
				
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				//ResultSet임시 저장소에 검색한 데이터(글 하나의 정보)가 존재하면?
				if(rs.next()) {
					//ResultSet에서 검색한 글의 정보들을 꺼내와서 BoardDto객체의 각 변수에 저장  
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setContent(rs.getString("content"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setT_name(rs.getString("t_name"));
					dto.setRef(rs.getInt("ref"));
				}
				
			} catch (Exception e) {
				
				System.out.println("getrvBoard메소드 내부에서 오류 : " + e.getMessage());
				
			}finally {
				if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(con != null) try{con.close();}catch(Exception e) {e.printStackTrace();}
			}
			
			return dto;	//DB로부터 검색한 하나의 글정보를 BoardDto객체에 저장 후 Update.jsp로 반환

		}
		
 
}
