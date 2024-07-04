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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import clover.datalab.airdata.http.forms.ProductForm;
import clover.datalab.airdata.services.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ProductController {
	
	private final ProductService service;
	
	@GetMapping("/admin/product/add")
	public String add(Model model) {
		model.addAttribute("product", new ProductForm());
		model.addAttribute("action", "/admin/product");
		model.addAttribute("actionName", "등록");
		return "_pages/admin/product/update";
	}
	
	@PostMapping("/admin/product")
	public String addProcess(
		@ModelAttribute("product") @Valid ProductForm product,
		@RequestPart("thumbnail") MultipartFile thumbnail,
		BindingResult bindingResult,
		Model model
	) {
		try {
			if (bindingResult.hasErrors()) {
				return "_pages/admin/product/update";
			}
			service.register(product, null); // 라이프스타일 기능 완성 시 수정 필요!
			return "redirect:/admin/product";
		} catch (Exception exception) {
			model.addAttribute("error", exception.getMessage());
			return "_pages/admin/product/update";
		}
	}
	
	@GetMapping("/admin/product")
	public String inventory(
		@RequestParam(name = "p", defaultValue = "1") int page,
		@RequestParam(name = "t", defaultValue = "") String searchType,
		@RequestParam(name = "s", defaultValue = "") String searchWord,
		Model model
	) {
		model.addAllAttributes(service.paginatedItem(page, page, searchType, searchWord));
		return "_pages/admin/product/list";
	}
	
	@GetMapping("/admin/product/{id}")
	public String updateDetail(
		@PathVariable("id") Long id, Model model
	) {
		try {
			model.addAttribute("product", service.currentItem(id));
			model.addAttribute("action", "/admin/product/update/" + id);
			model.addAttribute("actionName", "수정");
			return "_pages/admin/product/update";
		} catch (Exception exception) {
			return "redirect:/admin/product";
		}
	}
	
	@PostMapping("/admin/product/update/{id}")
	public String updateDetailProcess(
		@PathVariable("id") Long id,
		@ModelAttribute("product") @Valid ProductForm product,
		BindingResult bindingResult,
		Model model
	) {
		try {
			if (bindingResult.hasErrors()) {
				return "_pages/admin/product/update";
			}
			service.update(product, null, id); // 라이프스타일 기능 완성 시 수정 필요!
			return "redirect:/admin/product/" + id;
		} catch (Exception exception) {
			return "redirect:/admin/product";
		}
	}
	
	@GetMapping("/admin/product/delete/{id}")
	public String delete(@PathVariable("id") Long id) {
		service.delete(id);
		return "redirect:/admin/product";
	}

}
