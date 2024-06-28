package clover.datalab.airdata.http.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.lifestyle.LifestyleForm;
import clover.datalab.airdata.services.LifestyleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LifestyleController {

	private final LifestyleService service;

	// 라이프스타일 등록 페이지로 이동
	@GetMapping("/lifestyle/register")
	public String register(Model model) {
		model.addAttribute("lifestyle", new LifestyleForm());
		return "_pages/lifestyle/register";
	}

	// 라이프스타일 등록
	@PostMapping("/lifestyle/register")
	public String registerProcess(@ModelAttribute("lifestyle") @Valid LifestyleForm lifestyle,
			@RequestPart(name = "thumbnail") MultipartFile thumbnail,
			BindingResult bindingResult, Model model, MultipartHttpServletRequest mRequest) {
		
		try {
			if (bindingResult.hasErrors()) {
				return "_pages/lifestyle/register";
			}
			
			String path = "";
			path = mRequest.getServletContext().getRealPath(path);
				
			service.register(thumbnail, lifestyle, path);
			return "redirect:/lifestyle";
		} catch (Exception e) {
			model.addAttribute("error", e.toString());

			return "_pages/lifestyle/register";
		}
	}

	// 라이프스타일 목록 조회
	@GetMapping("/lifestyle")
	public String listLifestyle(
			@RequestParam(name = "page", defaultValue = "1") Integer page,
			@RequestParam(name = "search", defaultValue = "") String search,
			@RequestParam(name = "type", defaultValue = "") String type,
			@RequestParam(name = "sort", defaultValue = "id") String sort,
			Model model) {
		model.addAllAttributes(service.findLifestyles(page, search, type, sort));
		return "_pages/lifestyle/list";
	}
	
	// 라이프스타일 상세
	@GetMapping("/lifestyle/detail/{id}")
	public String detailLifeStyle(@PathVariable("id") Long id,	Model model) {
		try {
			model.addAttribute("lifestyle", service.findByLifestyleId(id));
		} catch (Exception e) {
			model.addAttribute("error", "데이터 처리 중 문제가 발생했습니다.");
		}
		return "_pages/lifestyle/detail";
	}

	// 라이프스타일 수정 페이지로 이동
	@GetMapping("/lifestyle/modify/{id}")
	public String modifyLifestyle(Model model, @PathVariable("id") Long id) {
		try {
			Lifestyle ls = service.findByLifestyleId(id);
			model.addAttribute("lifestyle", new LifestyleForm(ls.getSubject(), ls.getContent(), ls.getTags(), ls.getCategory()));
			model.addAttribute("thumbnail", ls.getThumbnail());
		} catch (Exception e) {
			model.addAttribute("error", "데이터 처리 중 문제가 발생했습니다.");
		}
		return "_pages/lifestyle/modify";
		
	}
	
	// 라이프스타일 수정
	@PostMapping("/lifestyle/modify/{id}")
	public String modifyLifestyleProcess(@ModelAttribute("lifestyle") @Valid LifestyleForm lifestyle,
			@RequestPart(name = "thumbnail") MultipartFile thumbnail, @PathVariable("id") Long id,
			BindingResult bindingResult, Model model, MultipartHttpServletRequest mRequest) {
		
		try {
			if (bindingResult.hasErrors()) {
				return "/lifestyle/moldify/" + id;
			}
			String path = "";
			path = mRequest.getServletContext().getRealPath(path);
			service.modify(thumbnail, lifestyle, path, id);
			return "redirect:/lifestyle/detail/" + id;
		} catch (Exception e) {
			model.addAttribute("error", e.toString());

			return "/lifestyle/modify/" + id;
		}
	}
	
	// 라이프스타일 삭제
	@GetMapping("/lifestyle/delete/{id}")
	public String deleteLifestyle(@PathVariable("id") Long id, Model model) {
		try {
			service.remove(id);
			return "redirect:/lifestyle";
		} catch (Exception e) {
			model.addAttribute("error", "데이터 처리 중 문제가 발생했습니다.");
			return "redirect:/lifestyle/detail/" + id;
		}
	}
}
