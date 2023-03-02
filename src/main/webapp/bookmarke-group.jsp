<%@ page import="java.util.ArrayList" %>
<%@ page import="DataBase.Book_DTO" %>
<%@ page import="DataBase.DataController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public Boolean chk;
%>
<%
    chk = false;
    ArrayList<Book_DTO> lst = new ArrayList<Book_DTO>();
    DataController dc =new DataController();
    lst = dc.SELECT_Book();
    if(lst.size() == 0){
        chk = false;
    }else{
        chk = true;
    }

%>
<html>
<head>
    <title>위치 히스토리 목록</title>
    <style>
        .Book_mark_table > table, th{
            border: 1px solid white;
            border-collapse: collapse;
        }
        .Book_mark_table > table > thead{
            background-color: #47C83E; color: #fff;
        }
        .Book_mark_table > table > tbody, td{
            border: 1px solid #BDBDBD;
            border-collapse: collapse;
            color: #000;
            text-align: center;
        }

        .Book_mark_table > table > tbody > tr:nth-child(odd){
            background-color: #D5D5D5;
        }

        .Book_mark_table > table > tbody > tr:nth-child(even){
            background-color: #F7F9FC;
        }

    </style>
</head>
<body>
<div class="head_name">
    <h2>위치 히스토리 목록</h2>
</div>
<div>
    <a href="/Mission1_war_exploded">홈</a> | <a href="bookmark-group-show.jsp">위치 히스토리 목록</a> | <a href="Open_API">Open API 와이파이 정보 가져오기</a> |
    <a href="like-group.jsp">즐겨 찾기 보기</a> | <a href="bookmarke-group.jsp">즐겨 찾기 그룹 관리</a>
</div>

<div class="bookmark_options">
    <p>
        <button onclick="location.href='bookmark-group-add.jsp'">북마크 그룹 이름 추가</button>
    </p>
</div>
<div class ="Book_mark_table">
    <table style="height: 80px; width:100%; font-size: 20px;">
        <thead style="height: 100%;">
        <tr>
            <th>ID</th>
            <th>북마크 이름</th>
            <th>순서</th>
            <th>등록일자</th>
            <th>수행일자</th>
            <th>비고</th>
        </tr>
        </thead>
        <tbody style="">
        <%
            if(chk == true){
                for (int i = 0; i <lst.size() ; i++) {
        %>
        <tr>
            <td><% out.print(lst.get(i).getLg_id()); %></td>
            <td><% out.print(lst.get(i).getBook_name()); %></td>
            <td><% out.print(lst.get(i).getOrdercnt()); %></td>
            <td><% out.print(lst.get(i).getAdd_date()); %></td>
            <td><% out.print(lst.get(i).getEdit_date()); %></td>
            <td>
                <a href="bookmark-group-edit.jsp?lg_id=<%=lst.get(i).getLg_id().toString()%>">수정</a>
                &nbsp;|&nbsp;
                <a href="bookmark-group-del.jsp?lg_id=<%=lst.get(i).getLg_id().toString()%>">삭제</a>
            </td>
        </tr>
        <% } } else if(chk == false){
        %>
        <tr>
            <td colspan="17">
                정보가 존재하지 않습니다.
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

</body>
</html>
