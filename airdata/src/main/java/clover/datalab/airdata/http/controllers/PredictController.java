package clover.datalab.airdata.http.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import clover.datalab.airdata.utilities.Weather;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PredictController {
	
	private final Weather weather;
	private final ObjectMapper objectMapper;
	
	@Value("${pythonURL}")
	public String pythonURL;
	
	private Map<String, Double> weatherData(String date, String localName) {
		try {
			String result = weather.weatherData(localName);
			Map<String, Map<String, Double>> resultData = processJsonData(result);
			return resultData.get((String)date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private Map<String, Double> nowWeatherData(String localName){
		
		try {
			String result = weather.nowWeatherData(localName);
			return processJsonDataPresent(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	@GetMapping("/information")
	public String show() {
		return "_pages/dust/predict";
	}
	
	@GetMapping("/predict/airCondition")
	@ResponseBody
	public String predictAirCondition(String dates, String localName) { 
		String[] dateList = dates.split(",");
		
		// 미세먼지 정보 호출 (??)
		Map<String, Double> dustData = new HashMap<>();
		dustData.put("PM10", 16.0);
		dustData.put("PM25", 7.0);

		// 현재 날씨 정보 호출
		Map<String, Double> nowWeatherData = nowWeatherData(localName);
		JSONObject input = new JSONObject();
		
		for (String date : dateList) {
			Map<String, Double> futureWeatherData = weatherData(date, localName);
			input.put(date, setInput(dustData, nowWeatherData, futureWeatherData, localName));
		}
		
		JSONObject temp = bypass(pythonURL, input, "POST");
		JSONObject data = new JSONObject(temp.get("data").toString());
		
		data.put(dateList[0], dustData);
		
		return data.toString();
	}
	
	@GetMapping("/predict/getWeather")
	@ResponseBody
	public String getWeatherInfo(String localName) {
		Map<String, Double> nowWeatherData = nowWeatherData(localName);
		JSONObject weatherInfo = new JSONObject();
		weatherInfo.put("humid", nowWeatherData.get("REH"));										// 현재 평균습도
		weatherInfo.put("wind_speed", nowWeatherData.get("WSD"));										// 현재 평균풍속
		weatherInfo.put("wind_direction", nowWeatherData.get("VEC"));									// 현재 최대풍속풍향
		weatherInfo.put("rainfall", nowWeatherData.get("RN1"));										// 현재 강수량
		weatherInfo.put("temperature", nowWeatherData.get("T1H"));
		
		return weatherInfo.toString();
	}
	
	
	private JSONObject setInput(Map<String, Double> dustData, Map<String, Double> nowWeatherData, Map<String, Double> futureWeatherData, String localName) {
		JSONObject input = new JSONObject();
		input.put("미세먼지(PM10)", dustData.get("PM10"));											// 현재 미세먼지 농도
		input.put("초미세먼지(PM25)", dustData.get("PM25"));										// 현재 초미세먼지 농도
		input.put("평균습도(%rh)", nowWeatherData.get("REH"));										// 현재 평균습도
		input.put("평균풍속(m/s)", nowWeatherData.get("WSD"));										// 현재 평균풍속
		input.put("최대풍속풍향(deg)", nowWeatherData.get("VEC"));									// 현재 최대풍속풍향
		input.put("강수량(mm)", nowWeatherData.get("RN1"));										// 현재 강수량
		input.put("평균기온(℃)", nowWeatherData.get("T1H"));										// 현재 평균기온
		input.put("humid_nextDay", futureWeatherData.get("REH"));								// 예측날짜 평균습도
		input.put("wv_nextDay", futureWeatherData.get("WSD"));									// 예측날짜 평균풍속
		input.put("wd_nextDay", futureWeatherData.get("VEC"));									// 예측날짜 최대풍속풍향
		input.put("pop_nextDay", futureWeatherData.get("PCP"));									// 예측날짜 강수량
		input.put("at_nextDay", futureWeatherData.get("TMP"));									// 예측날짜 평균기온
		input.put("ht_nextDay", futureWeatherData.get("TMX"));									// 예측날짜 최고기온
		input.put("지역1", localName);															// 예측 지역
		return input;
	}
	
	public JSONObject bypass(String uri, JSONObject jsonData, String option) {
		JSONObject responseJson = new JSONObject();
		try {
			// 연결할 url 생성
			URL start_object = new URL(uri);
			
			// http 객체 생성
			HttpURLConnection start_con = (HttpURLConnection) start_object.openConnection();
			start_con.setDoOutput(true);
			start_con.setDoInput(true);
			
			// 설정 정보
			start_con.setRequestProperty("Content-type", "application/json");
			start_con.setRequestProperty("Accept", "application/json");
			start_con.setRequestMethod(option);
			
			// 출력 부분
			OutputStreamWriter wr = new OutputStreamWriter(start_con.getOutputStream());
			wr.write(jsonData.toString());
			wr.flush();
			
			// 응답 받는 부분
			StringBuilder start_sb = new StringBuilder();
			int start_HttpResult = start_con.getResponseCode();
			
			if (start_HttpResult == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(start_con.getInputStream(), "utf-8"));
				String line = null;
				while ( (line = br.readLine()) != null) {
					start_sb.append(line);
				}
				responseJson.put("data", start_sb.toString());
				responseJson.put("result", "SUCCESS");
				br.close();
				
				start_con.disconnect();
				return responseJson;
			} else {
				responseJson.put("result", "FAIL");
				return responseJson;
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseJson.put("result", "Exception");
			return responseJson;
		}
	}
	
	// 초단기실황 API JSON 데이터 처리,
	public Map<String, Double> processJsonDataPresent(String jsonData) throws IOException {
		JsonNode rootNode = objectMapper.readTree(jsonData);
		Iterator<JsonNode> elements = rootNode.get("response").get("body").get("items").get("item").elements();
		
		Map<String, Double> resultMap = new HashMap<>();
		
		while (elements.hasNext()) {
			JsonNode element = elements.next();
			String category = element.get("category").asText();
			String obsrValue = element.get("obsrValue").asText();
			
			resultMap.put(category, Double.parseDouble(obsrValue));
		}
		
		return resultMap;
	}
	
	
	// 단기예보 API JSON 데이터 처리
	public Map<String, Map<String, Double>> processJsonData(String jsonData) throws IOException {
		JsonNode rootNode = objectMapper.readTree(jsonData);
		Iterator<JsonNode> elements = rootNode.get("response").get("body").get("items").get("item").elements();
		
		Map<String, Map<String, SumCount>> intermediateResults = new HashMap<>();

        // Parse each element
        while (elements.hasNext()) {
            JsonNode element = elements.next();
            String fcstDate = element.get("fcstDate").asText();
            String category = element.get("category").asText();
            String fcstValue = element.get("fcstValue").asText();

            // Check if the fcstValue is a numeric value
            if (isNumeric(fcstValue)) {
                double value = Double.parseDouble(fcstValue);
                intermediateResults.putIfAbsent(fcstDate, new HashMap<>());
                Map<String, SumCount> categoryMap = intermediateResults.get(fcstDate);
                categoryMap.putIfAbsent(category, new SumCount());
                SumCount sumCount = categoryMap.get(category);
                sumCount.add(value);
            } else {
            	double value = 0.0;
                intermediateResults.putIfAbsent(fcstDate, new HashMap<>());
                Map<String, SumCount> categoryMap = intermediateResults.get(fcstDate);
                categoryMap.putIfAbsent(category, new SumCount());
                SumCount sumCount = categoryMap.get(category);
                sumCount.add(value);
            }
        }

        // Calculate averages
        Map<String, Map<String, Double>> result = new HashMap<>();
        for (Map.Entry<String, Map<String, SumCount>> entry : intermediateResults.entrySet()) {
            String fcstDate = entry.getKey();
            Map<String, Double> averages = new HashMap<>();
            for (Map.Entry<String, SumCount> categoryEntry : entry.getValue().entrySet()) {
                String category = categoryEntry.getKey();
                SumCount sumCount = categoryEntry.getValue();
                averages.put(category, sumCount.getAverage());
            }
            result.put(fcstDate, averages);
        }

        return result;
    }

    private boolean isNumeric(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private static class SumCount {
        private double sum = 0;
        private int count = 0;

        public void add(double value) {
            sum += value;
            count++;
        }

        public double getAverage() {
            return (count == 0) ? 0 : sum / count;
        }
    }
}
