package clover.datalab.airdata.http.controllers;

import lombok.RequiredArgsConstructor;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.gson.Gson;

import clover.datalab.airdata.service.DustService;
import clover.datalab.airdata.services.LifestyleService;
import clover.datalab.airdata.services.LocationService;
import clover.datalab.airdata.services.ProductService;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final DustService dService;
	private final ProductService pService;
	private final LifestyleService lsService;
	private final LocationService lcService;

    @GetMapping("/")
    public String home(Model model) {
    	Map<String, String> averagePmValues = dService.getAvgPmValuesBySido();
    	Gson gson = new Gson();
        String json = gson.toJson(averagePmValues);
        model.addAttribute("jsonPmValues", json);
        model.addAttribute("averagePmValues", averagePmValues);
        model.addAttribute("products", pService.paginatedItem(1, 6, "", ""));
        model.addAttribute("lifestyles", lsService.findLifestyles(1, 6, "", "", "id"));
        model.addAttribute("locations", lcService.findLocations(1, 6, "", "id"));
        return "_pages/home";
    }

}
