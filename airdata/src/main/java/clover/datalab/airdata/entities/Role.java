package clover.datalab.airdata.entities;

import clover.datalab.airdata.enums.RoleType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "roles")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 고유번호(ID, 자동생성)

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private RoleType role; // 역할 구분

    @ManyToOne(fetch = FetchType.EAGER)
    private Member member; // 해당 역할을 가진 회원의 엔티티

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)

}
