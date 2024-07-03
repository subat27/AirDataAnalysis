package clover.datalab.airdata.services;

import java.util.Map;

import clover.datalab.airdata.entities.EditRequest;
import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.http.forms.editrequest.EditrequestForm;

public interface EditrequestService {
	void register(EditrequestForm form, Lifestyle lifestyle) throws Exception;
	void remove(Long id) throws Exception;
	EditRequest findByEditRequestId(Long id) throws Exception;
	Map<String, Object> findAllEditRequest(int page);
}
