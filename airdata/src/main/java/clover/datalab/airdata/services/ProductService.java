package clover.datalab.airdata.services;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.entities.Product;
import clover.datalab.airdata.http.forms.ProductForm;

import java.util.Map;

public interface ProductService {

    void register(ProductForm form, Lifestyle lifestyle, String thumbnail);
    void update(ProductForm form, Lifestyle lifestyle, Long id, String thumbnail) throws Exception;
    void delete(Long id);

    Product currentItem(Long id) throws Exception;

    Map<String, Object> paginatedItem(int page, int perPage, String searchType, String searchWord);

}
