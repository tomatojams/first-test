<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import = "java.net.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시판글보기 </title></head>

<body>
<h3>게시판 글 내용 보여주기 </h3>

<%


Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard", "root","1234");
Statement stmt = conn.createStatement();
// 전달된 글번호 받아서 변수에 보관
String strNumber = request.getParameter("write_number");
String strKey = null;
strKey = request.getParameter("key_word");


// 해당번호의 글만 가져옴

String strSQL = "UPDATE myboard SET fld_count = fld_count + 1 WHERE fld_number ="+strNumber;
stmt.executeUpdate(strSQL);
strSQL = "SELECT * FROM myboard WHERE fld_number =" +strNumber;
ResultSet rs = stmt.executeQuery(strSQL);

rs.first();

String strName = rs.getString("fld_name");
String strEmail = rs.getString("fld_email");
String strDate = rs.getString("fld_date");
String strCount = rs.getString("fld_count");
String strTitle = rs.getString("fld_title");
String strContent = rs.getString("fld_content");
strContent =strContent.replaceAll("\r\n","<br>");

if(strKey != null)
{
//strContent =strContent.replaceAll(strKey,"<font color=\"red\">"+strKey+"</font>");
strContent =strContent.replaceAll(strKey,"<span style= 'color:red;'>"+strKey+"</span>");

}



%>
<table border =0  width ="600">

<tr>
    <td align="left">  작성자 : <a href="mailto: <%= strEmail %>"><%= strName %></a></td> <!--표현식사용-->
    <td align ="right">작성일: <%=strDate %>, 조회수: <%=strCount%></td>

</tr>
</table>

<table border =2 cellspacing = 3 cellpadding =3 width ="600" bordercolor ="DFFFDF">
    <tr bgcolor ="#FBC48F">
    <td align = "center"><font size = 3 color = "0000057"><%=strTitle %><font></td>
    </tr>
</table>
<!-- 글내용시작 -->
<table border =1 cellspacing = 5 cellpadding =10 width ="600" bordercolor ="DFFFDF">
    <tr bgcolor ="#FFE6D9">
    <td align = "left"><font size = 2><%=strContent %><font></td>
    </tr>
</table>

<!-- 하단 메뉴 시작 -->
<table border=0 width="600">
   <tr><td align="left">
	<a href="board_modify.jsp?write_number=<%= strNumber %>">[수정]</a>
	<a href="board_delete.jsp?write_number=<%= strNumber %>">[삭제]</a></td>
          <td align="right">
	<a href="board_write.jsp">[쓰기]</a>
	<a href="board_list.jsp">[목록]</a></td>
   </tr>
</table>
<br>
<!-- 하단 메뉴 끝 -->

<!-- 댓글작성폼 -->



<!-- 댓글나열 -->
<table border =2 cellspacing = 3 cellpadding =3 width ="600" bordercolor ="DFFFDF">
<%

strSQL = "SELECT * FROM chat WHERE fld_number =" +strNumber;
rs = stmt.executeQuery(strSQL);

while (rs.next()){ 
    
    out.println("<tr>"); 
    out.println("<td>"+rs.getString("fld_chat_name") + "</td>");
    out.println("<td>"+rs.getString("fld_chat_content") + "</td>");
    out.println("</tr>");
}

rs.close();
stmt.close();
conn.close();

%>
</table>

<table border =0 >
<form method ="post" action ="board_chat_ok.jsp">
<tr>
<td bgcolor ="FBC48F"><b>댓글</b></td>
<input type="hidden"  name="fld_number" value=<%=strNumber%> >
<td><input type ="text" size =10 name = "chat_name" maxlength 10></td>
<td><input type ="text" size =50 name ="chat_text" maxlength 50></td>
<td colspan =2><center><input type ="submit" value ="저장"></center></td>
</tr>
</form>

</table>

</body>
</html>