<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="DataBase.DataController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public String BookName;
    public String BookNum;
%>
<%
    BookName = request.getParameter("book_name");
    BookNum = request.getParameter("order_book");
    if (BookName != null && BookNum != null){
        DataController dc = new DataController();
        try{
            dc.Insert_Book(BookName,BookNum);

        }catch (Exception e){
            out.print(e);
        }finally {
            out.println("<script>");
            out.println("document.location.href = 'bookmarke-group.jsp' ");
            out.println("</script>");
        }
    }else{
        //
    }
%>

<html>
<head>
    <title>와이파이 정보 구하기</title>
    <script>
        function get_Book(){
            alert("북마크를 추가 하였습니다.");
            document.forms['form_book'].submit();
        }

    </script>
    <style>
        table, th, tr{
            margin:0px;
            padding:0px;
            border-collapse: collapse;
        }

        .row01{
            width: 250px;
            height: 30px;
            background-color: #47C83E; color: #fff;
            text-align: center;
            border: 1px solid #fff;
            border-collapse: collapse;
        }

        .book_edit > table > tbody > tr:nth-child(odd){
            background-color: #D5D5D5;
        }

        .book_edit > table > tbody > tr:nth-child(even){
            background-color: #F7F9FC;
        }
    </style>
</head>
<body>
<h2><%="북마크 그룹 추가"%></h2>
<div>
    <a href="/Mission1_war_exploded">홈</a> | <a href="bookmark-group-show.jsp">위치 히스토리 목록</a> | <a href="Open_API">Open API 와이파이 정보 가져오기</a> |
    <a href="like-group.jsp">즐겨 찾기 보기</a> | <a href="bookmarke-group.jsp">즐겨 찾기 그룹 관리</a>
</div>
<br>
<form id="form_book" action="" method="GET">
<div class ="book_edit">
    <table style="width: 100%;">
        <tbody>
        <tr>
            <td class="row01">북마크 이름</td><td class="row02"> &nbsp;<input type="text" id="book_name" name="book_name"></td>
        </tr>
        <tr>
            <td class="row01">순서</td><td class="row02"> &nbsp;<input type="text" id="order_book" name="order_book" ></td>
        </tr>
        </tbody>
        <tfoot>

        </tfoot>
    </table>
    <br>
    <div class="bakc_btn" style="text-align: center">
<%--        <button type="submit" onclick="get_book()">추가</button>--%>
            <button type="button" onclick="get_Book()">추가</button>
    </div>
</div>
</form>
</body>
</html>

