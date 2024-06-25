package clover.datalab.airdata.http.controllers;

import clover.datalab.airdata.entities.Member;
import clover.datalab.airdata.enums.MemberUniqueType;
import clover.datalab.airdata.http.forms.MemberInformationUpdateForm;
import clover.datalab.airdata.http.forms.MemberPasswordUpdateForm;
import clover.datalab.airdata.http.forms.MemberRegisterForm;
import clover.datalab.airdata.http.validators.ServerValidator;
import clover.datalab.airdata.services.MemberService;
import clover.datalab.airdata.utilities.Common;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
@RequiredArgsConstructor
public class MemberController {

    private final PasswordEncoder encoder;
    private final ServerValidator validator;
    private final MemberService service;
    
    @GetMapping("/user/login")
    public String login() {
        return "_pages/user/login";
    }

    @GetMapping("/user/register")
    public String register(Model model) {
        model.addAttribute("member", new MemberRegisterForm());
        return "_pages/user/register";
    }

    @PostMapping("/user/register")
    public String registerProcess(
        @ModelAttribute("member") @Valid MemberRegisterForm member,
        BindingResult bindingResult,
        Model model
    ) {
        try {
            if(bindingResult.hasErrors()) {
                return "_pages/user/register";
            }
            service.register(member);
            return "redirect:/user/login";
        } catch (Exception exception) {
            model.addAttribute("error", "데이터 처리 중 문제가 발생했습니다.");
            return "_pages/user/register";
        }
    }

    @GetMapping("/admin/mypage/password")
    public String adminMyPage(Model model) {
        model.addAttribute("password", new MemberPasswordUpdateForm());
        return "_pages/admin/mypage/password";
    }

    @PostMapping("/admin/mypage/password")
    public String adminMyPasswordChange(
        @ModelAttribute("password") @Valid MemberPasswordUpdateForm password,
        BindingResult bindingResult,
        Model model,
        Authentication authentication
    ) {
        try {
            String username = authentication.getName();
            Member member = service.currentItemAtUsername(username);

            if (!encoder.matches(password.getNowPassword(), member.getPassword())) {
                bindingResult.rejectValue("nowPassword", "nowPassword.invalid", "기존 비밀번호가 다릅니다.");
            }

            if (bindingResult.hasErrors()) {
                return "_pages/admin/mypage/password";
            }

            service.updatePassword(password, member.getId());
            return "redirect:/admin/mypage/password";
        } catch (Exception exception) {
            model.addAttribute("error", exception.getMessage());
            return "_pages/admin/mypage/password";
        }
    }

    @GetMapping("/admin/mypage/information")
    public String adminMyInformation(
        Model model,
        Authentication authentication
    ) {
        try {
            Member member = service.currentItemAtUsername(authentication.getName());
            MemberInformationUpdateForm form = new MemberInformationUpdateForm();
            form.setName(member.getName());

            model.addAttribute("data", member);
            model.addAttribute("information", form);
            return "_pages/admin/mypage/information";
        } catch (Exception exception) {
            return "redirect:/";
        }
    }

    @PostMapping("/admin/mypage/information")
    public String adminMyInformationChange(
        @ModelAttribute("information") @Valid MemberInformationUpdateForm information,
        BindingResult bindingResult,
        Model model,
        Authentication authentication
    ) {
        try {
            Member member = service.currentItemAtUsername(authentication.getName());

            if (!information.getName().equals(member.getName())) {
                if (!validator.isMemberUnique(MemberUniqueType.NAME, information.getName())) {
                    bindingResult.rejectValue("name", "name.unique", "이미 사용 중인 이름입니다.");
                    return "_pages/admin/mypage/information";
                }
            }

            if(bindingResult.hasErrors()) {
                return "_pages/admin/mypage/information";
            }

            service.updateInformation(information, member.getId());
            return "redirect:/admin/mypage/information";
        } catch (Exception exception) {
            model.addAttribute("error", "처리 중 문제가 발생했습니다.");
            return "_pages/admin/mypage/information";
        }
    }



}
