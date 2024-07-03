package clover.datalab.airdata.http.controllers;

import lombok.RequiredArgsConstructor;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.gson.Gson;

import clover.datalab.airdata.service.DustService;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final DustService dService;

    @GetMapping("/")
    public String home(Model model) {
    	Map<String, String> averagePmValues = dService.getAvgPmValuesBySido();
    	Gson gson = new Gson();
        String json = gson.toJson(averagePmValues);
        model.addAttribute("jsonPmValues", json);
        model.addAttribute("averagePmValues", averagePmValues);
        return "_pages/home";
    }

}
