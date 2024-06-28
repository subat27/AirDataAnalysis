package clover.datalab.airdata.service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import clover.datalab.airdata.entities.Dust;
import clover.datalab.airdata.repositories.DustRepository;

@Service
public class DustService {
	
	@Autowired 
	private DustRepository dRepository;
	
    public Map<String, String> getAvgPmValuesBySido() {
        Map<String, String> result = new HashMap<>();
        
        List<Object[]> averagePmValues = dRepository.getAvgPmValuesBySido();
        
        for (Object[] row : averagePmValues) {
            String sido = (String) row[0];
            Double avgPm10Value = (Double) row[1];
            Double avgPm25Value = (Double) row[2];

            // 시도명을 key로 하고 미세먼지와 초미세먼지 평균 값을 value로 설정
            String averageValues = String.format("%.0f, %.0f", avgPm10Value, avgPm25Value);
            result.put(sido, averageValues);
        }

        return result;
    }
	
	
    /**
     * 최신 Dust 데이터를 조회합니다.
     *
     * @return 최신 Dust 데이터
     */
    // 현재 날짜와 시간에 해당하는 최신 미세먼지 데이터 가져오기
    public Dust findLatestDustDataByDateTime() {
        LocalDateTime currentDateTime = LocalDateTime.now().withMinute(0).withSecond(0).withNano(0); // 분, 초, 나노초를 0으로 설정하여 시간 단위로 자름
        
        // DustRepository에 정의된 메서드를 사용하여 시간별로 최신 데이터를 가져옵니다.
        return dRepository.findTopByDataTimeBeforeOrderByDataTimeDesc(currentDateTime);
    }
	
    public List<Object[]> getAveragePmValuesBySido() {
        return dRepository.findAveragePmValuesBySido();
    }
	
	public void insertItems(String jsonString) {
		JSONObject jsonObject = new JSONObject(jsonString);
		JSONArray jsonArray = jsonObject.getJSONObject("response").getJSONObject("body")
				.getJSONArray(("items"));
		
		System.out.println(jsonArray);
        ObjectMapper mapper = new ObjectMapper();
        for (Object o : jsonArray) {
        	try {
            Dust dust = mapper.readValue(o.toString(), Dust.class);
            dRepository.save(dust);
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}	
}
	
}
