package clover.datalab.airdata.http.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.editrequest.EditRequestForm;
import clover.datalab.airdata.services.EditRequestService;
import clover.datalab.airdata.services.LifestyleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EditRequestController {
	
	private final EditRequestService editService;
	private final LifestyleService lifestyleService;
	
	@GetMapping("/edit/register/{lifestyleId}")
	public String insert(Model model, @PathVariable("lifestyleId") Long lifestyleId) {
		try {
			Lifestyle ls = lifestyleService.findByLifestyleId(lifestyleId);
			model.addAttribute("lifestyleId", lifestyleId);
			model.addAttribute("editRequest", new EditRequestForm(ls.getSubject(), "", ls.getContent(), ""));
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return "_pages/editrequest/register";
	}
	
	@PostMapping("/edit/register/{lifestyleId}")
	public String insert(@ModelAttribute("editRequest") @Valid EditRequestForm editRequest, BindingResult bindingResult, Model model, @PathVariable("lifestyleId") Long lifestyleId) {
		try {
			if(bindingResult.hasErrors()) {
				return "_pages/editrequest/register";
			}
			editService.register(editRequest, lifestyleService.findByLifestyleId(lifestyleId));
			return "redirect:/lifestyle/detail/"+lifestyleId;
		} catch (Exception e) {
			model.addAttribute("error", e.toString());
			return "_pages/editrequest/register";
		}
	}
	
	@GetMapping("/edit/list")
	public String list(@RequestParam(name = "page", defaultValue = "1") Integer page, Model model) {
		model.addAllAttributes(editService.findAllEditRequest(page));
		
		return "_pages/editrequest/list";
	}
	
	@GetMapping("/edit/detail/{editId}")
	public String detail(@PathVariable("editId") Long editId, Model model) {
		try {
			model.addAttribute("editRequest", editService.findByEditRequestId(editId));
		} catch (Exception e) {
			model.addAttribute("error", e.toString());
		}
		return "_pages/editrequest/detail";
	}
	
	@GetMapping("/edit/delete/{editId}")
	public String delete(@PathVariable("editId") Long editId) {
		try {
			editService.remove(editId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/edit/list";
	}
	
}
