<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시도별 평균 미세먼지 및 초미세먼지 농도</title>
    <style>
        .overlaybox { border-radius: 30px; position: relative; width: 100px; height: 50px; background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat; padding: 15px 10px; }
        .overlaybox .boxtitle { text-align: center; color: #fff; font-size: 16px; font-weight: bold; margin-bottom: 8px; }
        td.good { background-color: #87CEEB; } /* 하늘색 */
        td.normal { background-color: #98FB98; } /* 연두색 */
        td.bad { background-color: #FFD700; } /* 연노랑색 */
        td.very-bad { background-color: #FF69B4; } /* 주홍색 */
        .dustData {text-align: center;}
        #legend { position: absolute; bottom: 5px; right: 50px; background-color: white; border: 1px solid #ccc; padding: 10px; border-radius: 5px; font-size: 14px; z-index: 1000; /* 범례의 z-index를 지도보다 큰 값으로 설정 */}
		.legend-item { display: flex; align-items: center; margin-bottom: 5px; }
		.legend-color { width: 12px; height: 12px; border-radius: 50%; display: inline-block; margin-right: 5px; }
		
		.good-color { background-color: #87CEEB; } /* 하늘색 */
		.normal-color { background-color: #98FB98; } /* 연두색 */
		.bad-color { background-color: #FFD700; } /* 연노랑색 */
		.very-bad-color { background-color: #FF69B4; } /* 주홍색 */
    </style>
</head>
<body>
    <div>
        <table class="table m-3" border="1" >
            <thead>
                <tr class="dustData">
                    <th>시도명</th>
                    <th>미세먼지 농도</th>
                    <th>등급</th>
                    <th>초미세먼지 농도</th>
                    <th>등급</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Map<String, String> averagePmValues = (Map<String, String>) request.getAttribute("averagePmValues");
                    Gson gson = new Gson();
                    String jsonPmValues = gson.toJson(averagePmValues);
                    
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
                <tr class="dustData">
                    <td><%= sido %></td>
                    <td><%= pm10Value %> ㎍/㎥</td>
                    <td class="<%= pm10Class %>"><%= pm10Grade %></td>
                    <td><%= pm25Value %> ㎍/㎥</td>
                    <td class="<%= pm25Class %>"><%= pm25Grade %></td>
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    
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
	
	<!-- 지도 우측의 범례 -->
	<div id="legend">
	   <div class="legend-item">
	      <span class="legend-color good-color"></span> 좋음 (0 - 30)
	   </div>
	   <div class="legend-item">
	      <span class="legend-color normal-color"></span> 보통 (31 - 80)
	   </div>
	   <div class="legend-item">
	      <span class="legend-color bad-color"></span> 나쁨 (81 - 150)
	   </div>
	   <div class="legend-item">
	      <span class="legend-color very-bad-color"></span> 매우나쁨 (151 - )
	   </div>
	</div>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/predict.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31c799a3e6c57bcc8d12337698e4159a"></script>
    <script>
        $(function() {
            const container = document.querySelector('div#map-view');
            const options = {
                center: new daum.maps.LatLng(35.7, 127.6911),
                level: 13
            };

            container.setAttribute('style', 'width:100%;height:560px;');
            let map = new daum.maps.Map(container, options);
            let customOverlay = new daum.maps.CustomOverlay({});

            const pmValues = <%= jsonPmValues %>;

            $.getJSON('/json/gson.json', function(geojson) {
                var data = geojson.features;
                var coordinates = [];
                var name = '';

                $.each(data, function(index, val) {
                    coordinates = val.geometry.coordinates;
                    name = val.properties.CTP_KOR_NM;

                    var pm10Value = pmValues[name].split(",")[0];
                    displayMap(coordinates, name, pm10Value);
                });
            });

            var polygons = [];

            function displayMap(coordinates, name, pm10Value) {
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

                var fillColor = getPolygonColor(pm10Value);

                var polygon = new daum.maps.Polygon({
                    map: map,
                    path: path,
                    strokeWeight: 2,
                    strokeColor: '#004c80',
                    strokeOpacity: 0.8,
                    fillColor: fillColor,
                    fillOpacity: 0.7
                });

                polygons.push(polygon);
                overlaySet(name, pm10Value, points, polygon);

                daum.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
                    polygon.setOptions({
                        fillColor: '#09f'
                    });
                    var content = '<div class="overlaybox">';
                    content += ' <div class="boxtitle">' + name + '</div> ';
                    customOverlay.setContent(content);
                    //customOverlay.setPosition(mouseEvent.latLng);
                    customOverlay.setMap(map);
                });

                daum.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                    console.log('mousemove 이벤트');
                });

                daum.maps.event.addListener(polygon, 'mouseout', function() {
                    polygon.setOptions({
                        fillColor: fillColor
                    });
                    customOverlay.setMap(null);
                    overlaySet(name, pm10Value, points, polygon);
                });

                daum.maps.event.addListener(polygon, 'click', function() {
                    var level = map.getLevel() - 2;
                    map.setLevel(level, {
                        anchor: centerMap(points),
                        animate: {
                            duration: 350
                        }
                    });
                });
            }

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

            function overlaySet(name, pm10Value, points, polygon) {
                var content = '<div class="area" style="font-weight:bold; font-size:13px; text-shadow: -1px -1px 0 #fff, 1px -1px 0 #fff, -1px 1px 0 #fff, 1px 1px 0 #fff; text-align: center; background-color: rgba(255, 255, 255, 0.7); border-radius: 30px; padding: 5px;">' 
                    + '<div>' + name + '</div>' 
                    + '<div>' + pm10Value + '</div>' 
                    + '</div>';

                var position = centerMap(points);

                // 각 지역별 위치 조정
                if (name === '서울') {
                    position = new daum.maps.LatLng(position.getLat(), position.getLng() + 0.02); // 서울을 오른쪽으로 조정
                } else if (name === '경기') {
                    position = new daum.maps.LatLng(position.getLat(), position.getLng() + 0.25); // 경기를 더 오른쪽으로 조정
                } else if (name === '세종') {
                    position = new daum.maps.LatLng(position.getLat() + 0.1, position.getLng()); // 세종을 약간 위로 조정
                } else if (name === '대전') {
                    position = new daum.maps.LatLng(position.getLat() - 0.1, position.getLng()); // 대전을 약간 아래로 조정
                } else if (name === '울산') {
                    position = new daum.maps.LatLng(position.getLat() + 0.1, position.getLng()); // 세종을 약간 위로 조정
                } else if (name === '부산') {
                    position = new daum.maps.LatLng(position.getLat() - 0.1, position.getLng()); // 대전을 약간 아래로 조정
                } else if (name === '전남') {
                    position = new daum.maps.LatLng(position.getLat(), position.getLng() + 0.25); // 전남을 더 오른쪽으로 조정
                }

                var customOverlay = new daum.maps.CustomOverlay({
                    position: position,
                    content: content,
                    xAnchor: 0.5,
                    yAnchor: 0.5  // 기본값인 0.5로 설정하여 조정
                });

                customOverlay.setMap(map);
            }

            function getPolygonColor(pm10Value) {
                let pm10Val = parseFloat(pm10Value);
                if (pm10Val <= 30) {
                    return '#87CEEB';
                } else if (pm10Val <= 80) {
                    return '#98FB98';
                } else if (pm10Val <= 150) {
                    return '#FFD700';
                } else {
                    return '#FF69B4';
                }
            }
        });
    </script>
</body>
</html>