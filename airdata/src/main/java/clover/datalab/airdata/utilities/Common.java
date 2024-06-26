package clover.datalab.airdata.utilities;

import org.springframework.data.domain.Page;

import java.util.HashMap;
import java.util.Map;

public class Common {

    public static Map<String, Object> paginate(int currentPage, Page<?> items, String search, String type, String sort) {
        int totalPages = items.getTotalPages();
        int start = Math.max(1, currentPage / 10 * 10 + 1);
        int end = Math.min(start + 9, totalPages);

        Map<String, Object> paginatePosition = new HashMap<>();
        paginatePosition.put("items", items);
        paginatePosition.put("currentPage", currentPage);
        paginatePosition.put("totalPages", totalPages);
        paginatePosition.put("start", start);
        paginatePosition.put("end", end);
        paginatePosition.put("search", search);
        paginatePosition.put("type", type);
        paginatePosition.put("sort", sort);

        return paginatePosition;
    }

}
