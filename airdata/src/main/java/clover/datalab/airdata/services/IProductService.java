package clover.datalab.airdata.services;

import clover.datalab.airdata.entities.Lifestyle;
import clover.datalab.airdata.entities.Product;
import clover.datalab.airdata.http.forms.ProductForm;
import clover.datalab.airdata.repositories.ProductRepository;
import clover.datalab.airdata.utilities.Common;
import lombok.RequiredArgsConstructor;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class IProductService implements ProductService {

	private final ProductRepository repository;
	
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void register(ProductForm form, Lifestyle lifestyle, String thumbnail) {
    	repository.save(
    		Product.builder().subject(form.getSubject())
			    			 .content(form.getContent())
			    			 .price(form.getPrice())
			    			 .tags(form.getTags())
			    			 .thumbnail(thumbnail)
			    			 .category(form.getCategory())
			    			 .link(form.getLink())
			    			 .lifestyle(lifestyle)
			    			 .build()
    	);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(ProductForm form, Lifestyle lifestyle, Long id, String thumbnail) throws Exception {
    	Product product = currentItem(id);
    	String image = product.getThumbnail();
    	
    	if (!thumbnail.isBlank()) {
    		image = thumbnail;
    	}
    	
    	product.setSubject(form.getSubject());
    	product.setContent(form.getContent());
    	product.setCategory(form.getCategory());
    	product.setThumbnail(image);
    	product.setPrice(form.getPrice());
    	product.setTags(form.getTags()); 
    	product.setLink(form.getLink());
    
    	repository.save(product);
    }

    @Override
    public void delete(Long id) {
    	if (repository.existsById(id)) {
    		repository.deleteById(id);    	
    	}
    }

    @Override
    public Product currentItem(Long id) throws Exception {
        return repository.findById(id).orElseThrow(() -> new Exception("데이터가 없습니다."));
    }

    @Override
    public Map<String, Object> paginatedItem(int page, int perPage, String searchType, String searchWord) {
    	Pageable pageable = PageRequest.of((page - 1), perPage);
    	
    	Page<Product> items = switch(searchType) {
    		case "subject" -> repository.findAllBySubjectContainsOrderByIdDesc(searchWord, pageable);
    		case "content" -> repository.findAllByContentContainsOrderByIdDesc(searchWord, pageable);
    		default -> repository.findAllByOrderByIdDesc(pageable);
    	};
    	
        return Common.paginate(page, items, searchWord, searchType, "");
    }

}
