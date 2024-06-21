package clover.datalab.airdata.entities;

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
@Table(name = "lifestyle_edit_requests")
public class EditRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 고유번호(ID, 자동생성)

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id")
    private Lifestyle lifestyle; // 해당되는 라이프스타일 엔티티

    @Column(nullable = false)
    private String name; // 수정 요청자명

    @Column(nullable = false)
    private String subject; // 제목

    @Column(nullable = false, columnDefinition = "text")
    private String content; // 내용(에디터로 작성된 HTML 형태의 내용)

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)

}
