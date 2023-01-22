<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시판만들기 글쓰기 </title></head>

<body>
<h3>댓글 DB에 저장</h3>

<%

//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");

Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard", "root","1234");

// Sql문을 실행하기 위한 statement 객체를 생성
Statement stmt = conn.createStatement();
PreparedStatement pstmt = null;

String chatName = request.getParameter("chat_name");
String chatText = request.getParameter("chat_text");
int fldNmumber = Integer.parseInt(request.getParameter("fld_number"));


ResultSet rs = stmt.executeQuery("SELECT max(fld_number) as max_number FROM chat");
rs.next();
int intchatNumber = rs.getInt("max_number") +1;


String strSQL = "INSERT INTO chat (fld_chat_number, fld_number, fld_chat_name, fld_chat_content )";
strSQL = strSQL + "VALUES (?,?,?,?)";

pstmt = conn.prepareStatement(strSQL);

     pstmt.setInt(1, intchatNumber) ;
     pstmt.setInt(2, fldNmumber) ;
     pstmt.setString(3, chatName) ;
     pstmt.setString(4, chatText) ;
 
 
pstmt.executeUpdate();

//stmt.executeUpdate(strSQL);

pstmt.close();
rs.close();
stmt.close();
conn.close();

%>

<a href ="board_list.jsp"> [글목록]</a>

</body>
</html>