package mcs

import java.text.DecimalFormat
import java.text.NumberFormat
/**
 * Created with IntelliJ IDEA.
 * User: Sigma
 * Date: 11/22/12
 * Time: 10:34 AM
 * To change this template use File | Settings | File Templates.
 */
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class UtilsController {
    static String toWeekDate(Date date) {
        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.time = date
        def tmp = c.get(java.util.Calendar.DAY_OF_WEEK)
        def week = c.get(java.util.Calendar.WEEK_OF_YEAR)
        return (week < 10 ? '0' + week.toString() : week) + '' + (tmp == 1 ? 7 : tmp - 1)

        //        int javaDay = (day == 7) ? 1 : (day + 1)
        //        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        //        c.set(java.util.Calendar.YEAR, year.toInteger())

    }


    static String getCurrentWeek() {
        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.time = new Date()
//        def tmp = c.get(java.util.Calendar.DAY_OF_WEEK)
        def week = c.get(java.util.Calendar.WEEK_OF_YEAR)
        return (week < 10 ? '0' + week.toString() : week)

        //        int javaDay = (day == 7) ? 1 : (day + 1)
        //        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        //        c.set(java.util.Calendar.YEAR, year.toInteger())

    }
    static Integer getNextWeek() {
        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.time = new Date()
//        def tmp = c.get(java.util.Calendar.DAY_OF_WEEK)
        def week = c.get(java.util.Calendar.WEEK_OF_YEAR) + 1
        return week

        //        int javaDay = (day == 7) ? 1 : (day + 1)
        //        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        //        c.set(java.util.Calendar.YEAR, year.toInteger())

    }
   static String getCurrentWeekDate() {
        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.time = new Date()
        def tmp = c.get(java.util.Calendar.DAY_OF_WEEK)
        def week = c.get(java.util.Calendar.WEEK_OF_YEAR)
        return (week < 10 ? '0' + week.toString() : week) + '' + (tmp == 1 ? 7 : tmp - 1)

        //        int javaDay = (day == 7) ? 1 : (day + 1)
        //        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        //        c.set(java.util.Calendar.YEAR, year.toInteger())

    }
 static String getNextWeekDate() {
        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.time = new Date() + 1
        def tmp = c.get(java.util.Calendar.DAY_OF_WEEK)
        def week = c.get(java.util.Calendar.WEEK_OF_YEAR)
        return (week < 10 ? '0' + week.toString() : week) + '' + (tmp == 1 ? 7 : tmp - 1)

        //        int javaDay = (day == 7) ? 1 : (day + 1)
        //        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        //        c.set(java.util.Calendar.YEAR, year.toInteger())

    }


    static String fromWeekDate(String weekDate) {

        def year = '20' + weekDate.substring(4, 6)
        //weekDate = weekDate.substring(0, 3)
        int week = Integer.parseInt(weekDate.substring(0, 2))
        int day = Integer.parseInt(weekDate.substring(2, 3))
        if (week == 0 || week > 53 || day < 0 || day > 7) {
            //log.error "Invalid weekDate ranges"
            throw new IOException()
        }

        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
        int javaDay = (day == 7) ? 1 : (day + 1)
        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        c.set(java.util.Calendar.YEAR, year.toInteger())
        //return Date.parse("yyyy-M-d", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE))
        return c.get(Calendar.DATE) + '.' + (c.get(Calendar.MONTH) + 1) + '.' + c.get(Calendar.YEAR)

    }

    static Date fromWeekDateAsDate(String weekDate) {

        def year = '20' + weekDate.substring(4, 6)
        def time = weekDate.substring(7)
        //        weekDate = weekDate.substring(0, 3)
        int week = Integer.parseInt(weekDate.substring(0, 2))
        int day = Integer.parseInt(weekDate.substring(2, 3))
        if (week == 0 || week > 53 || day < 0 || day > 7) {
         //   log.warn "Invalid weekDate ranges"
            throw new IOException()
        }

        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
        int javaDay = (day == 7) ? 1 : (day + 1)
        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        c.set(java.util.Calendar.YEAR, year.toInteger())
        return Date.parse("yyyy-MM-dd HH:mm", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time)
        //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)

    }

    static Date fromWeekDateAsDateGeneral(String weekDate) {

        def year = '2012'
        if (weekDate.length() == 6)
            year = '20' + weekDate.substring(4)
        def time = ' 00:00'
        if (weekDate.length() > 6)
            time = weekDate.substring(7,9) + ':' + weekDate.substring(9)
        //        weekDate = weekDate.substring(0, 3)
        int week = Integer.parseInt(weekDate.substring(0, 2))
        int day = Integer.parseInt(weekDate.substring(2, 3))
        if (week == 0 || week > 53 || day < 0 || day > 7) {
        //    log.warn "Invalid weekDate ranges"
            throw new IOException()
        }

        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
        int javaDay = (day == 7) ? 1 : (day + 1)
        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        c.set(java.util.Calendar.YEAR, year.toInteger())

        Date.parse("yyyy-MM-dd HH:mm", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time)
        //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)

    }


    static Date fromWeekDateAsDateTime(String weekDate) {

        def year = '2012'// + weekDate.substring(4, 6)
        def time = weekDate.substring(4)
        //        weekDate = weekDate.substring(0, 3)
        int week = Integer.parseInt(weekDate.substring(0, 2))
        int day = Integer.parseInt(weekDate.substring(2, 3))
        if (week == 0 || week > 53 || day < 0 || day > 7) {
        //    log.warn "Invalid weekDate ranges"
            throw new IOException()
        }

        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
        int javaDay = (day == 7) ? 1 : (day + 1)
        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
        c.set(java.util.Calendar.YEAR, year.toInteger())
        return Date.parse("yyyy-MM-dd HH:mm", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time + ':00')
        //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)

    }


}
