package clover.datalab.airdata.services;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.lifestyle.LifestyleForm;

public interface LifestyleService {

//	void register(MultipartFile filename, LifestyleForm form) throws Exception;
	void register(MultipartFile filename, LifestyleForm form, String path) throws Exception;
	
	void modify(MultipartFile filename, LifestyleForm form, String path, Long id) throws Exception;
	
	void remove(Long id) throws Exception;
	
	Lifestyle findByLifestyleId(Long id) throws Exception;
	Map<String, Object> findLifestyles(int page, String search, String type, String sort);
}
