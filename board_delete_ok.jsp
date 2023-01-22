<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시판만들기 글쓰기 </title></head>

<body>
<h3>비밀번호 비교후 삭제 </h3>
<%
Class.forName("org.mariadb.jdbc.Driver");     // JDBC 드라이버 로드

Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1234");
PreparedStatement pstmt = null;  

String strNumber = request.getParameter("write_number"); // 글번호
String strPass =  request.getParameter("write_pass");       // 비밀번호

    // 데이터베이스에서 저장된 글의 원래 비밀번호를 알아냅니다.
    String strSQL = "SELECT * FROM myboard WHERE fld_number = " + strNumber;
    pstmt = conn.prepareStatement(strSQL);
    ResultSet rs = pstmt.executeQuery();

rs.first();
String dbPass = rs.getString("fld_pass");

if(strPass.equals(dbPass)){

    strSQL = "DELETE FROM myboard WHERE fld_number=" + strNumber;
    pstmt = conn.prepareStatement(strSQL);
    pstmt.executeUpdate();

    out.println("해당글이 삭제되었습니다."); 

}else {
    out.println("비밀번호가 다릅니다.");
}

pstmt.close();
conn.close();
%>

<a href="board_list.jsp">[글목록]</a>
</body>
</html>