package clover.datalab.airdata.services;

import java.util.Map;

import clover.datalab.airdata.entities.Location;

public interface LocationService {
	void register(Location location);
	void modify(Location location);
	Location findByLocationId(Long id);
	Map<String, Object> findLocations(int page, int perPage, String search, String sort);
}
