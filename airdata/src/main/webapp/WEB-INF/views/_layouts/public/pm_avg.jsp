<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시도별 평균 미세먼지 및 초미세먼지 농도</title>
    <style>
        .good { background-color: #9ACD32; }
        .normal { background-color: #FFFF00; }
        .bad { background-color: #FFA500; }
        .very-bad { background-color: #FF6347; }
    </style>
</head>
<body>
    <div>
        <h3>미세먼지 및 초미세먼지 평균 농도</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>시도명</th>
                    <th>평균 미세먼지 농도</th>
                    <th>미세먼지 등급</th>
                    <th>평균 초미세먼지 농도</th>
                    <th>초미세먼지 등급</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // averagePmValues 변수에 대한 처리
                    Map<String, String> averagePmValues = (Map<String, String>) request.getAttribute("averagePmValues");
                    if (averagePmValues != null) {
                        for (Map.Entry<String, String> entry : averagePmValues.entrySet()) {
                            String sido = entry.getKey();
                            String[] values = entry.getValue().split(",");
                            String pm10Value = values[0];
                            String pm25Value = values[1];

                            String pm10Grade = getPmGrade(pm10Value);
                            String pm25Grade = getPmGrade(pm25Value);

                            String pm10Class = getAirQualityClass(pm10Value);
                            String pm25Class = getAirQualityClass(pm25Value);
                %>
                <tr>
                    <td><%= sido %></td> <!-- 시도명 -->
                    <td><%= pm10Value %></td> <!-- 평균 미세먼지 농도 -->
                    <td class="<%= pm10Class %>"><%= pm10Grade %></td> <!-- 미세먼지 등급 -->
                    <td><%= pm25Value %></td> <!-- 평균 초미세먼지 농도 -->
                    <td class="<%= pm25Class %>"><%= pm25Grade %></td> <!-- 초미세먼지 등급 -->
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <%-- Java 코드로 등급에 따른 CSS 클래스 반환 --%>
    <%!
        String getAirQualityClass(String value) {
            double pmValue = Double.parseDouble(value);
            if (pmValue <= 30) {
                return "good";
            } else if (pmValue <= 80) {
                return "normal";
            } else if (pmValue <= 150) {
                return "bad";
            } else {
                return "very-bad";
            }
        }

        String getPmGrade(String value) {
            double pmValue = Double.parseDouble(value);
            if (pmValue <= 30) {
                return "좋음";
            } else if (pmValue <= 80) {
                return "보통";
            } else if (pmValue <= 150) {
                return "나쁨";
            } else {
                return "매우나쁨";
            }
        }
    %>
</body>
</html>