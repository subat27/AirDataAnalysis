package clover.datalab.airdata.http.forms.editrequest;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EditrequestForm {
	private String subject;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String name;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String content;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String reason;
}
