package clover.datalab.airdata.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import clover.datalab.airdata.entities.Location;

@Repository
public interface LocationRepository extends JpaRepository<Location, Long>{

}