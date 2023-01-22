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
PreparedStatement pstmt = null;

// Sql문을 실행하기 위한 statement 객체를 생성

String strNumber = request.getParameter("write_number");
String strName = request.getParameter("write_name");
String strPass = request.getParameter("write_pass");
String strEmail = request.getParameter("write_email");
String strTitle = request.getParameter("write_title");
String strContent = request.getParameter("write_content");


String strSQL = "SELECT * FROM myboard WHERE fld_number = " + strNumber;
    pstmt = conn.prepareStatement(strSQL);
    ResultSet rs = pstmt.executeQuery();

rs.first();
String dbPass = rs.getString("fld_pass");

if(strPass.equals(dbPass)){

   strSQL = "UPDATE myboard SET fld_name =?, fld_email=?, fld_title=?, fld_content=? WHERE fld_number ="+ strNumber;

pstmt = conn.prepareStatement(strSQL);

     pstmt.setString(1, strName) ;
     pstmt.setString(2, strEmail) ;
     pstmt.setString(3, strTitle) ;
     pstmt.setString(4, strContent) ;

pstmt.executeUpdate();

    out.println("해당글이 수정되었습니다.."); 

}else {
    out.println("비밀번호가 다릅니다.");
}


pstmt.close();
conn.close();

%>

<a href ="board_list.jsp"> [글목록]</a>

</body>
</html>