package clover.datalab.airdata.entities;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "locations")
public class Location {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;			// 고유번호(ID, 자동생성)

    @Column(nullable = false, unique = true)
    private String name;		// 장소명

    @Column(nullable = false)
    private String address;		// 위치

    @Column(nullable = true)
    private String tags;		// 태그
    
    @Column(nullable = false)
    private String category; // 카테고리명(일반 한글 형태의 문자열)

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)
}
