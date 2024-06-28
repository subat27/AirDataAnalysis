package clover.datalab.airdata.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import clover.datalab.airdata.entities.Dust;
import clover.datalab.airdata.service.ApiService;
import clover.datalab.airdata.service.DustService;


@Controller
@RequestMapping("/dust")
public class Dustcontrollers {

	@Autowired
	private ApiService apiService;
	
	@Autowired
	private DustService dService;
	
    @GetMapping("/pm-avg")
    public String getAveragePmValues(Model model) {
        Map<String, String> averagePmValues = dService.getAvgPmValuesBySido();
        model.addAttribute("averagePmValues", averagePmValues);
        System.out.println(":::::::::::::::::::::");
        System.out.println(averagePmValues);
        System.out.println(":::::::::::::::::::::");
        return "_layouts/public/pm_avg"; // 해당 뷰의 이름을 리턴 (average_pm_values.html 등)
    }
	
    @GetMapping("/sido")
    public String getAveragePmValuesBySido(Model model) {
    	
    	Dust latestDust = dService.findLatestDustDataByDateTime();
        List<Object[]> averagePmValues = dService.getAveragePmValuesBySido();
        
        model.addAttribute("latestDust", latestDust);
        model.addAttribute("averagePmValues", averagePmValues);

        return  "_layouts/public/sido_dust";
    }
	
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
