package clover.datalab.airdata.service;

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
