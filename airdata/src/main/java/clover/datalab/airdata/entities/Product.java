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
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 고유번호(ID, 자동생성)

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id")
    private Lifestyle lifestyle; // 해당되는 라이프스타일 엔티티

    @Column(nullable = false)
    private String subject; // 상품명

    @Column(nullable = false, columnDefinition = "text")
    private String content; // 내용(에디터로 작성된 HTML 형태의 내용)

    @Column(nullable = false)
    private int price; // 상품 가격

    @Column(nullable = false)
    private String tags; // 해시태그(여러 개인 경우 콤마로 구분)

    @Column(nullable = false)
    private String thumbnail; // 메인 섬네일 이미지(파일 경로, AWS S3이용예정)

    @Column(nullable = false)
    private String category; // 카테고리명(일반 한글 형태의 문자열)

    @Column(nullable = false)
    private String link; // 구매 링크

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)

}
