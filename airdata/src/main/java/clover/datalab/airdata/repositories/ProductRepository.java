package clover.datalab.airdata.repositories;

import clover.datalab.airdata.entities.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    Page<Product> findAllByOrderByIdDesc(Pageable pageable);
    Page<Product> findAllBySubjectContainsOrderByIdDesc(String subject, Pageable pageable);
    Page<Product> findAllByContentContainsOrderByIdDesc(String content, Pageable pageable);

    List<Product> findTop10ByLifestyle_IdOrderByIdDesc(Long lifestyle);

    @Query(value = "SELECT p.*, " +
                   "       (SELECT COUNT(*) " +
                   "        FROM (SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(p.tags, ',', numbers.n), ',', -1) AS value " +
                   "              FROM (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL " +
                   "                           SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) numbers " +
                   "              WHERE CHAR_LENGTH(p.tags) - CHAR_LENGTH(REPLACE(p.tags, ',', '')) >= numbers.n - 1) " +
                   "        AS temp WHERE temp.value IN (:searchList)) AS match_count " +
                   "FROM products p " +
                   "ORDER BY match_count DESC",
            nativeQuery = true)
    List<Product> sortRecommendTags(@Param("searchList") List<String> searchList);

}