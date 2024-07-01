package clover.datalab.airdata.http.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import clover.datalab.airdata.entities.EditRequest;
import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.editrequest.EditrequestForm;
import clover.datalab.airdata.http.forms.lifestyle.LifestyleForm;
import clover.datalab.airdata.services.EditrequestService;
import clover.datalab.airdata.services.LifestyleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EditrequestController {
	private final EditrequestService editService;
	private final LifestyleService lifestyleService;
	
	@GetMapping("/edit/register")
	public String insertNew(Model model) {
		model.addAttribute("editRequest", new EditrequestForm());
		model.addAttribute("actionName", "등록");
		model.addAttribute("action", "/edit/register");
		return "_pages/editrequest/register";
	}
	
	@GetMapping("/edit/register/{lifestyleId}")
	public String insert(Model model, @PathVariable("lifestyleId") Long lifestyleId) {
		try {
			Lifestyle ls = lifestyleService.findByLifestyleId(lifestyleId);
			model.addAttribute("lifestyleId", lifestyleId);
			model.addAttribute("editRequest", new EditrequestForm(ls.getSubject(), "", ls.getContent(), ""));
			model.addAttribute("actionName", "수정");
			model.addAttribute("action", "/edit/register/");
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return "_pages/editrequest/register";
	}
	
	@PostMapping("/edit/register/{lifestyleId}")
	public String insert(@ModelAttribute("editRequest") @Valid EditrequestForm editRequest, BindingResult bindingResult, Model model, @PathVariable("lifestyleId") Long lifestyleId) {
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
	
	@PostMapping("/edit/register")
	public String insertNew(@ModelAttribute("editRequest") @Valid EditrequestForm editRequest,
			BindingResult bindingResult, Model model) {
		try {
			
			if(bindingResult.hasErrors()) {
				return "_pages/editrequest/register";
			}			
			editService.register(editRequest, null);
			return "redirect:/lifestyle"; 
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
			EditRequest editRequest = editService.findByEditRequestId(editId);
			model.addAttribute("editRequest", editRequest);
			if (editRequest.getLifestyle() == null) {
				model.addAttribute("action", "등록");	
			} else {
				model.addAttribute("action", "수정");
			}
		} catch (Exception e) {
			model.addAttribute("error", e.toString());
		}
		return "_pages/editrequest/detail";
	}
	
	@GetMapping("/edit/modify/{editId}")
	public String modify(@PathVariable("editId") Long editId, Model model) {
		EditRequest editRequest;
		try {
			editRequest = editService.findByEditRequestId(editId);
			model.addAttribute("editRequest", editRequest);
			Lifestyle ls = editRequest.getLifestyle();
			if (ls == null) {
				model.addAttribute("lifestyle", new LifestyleForm());
				model.addAttribute("thumbnail", "");
				model.addAttribute("action", "등록");
			} else {
				model.addAttribute("lifestyle", new LifestyleForm(ls.getSubject(), ls.getContent(), ls.getTags(), ls.getCategory()));
				model.addAttribute("thumbnail", ls.getThumbnail());
				model.addAttribute("action", "수정");
			}
			
		} catch (Exception e) {
			model.addAttribute("error", "데이터 처리 중 에러 발생");
			e.printStackTrace();
		}
		
		
		return "_pages/editrequest/modify";
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
