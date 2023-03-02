<%@ page import="DataBase.DataController" %>
<%@ page import="DataBase.Like_DTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
  public Boolean chk;
%>
<%
  chk = false;
  ArrayList<Like_DTO> lst = new ArrayList<Like_DTO>();
  DataController dc =new DataController();
  lst = dc.SELECT_LIKE();
  if(lst.size() == 0){
    chk = false;
  }else{
    chk = true;
  }

%>
<html>
<head>
  <title>즐겨 찾기 보기</title>
  <style>
    .Like_group > table, th{
      border: 1px solid white;
      border-collapse: collapse;
    }
    .Like_group > table > thead{
      background-color: #47C83E; color: #fff;
    }
    .Like_group > table > tbody, td{
      border: 1px solid #BDBDBD;
      border-collapse: collapse;
      color: #000;
      text-align: center;
    }

    .Like_group > table > tbody > tr:nth-child(odd){
      background-color: #D5D5D5;
    }

    .Like_group > table > tbody > tr:nth-child(even){
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
<br>
<div class="Like_group">
  <table style="height: 80px; width:100%; font-size: 20px;">
    <thead style="height: 100%;">
    <tr>
      <th>ID</th>
      <th>북마크 이름</th>
      <th>와이파이 명</th>
      <th>등록일자</th>
      <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
      if(chk == true){
        for (int i = 0; i <lst.size(); i++) {
    %>
    <tr>
      <td><% out.print(lst.get(i).getLike_id()); %></td>
      <td><% out.print(lst.get(i).getBook_name()); %></td>
      <td><% out.print(lst.get(i).getWifiName()); %></td>
      <td><% out.print(lst.get(i).getAdd_date()); %></td>
      <td><a href="like-group-del.jsp?lg_id=<%=lst.get(i).getLike_id().toString()%>">삭제</a></td>
    </tr>
    <%  } } else if (chk == false){
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
</div>

</body>
</html>
