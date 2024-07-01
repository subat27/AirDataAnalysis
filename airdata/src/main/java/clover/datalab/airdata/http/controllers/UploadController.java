package clover.datalab.airdata.http.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import clover.datalab.airdata.utilities.Uploader;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class UploadController {
	
	private final Uploader uploader;

	@PostMapping("/uploader")
    public Map<String, String> uploadImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> result;
        Map<String, String> responseData = new HashMap<String, String>();
        String baseUrl = "https://subat27awsbucket.s3.ap-northeast-2.amazonaws.com/";
		try {
			result = uploader.upload(file, "lifestyle");
			responseData.put("location", baseUrl + result.get("uploadFileName").toString());
			return responseData;
		} catch (IOException e) {
			return responseData;
		}

    }
	
}
