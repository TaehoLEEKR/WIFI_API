<%@ page import="DataBase.DataController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String key = request.getParameter("a"); // 와이파이명
    String wifiID = request.getParameter("b"); // 즐겨찾기

    System.out.println(key);
    System.out.println(wifiID);


    DataController dc = new DataController();
    dc.InsertLike(key,wifiID);

    out.println("<script>");
    out.println("document.location.href = 'like-group.jsp' ");
    out.println("</script>");
%>

