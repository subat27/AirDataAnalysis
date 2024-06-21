package clover.datalab.airdata.repositories;

import clover.datalab.airdata.entities.Lifestyle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LifestyleRepository extends JpaRepository<Lifestyle, Long> {
}