package clover.datalab.airdata.http.forms;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductForm {
	
	private String lifestyle;

	@NotBlank(message = "필수 입력 항목입니다.")
	@Pattern(regexp = "^[a-zA-Z0-9가-힣 ]*$", message = "한글, 영문, 숫자만 입력 가능합니다.")
	@Size(min = 1, max = 100, message = "100자까지 입력 가능합니다.")
	private String subject;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String content;
	
	@Positive(message = "1이상의 숫자로 입력해 주십시오.")
	private int price;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String tags;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String category;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String link;
	
}
