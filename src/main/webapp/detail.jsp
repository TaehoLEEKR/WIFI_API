<%@ page import="DataBase.DataController" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.mission1.Distance" %>
<%@ page import="DataBase.Book_DTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
  public String Key;
  public String hkey;
%>
<%

    ArrayList<JsonElement> ReadApi = new ArrayList<JsonElement>();
    String wifiID = request.getParameter("wifiID");
    DataController dc = new DataController();
    ReadApi = dc.SELECT_Key(wifiID);
    Distance disc = new Distance();

    ArrayList<Book_DTO> lst = new ArrayList<Book_DTO>();
    lst = dc.SELECT_BOOK_NAME();



%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

    .detail_table > table > tbody > tr:nth-child(odd){
      background-color: #D5D5D5;
    }

    .detail_table > table > tbody > tr:nth-child(even){
      background-color: #F7F9FC;
    }
  </style>
  <script>
    function addLike(){
      // index는 고른 인덱스
      var index = document.getElementById("bookmark").selectedIndex;
      // options 가져옴
      var y = document.getElementById("bookmark").options;

      alert("즐겨찾기에 추가 되었습니다.");
      document.forms['detail_insert']['a'].value = document.getElementById('aaaa').childNodes[0].innerText;
      document.forms['detail_insert']['b'].value = y[index].innerText;
      document.forms['detail_insert'].submit();
    }
  </script>
</head>

<body>
<div class="head_name">
  <h2>와이파이 정보 구하기</h2>
</div>
<div>
  <a href="/Mission1_war_exploded">홈</a> | <a href="bookmark-group-show.jsp">위치 히스토리 목록</a> | <a href="Open_API">Open API 와이파이 정보 가져오기</a> |
  <a href="like-group.jsp">즐겨 찾기 보기</a> | <a href="bookmarke-group.jsp">즐겨 찾기 그룹 관리</a>
</div>

<div class="bookmark_options">
  <p>
    <select id="bookmark" name="bookmark">
      <option value="">북마크 그룹 이름 선택</option>
      <%
        for (int i = 0; i < lst.size(); i++) {
      %>
      <option value="<%out.print(lst.get(i).getBook_name());%>"><%out.print(lst.get(i).getBook_name());%></option>
      <%
        }
      %>
    </select>
    <button type="button" onclick="addLike()">즐겨찾기 추가하기</button>
  </p>
</div>


<form id="detail_insert" action="detail_insert.jsp" method="GET">
  <!-- 상수도 -->
  <input type="hidden" id = 'num' name = 'num' value="0">
  <input type="hidden" id='a' name='a' value="0">
  <!-- 내근집 처 -->
  <input type="hidden" id='b' name='b' value="0">
</form>


<div class="detail_table">
  <table style="width:100%;">
    <tbody>
    <%
      //System.out.println(ReadApi.size());
      for (int i = 0; i <ReadApi.size(); i++) {
    %>
    <tr>
      <td class="row01">거리(KM)</td><td class="row02"><%= 0 %></td>
    </tr>
    <tr>
      <td class="row01">관리번호</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_MGR_NO").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">자치구</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_WRDOFC").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">와이파이명</td><td class="row02" id="aaaa"><a href="detail.jsp?wifiID=<%=ReadApi.get(i).getAsJsonObject().get("X_SWIFI_MGR_NO").toString().replace('"',' ')%>">
      <% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_MAIN_NM").toString().replace('"',' ')); %>
    </a></td>
    </tr>
    <tr>
      <td class="row01">도로명주소</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_ADRES1").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">상세주소</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_ADRES2").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">설치위치(층)</td><td class="row02">TE<% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INSTL_FLOOR").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">설치유형</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INSTL_TY").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">설치기관</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INSTL_MBY").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">서비스구분</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_SVC_SE").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">망종류</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_CMCWR").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">설치년도</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_CNSTC_YEAR").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">실내외구분</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INOUT_DOOR").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">WIFI접속환경</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_REMARS3").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">X좌표</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("LAT").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">Y좌표</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("LAT").toString().replace('"',' ')); %></td>
    </tr>
    <tr>
      <td class="row01">작업일자</td><td class="row02"><% out.print(ReadApi.get(i).getAsJsonObject().get("LNT").toString().replace('"',' ')); %></td>
    </tr>

    <%
      }
    %>


    </tbody>
  </table>
</div>
</body>
</html>