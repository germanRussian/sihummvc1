<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	//DB불러오기
	String url = "jdbc:mysql://localhost:3306/smart?characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
	String user = "root";
	String password = "smart";
	String sql = " SELECT * FROM board ORDER BY num DESC ";
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		conn = DriverManager.getConnection(url, user, password);
		stmt = conn.prepareStatement(sql);

		rs = stmt.executeQuery();
		
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<table class="table">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
<%
while(rs.next()){

%>		
			<tr>
				<td><%=rs.getInt("num") %></td>
				<td><a href="view.jsp?num=<%=rs.getInt("num") %>"><%=rs.getString("title") %></a></td>
				<td><%=rs.getString("writer") %></td>
				<td><%=rs.getString("writerDate") %></td>
			</tr>
<%

}
%>			
		</tbody>
	</table>
	<div class="pull-right"><a href="writer.jsp" class="btn btn-default">글쓰기</a></div>
</div>
</body>
</html>
<%
	} catch (Exception e){
		e.getLocalizedMessage();
	} finally {
		try{
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		} catch(Exception e){
			e.getLocalizedMessage();
		}
	}
%>