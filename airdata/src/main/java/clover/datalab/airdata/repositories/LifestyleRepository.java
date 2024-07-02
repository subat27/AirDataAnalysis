package clover.datalab.airdata.repositories;

import clover.datalab.airdata.entities.Lifestyle;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LifestyleRepository extends JpaRepository<Lifestyle, Long> {

    @Query(value = "SELECT e.*, " +
                   "       (SELECT COUNT(*) " +
                   "        FROM (SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(e.tags, ',', numbers.n), ',', -1) AS value " +
                   "              FROM (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL " +
                   "                           SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) numbers " +
                   "              WHERE CHAR_LENGTH(e.tags) - CHAR_LENGTH(REPLACE(e.tags, ',', '')) >= numbers.n - 1) " +
                   "        AS temp WHERE temp.value IN (:searchList)) AS match_count " +
                   "FROM lifestyles e " +
                   "ORDER BY match_count DESC",
            nativeQuery = true)
    Page<Lifestyle> sortRecommendTags(@Param("searchList") List<String> searchList, Pageable pageable);
    
    Page<Lifestyle> findByCategoryContaining(String category, Pageable pageable);

}