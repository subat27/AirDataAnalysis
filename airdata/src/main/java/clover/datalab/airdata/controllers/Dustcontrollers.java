package clover.datalab.airdata.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import clover.datalab.airdata.service.DustService;


@Controller
@RequestMapping("/dust")
public class Dustcontrollers {
	
	@Autowired
	private DustService dService;
	
    @GetMapping("/pm")
    public String getAveragePmValues(Model model) {
        Map<String, String> averagePmValues = dService.getAvgPmValuesBySido();
        model.addAttribute("averagePmValues", averagePmValues);
        System.out.println(":::::::::::::::::::::");
        System.out.println(averagePmValues);
        System.out.println(":::::::::::::::::::::");
        return "_layouts/public/pm_avg"; 
    }
    
}