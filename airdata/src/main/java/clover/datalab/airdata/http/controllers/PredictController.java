package clover.datalab.airdata.http.controllers;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PredictController {
	@Value("${pythonURL}")
	public String pythonURL;
	
	@GetMapping("/predict/show")
	public String show() {
		return "_pages/dust/predict";
	}
	
	@GetMapping("/predict/airCondition")
	@ResponseBody
	public String predictAirCondition() {
		
		JSONObject input = new JSONObject();
		input.put("미세먼지(PM10)", 11);
		input.put("초미세먼지(PM25)", 3);
		input.put("평균습도(%rh)", 49);
		input.put("평균풍속(m/s)", 5);
		input.put("최대풍속풍향(deg)", 359);
		input.put("강수량(mm)", 0);
		input.put("평균기온(℃)", 26);
		input.put("최고기온(℃)", 26);
		input.put("일교차", 11);
		input.put("humid_nextDay", 46);
		input.put("wv_nextDay", 0);
		input.put("wd_nextDay", 196);
		input.put("pop_nextDay", 0);
		input.put("at_nextDay", 24);
		input.put("ht_nextDay", 31);
		input.put("td_nextDay", 14);
		input.put("지역1", "서울");
		JSONObject result = bypass(pythonURL, input, "POST");
		
		return result.toString();
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
			
			System.out.println(jsonData.toString());
			
			// 응답 받는 부분
			StringBuilder start_sb = new StringBuilder();
			int start_HttpResult = start_con.getResponseCode();
			
			if (start_HttpResult == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(start_con.getInputStream(), "utf-8"));
				String line = null;
				while ( (line = br.readLine()) != null) {
					start_sb.append(line);
				}
				responseJson.put("data", start_sb);
				responseJson.put("result", "SUCCESS");
				br.close();
				
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
	
}
