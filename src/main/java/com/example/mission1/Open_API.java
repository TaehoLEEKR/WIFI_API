package com.example.mission1;

import com.google.gson.JsonElement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name ="Open_API", value = "/Open_API")
public class Open_API extends HttpServlet {
        test t = new test();
        int size;

    {
        try {
            size = test.getSize();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private String SIZE;
    private String message;
    public void init() {
        SIZE = String.valueOf(size);
        message = "개의 WIFI 정보를 정상적으로 저장하였습니다.";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><body style='text-align : center'>");
        out.println("<br>");
        out.println("<h1>" + SIZE + message +"</h1>");
        out.println("<br>");
        out.println("<a href=/Mission1_war_exploded>" +" 홈 으로 가기" + "</a>");
        //out.println("<a href=\"/Mission1_war_exploded\">홈 으로 가기</a>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}
