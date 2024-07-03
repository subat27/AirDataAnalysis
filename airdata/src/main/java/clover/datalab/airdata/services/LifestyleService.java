package clover.datalab.airdata.services;

import java.util.Map;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.lifestyle.LifestyleForm;

public interface LifestyleService {
	void register(LifestyleForm form, String thumbnail) throws Exception;
	void modify(LifestyleForm form, String thumbnail, Long id) throws Exception;
	void remove(Long id) throws Exception;
	Lifestyle findByLifestyleId(Long id) throws Exception;
	Map<String, Object> findLifestyles(int page, String search, String type, String sort);
}
