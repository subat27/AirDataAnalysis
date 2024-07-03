package clover.datalab.airdata.configurations;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import clover.datalab.airdata.service.DataInsertService;

@Configuration
@EnableScheduling
public class SchedulingConfiguration {

    @Autowired
    private DataInsertService dataInsertService;

    @Scheduled(fixedRate = 1 * 60 * 1000) // 1분마다 실행(실시간 데이터 저장)
    public void insertScheduledData() {
        dataInsertService.insertData();
    }

    @Scheduled(fixedRate = 1 * 60 * 1000) // 1분마다 실행(지난 데이터 삭제)
    public void deleteScheduledData() {
        dataInsertService.cleanupOldData();
    }
}