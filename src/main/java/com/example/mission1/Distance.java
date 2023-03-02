package com.example.mission1;

public class Distance {
    public static String distance(String x,String y,String lat, String lnt){
        double x2 = Double.parseDouble(x.replace("\"",""));
        double y2 = Double.parseDouble(y.replace("\"",""));
        double x1 = Double.parseDouble(lat);
        double y1 = Double.parseDouble(lnt);

        double dis;
        double radius = 6371; // 지구 반지름(km)
        double toRadian = Math.PI / 180;

        double deltaLatitude = Math.abs(x1 - x2) * toRadian;
        double deltaLongitude = Math.abs(y1 - y2) * toRadian;

        double sinDeltaLat = Math.sin(deltaLatitude / 2);
        double sinDeltaLng = Math.sin(deltaLongitude / 2);
        double squareRoot = Math.sqrt(
                sinDeltaLat * sinDeltaLat +
                        Math.cos(x1 * toRadian) * Math.cos(x2 * toRadian) * sinDeltaLng * sinDeltaLng);

        dis = 2 * radius * Math.asin(squareRoot);

        return String.format("%.5f",dis / 1000);
    }
}
