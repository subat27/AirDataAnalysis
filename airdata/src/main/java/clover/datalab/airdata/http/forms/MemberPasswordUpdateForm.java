package clover.datalab.airdata.http.forms;

import clover.datalab.airdata.http.validators.annotations.EqualTo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualTo(first = "newPassword", second = "confirmPassword", message = "비밀번호가 서로 일치하지 않습니다.")
public class MemberPasswordUpdateForm {

    @NotBlank(message = "필수 입력 항목입니다.")
    @Size(min = 6, max = 30, message = "6~30자로 입력해 주십시오.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "영문, 숫자만 입력 가능합니다.")
    private String nowPassword;

    @NotBlank(message = "필수 입력 항목입니다.")
    @Size(min = 6, max = 30, message = "6~30자로 입력해 주십시오.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "영문, 숫자만 입력 가능합니다.")
    private String newPassword;

    @NotBlank(message = "필수 입력 항목입니다.")
    private String confirmPassword;

}
