<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시판글쓰기 </title></head>

<body>
<h3>게시판 글쓰기 </h3>


<table border =0 >
<form method ="post" action ="board_write_ok.jsp">

<tr>
<td bgcolor ="FBC48F"><b>이름</b></td>
<td><input type ="text" size =20 name = "write_name" maxlength 20></td>
<tr>
<td bgcolor ="FBC48F"><b>비밀번호</b></td>
<td><input type ="password" size =30 name ="write_pass" maxlength 30></td>
</tr>
</tr>
<tr>
<td bgcolor ="FBC48F"><b>전자우편</b></td>
<td><input type ="text" size =30 name ="write_email" maxlength 30></td>
</tr>
<tr>
<td bgcolor ="FBC48F"><b>제목</b></td>
<td><input type ="text" size =50 name ="write_title" maxlength 50></td>
</tr>
<tr>
<td colspan =2><textarea name ="write_content" rows =15 cols=75></textarea></td>
</tr>
<tr>



<td colspan =2><center><input type ="reset" value="다시작성">
        <input type ="submit" value ="저장"></center></td>
</tr>
</form>

</table>

</body>
</html>