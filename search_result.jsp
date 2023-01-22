<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.net.*" %>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>14강 검색</title></head>
<body>
<h3>검색결과 보여주기 </h3>
<%

    //  JDBC 드라이버 로드, 데이터베이스 연결(Connection 객체 생성), Statement 객체 생성 
     Class.forName("org.mariadb.jdbc.Driver");     // JDBC 드라이버 로드
     Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1234");
     Statement stmt = conn.createStatement();

     // 전달받은 값 받아오기
    String strType=request.getParameter("search_type");
    String strString=request.getParameter("search_string");
    URLEncoder.encode(strString,"UTF-8");
    String strSql = "";
        // 조건에 맞추어 SQL문 구성
    if(strType.equals("name"))
    {
        strSql = "select * from myboard where fld_name like '%" +strString+ "%'";
     }
    else if(strType.equals("title"))
    {
        strSql = "select * from myboard where fld_title like '%" +strString+ "%'";
    }
    else
    {
        strSql = "select * from myboard where fld_content like '%" +strString+ "%'";  
    }

   // SQL 실행(쿼리 수행) , 수행한 결과는 ResultSet으로 가져옴
   ResultSet rs = stmt.executeQuery(strSql);
%>


<table border=0 width=600>
<tr bgcolor="#FBC48F">
<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>조회수</td>
</tr>
<%
    //rs의 데이터를 마지막 레코드가 될 때까지 반복해서 출력
      while (rs.next()) {
         out.println("<tr>");
         String strNumber = rs.getString("fld_number"); //글번호
         out.println("<td>" + strNumber + "</td>");   //글번호
         // 글 제목
         out.println("<td><a href=board_view.jsp?write_number="+ strNumber + "&key_word=" +strString+">" + rs.getString("fld_title") + "</a></td>");       
         out.println("<td>" + rs.getString("fld_name") + "</td>");     // 작성자
         out.println("<td>" + rs.getDate("fld_date") + "</td>");       // 작성일
         out.println("<td>" + rs.getString("fld_count") + "</td>");     // 조회수
         out.println("</tr>");
     }
  
%>
</table>
<%
// 데이터베이스를 위해 할당했던 자원들을 해제한다.
rs.close();
stmt.close();
conn.close();
%>
</body></html>