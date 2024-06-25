package clover.datalab.airdata.repositories;

import clover.datalab.airdata.entities.Dust;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DustRepository extends JpaRepository<Dust, Long> {
}