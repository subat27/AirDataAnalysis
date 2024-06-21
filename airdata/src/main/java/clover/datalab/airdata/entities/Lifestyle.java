package clover.datalab.airdata.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "lifestyles")
public class Lifestyle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 고유번호(ID, 자동생성)

    @Column(nullable = false)
    private String subject; // 제목

    @Column(nullable = false, columnDefinition = "text")
    private String content; // 내용(에디터로 작성된 HTML 형태의 내용)

    @Column(nullable = false)
    private String tags; // 해시태그(여러 개인 경우 콤마로 구분)

    @Column(nullable = false)
    private String thumbnail; // 메인 섬네일 이미지(파일 경로, AWS S3이용예정)

    @Column(nullable = false)
    private String category; // 카테고리명(일반 한글 형태의 문자열)

    @OneToMany(mappedBy = "lifestyle", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<EditRequest> requests; // 해당 라이프스타일의 수정 요청 게시글의 엔티티들

    @OneToMany(mappedBy = "lifestyle", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Product> products; // 해당 라이프스타일과 연돤 된 상품의 엔티티들

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)

}
