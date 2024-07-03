package clover.datalab.airdata.http.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import clover.datalab.airdata.service.DustService;


@Controller
@RequestMapping("/dust")
public class Dustcontrollers {
	
	@Autowired
	private DustService dService;
	
    @GetMapping("/pm")
    public String getAveragePmValues(Model model) {
        Map<String, String> averagePmValues = dService.getAvgPmValuesBySido();
        Gson gson = new Gson();
        String json = gson.toJson(averagePmValues);
        model.addAttribute("jsonPmValues", json);
        model.addAttribute("averagePmValues", averagePmValues);
        return "_layouts/public/pm_avg"; 
    }
    
}