package clover.datalab.airdata.utilities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Weather {
	
	private final Common common;
	
	public static final Map<String, String> LOCATION_MAP;
	
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
	
	public String weatherData(String localName) throws Exception {
		String[] position = getPosition(localName);
		return common.getRestApi(nowDate(), position[0], position[1]);
	}
	
	private String nowDate() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        return now.format(formatter);
	}
	
	private String[] getPosition(String localName) {
		return LOCATION_MAP.get(localName).split(",");
	}
	
}
