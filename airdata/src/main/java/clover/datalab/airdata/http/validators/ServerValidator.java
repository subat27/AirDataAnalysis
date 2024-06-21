package clover.datalab.airdata.http.validators;

import clover.datalab.airdata.enums.MemberUniqueType;
import clover.datalab.airdata.repositories.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ServerValidator {

    private final MemberRepository memberRepository;

    public boolean isMemberUnique(MemberUniqueType type, String value) {
        return !switch(type) {
            case USERNAME -> memberRepository.existsByUsername(value);
            case NAME -> memberRepository.existsByName(value);
        };
    }

}
