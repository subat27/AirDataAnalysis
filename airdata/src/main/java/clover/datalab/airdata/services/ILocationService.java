package clover.datalab.airdata.services;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import clover.datalab.airdata.entities.Location;
import clover.datalab.airdata.repositories.LocationRepository;
import clover.datalab.airdata.utilities.Common;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ILocationService implements LocationService {

	private final LocationRepository repository;
	
	@Override
	public void register(Location location) {
		repository.save(location);
	}

	@Override
	public void modify(Location location) {
		Location orgLocation = repository.findById(location.getId()).get();
		
		orgLocation.setName(location.getName());
		orgLocation.setAddress(location.getAddress());
		orgLocation.setTags(location.getTags());
		orgLocation.setCategory(location.getCategory());
		orgLocation.setThumbnail(location.getThumbnail());
		
		repository.save(orgLocation);
	}
	
	@Override
	public Location findByLocationId(Long id) {
		return repository.findById(id).get();
	}

	@Override
	public Map<String, Object> findLocations(int page, int perPage, String search, String sort) {
		Pageable pageable = PageRequest.of(page-1, perPage, Sort.by(Sort.Direction.DESC, sort));
		Page<Location> locations = repository.findAll(pageable);
		return Common.paginate(page, locations, search, search, sort);
	}

}
