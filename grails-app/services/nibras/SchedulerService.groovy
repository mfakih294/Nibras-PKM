package nibras

import groovy.transform.CompileStatic
import groovy.util.logging.Slf4j
import org.springframework.scheduling.annotation.Scheduled

import java.text.SimpleDateFormat

//@Slf4j
//@CompileStatic
class SchedulerService {

    boolean lazyInit = false

    @Scheduled(fixedDelay = 400000000L)
    void executeEveryTen() {
   //     log.error "Simple Job every 4 seconds :{}", new SimpleDateFormat("dd/M/yyyy hh:mm:ss").format(new Date())
    //    log.info "Simple Job every 4 seconds :{}", new SimpleDateFormat("dd/M/yyyy hh:mm:ss").format(new Date())
//        println " println Simple Job every 4444444444444444444444444 seconds :{}"
    }

    @Scheduled(fixedDelay = 450000000L, initialDelay = 5000L)
    void executeEveryFourtyFive() {
   //     log.warn  " println Simple Job every 45 seconds :{}", new SimpleDateFormat("dd/M/yyyy hh:mm:ss").format(new Date())
//        println  " println Simple Job every 45 seconds :{}"
    }


    @Scheduled(cron = "0 1 1 1/1 * ?")
    void execute() {
  //      log.error  " println once a day at 09:5 AM"
//        println  " println once a day at 09:5 AM"
    }
}
	
