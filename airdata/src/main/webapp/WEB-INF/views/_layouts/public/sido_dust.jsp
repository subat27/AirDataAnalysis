<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시도별 평균 미세먼지 농도</title>
    <style>
        .good { background-color: #9ACD32; }
        .normal { background-color: #FFFF00; }
        .bad { background-color: #FFA500; }
        .very-bad { background-color: #FF6347; }
    </style>
</head>
<body>
    <div>
        <h3>미세먼지 농도</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>시도명</th>
                    <th>평균 농도</th>
                    <th>등급</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Object[]> averagePmValues = (List<Object[]>) request.getAttribute("averagePmValues");
                    if (averagePmValues != null) {
                        for (Object[] row : averagePmValues) {
                            String sido = (String) row[0];
                            double pmValue = (double) row[1];
                            String pmGrade;
                            if (pmValue <= 30) {
                                pmGrade = "좋음";
                            } else if (pmValue <= 80) {
                                pmGrade = "보통";
                            } else if (pmValue <= 150) {
                                pmGrade = "나쁨";
                            } else {
                                pmGrade = "매우나쁨";
                            }
                %>
                <tr>
                    <td><%= sido %></td> <!-- 시도명 -->
                    <td><%= String.format("%.0f", pmValue) %></td> <!-- 평균 미세먼지 농도 -->
                    <td class="<%= getAirQualityClass(pmValue) %>"><%= pmGrade %></td> <!-- 등급 -->
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <div>
        <h3>초미세먼지 농도</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>시도명</th>
                    <th>평균 농도</th>
                    <th>등급</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (averagePmValues != null) {
                        for (Object[] row : averagePmValues) {
                            String sido = (String) row[0];
                            double finePmValue = (double) row[2];
                            String finePmGrade;
                            if (finePmValue <= 15) {
                                finePmGrade = "좋음";
                            } else if (finePmValue <= 35) {
                                finePmGrade = "보통";
                            } else if (finePmValue <= 75) {
                                finePmGrade = "나쁨";
                            } else {
                                finePmGrade = "매우나쁨";
                            }
                %>
                <tr>
                    <td><%= sido %></td> <!-- 시도명 -->
                    <td><%= String.format("%.0f", finePmValue) %></td> <!-- 평균 초미세먼지 농도 -->
                    <td class="<%= getAirQualityClass(finePmValue) %>"><%= finePmGrade %></td> <!-- 등급 -->
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
        String getAirQualityClass(double value) {
            if (value <= 30) {
                return "good";
            } else if (value <= 80) {
                return "normal";
            } else if (value <= 150) {
                return "bad";
            } else {
                return "very-bad";
            }
        }
    %>
</body>
</html>

