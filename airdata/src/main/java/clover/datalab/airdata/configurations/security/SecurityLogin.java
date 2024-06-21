package clover.datalab.airdata.configurations.security;

import clover.datalab.airdata.entities.Member;
import clover.datalab.airdata.entities.Role;
import clover.datalab.airdata.repositories.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class SecurityLogin implements UserDetailsService {

    private final MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Member> member = memberRepository.findByUsername(username);

        if (member.isPresent()) {
            List<Role> roles = member.get().getRoles();
            List<GrantedAuthority> grantedAuthorities = new ArrayList<>();

            roles.forEach(role -> {
                grantedAuthorities.add(new SimpleGrantedAuthority(role.getRole().toString()));
            });

            return User.builder().username(username)
                                 .password(member.get().getPassword())
                                 .authorities(grantedAuthorities)
                                 .build();
        } else {
            throw new UsernameNotFoundException("등록된 사용자가 없습니다.");
        }
    }

}
