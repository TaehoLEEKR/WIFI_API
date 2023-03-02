<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.mission1.test" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="DataBase.DataController" %>
<%@ page import="com.example.mission1.Distance" %>
<%--<%--%>
<%--    test t = new test();--%>
<%--    ArrayList<JsonElement> ReadApi=t.getAPI();--%>
<%--    // LAT 받기--%>
<%--//    request.getParameter("LAT");--%>
<%--%>--%>
<%!
    public String lat;
    public String lnt;
%>
<%!
        Distance disc = new Distance();
%>
<%
    lat = request.getParameter("latitude");
    lnt = request.getParameter("longitude");

    ArrayList <JsonElement> ReadApi = new ArrayList<JsonElement>();
    boolean chk = false;
    if(lat == null && lnt == null || (lat =="0.0" && lnt =="0.0")){
        chk = true;
        lat = "0.0";
        lnt = "0.0";
    }else{
            test t = new test();
            DataController dc = new DataController();
        try {
            t.getInsertApi();
            ReadApi = dc.SELECT_ALL();
        }catch (Exception e){
            out.print(e);
        }
    }

%>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
<script>

    function get_AT(){
        navigator.geolocation.getCurrentPosition(function(pos) {
            console.log(pos);
            var latitude = pos.coords.latitude;
            var longitude = pos.coords.longitude;

            document.getElementById('latitude').value = latitude;
            document.getElementById('longitude').value = longitude;
        });
    }

    function get_distance(){
        const lat =  document.getElementById('latitude').value;
        const lnt =  document.getElementById('longitude').value;
        document.forms['form_getAT']['latitude'].value = lat;
        document.forms['form_getAT']['longitude'].value = lnt;
        document.forms['form_getAT'].submit();
    }

</script>
<html>
<head>
    <title>Mission1</title>
    <style>
        .main_table > table, th{
            border: 1px solid white;
            border-collapse: collapse;
        }
        .main_table > table > thead{
            background-color: #47C83E; color: #fff;
        }
        .main_table > table > tbody, td{
            border: 1px solid #BDBDBD;
            border-collapse: collapse;
            color: #000;
            text-align: center;
        }

        .main_table > table > tbody > tr:nth-child(odd){
            background-color: #D5D5D5;
        }

        .main_table > table > tbody > tr:nth-child(even){
            background-color: #F7F9FC;
        }

    </style>
</head>
<body>
<h2><%= "와이파이 정보 구하기" %>
</h2>

<div>
    <a href="/Mission1_war_exploded">홈</a> | <a href="bookmark-group-show.jsp">위치 히스토리 목록</a> | <a href="Open_API">Open API 와이파이 정보 가져오기</a> |
    <a href="like-group.jsp">즐겨 찾기 보기</a> | <a href="bookmarke-group.jsp">즐겨 찾기 그룹 관리</a>
</div>
<div id="Input_AN" name="Input_AN">
    <br>
<form id = "form_getAT" action="" method="GET">
    <label> LAT : </label>
    <input type="text" name="latitude" id="latitude" value="0.0"> &nbsp;
    <label> LNT : </label>
    <input type="text" name="longitude" id="longitude" value="0.0">
    <input type="button" value="내 위치 가져오기" onclick="get_AT()">
    <input type="submit" value="근처 WIPI정보 가져오기" onclick="get_distance()">
</form>
    <br>
</div>
<div class="main_table">
    <table style="height: 80px; width:100%; font-size: 20px;">
        <thead style="height: 100%;">
        <tr>
            <th>거리(Km)</th>
            <th>관리번호</th>
            <th>자치구</th>
            <th>와이파이명</th>
            <th>도로명주소</th>
            <th>상세주소</th>
            <th>설치위치(층)</th>
            <th>설치유형</th>
            <th>설치기관</th>
            <th>서비스구분</th>
            <th>망종류</th>
            <th>설치년도</th>
            <th>실내외구분</th>
            <th>WIFI접속환경</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>작업일자</th>
        </tr>
        </thead>
        <tbody style="">
        <%
            if(chk == false){
                for(int i=0; i< ReadApi.size(); i++){
        %>
        <tr>
            <td><% out.print(disc.distance(ReadApi.get(i).getAsJsonObject().get("LAT").toString(),ReadApi.get(i).getAsJsonObject().get("LNT").toString(), lat, lnt)); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_MGR_NO").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_WRDOFC").toString().replace('"',' ')); %></td>
            <td>
                <a href="detail.jsp?wifiID=<%=ReadApi.get(i).getAsJsonObject().get("X_SWIFI_MGR_NO").toString().replace('"',' ')%>">
                    <% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_MAIN_NM").toString().replace('"',' ')); %>
                </a>
            </td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_ADRES1").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_ADRES2").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INSTL_FLOOR").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INSTL_TY").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INSTL_MBY").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_SVC_SE").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_CMCWR").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_CNSTC_YEAR").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_INOUT_DOOR").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("X_SWIFI_REMARS3").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("LAT").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("LNT").toString().replace('"',' ')); %></td>
            <td><% out.print(ReadApi.get(i).getAsJsonObject().get("WORK_DTTM").toString().replace('"',' ')); %></td>

        </tr>
        <% } }else if(chk == true){
        %>
        <tr>
            <td colspan="17">
                위치 정보를 입력한 후에 조회해 주세요.
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