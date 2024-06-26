package clover.datalab.airdata.http.forms;

import clover.datalab.airdata.enums.MemberUniqueType;
import clover.datalab.airdata.http.validators.annotations.EqualTo;
import clover.datalab.airdata.http.validators.annotations.MemberUnique;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualTo(first = "password", second = "confirm", message = "비밀번호가 서로 일치하지 않습니다.")
public class MemberRegisterForm {

    @NotBlank(message = "필수 입력 항목입니다.")
    @Size(min = 6, max = 30, message = "6~30자로 입력해 주십시오.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "영문, 숫자만 입력 가능합니다.")
    @MemberUnique(type = MemberUniqueType.USERNAME, message = "이미 등록된 사용자 입니다.")
    private String username;

    @NotBlank(message = "필수 입력 항목입니다.")
    @Size(min = 6, max = 30, message = "6~30자로 입력해 주십시오.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "영문, 숫자만 입력 가능합니다.")
    private String password;

    @NotBlank(message = "필수 입력 항목입니다.")
    private String confirm;

    @NotBlank(message = "필수 입력 항목입니다.")
    @Size(min = 2, max = 10, message = "2~10자로 입력해 주십시오.")
    @Pattern(regexp = "^[a-zA-Z0-9가-힣 ]*$", message = "한글, 영문, 숫자만 입력 가능합니다.")
    @MemberUnique(type = MemberUniqueType.USERNAME, message = "이미 등록된 사용자 입니다.")
    private String name;

}
