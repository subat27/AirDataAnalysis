package clover.datalab.airdata.services;

import clover.datalab.airdata.entities.Member;
import clover.datalab.airdata.entities.Role;
import clover.datalab.airdata.enums.RoleType;
import clover.datalab.airdata.repositories.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IRoleService implements RoleService {

    private final RoleRepository repository;

    @Override
    public void add(Member member, RoleType role) {
        repository.save(
            Role.builder().member(member).role(role).build()
        );
    }

}
