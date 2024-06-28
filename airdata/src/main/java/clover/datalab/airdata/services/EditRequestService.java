package clover.datalab.airdata.services;

import java.util.Map;

import clover.datalab.airdata.entities.EditRequest;
import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.editrequest.EditRequestForm;

public interface EditRequestService {
	void register(EditRequestForm form, Lifestyle lifestyle) throws Exception;
	void remove(Long id) throws Exception;
	EditRequest findByEditRequestId(Long id) throws Exception;
	Map<String, Object> findAllEditRequest(int page);
}
