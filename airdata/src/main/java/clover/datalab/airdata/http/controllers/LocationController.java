package clover.datalab.airdata.http.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import clover.datalab.airdata.http.forms.LocationForm;
import clover.datalab.airdata.services.LocationService;
import jakarta.validation.Valid;
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
			@RequestParam(name = "perPage", defaultValue = "12") int perPage,
			@RequestParam(name = "search", defaultValue = "") String search,
			@RequestParam(name = "sort", defaultValue = "id") String sort,
			Model model) {
		
		model.addAllAttributes(service.findLocations(page, perPage, search, sort));
		
		return "_pages/location/list";
	}
	
	@GetMapping("/location/insert")
	public String insertLocation(Model model) {
		model.addAttribute("location", new LocationForm());
		return "_pages/location/insert";
	}
	
	@PostMapping("/location/insert")
	public String insertLocation(@ModelAttribute("location") @Valid LocationForm location,
			BindingResult bindingResult, Model model, String thumbnail) {
		
		try {
			if (bindingResult.hasErrors()) {
				return "_pages/location/insert";
			}
			service.register(location, thumbnail);
			return "redirect:/location/list";
		} catch (Exception e) {
			model.addAttribute("error", e.toString());

			return "_pages/location/insert";
		}
	}
	
}
