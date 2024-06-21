package clover.datalab.airdata.services;

import clover.datalab.airdata.entities.Member;
import clover.datalab.airdata.enums.RoleType;
import clover.datalab.airdata.http.forms.MemberInformationUpdateForm;
import clover.datalab.airdata.http.forms.MemberPasswordUpdateForm;
import clover.datalab.airdata.http.forms.MemberRegisterForm;
import clover.datalab.airdata.repositories.MemberRepository;
import clover.datalab.airdata.utilities.Common;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class IMemberService implements MemberService {

    private final PasswordEncoder encoder;
    private final MemberRepository repository;
    private final RoleService roleService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void register(MemberRegisterForm form) throws Exception {
        try {
            Member member = repository.save(
                Member.builder().username(form.getUsername())
                                .password(encoder.encode(form.getPassword()))
                                .name(form.getName())
                                .build()
            );

            roleService.add(member, RoleType.USER);

            if (repository.count() == 1L) {
                roleService.add(member, RoleType.ADMIN);
            }
        } catch (DataAccessException exception) {
            throw new Exception("데이터 처리 중 문제가 발생했습니다.");
        }
    }

    @Override
    @Transactional
    public void updateInformation(MemberInformationUpdateForm form, Long id) throws Exception {
        Member member = repository.findById(id).orElseThrow(() -> new Exception("데이터 처리 중 문제가 발생했습니다."));
        member.setName(form.getName());

        repository.save(member);
    }

    @Override
    @Transactional
    public void updatePassword(MemberPasswordUpdateForm form, Long id) throws Exception {
        Member member = repository.findById(id).orElseThrow(() -> new Exception("데이터 처리 중 문제가 발생했습니다."));
        member.setPassword(encoder.encode(form.getNewPassword()));

        repository.save(member);
    }

    @Override
    public Member currentItemAtUsername(String username) throws Exception {
        return repository.findByUsername(username).orElseThrow(() -> new Exception("정보가 없습니다."));
    }

}
