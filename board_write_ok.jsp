<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시판만들기 글쓰기 </title></head>

<body>
<h3>입력글 DB에 저장 </h3>

<%

//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");

Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard", "root","1234");

// Sql문을 실행하기 위한 statement 객체를 생성
Statement stmt = conn.createStatement();
PreparedStatement pstmt = null;

String strName = request.getParameter("write_name");
String strPass = request.getParameter("write_pass");
String strEmail = request.getParameter("write_email");
String strTitle = request.getParameter("write_title");
String strContent = request.getParameter("write_content");

ResultSet rs = stmt.executeQuery("SELECT max(fld_number) as max_number FROM myboard");
rs.next();
int intNumber = rs.getInt("max_number") +1;

java.sql.Date dtDate = new java.sql.Date(new java.util.Date().getTime());

/*String strSQL = "INSERT INTO myboard (fld_number, fld_name, fld_pass, fld_email, fld_title, fld_content, fld_date, fld_count) VALUES ";
     strSQL = strSQL + "(" + intNumber + "," ;
     strSQL = strSQL + "'" + strName + "'" + "," ;
     strSQL = strSQL + "'" + strPass + "'" + "," ;
     strSQL = strSQL + "'" + strEmail + "'" + "," ;
     strSQL = strSQL + "'" + strTitle + "'" + "," ;
     strSQL = strSQL + "'" + strContent + "'" + "," ;
     strSQL = strSQL + "'" + dtDate.toString() + "'" + "," ;
     strSQL = strSQL + "0"+ ")" ;*/
String strSQL = "INSERT INTO myboard (fld_number, fld_name, fld_pass, fld_email, fld_title, fld_content, fld_date, fld_count)";
strSQL = strSQL + "VALUES (?,?,?,?,?,?,?,?)";

pstmt = conn.prepareStatement(strSQL);

     pstmt.setInt(1, intNumber) ;
     pstmt.setString(2, strName) ;
     pstmt.setString(3, strPass) ;
     pstmt.setString(4, strEmail) ;
     pstmt.setString(5, strTitle) ;
     pstmt.setString(6, strContent) ;
     pstmt.setDate(7, dtDate) ;
     pstmt.setInt(8, 0) ;
 
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