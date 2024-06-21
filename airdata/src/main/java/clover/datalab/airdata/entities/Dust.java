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
@Table(name = "dusts")
public class Dust {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 고유번호(ID, 자동생성)

    @Column(nullable = false, name = "sido_name")
    private String sidoName; // 시도명

    @Column(nullable = false, name = "data_time")
    private String dataTime; // 측정일시

    @Column(nullable = false, name = "station_name")
    private String stationName; // 측정소명

    @Column(nullable = false, name = "station_code")
    private String stationCode; // 측정소 코드

    @Column(nullable = false, name = "mang_name")
    private String mangName; // 측정망 정보

    @Column(nullable = false, name = "pm10_value")
    private String pm10Value; // 미세먼지 농도

    @Column(nullable = false, name = "pm25_value")
    private String pm25Value; // 초미세먼지 농도

    @Column(nullable = false, name = "pm10_grade")
    private String pm10Grade; // 미세먼지 등급

    @Column(nullable = false, name = "pm25_grade")
    private String pm25Grade; // 초미세먼지 등급

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)

}
