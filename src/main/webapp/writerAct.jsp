<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
//넘어온 값을 변수에 저장
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");

	//DB저장
	String url = "jdbc:mysql://localhost:3306/smart?characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
	String user = "root";
	String password = "smart";
	String sql = " INSERT INTO board (title, content, writer, writerDate) ";
	sql += " VALUES(?, ?, ?, now()) ";
	Connection conn = null;
	PreparedStatement stmt = null;
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		conn = DriverManager.getConnection(url, user, password);
		stmt = conn.prepareStatement(sql);

		stmt.setString(1, title);
		stmt.setString(2, content);
		stmt.setString(3, writer);
		stmt.executeUpdate();
	} catch (Exception e){
		e.getLocalizedMessage();
	} finally {
		try{
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		} catch(Exception e){
			e.getLocalizedMessage();
		}
	}
	
	//페이지 이동
	response.sendRedirect("list.jsp");

%>

