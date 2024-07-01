package clover.datalab.airdata.services;

import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import clover.datalab.airdata.entities.EditRequest;
import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.editrequest.EditrequestForm;
import clover.datalab.airdata.repositories.EditRequestRepository;
import clover.datalab.airdata.utilities.Common;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IEditrequestService implements EditrequestService {

	private final EditRequestRepository repository;
	
	@Override
	public void register(EditrequestForm form, Lifestyle lifestyle) throws Exception {
		try {
			repository.save(
					EditRequest.builder().subject(form.getSubject())
										.content(form.getContent())
										.reason(form.getReason())
										.name(form.getName())
										.lifestyle(lifestyle)
										.build()
				);
		} catch (DataAccessException exception) {
			throw new Exception("데이터 처리 중 문제가 발생했습니다.");
		}
	}

	@Override
	public void remove(Long id) throws Exception {
		try {
			repository.deleteById(id);
		} catch (Exception e) {
			throw new Exception("데이터 처리 중 문제가 발생했습니다.");
		}
		
	}

	@Override
	public EditRequest findByEditRequestId(Long id) throws Exception {
		return repository.findById(id).orElseThrow(() -> new Exception("데이터 처리 중 문제가 발생했습니다."));
	}

	@Override
	public Map<String, Object> findAllEditRequest(int page) {
		int pagePerCount = 5;
		Pageable pageable = PageRequest.of(page-1, pagePerCount, Sort.by(Sort.Direction.DESC, "created"));
		
		Page<EditRequest> editRequests = repository.findAll(pageable); 
		return Common.paginate(page, editRequests, "", "", "");
	}

}
