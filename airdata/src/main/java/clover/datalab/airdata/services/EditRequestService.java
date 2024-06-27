package clover.datalab.airdata.services;

import java.util.Map;

import clover.datalab.airdata.entities.EditRequest;
import clover.datalab.airdata.http.forms.editrequest.EditRequestForm;

public interface EditRequestService {
	void register(EditRequestForm form);
	void remove();
	EditRequest findByEditRequestId(Long id);
	Map<String, Object> findAllEditRequest(int page);
}
