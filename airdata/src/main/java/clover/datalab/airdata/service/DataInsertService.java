package clover.datalab.airdata.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import clover.datalab.airdata.repositories.DustRepository;


@Service
public class DataInsertService {

    @Autowired
    private ApiService apiService;

    @Autowired
    private DustService dService;
    
    @Autowired
    private DustRepository dRepository;

    public void insertData() {
        try {
        	System.out.println("실시간 미세먼지 데이터 저장");
            dService.insertItems(apiService.getDustData());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Transactional
    public void cleanupOldData() {
        // 현재 시간에서 10분 전의 시간을 계산
        Date oneHourAgo = new Date(System.currentTimeMillis() - 10 * 60 * 1000);

        // 한 시간 이전의 데이터를 삭제하는 쿼리 실행
        dRepository.deleteByTimestampBefore(oneHourAgo);

        System.out.println("10분 이전 데이터 삭제 완료: " + new Date());
    }
    
}