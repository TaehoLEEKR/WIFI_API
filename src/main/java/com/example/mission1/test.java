package com.example.mission1;

import DataBase.DataController;
import com.google.gson.*;

//import org.json.simple.parser.JSONParser;

import javax.servlet.annotation.WebServlet;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.DoubleStream;


public class test {

    public static JsonObject APIDATA() throws IOException{

        JsonParser jsonParser = new JsonParser();
        StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
        urlBuilder.append("/" + URLEncoder.encode("6b6649667564646138376f6d4d737a","UTF-8") );
        urlBuilder.append("/" + URLEncoder.encode("json","UTF-8") );
        urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo","UTF-8"));
        urlBuilder.append("/" + URLEncoder.encode("1","UTF-8"));
        urlBuilder.append("/" + URLEncoder.encode("100","UTF-8"));

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/xml");
        System.out.println("Response code: " + conn.getResponseCode());

        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        Object obj = jsonParser.parse(sb.toString());
        JsonObject jsonObject = (JsonObject) obj;

        return jsonObject;
    }
    public static int getSize() throws IOException{

        JsonObject jasonObject = APIDATA();

        // 해당 값이 JSON 의 사이즈
        int size = Integer.parseInt(jasonObject.get("TbPublicWifiInfo").getAsJsonObject().get("list_total_count").toString());
        return size;
    }
    public static void getInsertApi()throws IOException{


        JsonObject jasonObject = APIDATA();
        DataController dc = new DataController();

        JsonArray arr = (JsonArray) jasonObject.get("TbPublicWifiInfo").getAsJsonObject().get("row");
        ArrayList<JsonElement> myList = new ArrayList<>();

        for (int i=0; i< arr.size(); i++){
            myList.add(arr.get(i));
            try {
                dc.InsertAPI(String.valueOf(arr.get(i).getAsJsonObject().get("X_SWIFI_MGR_NO")), String.valueOf(arr.get(i)));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }

    public static void main(String[] args) throws IOException {
        getInsertApi();

    }

}
