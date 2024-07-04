package clover.datalab.airdata.utilities;

import java.net.URI;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Weather {
	
	@Value("${publicApiKey}")
	private String publicApiKey;
	
	public static final Map<String, String> LOCATION_MAP;
	
	// 시도별 위경도 좌표
	static {
		LOCATION_MAP = new HashMap<String, String>();
		LOCATION_MAP.put("서울", "60,127");
		LOCATION_MAP.put("부산", "98,76");
		LOCATION_MAP.put("대구", "89,90");
		LOCATION_MAP.put("인천", "55,124");
		LOCATION_MAP.put("광주", "58,74");
		LOCATION_MAP.put("대전", "67,100");
		LOCATION_MAP.put("울산", "102,84");
		LOCATION_MAP.put("세종", "66,103");
		LOCATION_MAP.put("경기", "60,120");
		LOCATION_MAP.put("충북", "69,107");
		LOCATION_MAP.put("충남", "68,100");
		LOCATION_MAP.put("전북", "63,89");
		LOCATION_MAP.put("전남", "51,67");
		LOCATION_MAP.put("경북", "87,106");
		LOCATION_MAP.put("경남", "91,77");
		LOCATION_MAP.put("제주", "52,38");
		LOCATION_MAP.put("강원", "73,134");
	}
	
	// 단기예보 조회
	public String getRestApi(String base_date, String nx, String ny) throws Exception {
    	String url = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?" +
				"serviceKey=" + publicApiKey +
				"&pageNo=1&numOfRows=1000&dataType=JSON&base_time=0500" +
				"&base_date=" + base_date +
				"&nx=" + nx +
				"&ny=" + ny;
		URI uri = new URI(url);
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		ResponseEntity<String> response = restTemplate.getForEntity(uri, String.class);
	    return response.getBody();
	}
	
	// 초단기실황 조회
    public String getRestApi(String base_date, String base_time, String nx, String ny) throws Exception {
    	String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?" +
    				"serviceKey=" + publicApiKey +
    				"&pageNo=1&numOfRows=1000&dataType=JSON" +
    				"&base_time=" + base_time +
    				"&base_date=" + base_date +
    				"&nx=" + nx +
    				"&ny=" + ny;
    	URI uri = new URI(url);
    	RestTemplate restTemplate = new RestTemplate();
    	HttpHeaders headers = new HttpHeaders();
    	headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
    	
    	ResponseEntity<String> response = restTemplate.getForEntity(uri, String.class);
        return response.getBody();
    }
    
    // 단기예보 API 호출
 	public String weatherData(String localName) throws Exception {
 		String[] position = getPosition(localName);
 		return getRestApi(nowDate(""), position[0], position[1]);
 	}
 	
 	// 초단기실황 API 호출
 	public String nowWeatherData(String localName) throws Exception {
 		String[] position = getPosition(localName);
 		return getRestApi(nowDate("now"), nowHour(), position[0], position[1]);
 	}
 	
 	// 현재 날짜를 yyyyMMdd로 반환하는 함수
 	private String nowDate(String type) {
 		LocalDateTime now = LocalDateTime.now();
 		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
 		if(!type.equals("now") && now.getHour() < 5) {
 			now = now.minusDays(1);
 			System.out.println("after: " + now);
 		}
 		System.out.println("format: "+now.format(formatter));
        return now.format(formatter);
 	}

 	// 현재 시간을 반환하는 함수
 	private String nowHour() {
 		LocalDateTime now = LocalDateTime.now();
 		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH");
 		now = now.minusHours(1);
         return now.format(formatter) + "00";
 	}
 	
 	// 지역별 위경도 좌표를 배열로 반환하는 함수
 	private String[] getPosition(String localName) {
 		return LOCATION_MAP.get(localName).split(",");
 	}
	
}
