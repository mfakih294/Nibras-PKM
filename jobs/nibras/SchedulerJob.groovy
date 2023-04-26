package nibras

import groovy.sql.Sql
import grails.util.Environment


class SchedulerJob {

    def dataSource

    static triggers = {
//        simple name: 'simpleTrigger', startDelay: 1000, repeatInterval: 60 * 60 * 1000//, repeatCount: 10
        cron name:   'cronTrigger4', cronExpression: '0 0 8,10,12 * * ?'
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

//        println ' in env: '  + Environment.current.name + ' at ' + new Date()?.format('dd.MM.yyyy HH:mm:ss')
//        def environment
        switch (Environment.current.name) {
            case 'dev':
                println "Job run in dev env!"
                break
            case 'production':
            //    println "Job run in prod env!"
                break
            case 'h2':
                def db = new Sql(dataSource)
                def date = new Date()?.format('ddMMyyyyHHmmss')
                def query = "BACKUP TO 'db-backup-" + new Date()?.format('EE_HH') +".zip'" //ddMMyyyyHHmmss
                def result = db.execute(query)
                //  result
             //   println "Job run in h2 env!"
                break
        }

    }
}
