<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시도별 평균 미세먼지 및 초미세먼지 농도</title>
    <style>
    	.overlaybox { border-radius: 30px; position: relative; width: 100px; height: 50px; background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat; padding: 15px 10px; }
        .overlaybox .boxtitle { text-align: center; color: #fff; font-size: 16px; font-weight: bold; margin-bottom: 8px; }
        .good { background-color: #87CEEB; } /* 하늘색 */
        .normal { background-color: #98FB98; } /* 연두색 */
        .bad { background-color: #FFD700; } /* 연노랑색 */
        .very-bad { background-color: #FF69B4; } /* 주홍색 */
    </style>
</head>
<body>
    <div>
        <table border="1">
            <thead>
                <tr>
                    <th>시도명</th>
                    <th>미세먼지 농도</th>
                    <th>등급</th>
                    <th>초미세먼지 농도</th>
                    <th>등급</th>
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

                            String pm10Grade = getPmGrade10(pm10Value);
                            String pm25Grade = getPmGrade25(pm25Value);

                            String pm10Class = getAirQualityClass10(pm10Value);
                            String pm25Class = getAirQualityClass25(pm25Value);
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
    
    <%-- 미세먼지, Java 코드로 등급에 따른 CSS 클래스 반환 --%>
    <%!
        String getAirQualityClass10(String value) {
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

        String getPmGrade10(String value) {
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

        String getAirQualityClass25(String value) {
            double pmValue = Double.parseDouble(value);
            if (pmValue <= 15) {
                return "good";
            } else if (pmValue <= 35) {
                return "normal";
            } else if (pmValue <= 75) {
                return "bad";
            } else {
                return "very-bad";
            }
        }

        String getPmGrade25(String value) {
            double pmValue = Double.parseDouble(value);
            if (pmValue <= 15) {
                return "좋음";
            } else if (pmValue <= 35) {
                return "보통";
            } else if (pmValue <= 75) {
                return "나쁨";
            } else {
                return "매우나쁨";
            }
        }
    %>

    <script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31c799a3e6c57bcc8d12337698e4159a"></script>
    <script>
        $(function() { // document ready 시 실행될 함수
            const container = document.querySelector('main#page-content--main > section#map.map'); // 지도를 표시할 div 
            const options = {
                center: new daum.maps.LatLng(36.6358, 127.4911), // 지도의 중심좌표: 충북
                level: 13 // 지도의 확대 레벨
            };

            container.setAttribute('style', 'width:100%;height:560px;');
            let map = new daum.maps.Map(container, options);
            let customOverlay = new daum.maps.CustomOverlay({});

            $.getJSON('/json/gson.json', function(geojson) {
                var data = geojson.features;
                var coordinates = [];
                var name = '';

                $.each(data, function(index, val) {
                    coordinates = val.geometry.coordinates;
                    name = val.properties.CTP_KOR_NM;

                    displayMap(coordinates, name);
                });
            });

            var polygons = []; // 전역변수

            // 대한민국 지도 폴리곤
            function displayMap(coordinates, name) {
                var path = [];
                var points = [];
                var pathArr = [];
                
                $.each(coordinates[0], function(index, coordinate) {
                    var point = new Object();
                    point.x = coordinate[1];
                    point.y = coordinate[0];
                    points.push(point);
                    path.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));
                    pathArr.push([coordinate[1], coordinate[0]]);
                });

                // 다각형을 생성합니다
                var polygon = new daum.maps.Polygon({
                    map: map, // 다각형을 표시할 지도 객체
                    path: path,
                    strokeWeight: 2,
                    strokeColor: '#004c80',
                    strokeOpacity: 0.8,
                    fillColor: '#fff',
                    fillOpacity: 0.7
                });

                polygons.push(polygon);
                overlaySet(name, points, polygon);

                daum.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
                    polygon.setOptions({
                        fillColor: '#09f'
                    });
                    var content = '<div class="overlaybox">';
                    content += ' <div class="boxtitle">' + name + '</div> ';
                    content += '</div>';

                    customOverlay.setContent(content);
                    customOverlay.setPosition(mouseEvent.latLng);
                    customOverlay.setMap(map);
                });

                // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 동작한다.
                daum.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                    console.log('mousemove 이벤트');
                });

                // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 색을 변경하고, 커스텀오버레이를 변경한다.
                // 커스텀 오버레이를 지도에서 제거합니다 
                daum.maps.event.addListener(polygon, 'mouseout', function() {
                    polygon.setOptions({
                        fillColor: '#fff'
                    });
                    customOverlay.setMap(null);
                    overlaySet(name, points, polygon);
                });

                // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 해당 지역 확대을 확대한다.
                daum.maps.event.addListener(polygon, 'click', function() {
                    // 현재 지도 레벨에서 2레벨 확대한 레벨
                    var level = map.getLevel() - 2;

                    // 지도를 클릭된 폴리곤의 중앙 위치를 기준으로 확대합니다
                    map.setLevel(level, {
                        anchor: centerMap(points),
                        animate: {
                            duration: 350
                        }
                    });
                });
            }

            // centroid 알고리즘 (폴리곤 중심좌표 구하기 위함)
            function centerMap(points) {
                var i, j, len, p1, p2, f, area, x, y;

                area = x = y = 0;

                for (i = 0, len = points.length, j = len - 1; i < len; j = i++) {
                    p1 = points[i];
                    p2 = points[j];

                    f = p1.y * p2.x - p2.y * p1.x;
                    x += (p1.x + p2.x) * f;
                    y += (p1.y + p2.y) * f;
                    area += f * 3;
                }
                return new daum.maps.LatLng(x / area, y / area);
            }

            function overlaySet(name, points, polygon) {
                var content = '<div class="area" style="font-weight:bold; font-size:13px; text-shadow: -1px -1px 0 #fff, 1px -1px 0 #fff, -1px 1px 0 #fff, 1px 1px 0 #fff;">' + name + '</div>';

                // 커스텀 오버레이가 표시될 위치입니다 
                var position = centerMap(points);

                // 커스텀 오버레이를 생성합니다
                customOverlay = new daum.maps.CustomOverlay({
                    position: position,
                    content: content,
                    xAnchor: 0.3,
                    yAnchor: 0.91
                });

                // 커스텀 오버레이를 지도에 표시합니다
                customOverlay.setMap(map);
            }

        });
    </script>
</body>
</html>