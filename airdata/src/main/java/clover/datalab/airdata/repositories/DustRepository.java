package clover.datalab.airdata.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import clover.datalab.airdata.entities.Dust;


@Repository
public interface DustRepository extends JpaRepository<Dust, Long>{
    
	@Query("SELECT d.sidoName, AVG(CASE WHEN d.pm10Value <> '-' AND CAST(d.pm10Value AS double) <= 500 THEN CAST(d.pm10Value AS double) ELSE NULL END), " +
		   "AVG(CASE WHEN d.pm25Value <> '-' AND CAST(d.pm25Value AS double) <= 500 THEN CAST(d.pm25Value AS double) ELSE NULL END) " +
		   "FROM Dust d GROUP BY d.sidoName")
		List<Object[]> getAvgPmValuesBySido();
	
    @Modifying
    @Transactional
    @Query("delete from Dust d where d.timestamp < :timestamp")
    void deleteByTimestampBefore(@Param("timestamp") Date timestamp);
	
}

