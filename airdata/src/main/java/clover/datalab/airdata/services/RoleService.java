package clover.datalab.airdata.services;

import clover.datalab.airdata.entities.Member;
import clover.datalab.airdata.enums.RoleType;

public interface RoleService {

    void add(Member member, RoleType role);

}
