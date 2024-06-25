package clover.datalab.airdata.http.forms.lifestyle;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LifestyleForm {
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String subject;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String content;

	@NotBlank(message = "필수 입력 항목입니다.")
	private String tags;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String category;
	
}
