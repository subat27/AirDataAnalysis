package clover.datalab.airdata.utilities;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;

import clover.datalab.airdata.configurations.AwsConfiguration;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Uploader {
	
	private final AwsConfiguration config;
		
	private String[] ALLOW_UPLOAD = {
		"jpg", "gif", "png", "svg"	
	};

	public Map<String, Object> upload(MultipartFile file, String path) throws IOException {
		AmazonS3 s3Client = config.s3Client();
		
		if (file.isEmpty()) throw new IOException("E-0000");
		if (Objects.equals(file.getOriginalFilename(), "..")) throw new IOException("E-0100");
		
		Map<String, Object> response = new HashMap<>();
		
		String extension = getFileExtension(Objects.requireNonNull(file.getOriginalFilename()));
		String uploadFileName = path + "/" + UUID.randomUUID() + "." + extension;
		
		if (!extensionContains(extension)) throw new IOException("E-0200");
		
		ObjectMetadata meta = new ObjectMetadata();
		meta.setContentLength(file.getSize());
		meta.setContentType(file.getContentType());
		
		s3Client.putObject("blueskywellness", uploadFileName, file.getInputStream(), meta);
		
		response.put("originalFileName", file.getOriginalFilename());
		response.put("uploadFileName", uploadFileName);
		response.put("path", path);
		response.put("size", file.getSize());
		
		return response;
	}
	
	private String getFileExtension(String fileName) {
		String extension = "";
		
		int index = fileName.lastIndexOf(".");
		
		if (index > 0 && index < fileName.length() - 1) {
			extension = fileName.substring(index + 1);
			
		}
		
		return extension;
	}
	
	private boolean extensionContains(String extension) {
		if (extension == null) return false;
		
		for (String s: ALLOW_UPLOAD) {
			if (extension.contains(s)) return true;
		}
		
		return false;
	}
	
}
