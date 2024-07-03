package clover.datalab.airdata.http.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import clover.datalab.airdata.services.LocationService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LocationController {
	private final LocationService service;
	
	@GetMapping("/location/detail/{id}")
	public String getLocation(@PathVariable("id") Long id, Model model) {
		model.addAttribute("location", service.findByLocationId(id));
		return "_pages/location/detail";
	}
	
	@GetMapping("/location/list")
	public String listLocation(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "search", defaultValue = "") String search,
			@RequestParam(name = "type", defaultValue = "") String type,
			Model model) {
		
		model.addAttribute("locations", service.findLocations(page, search, type));
		
		return "_pages/location/list";
	}
	
	
}
