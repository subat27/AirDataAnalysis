package clover.datalab.airdata.services;

import java.io.IOException;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.lifestyle.LifestyleForm;
import clover.datalab.airdata.repositories.LifestyleRepository;
import clover.datalab.airdata.utilities.Common;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ILifestyleService implements LifestyleService {

	private final LifestyleRepository repository;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void register(LifestyleForm form, String thumbnail) throws Exception {
		try {
			repository.save(
					Lifestyle.builder().subject(form.getSubject())
									   .content(form.getContent())
									   .tags(form.getTags())
									   .category(form.getCategory())
									   .thumbnail(thumbnail)
									   .build()
			);
		} catch (DataAccessException exception) {
			throw new Exception("service: 데이터 처리 중 문제가 발생했습니다.");
		}
		
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void modify(LifestyleForm form, String thumbnail, Long id) throws Exception {
		try {
			Lifestyle orgLifestyle = repository.findById(id).orElseThrow(() -> new Exception("데이터 처리 중 문제가 발생했습니다."));
			
			orgLifestyle.setSubject(form.getSubject());
			orgLifestyle.setContent(form.getContent());
			orgLifestyle.setTags(form.getTags());
			orgLifestyle.setCategory(form.getCategory());
			orgLifestyle.setThumbnail(thumbnail);
			
			repository.save(orgLifestyle);
			
		} catch (DataAccessException exception) {
			throw new Exception("service: 데이터 처리 중 문제가 발생했습니다.");
		} catch (IOException e) {
			throw new IOException("파일 경로를 찾을수 없습니다.");
		}
		
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void remove(Long id) throws Exception {
		repository.deleteById(id);
	}

	@Override
	public Lifestyle findByLifestyleId(Long id) throws Exception {
		return repository.findById(id).orElseThrow(() -> new Exception("데이터 처리 중 문제가 발생했습니다."));
	}

	@Override
	public Map<String, Object> findLifestyles(int page, String search, String type, String sort) {
		int pagePerCount = 12;
		Pageable pageable = PageRequest.of(page-1, pagePerCount, Sort.by(Sort.Direction.DESC, sort));
		
		Page<Lifestyle> lifestyles = repository.findAll(pageable);
		
		return Common.paginate(page, lifestyles, search, type, sort);
	}

}
