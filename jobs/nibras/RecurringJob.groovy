package nibras

//import groovy.sql.Sql
import grails.util.Environment


class RecurringJob {

    def supportService

    static triggers = {

        simple name: 'simpleTrigger2', startDelay: 10000, repeatInterval: 5 * 60 * 1000//, repeatCount: 10
//        cron name:   'cronTrigger2', cronExpression: '0 0/5 * * * ?'
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

        println 'Updating bookmarked files count in env: '  + Environment.current.name + ' at ' + new Date()?.format('dd.MM.yyyy HH:mm:ss')
//        def environment
        supportService.updateBookmarkedRecordsFileCount()
    }
}
