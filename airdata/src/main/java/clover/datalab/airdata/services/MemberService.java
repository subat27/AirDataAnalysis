package clover.datalab.airdata.services;

import clover.datalab.airdata.entities.Member;
import clover.datalab.airdata.http.forms.MemberInformationUpdateForm;
import clover.datalab.airdata.http.forms.MemberPasswordUpdateForm;
import clover.datalab.airdata.http.forms.MemberRegisterForm;

public interface MemberService {

    void register(MemberRegisterForm form) throws Exception;
    void updateInformation(MemberInformationUpdateForm form, Long id) throws Exception;
    void updatePassword(MemberPasswordUpdateForm form, Long id) throws Exception;

    Member currentItemAtUsername(String username) throws Exception;

}
