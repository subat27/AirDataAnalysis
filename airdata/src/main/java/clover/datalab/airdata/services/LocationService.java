package clover.datalab.airdata.services;

import java.util.Map;

import clover.datalab.airdata.entities.Location;
import clover.datalab.airdata.http.forms.LocationForm;

public interface LocationService {
	void register(LocationForm location, String thumbnail);
	void modify(Location location);
	Location findByLocationId(Long id);
	Map<String, Object> findLocations(int page, int perPage, String search, String sort);
}
