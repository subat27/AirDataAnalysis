package clover.datalab.airdata.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import clover.datalab.airdata.entities.Dust;

@Repository
public interface DustRepository extends JpaRepository<Dust, Long>{

}