package clover.datalab.airdata.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "dusts")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Dust {
	
    public LocalDateTime getDataTime() {
        return this.dataTime;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 고유번호(ID, 자동생성)

    @Column(nullable = true, name = "sido_name")
    private String sidoName; // 시도명

    @Column(nullable = true, name = "data_time")
    private LocalDateTime dataTime; // 측정일시

    @Column(nullable = true, name = "station_name")
    private String stationName; // 측정소명

    @Column(nullable = true, name = "station_code")
    private String stationCode; // 측정소 코드

    @Column(nullable = true, name = "mang_name")
    private String mangName; // 측정망 정보

    @Column(nullable = true, name = "pm10_value")
    private String pm10Value; // 미세먼지 농도

    @Column(nullable = true, name = "pm25_value")
    private String pm25Value; // 초미세먼지 농도
    
    @Column(nullable = true, name = "pm10_grade")
    private String pm10Grade1h; // 미세먼지 등급

    @Column(nullable = true, name = "pm25_grade")
    private String pm25Grade1h; // 초미세먼지 등급
    
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime created; // 등록일자 (자동생성)

    @UpdateTimestamp
    private LocalDateTime updated; // 수정일자 (자동생성)

}
