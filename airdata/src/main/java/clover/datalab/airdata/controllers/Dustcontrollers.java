package clover.datalab.airdata.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import clover.datalab.airdata.service.ApiService;
import clover.datalab.airdata.service.DustService;


@Controller
@RequestMapping("/dust")
public class Dustcontrollers {

	@Autowired
	private ApiService apiService;
	
	@Autowired
	private DustService dService;
	
	// 미세먼지 정보를 가져와서 DB에 저장
	@GetMapping("insert")
	public String insert() {
		try {
			dService.insertItems(apiService.getDustData());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}	
	
}
