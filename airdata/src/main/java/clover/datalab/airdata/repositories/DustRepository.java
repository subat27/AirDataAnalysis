package clover.datalab.airdata.repositories;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import clover.datalab.airdata.entities.Dust;

@Repository
public interface DustRepository extends JpaRepository<Dust, Long>{
    
    // 시간별로 최신 데이터를 가져오는 쿼리 메서드
	Dust findTopByDataTimeBeforeOrderByDataTimeDesc(LocalDateTime currentDateTime);
	
    @Query("SELECT d.sidoName, AVG(CASE WHEN d.pm10Value <> '-' THEN CAST(d.pm10Value AS double) ELSE NULL END), AVG(CASE WHEN d.pm25Value <> '-' THEN CAST(d.pm25Value AS double) ELSE NULL END) FROM Dust d GROUP BY d.sidoName")
    List<Object[]> findAveragePmValuesBySido();	
    @Query("SELECT d.sidoName, AVG(CASE WHEN d.pm10Value <> '-' THEN CAST(d.pm10Value AS double) ELSE NULL END), AVG(CASE WHEN d.pm25Value <> '-' THEN CAST(d.pm25Value AS double) ELSE NULL END) FROM Dust d GROUP BY d.sidoName")
	List<Object[]> getAvgPmValuesBySido();	
	
}

