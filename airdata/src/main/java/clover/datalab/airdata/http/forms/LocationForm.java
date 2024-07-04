package clover.datalab.airdata.http.forms;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LocationForm {
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String name;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String address;

	@NotBlank(message = "필수 입력 항목입니다.")
	private String tags;
	
	@NotBlank(message = "필수 입력 항목입니다.")
	private String category;
	
}
