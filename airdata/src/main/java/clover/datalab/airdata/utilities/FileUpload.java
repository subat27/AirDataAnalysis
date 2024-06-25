package clover.datalab.airdata.utilities;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class FileUpload {
	
	// 허용된 확장자명 목록
	private static final String[] ALLOW_UPLOAD = {
		"jpg", "jpeg", "png", "svg", "gif", "PNG"
	};
	
	
	public Map<String, Object> upload(MultipartFile file, String directory, String path) throws IOException{
		
		if (file.isEmpty()) {
			throw new IOException("파일을 첨부해 주십시오.");
		}
		
		Map<String, Object> response = new HashMap<>();
		
		String extension = getFileExtension(Objects.requireNonNull(file.getOriginalFilename()));
		String uploadFileName = directory + File.separator + UUID.randomUUID() + "." + extension;
		if (!extensionsContains(extension)) {
			throw new IOException("첨부 불가능한 파일 확장자명입니다.");
		}
		
		// 파일 저장 (추후 AWS S3로 수정)
		File target = new File(path, uploadFileName);
		System.out.println(target.getAbsolutePath());
		FileCopyUtils.copy(file.getBytes(), target);
		
		
		response.put("originalFileName", file.getOriginalFilename());
		response.put("uploadFileName", uploadFileName);
		response.put("path", directory);
		response.put("size", file.getSize());
		
		return response;
	}
	
	// 확장자명 가져오는 함수
	private String getFileExtension(String fileName) {
		String extension = "";
		
		int index = fileName.lastIndexOf(".");
		
		if (index > 0  && index < fileName.length() - 1) {
			extension = fileName.substring(index + 1);
		}
		
		return extension;
	}
	
	// 확장자명이 허용된 확장자명에 포함되어 있는지 확인하는 함수
	private boolean extensionsContains(String extension) {
		if (extension == null) {
			return false;
		}
		
		for (String s : ALLOW_UPLOAD) {
			if (extension.contains(s)) {
				return true;
			}
		}
		
		return false;
	}

	
}
