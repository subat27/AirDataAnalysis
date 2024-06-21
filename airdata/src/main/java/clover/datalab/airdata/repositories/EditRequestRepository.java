package clover.datalab.airdata.repositories;

import clover.datalab.airdata.entities.EditRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EditRequestRepository extends JpaRepository<EditRequest, Long> {
}