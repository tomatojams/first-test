<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head><title>게시판만들기 실습 </title></head>

<body>
<h3>게시판 글 리스트 보여주기 </h3>

<%

//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");

Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard", "root","1234");
Statement stmt = conn.createStatement();
PreparedStatement pstmt = null;


// 분류방법 받아오기
String strSortType =request.getParameter("sort_type");

// 현재페이지
String cpage = request.getParameter("currentPage");
// 페이지수변수
int numPerPage =5;
int totalPage = 0;
int nowPage =1;
int startRecord = 0;

if(cpage != null){
nowPage = Integer.parseInt(cpage);
} // 널값이 아닐때 nowPage가 현재페이지

// 전체 게시글수 받아오기
ResultSet rs = stmt.executeQuery("SELECT count(fld_number) AS recNumber from myboard");
rs.next();

int totalRecord = rs.getInt("recNumber");
int a = totalRecord / numPerPage;
int b = totalRecord % numPerPage;

if(b != 0){
    a = a + 1;
}
totalPage = a;
// 전체 페이지구함

// sql문 스트링 생성
String strSql= null;

int curLimit = 5*nowPage -5;
int curLimit2 = curLimit -1;
int curLimit3 = curLimit +5;
String cur = Integer.toString(curLimit);
String cur2 = Integer.toString(curLimit2);
String cur3 = Integer.toString(curLimit3);

String end = Integer.toString(numPerPage);

if (strSortType == null){
    strSql  = "select * from myboard limit "+ cur +","+ end;


} else if (strSortType.equals("number")){
    strSql = "select * from myboard order by fld_number ASC"; 
} else if (strSortType.equals("title")){
    strSql = "select * from myboard order by fld_title";
} else if (strSortType.equals("name")){
    strSql = "select * from myboard order by fld_name";
} else if (strSortType.equals("date")){
    strSql = "select * from myboard order by fld_date";
} else {
    strSql = "select * from myboard order by fld_count";
}

//pstmt = conn.prepareStatement(strSQL);

 //   pstmt.setInt(1, curLimit) ;
   // pstmt.setInt(2, numPerPage) ;
//
//rs = pstmt.executeQuery();


rs = stmt.executeQuery(strSql);



%>
<table border =0 bordercolor ="#DFFFDF" cellpadding =2 width =600>

<tr bgcolor = "#00ffff">
<td><a href="board_list.jsp?sort_type=number">번호</a></td><td><a href="board_list.jsp?sort_type=title">제목</a></td><td><a href="board_list.jsp?sort_type=name">작성자</a></td><td><a href="board_list.jsp?sort_type=date">작성일</a></td><td><a href="board_list.jsp?sort_type=count">조회수</a></td>
</tr>

<%
String strRowColor;
int rowCount = 1;
while (rs.next()){ 
    if(rowCount%2 ==1){
       strRowColor = "#aaffff";
        rowCount = rowCount +1;
    } else {
        strRowColor = "#f0f8ff";
        rowCount = rowCount +1;
    }
    
    out.println("<tr bgcolor="+strRowColor+">");
    String strNumber = rs.getString("fld_number");

    out.println("<td>"+strNumber+ "</td>");
    out.println("<td><a href=board_view.jsp?write_number=" + strNumber + ">" + rs.getString("fld_title") + "</a></td>");  
    //board_view.jsp를 부르면서 패러미터를 strNumber를 넘겨줌
    //out.println("<td>"+rs.getString("fld_title") + "</td>");
    out.println("<td>"+rs.getString("fld_name") + "</td>");
    out.println("<td>"+rs.getDate("fld_date") + "</td>");
    out.println("<td>"+rs.getString("fld_count") + "</td>");
    out.println("</tr>");
}


%>
</table><p>
<a href ="board_write.jsp"> [글쓰기]</a>
<a href ="board_list.jsp"> [다시읽기]</a>


  <center> 
    <form method="post" action="search_result.jsp">
    <select name="search_type">
       <option value="title">글제목 </option> 
       <option value="name">작성자 </option> 
       <option value="content">글내용</option> 
    </select>
    <input type="text" name="search_string" size=20> 
    <input type="submit" value = "검색">
   </form> 
  </center>
    <center> 

<%

int c = totalPage;
int i = 1;

out.println("<a href=board_list.jsp?currentPage=1>"+"[처음]"+"</a>");

while(c !=0)
{
        out.println("<a href=board_list.jsp?currentPage="+i+">"+"["+i+"]"+"</a>");
       c = c-1;
       i = i+1;
}

out.println("<a href=board_list.jsp?currentPage="+totalPage+">"+"[끝]"+"</a>");

%>
  </center>
  <br>

  <%
  if(curLimit2>=0)
  {
  strSql  = "select * from myboard limit "+ cur2 +","+ end;

  rs = stmt.executeQuery(strSql);
  
   rs.next();
   
    
    out.println("<tr>");
    String strNumber = rs.getString("fld_number");

    out.println("<td>이전글:     </td>");
    out.println("<td><a href=board_view.jsp?write_number=" + strNumber + ">" + rs.getString("fld_title") + "</a></td>");  
    //board_view.jsp를 부르면서 패러미터를 strNumber를 넘겨줌
    //out.println("<td>"+rs.getString("fld_title") + "</td>");
    out.println("<td>"+rs.getString("fld_name") + "</td>");
    out.println("<td>"+rs.getDate("fld_date") + "</td>");
    out.println("<td>"+rs.getString("fld_count") + "</td>");
    out.println("</tr><br>");
}
    if(nowPage != totalPage)
  {

 strSql  = "select * from myboard limit "+ cur3 +","+ end;

  rs = stmt.executeQuery(strSql);
  
   rs.next();
   
    
    out.println("<tr>");
    String strNumber = rs.getString("fld_number");
    out.println("<td>다음글:     </td>");
    out.println("<td><a href=board_view.jsp?write_number=" + strNumber + ">" + rs.getString("fld_title") + "</a></td>");  
    //board_view.jsp를 부르면서 패러미터를 strNumber를 넘겨줌
    //out.println("<td>"+rs.getString("fld_title") + "</td>");
    out.println("<td>"+rs.getString("fld_name") + "</td>");
    out.println("<td>"+rs.getDate("fld_date") + "</td>");
    out.println("<td>"+rs.getString("fld_count") + "</td>");
    out.println("</tr>");
  
  }

  %>


</body>
</html>