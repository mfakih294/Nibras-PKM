package nibras

import groovy.sql.Sql

class SchedulerJob {

    def dataSource

    static triggers = {
        simple name: 'simpleTrigger', startDelay: 1000, repeatInterval: 60 * 60 * 1000//, repeatCount: 10
//        cron name:   'cronTrigger',   startDelay: 10000, cronExpression: '30 27 * * * ?'
    }
//    Seconds
//    Minutes
//    Hours
//    Day-of-Month
//    Month
//    Day-of-Week
//    Year (optional field)



    def execute() {
        // execute job


        def db = new Sql(dataSource)
        def date = new Date()?.format('ddMMyyyyHHmmss')
        def query = "BACKUP TO 'db-backup-" + new Date()?.format('ddMMyyyyHHmmss') +".zip'"
        def result = db.execute(query)
      //  result
        println "Job run!"
    }
}
