<%@ page import="DataBase.DataController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataBase.Book_DTO" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="DataBase.Like_DTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public String BookName;
    public String BookNum;
    public String Key;
    public String Hkey;
%>
<%
    BookName = request.getParameter("book_name");
    BookNum = request.getParameter("order_book");
    Key = request.getParameter("lg_id");
    ArrayList<Like_DTO> lst = new ArrayList<Like_DTO>();

    if (Key == null){
        Hkey = request.getParameter("hid_key");
    }


    if (BookName == null && BookNum == null ){
        DataController dc = new DataController();
        try{
            lst = dc.SELECT_KEY_Like(Key);
        }catch (Exception e){
            out.print(e);
        }
    }else{
        try{
            DataController dc = new DataController();
            dc.Delete_like(Hkey);
        }catch (Exception e){

        }finally {
            out.println("<script>");
            out.println("document.location.href = 'like-group.jsp' ");
            out.println("</script>");
        }
    }
%>

<html>
<head>
    <title>와이파이 정보 구하기</title>
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

        .book_del > table > tbody > tr:nth-child(odd){
            background-color: #D5D5D5;
        }

        .book_del > table > tbody > tr:nth-child(even){
            background-color: #F7F9FC;
        }
    </style>
    <script>
        function del_like(){
            alert("북마크를 삭제 하였습니다.")
            const lg_id = document.getElementById('hid_key').value;
            document.forms['form_like']['hid_key'].value = lg_id;
            document.forms['form_like'].submit();
        }
    </script>
</head>
<body>
<h2><%="위치 히스토리 목록"%></h2>
<div>
    <a href="/Mission1_war_exploded">홈</a> | <a href="bookmark-group-show.jsp">위치 히스토리 목록</a> | <a href="Open_API">Open API 와이파이 정보 가져오기</a> |
    <a href="like-group.jsp">즐겨 찾기 보기</a> | <a href="bookmarke-group.jsp">즐겨 찾기 그룹 관리</a>
</div>
<br>
<h4><%="북마크를 삭제하시겠습니까?"%></h4>
<br>
<form id ="form_like" action="" method="GET">
    <div class ="book_del">
        <%
        %>
        <table style="width: 100%;">
            <tbody>
            <tr>
                <td class="row01">북마크 이름</td><td class="row02"> &nbsp;<input type="text" id="book_name" name="book_name" readonly value="<%
                if(lst.size() == 0){
                    out.print("");
                }else{
                    out.print(lst.get(0).getBook_name());
                }
                %>"></td>
            </tr>
            <tr>
                <td class="row01">와이파이명</td><td class="row02"> &nbsp;<input type="text" id="wifiName" name="order_book" readonly value="<%
                if(lst.size() == 0){
                    out.print("");
                }else{
                    out.print(lst.get(0).getWifiName());
                };
                %>"></td>
            </tr>
            <tr>
                <td class="row01">등록일자</td><td class="row02"> &nbsp;<input type="text" id="addDate" name="addDate" readonly value="<%
                if(lst.size() == 0){
                    out.print("");
                }else{
                    out.print(lst.get(0).getAdd_date());
                };
                %>"></td>
            </tr>
            </tbody>
            <tfoot>

            </tfoot>
        </table>
        <br>

        <input type="hidden" id="hid_key" name="hid_key" value="<%=request.getParameter("lg_id")%>">
        <div class="bakc_btn" style="text-align: center">
            <a href="/Mission1_war_exploded">돌아가기</a> &nbsp; | &nbsp;<button type="button" onclick="del_like()">삭제</button>
        </div>
    </div>
</form>
</body>
</html>
