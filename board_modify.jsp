<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시글 수정하기</title></head>

<body>
<h3>게시판 글 수정 </h3>

<%


Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard", "root","1234");
Statement stmt = conn.createStatement();
// 전달된 글번호 받아서 변수에 보관
String strNumber = request.getParameter("write_number");
// 해당번호의 글만 가져옴
String strSQL = "SELECT * FROM myboard WHERE fld_number =" +strNumber;

ResultSet rs = stmt.executeQuery(strSQL);

rs.first();

String strName = rs.getString("fld_name");
String strEmail = rs.getString("fld_email");
String strTitle = rs.getString("fld_title");
String strContent = rs.getString("fld_content");

%>
<table border=0 width=600 align="left">
   <form method="post" action="board_modify_ok.jsp">
       <input type="hidden" name="write_number" value=<%=strNumber %>>
       <tr><td bgcolor="FBC48F"><b>성명</b></td>
	<td><input type="text" name="write_name" size=20 maxlength=20 value="<%=strName %>"></td>
        </tr> 
       <tr> <td bgcolor="FBC48F"><b>전자우편</b></td>
              <td><input type="text" name="write_email" size=30 maxlength=30 value="<%=strEmail %>"></td>
       </tr>
       <tr> <td bgcolor="FBC48F"><b>제목</b></td>
              <td><input type="text" name="write_title" size=50 maxlength=50 value="<%=strTitle %>"></td>
        </tr>
       <tr><td bgcolor="FBC48F"><b>비밀번호</b></td>
            <td><input type="text" name="write_pass" size=10 maxlength=10></td>
       </tr>
<!-- 글 정보 및 내용 보여주기/입력받기 끝 -->

<!-- 글 내용 보여주기 -->
      <tr><td colspan=2><textarea name="write_content" rows=15 cols=75><%= strContent %></textarea></td>
      </tr>
      <tr><td colspan=2>
           <input type="reset" value="원래값">
           <input type="submit" value="수정하기">
       </td></tr>
   </form>
</table> 


<%
rs.close();
stmt.close();
conn.close();

%>

</body>
</html>