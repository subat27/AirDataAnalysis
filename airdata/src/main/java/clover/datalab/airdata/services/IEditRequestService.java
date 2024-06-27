package clover.datalab.airdata.services;

import java.util.Map;

import org.springframework.stereotype.Service;

import clover.datalab.airdata.entities.EditRequest;
import clover.datalab.airdata.http.forms.editrequest.EditRequestForm;
import clover.datalab.airdata.repositories.EditRequestRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IEditRequestService implements EditRequestService {
	
	private final EditRequestRepository repository;

	@Override
	public void register(EditRequestForm form) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void remove() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public EditRequest findByEditRequestId(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> findAllEditRequest(int page) {
		// TODO Auto-generated method stub
		return null;
	}

}
