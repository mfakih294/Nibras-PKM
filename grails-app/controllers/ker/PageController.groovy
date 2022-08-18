/*
 * Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */


package ker

import grails.util.Environment
import mcs.Book
import grails.web.JSONBuilder

//import org.eclipse.mylyn.wikitext.core.parser.MarkupParser
//import org.eclipse.mylyn.wikitext.markdown.core.MarkdownLanguage


import grails.plugin.springsecurity.annotation.Secured
import newpackage.PrayTime

import java.time.Duration
import java.time.Instant

import com.vladsch.flexmark.util.ast.Node;
import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.ParserEmulationProfile;
import com.vladsch.flexmark.ext.gfm.strikethrough.StrikethroughExtension;
import com.vladsch.flexmark.ext.toc.TocExtension;
import com.vladsch.flexmark.ext.typographic.TypographicExtension;

import com.vladsch.flexmark.ext.emoji.EmojiExtension;
import com.vladsch.flexmark.ext.emoji.EmojiImageType;
import com.vladsch.flexmark.ext.emoji.EmojiShortcutType;
import com.vladsch.flexmark.ext.definition.DefinitionExtension;
import com.vladsch.flexmark.ext.emoji.EmojiExtension;
import com.vladsch.flexmark.ext.footnotes.FootnoteExtension;
import com.vladsch.flexmark.ext.gfm.strikethrough.StrikethroughSubscriptExtension;
import com.vladsch.flexmark.ext.ins.InsExtension;
import com.vladsch.flexmark.ext.superscript.SuperscriptExtension;
import com.vladsch.flexmark.ext.tables.TablesExtension;
import com.vladsch.flexmark.ext.gfm.tasklist.TaskListExtension;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.util.data.MutableDataSet;

//import java.io.StringWriter;
//import org.eclipse.mylyn.wikitext.core.parser.MarkupParser;
//import org.eclipse.mylyn.wikitext.core.parser.builder.HtmlDocumentBuilder;
//import org.eclipse.mylyn.wikitext.core.parser.markup.MarkupLanguage;
//import org.eclipse.mylyn.wikitext.markdown.core.MarkdownLanguage;

@Secured(['ROLE_ADMIN','ROLE_READER'])
class PageController {

    static entityMapping = [
            'G'  : 'mcs.Goal',
            'T'  : 'mcs.Task',
            'P'  : 'mcs.Planner',

            'W'  : 'mcs.Writing',
            'N'  : 'app.IndexCard',

            'J'  : 'mcs.Journal',
            'I'  : 'app.IndicatorData',
            'K'  : 'app.Indicator',

            'Q'  : 'app.Payment',
            'L'  : 'app.PaymentCategory',

            'R'  : 'mcs.Book',
            'C'  : 'mcs.Course',
            'D'  : 'mcs.Department',
            'E'  : 'mcs.Excerpt',
            'S'  : 'app.Contact',
            'Tag': 'app.Tag',

            'O'            : 'mcs.Operation',

            'Y'  : 'cmn.Setting',
            'X'  : 'mcs.parameters.SavedSearch'
    ]

    static allClasses = [mcs.Task, mcs.Goal, mcs.Writing, app.IndexCard,
                         app.Payment, app.IndicatorData,
                         mcs.Journal, mcs.Planner, mcs.Book]

    static allClassesWithCourses = allClasses -
            [mcs.Excerpt, mcs.Course,
             app.IndicatorData, app.Payment, app.PaymentCategory, app.Indicator, mcs.parameters.SavedSearch]

    static recentClasses = [mcs.Goal, mcs.Task, mcs.Planner, mcs.Journal, mcs.Writing, app.IndexCard,
                            mcs.Book]


    def legacyAdd() {
        render(template: '/layouts/legacyAdd')
    }

    def help() {
        render(template: '/page/help')
    }
// def main2() {
//        render(view: '/page/main2')
//    }


    def springSecurityService

    def supportService

    def appMain() {


//
//        ['IPs.show',                    'add-import-panel.enabled',                    'advanced-panel.enabled',                    'calendar.enabled',                    'commandbar.enabled',                    'copyright.show',                    'course.enabled',                    'extra-panes.enabled',                    'notes.enabled',                    'open-record-folders.enabled',                    'quick-add-form.enabled',                    'review.enabled',                    'rss.enabled',                    'scans.enabled',                    'selection-actions.enabled',                    'tasks.enabled',                    'today-report.enabled',
//         'convert-records.enabled',
//         'bibTex.enabled',
//
//         'upload-cover.enabled',                    'upload-files.enabled',                    'department.enabled'].each() {
//            new cmn.Setting([name: it, value: 'yes', allowedValue: 'yes,no']).save(flush: true)
//        }


        def types = []

        [
                [id: 'T', name: 'Task', code: 'tasks'],
                [id: 'G', name: 'Goal', code: 'goals'],
                [id: 'N', name: 'Note', code: 'notes'],
                [id: 'W', name: 'Writing', code: 'writings'],
                [id: 'J', name: 'Journal', code: 'journal'],
//                [id: 'Jt', name: 'Yesterday journal', code: 'journal'],
                [id: 'R', name: 'Resource', code: 'resources']
        ].each(){
            if (OperationController.getPath(it.code + '.enabled') == 'yes')
                types += it
        }


        if (cmn.Setting.count() == 0) {
            def r
            [
                    ['mcs.parameters.GoalType', 'Done', 'done'],
                    ['mcs.parameters.Context', 'Home', 'home'],
                    ['mcs.parameters.Context', 'work', 'Work'],
                    ['mcs.parameters.WorkStatus', 'Done', 'done'],
                    ['mcs.parameters.WorkStatus', 'Dismissed', 'dismissed'],
                    ['mcs.parameters.PlannerType', 'Assign', 'assign'],
                    ['mcs.parameters.JournalType', 'Event', 'event'],
                    ['mcs.parameters.JournalType', 'Summary', 'summary'],
                    ['mcs.parameters.ResourceStatus', 'Read', 'read'],
                    ['mcs.parameters.ResourceStatus', 'Core', 'core'],
                    ['app.parameters.ResourceType', 'Various', 'various'],
                    ['app.parameters.ResourceType', 'Audio', 'audio'],
                    ['app.parameters.ResourceType', 'Video', 'video'],
                    ['app.parameters.ResourceType', 'Document', 'doc'],
                    ['app.parameters.ResourceType', 'Article', 'article'],
                    ['app.parameters.ResourceType', 'News', 'nws'],
                    ['app.parameters.ResourceType', 'Book', 'book'],
                    ['mcs.parameters.WritingStatus', 'Revised', 'revised'],
                    ['mcs.parameters.WritingType', 'Unsorted', 'usr'],
                    ['mcs.parameters.WritingType', 'Quotation', 'quote'],
                    ['app.PaymentCategory', 'bill', 'Bill'],
                    ['app.PaymentCategory', 'food', 'Food'],
                    ['app.PaymentCategory', 'cloth', 'cloth'],
                    ['app.PaymentCategory', 'transp', 'Transportation']
            ].each() { d ->
                r = grailsApplication.classLoader.loadClass(d[0]).newInstance()
                r.name = d[1]
                r.code = d[2]
                r.save(flush: true)
            }


            [
                    ['app.parameters.CommandPrefix', 'Add goals (one per line)', ''],
                    ['app.parameters.CommandPrefix', 'Add tasks (one per line) a t -- ', ''],
                    ['app.parameters.CommandPrefix', 'Add tasks (one per line) a t -- ', ''],
                    ['app.parameters.CommandPrefix', 'Command', 'a j #summary  (?date -- ']
            ].each() { d ->
                new app.parameters.CommandPrefix([summary: d[1], description: d[2], multiLine: true]).save(flush: true)
            }




            def s
            [
                    ['All journal', 'J', 'Jcal', 'from Journal t where id > 0', 'select count(*) from Journal', 1],
                    ['All plans', 'P', 'Pcal', 'from Planner t where id > 0', 'select count(*) from Planner', 1],
//                    ['All tasks with due dates', 'T', 'Tcal', 'from Task t where endDate is not null', 'select count(*) from Task t where endDate is not null', 1],
                    ['All tasks', 'T', 'Tall', 'from Task t where id > 0', 'select count(*) from Task t', 0],
                    ['All notes', 'N', 'Nall', 'from IndexCard t where id > 0', 'select count(*) from IndexCard t', 0],
                    ['All resources', 'R', 'Rall', 'from Book t where id > 0', 'select count(*) from Book t', 0],
                    ['All department', 'D', 'Dall', 'from Department t where id > 0', 'select count(*) from Department t', 0],
                    ['All courses', 'C', 'Call', 'from Course t where id > 0', 'select count(*) from Course t', 0]
            ].each() { d ->
                s = new mcs.parameters.SavedSearch()
                s.entity = d[1]
                s.summary = d[0]
                s.query = d[3]
                s.countQuery = d[4]
                s.queryType = 'hql'

                if (d[5] == 1)
                    s.calendarEnabled = true

                s.save(flush: true)
            }




            [                    
				["IPs.show","yes"],
				["accordion.east.default.panel","1"],
				["accordion.west.default.panel","0"],
				["add-import-panel.enabled","yes"],
				["advanced-panel.enabled","no"],
				["app.name","Nibras"],
				['app.URL', 'http://localhost:1441/nibras'],
				["bibTex.enabled","no"],
				["calendar.enabled","yes"],
				["calendar.reload.interval","60"],
				["commandBar.enabled","no"],
				["contacts.enabled","yes"],
				["convert-records.enabled","no"],
				["copyright.show","yes"],
				["course.enabled","yes"],
				["coursePanel.enabled","yes"],
				["courses.enabled","yes"],
				["coursesPanel.enabled","yes"],
				["dashboard.enabled","no"],
				["date.format","dd.MM.yyyy"],
				["datetime.format","dd.MM.yyyy_HHmm"],
				["default.ResourceStatus.done","read"],
				["default.WorkStatus.done","done"],
				["default.WritingStatus.done","revised"],
				["default.language","en"],
				["department.enabled","yes"],
				["description.style","padding:3px;font-size:20px;font-family:'TraditionalArabic',tahoma;margin:5px;line-height:25px;text-align:justify;color:black;"],
				["description.summarize.threshold","180"],
				["description.summarize.thresholdMax","180"],
				["enable.fullCalendar","yes"],
				["enable.kanban","yes"],
				["excerpts.enabled","no"],
				["explorer.path.linux","/usr/bin/nemo"],
				["explorer.path.win","./scripts/open-explorer.bat"],
				["extra-panes.enabled","yes"],
				["fullCalendar.enabled","yes"],
				["goals.enabled","no"],
				["import.enabled","yes"],
				["indicators.enabled","no"],
				["journal.enabled","yes"],
				["notes.enabled","yes"],
				["open-record-folders.enabled","yes"],
				["payments.enabled","no"],
				["planner.enabled","no"],
				["planner.homepage.default-type","knb"],
				["quick-add-form.enabled","yes"],
				["rangeCalendar.enabled","yes"],
				["recordPage.text.style","color:black;padding:30px;font-size:17px!important;font-family:'Lato,Georgia,serif';font-weight:normal;margin:60px;line-height:1.9;max-width:700px;text-align:justify;"],
				["repository.languages","ar,fr,en"],
				["repository.languages.LTR","fr,en"],
				["repository.languages.RTL","ar"],
				["resources.enabled","yes"],
				["review.enabled","no"],
				["root.rps1.path","./repo1/"],
				["root.rps2.path","./repo2/"],
				["rss.enabled","yes"],
				["scans.enabled","no"],
				["selection-actions.enabled","no"],
				["summary.summarize.threshold","160"],
				["tasks.enabled","yes"],
				["tmp.path","./tmp"],
				["today-report.enabled","no"],
				["updateResultSet.max-items","100"],
				["upload-cover.enabled","no"],
				["upload-files.enabled","yes"],
				["writings.enabled","no"]
            ].each() {
                new cmn.Setting([name: it[0], value: it[1]]).save(flush: true)
            }

        }
//        def environment
//        switch (Environment.current) {
//            case Environment.PRODUCTION:
//                environment = 'prod'
//                break
//            case Environment.DEVELOPMENT:
//                environment = 'dev'
//                break
//        }
//
//        environment = Environment.current.name

//        def wrtCount = 0
//        mcs.Writing.findAllByIsLatex(true).each() {
//            wrtCount += it.description?.count(' ') ?: 0 //length() ?: 0
//        }

        def recentRecords = []
        recentClasses.each() {
//            recentRecords += it.findAllByDateCreatedGreaterThanAndDeletedOnIsNull(new Date() - 2, [sort: 'dateCreated', order: 'desc', max: 1])?.reverse()
            recentRecords += it.findAll([sort: 'dateCreated', order: 'desc', max: 1])?.reverse()
        }

//        def filledInDates = ''
//        Journal.executeQuery("select  DATE_FORMAT(startDate, '%c/%e/%Y') from Journal group by date(startDate) order by startDate asc").each() {
//            filledInDates += it + ' '
//        }

//        session['log'] = 1
        session['J'] = 1
        session['P'] = 1

        session['showLine1Only'] = 'on'
        session['showFullCard'] = 'off'

//        MarkupParser markupParser = new MarkupParser();
//        markupParser.setMarkupLanguage(new MarkdownLanguage());
//        String htmlContent = markupParser.parseToHtml(text);

        def r = ''
   //     def c = 0
//        def f = ker.OperationController.getPath('editBox.path')
//        if (f) {
//            new File(f)?.listFiles().each(){
//                if (it.isFile() && it.name?.endsWith('.md'))
//                    c++
////                if (it.isDirectory() && it.name.length() > 1)
////                    c++
//            }
//        }

        def resources =
                Book.executeQuery('from Book r where r.course.bookmarked = ? ' +
//                        in ' +
//                        '(select course from Planner p where p.startDate < current_date and p.endDate > current_date and p.course is not null)' +
                        ' and r.priority >= ? and r.readOn is not null' +
                        ' and (r.lastReviewed < ? or r.lastReviewed is null) and r.reviewCount < ?' +
                        ' order by r.orderNumber asc, r.reviewCount asc',
                        [true, 3, new Date() + 7, 5])
        def excerpts =
                Book.executeQuery('from Excerpt r where r.book.course.bookmarked = ? ' +
//                ' in' +
//                ' (select course from Planner p where p.startDate < current_date and p.endDate > current_date and p.course is not null)' +
                        ' and r.priority >= ? and r.readOn is not null' +
                        ' and (r.lastReviewed < ? or r.lastReviewed is null) and r.reviewCount < ?' +
                        ' order by r.orderNumber asc, r.reviewCount asc',
                        [true, 3, new Date() + 7, 5])

//        println 'r ' + resources
//        println 'e ' + excerpts

        def ips = []
        def ip
        def interf

        def interfaces = NetworkInterface.getNetworkInterfaces()

        while (interfaces.hasMoreElements()) {

            interf = interfaces.nextElement()
            def addresses = interf.getInetAddresses()

            while (addresses.hasMoreElements()) {
                ip = addresses.nextElement().getHostAddress().toString()
                if (ip && ip != '' && !ip.contains(':') && !ip.startsWith('127'))
                    ips.add([name: interf.getName(), title: interf.getDisplayName(), ip: ip]) //?.split(/\(/)[0]
//                println (addresses.nextElement().getCanonicalHostName())
//                println (addresses.nextElement().hostAddress)
            }
        }



        def datesHb = [:]
        for (c in [[mcs.Goal, 'Goal'], [mcs.Task, 'Task'],
//                [mcs.Book, 'Resource'],
                   [mcs.Planner, 'Plan'],
                   [mcs.Journal, 'Journal'], [app.IndexCard, 'Note']]) {
            for (t in c[0].findAllByDateCreatedGreaterThan(new Date() - 90, [sort: 'dateCreated', order: 'asc'])) {
                def date = t.dateCreated.format('yyyy-MM-dd')
                if (!datesHb[date])
                    datesHb[date] = ['Goal'   : 0,
                                     'Task'   : 0,
//                            'Resource': 0,
                                     'Plan'   : 0,
                                     'Journal': 0,
                                     'Writing': 0,
                                     'Note'   : 0
                    ]

                datesHb[date][c[1]] += 1
            }
        }


        def tasksActiveNotStarted = supportService.getTasksActiveNotStarted()


        def user = springSecurityService.currentUser


//        def rpsSize = '/home/maitham/job/rps1/bin/rps0size.sh'.execute().text
        render(view: '/appMain/main', model: [
                htmlContent      : null,
                ips              : ips,
//                rpsSize              : rpsSize,
                selectBasketCount: GenericsController.selectedRecords.size(),
                editFileCount    : 0, // todo: fix
                dates: datesHb,
                username         : user.username,
                reviewPileSize   : resources.size() + excerpts.size(),
                types: types,
                tasksActiveNotStarted: tasksActiveNotStarted,
//                environment: environment
                //,
//                filledInDates: filledInDates?.trim(),
                // wrtCount: wrtCount,
                recentRecords: recentRecords?.sort({ it.dateCreated })//.reverse()

        ])
    }

    def appLight() {

        def ips = []
        def ip
        def interf

        def types = []

        [
                [id: 'T', name: 'Task', code: 'tasks'],
                [id: 'P', name: 'Plan', code: 'plans'],
                [id: 'G', name: 'Goal', code: 'goals'],
                [id: 'N', name: 'Note', code: 'notes'],
                [id: 'W', name: 'Writing', code: 'writings'],
                [id: 'J', name: 'Journal', code: 'journal'],
//                [id: 'Jt', name: 'Yesterday journal', code: 'journal'],
                [id: 'R', name: 'Resource', code: 'resources']
        ].each(){
            if (OperationController.getPath(it.code + '.enabled') == 'yes')
                types += it
        }


        def interfaces = NetworkInterface.getNetworkInterfaces()

        while (interfaces.hasMoreElements()) {

            interf = interfaces.nextElement()
            def addresses = interf.getInetAddresses()

            while (addresses.hasMoreElements()) {
                ip = addresses.nextElement().getHostAddress().toString()
                if (ip && ip != '' && !ip.contains(':') && !ip.startsWith('127'))
                    ips.add([name: interf.getName(), title: interf.getDisplayName(), ip: ip])
            }
        }

        def user = springSecurityService.currentUser
        render(view: '/appLight/main', model: [htmlContent: null,
                                               ips        : ips,
                types: types,
                                               username   : user.username
        ])
    }


    def manageUser() {
        render(template: '/page/userInfo', model: [username: springSecurityService.currentUser.username])

    }

    def changePassword() {
        def userInstance = springSecurityService.currentUser
        userInstance.password = params.password//springSecurityService.encodePassword(
        //'12345', userInstance.username)

        if (userInstance.save(flush: true)) {
            render 'Password changed to ' + params.password
        } else render 'problem updating password. '
    }

    def appMihrab() {
        render(view: '/appMihrab/main', model: [
        ])
    }
  def appModern() {
        render(view: '/appModern/main', model: [
        ])
    }

    def appCourse() {
        render(view: '/appCourse/main', model: [record: mcs.Course.get(params.id)
        ])
    }
def appPile() {
        render(view: '/appPile/main', model: [ ])
    }

    def appKanban() {

        def courses = mcs.Book.executeQuery('select p.course from Task p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Goal p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Planner p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Journal p where p.bookmarked = 1')
//                mcs.Book.executeQuery('select p.course from Book p where p.bookmarked = 1 and p.priority >=4')

//        println 'crs +' + courses
        def overdue = supportService.getOverdueTasks()
        def pile = supportService.getTasksPile()
        def todayInProgress = supportService.getTasksTodayInProgress()
        def todayCompleted = supportService.getTasksTodayCompleted()
        def todayNotStarted = supportService.getTasksTodayNotStarted()


        render(view: '/appKanban/main', model: [courses: courses.unique().reverse(),
        overdue: overdue,
        pile: pile,
        inProgress: todayInProgress,
        completed: todayCompleted,
        notStarted: todayNotStarted
        ]) //.sort({i,j -> i.priority.compareTo(j.priority)})

    }

    def appNotes() {

        def recentRecords = []

        allClassesWithCourses.each() {
            recentRecords += it.findAllByDateCreatedLessThanAndDateCreatedGreaterThan(new Date() + 1, new Date() - 2, [sort: 'dateCreated', order: 'desc', max: 1])
            //    recentRecords += it.findAllByLastUpdatedGreaterThan(new Date() - 7, [max: 7])
        }

        recentRecords = recentRecords.sort({ it.dateCreated })//.reverse()
//        //recentRecords.unique()
//        if (recentRecords.size() > 0)
//            render(template: '/gTemplates/recordListing', model: [
//                    title: 'Recent records',
//                    list : recentRecords
//            ])
//        else
//            render(template: '/layouts/message', model: [messageCode: 'help.recent.records.no'])


        def types = []

        [
                [id: 'T', name: 'Task', code: 'tasks'],
                [id: 'P', name: 'Plan', code: 'plans'],
                [id: 'G', name: 'Goal', code: 'goals'],
                [id: 'N', name: 'Note', code: 'notes'],
                [id: 'W', name: 'Writing', code: 'writings'],
                [id: 'J', name: 'Journal', code: 'journal'],
//                 [id: 'Jt', name: 'Yesterday journal', code: 'journal'],
                [id: 'R', name: 'Resource', code: 'resources']
        ].each() {
            if (OperationController.getPath(it.code + '.enabled') == 'yes')
                types += it
        }

        render(view: '/appNote/main', model: [types: types, recentRecords: recentRecords])

    }

 def appDashboard() {

     double latitude = 33.8933182;
     double longitude = 35.5015717;
     double timezone = ker.OperationController.getPath('prayers.timezone') ?ker.OperationController.getPath('prayers.timezone').toInteger(): 3 ;
     // Test Prayer times here
     PrayTime prayers = new newpackage.PrayTime();

     prayers.setTimeFormat(prayers.Time12NS);
     prayers.setCalcMethod(prayers.Jafari);
     prayers.setAsrJuristic(prayers.Shafii);
     prayers.setAdjustHighLats(prayers.AngleBased);
     int[] offsets = [0, 1, 0, 0, 0, 3, 5]; // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
     prayers.tune(offsets);

     Date now = new Date();
     Calendar cal = Calendar.getInstance();
     cal.setTime(now);

     ArrayList<String> prayerTimes = prayers.getPrayerTimes(cal,
             latitude, longitude, timezone);
     ArrayList<String> prayerNames = prayers.getTimeNames();

     def prayersText = ''
//     for (int i = 0; i < prayerTimes.size(); i++) {
         prayersText += (prayerNames.get(0) + ": " + prayerTimes.get(0) + '\n')
         prayersText += (prayerNames.get(1) + ": " + prayerTimes.get(1) + '\n')
         prayersText += (prayerNames.get(2) + ": " + prayerTimes.get(2) + '\n')
         prayersText += (prayerNames.get(3) + ": " + prayerTimes.get(3) + '\n')
         prayersText += (prayerNames.get(4) + ": " + prayerTimes.get(4) + '\n')
         prayersText += (prayerNames.get(5) + ": " + prayerTimes.get(5) + '\n')
//         prayersText += (prayerNames.get(6) + ": " + prayerTimes.get(6) + '\n')
//     }


    render(view: '/appDashboard/main', model: [prayersText: prayersText])

    }



    def appDaftar() {
        render(view: '/appMain/daftar', model: [])
    }

    def appCalendar() {


        double latitude = 33.8933182;
        double longitude = 35.5015717;
        double timezone = ker.OperationController.getPath('prayers.timezone') ?ker.OperationController.getPath('prayers.timezone').toInteger(): 3 ;
        // Test Prayer times here
        PrayTime prayers = new newpackage.PrayTime();

        prayers.setTimeFormat(prayers.Time12NS);
        prayers.setCalcMethod(prayers.Jafari);
        prayers.setAsrJuristic(prayers.Shafii);
        prayers.setAdjustHighLats(prayers.AngleBased);
        int[] offsets = [1, 1, 0, 0, 0, 3, 5]; // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
        prayers.tune(offsets);

        Date now = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);

        ArrayList<String> prayerTimes = prayers.getPrayerTimes(cal,
                latitude, longitude, timezone);
        ArrayList<String> prayerNames = prayers.getTimeNames();

        def prayersText = ''
//     for (int i = 0; i < prayerTimes.size(); i++) {
        prayersText += (prayerNames.get(0) + ": " + prayerTimes.get(0) + '\n')
        prayersText += (prayerNames.get(1) + ": " + prayerTimes.get(1) + '\n')
        prayersText += (prayerNames.get(2) + ": " + prayerTimes.get(2) + '\n')
        prayersText += (prayerNames.get(3) + ": " + prayerTimes.get(3) + '\n')
        prayersText += (prayerNames.get(4) + ": " + prayerTimes.get(4) + '\n')
        prayersText += (prayerNames.get(5) + ": " + prayerTimes.get(5) + '\n')
//         prayersText += (prayerNames.get(6) + ": " + prayerTimes.get(6) + '\n')
//     }

        def max = 1
        if (ker.OperationController.getPath('hijriDate.enabled')?.toLowerCase() == 'yes')
 max = app.IndexCard.executeQuery('select count(*) from IndexCard i where i.priority >= ? and i.type.code = ? and length(i.summary) > 80 and length(i.summary) < 800', [4, 'aya'])[0].toInteger()


        def overdue = supportService.getOverdueTasks()
        def pile = supportService.getTasksPile()
        def todayInProgress = supportService.getTasksTodayInProgress()
        def todayCompleted = supportService.getTasksTodayCompleted()
        def todayNotStarted = supportService.getTasksTodayNotStarted()


//        render(view: '/appKanban/main', model: [courses: courses.unique().reverse(),


        render(view: '/appCalendar/main', model: [
                prayersText: prayersText,
                random: Math.floor(Math.random() * max),
                overdue: overdue,
                pile: pile,
                inProgress: todayInProgress,
                courses: mcs.Course.findAllByBookmarked(true),
                completed: todayCompleted,
                notStarted: todayNotStarted
        ])
    }
  def appMobileCalendar() {

        Date now = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);

        render(view: '/appMobileCalendar/main', model: [
        ])
    }

    def record() {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        if (record)
        render(view: '/page/record', model: [record:record
        ])
        else render 'Record not found.'
    }
 def rssPage() {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.id?.split('-')[1]]).get(params.id?.split('-')[0])
        if (record)
        render(view: '/page/record', model: [record:record])
        else render 'Record not found.'
    }

    def panel() {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        def typeSandboxPath

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true

        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true


        if (record.entityCode() == 'R') {
            typeSandboxPath = OperationController.getPath('root.rps1.path') + 'R' +
                    (resourceNestedByType ?  '/' +  record.type.code : '') +
                    (resourceNestedById ?  '/' +   (record.id / 100).toInteger() : '') +
                    '/' + record.id
        } else {
            typeSandboxPath = OperationController.getPath('root.rps1.path') + '' + params.entityCode + '/' + record.id
        }

def coverPath
        if (params.entityCode == 'R') {
            def b = Book.get(params.recordId)
            coverPath = OperationController.getPath('root.rps1.path') + '/R/cvr/' //+ b.id + '.jpg'
        } else {
            coverPath = OperationController.getPath('root.rps1.path') + '/' + params.entityCode + '/cvr/' //+ params.recordId + '.jpg'
        }

        def source = ''
        def authors = ''
        if (record) {
            if (record.entityCode() == 'N' || record.entityCode() == 'W') {
                java.util.regex.Matcher matcher = record.description =~ /@([\S_-]*) /

                matcher.eachWithIndex() { match, i ->
                    source += mcs.Book.findByCode(match[1]?.replace(']', '')) ?
                            ''//('Source found: ' + mcs.Book.findByCode(match[1]) + '<br/>')
                            :
                            ('Source not found: ' + match[1]) + '<br/>'
                }
            }
            def finalText
            /*
            if (record.entityCode() == 'W') {
                java.util.regex.Matcher matcher = record.description =~ /\}\{([\S\_-]*)\}/
                def book
                finalText = record.description
                matcher.eachWithIndex() { match, i ->
                    println 'match ' + match[1]
                    book = mcs.Book.findByCode(match[1])
                    if (book) {
                        authors += 'f r =' + match[1] + '<br/>'// + book.authorInBib + '<br/>'
                        finalText = finalText.replace('{' + match[1] + '}', '{' + book.authorInBib + '}')
                    }
                    else authors += ('Author not found: ' + match[1] + '<br/>')
                }
                //r.description = finalText
              new File('E:/wrt/w-ioa.tmp').write(finalText, 'UTF-8')
            }
            */


def htmlText = ''

            if (record.entityCode() == 'N' && record.description) {
                MutableDataSet options = new MutableDataSet();

                options.setFrom(ParserEmulationProfile.MARKDOWN);
                options.set(Parser.EXTENSIONS, Arrays.asList(
                        //                    AbbreviationExtension.create(),
                        //                    DefinitionExtension.create(),
                        StrikethroughExtension.create(),
                    TocExtension.create(),
                                            FootnoteExtension.create(),
                                            TypographicExtension.create(),
                        TablesExtension.create()
                ));

                Parser parser = Parser.builder(options).build();
                HtmlRenderer renderer = HtmlRenderer.builder(options).build();

                // You can re-use parser and renderer instances
                Node document = parser.parse(record.description?.replaceAll('\n', '\n<br/>\n'));
                String html = renderer.render(document);  // "<p>This is <em>Sparta</em></p>\n"
                record.descriptionHTML =  html//?.replaceAll('\n', '<br/>\n')?.replaceAll('<br/>', '<br/>\n')
                // println 'html ' + html
            }


            def htmlFullText = ''
//            println record.dump()
if (record.entityCode() == 'R' && record.withMarkdown) {

                MutableDataSet options = new MutableDataSet();

                options.setFrom(ParserEmulationProfile.MARKDOWN);
                options.set(Parser.EXTENSIONS, Arrays.asList(
                        //                    AbbreviationExtension.create(),
                        //                    DefinitionExtension.create(),
                        StrikethroughExtension.create(),
                    TocExtension.create(),
                                            FootnoteExtension.create(),
                                            TypographicExtension.create(),
                        TablesExtension.create()
                ));

                Parser parser = Parser.builder(options).build();
                HtmlRenderer renderer = HtmlRenderer.builder(options).build();

                // You can re-use parser and renderer instances
                Node document = parser.parse(record.fullText?.replaceAll('\n', '\n<br/>\n'));
                htmlFullText = renderer.render(document);  // "<p>This is <em>Sparta</em></p>\n"
            }

//            StringBuilder sb = new StringBuilder();
//            sb.append("# Heading 1\n");
//            String text = sb.toString();
//
//            MarkupLanguage markupLanguage = new MarkdownLanguage();
//
//            StringWriter writer = new StringWriter();
//            HtmlDocumentBuilder builder = new HtmlDocumentBuilder(writer);
//            builder.setEmitAsDocument(false);
//            MarkupParser parser = new MarkupParser(markupLanguage, builder);
//            parser.parse(text);
//htmlText = writer.toString();
//            println 'hhtmlText' + htmlText

	    // changes for the operation module w08.2022
            if (params.entityCode != 'O') {
                render(template: '/layouts/panel', model: [entityCode     : params.entityCode, record: record,
                                                           mobileView     : params.mobileView,
                                                           typeSandboxPath: typeSandboxPath,
                                                           coverPath      : coverPath + '-' + record.id,
                                                           source         : source, authors: authors, htmlText: htmlText, htmlFullText: htmlFullText
                ])
            }
            else {
                render(template: '/gTemplates/addQuickForm', model: [entityController: 'mcs.Operation',
                                                                     fields          : grailsApplication.classLoader.loadClass('mcs.Operation').declaredFields.name,
                                                                     updateRegion    : '3rdPanel',
                                                                     record          : record
                ])
            }

        } else render 'Record not found'
    }

    def publish() {
        render(view: '/page/publish', model: [record:
                                                      grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        ])
    }

    def presentation() {
        render(view: '/page/presentation', model: [record:
                                                           grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        ])
    }


    def indicators() {
        render(view: '/page/indicators', model: [])
    }

    def calendar() {

        render(view: '/reports/calendar', model: [savedSearchId: params.id])
    }

//    ResourceLocator grailsResourceLocator // injected during initialization


    def slides() {

//            def resource = grailsResourceLocator.findResourceForURI('/css/chosen.css')
//            def path = resource.file.path // absolute file path
//            def resource = this.class.classLoader.getResource('chosen.css')
//            def path = resource.file // absolute file path
//            def inputStream = resource.inputStream // input stream for the file
//                             println 'chosen path'  + path + '\n'// + new File(path).text

        if (ker.OperationController.getPath('slides.path') && new File(ker.OperationController.getPath('slides.path')).exists()) {
            def f = new File(ker.OperationController.getPath('slides.path') + '/contents.md')
            def t = ''
            app.IndexCard.findAllByMainHighlightsIsNotNull().each() {
                t += it.mainHighlights + '\n---\n'
            }
            f.write(t, 'UTF-8')
            render("Contents file saved. Please open 'index.html' in " + ker.OperationController.getPath('slides.path') + " to see the slides.")
//                redirect(url: 'file://' + ker.OperationController.getPath('slides.path') + '/index.html')
//                redirect(url: "file:///D:/mhi/rps1/slides/index.html/")
        } else {
            render 'Setting slides.path is not set or path does not exists.'
        }
    }

    def kanban() {

        def courses = mcs.Book.executeQuery('select p.course from Task p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Goal p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Plan p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Journal p where p.bookmarked = 1') +
                mcs.Book.executeQuery('select p.course from Book p where p.bookmarked = 1')

     //   println 'crs +' + courses
        render(view: '/page/kanbanCrs', model: [courses: courses])
    }

    def kanbanCrs() {


        def courses = mcs.Book.executeQuery('select p.course from Task p where p.bookmarked = 1') +
        mcs.Book.executeQuery('select p.course from Goal p where p.bookmarked = 1') +
        mcs.Book.executeQuery('select p.course from Plan p where p.bookmarked = 1') +
        mcs.Book.executeQuery('select p.course from Journal p where p.bookmarked = 1') +
        mcs.Book.executeQuery('select p.course from Book p where p.bookmarked = 1')

    //    println 'crs +' + courses
        render(view: '/page/kanbanCrs', model: [courses: courses])
    }

    def mobile() {
        render(view: '/appMobile/mobile', model: [mobileView: true])
    }
  def media() {
        render(view: '/appMobile/mobile', model: [mobileView: true])
    }

    def colors() {


        def colors = """AliceBlue;#F0F8FF
AntiqueWhite;#FAEBD7
Aqua;#00FFFF
Aquamarine;#7FFFD4
Azure;#F0FFFF
Beige;#F5F5DC
Bisque;#FFE4C4
Black;#000000
BlanchedAlmond;#FFEBCD
Blue;#0000FF
BlueViolet;#8A2BE2
Brown;#A52A2A
BurlyWood;#DEB887
CadetBlue;#5F9EA0
Chartreuse;#7FFF00
Chocolate;#D2691E
Coral;#FF7F50
CornflowerBlue;#6495ED
Cornsilk;#FFF8DC
Crimson;#DC143C
Cyan;#00FFFF
DarkBlue;#00008B
DarkCyan;#008B8B
DarkGoldenRod;#B8860B
DarkGray;#A9A9A9
DarkGreen;#006400
DarkKhaki;#BDB76B
DarkMagenta;#8B008B
DarkOliveGreen;#556B2F
DarkOrange;#FF8C00
DarkOrchid;#9932CC
DarkRed;#8B0000
DarkSalmon;#E9967A
DarkSeaGreen;#8FBC8F
DarkSlateBlue;#483D8B
DarkSlateGray;#2F4F4F
DarkTurquoise;#00CED1
DarkViolet;#9400D3
DeepPink;#FF1493
DeepSkyBlue;#00BFFF
DimGray;#696969
DodgerBlue;#1E90FF
FireBrick;#B22222
FloralWhite;#FFFAF0
ForestGreen;#228B22
Fuchsia;#FF00FF
Gainsboro;#DCDCDC
GhostWhite;#F8F8FF
Gold;#FFD700
GoldenRod;#DAA520
Gray;#808080
Green;#008000
GreenYellow;#ADFF2F
HoneyDew;#F0FFF0
HotPink;#FF69B4
IndianRed ;#CD5C5C
Indigo ;#4B0082
Ivory;#FFFFF0
Khaki;#F0E68C
Lavender;#E6E6FA
LavenderBlush;#FFF0F5
LawnGreen;#7CFC00
LemonChiffon;#FFFACD
LightBlue;#ADD8E6
LightCoral;#F08080
LightCyan;#E0FFFF
LightGoldenRodYellow;#FAFAD2
LightGray;#D3D3D3
LightGreen;#90EE90
LightPink;#FFB6C1
LightSalmon;#FFA07A
LightSeaGreen;#20B2AA
LightSkyBlue;#87CEFA
LightSlateGray;#778899
LightSteelBlue;#B0C4DE
LightYellow;#FFFFE0
Lime;#00FF00
LimeGreen;#32CD32
Linen;#FAF0E6
Magenta;#FF00FF
Maroon;#800000
MediumAquaMarine;#66CDAA
MediumBlue;#0000CD
MediumOrchid;#BA55D3
MediumPurple;#9370DB
MediumSeaGreen;#3CB371
MediumSlateBlue;#7B68EE
MediumSpringGreen;#00FA9A
MediumTurquoise;#48D1CC
MediumVioletRed;#C71585
MidnightBlue;#191970
MintCream;#F5FFFA
MistyRose;#FFE4E1
Moccasin;#FFE4B5
NavajoWhite;#FFDEAD
Navy;#000080
OldLace;#FDF5E6
Olive;#808000
OliveDrab;#6B8E23
Orange;#FFA500
OrangeRed;#FF4500
Orchid;#DA70D6
PaleGoldenRod;#EEE8AA
PaleGreen;#98FB98
PaleTurquoise;#AFEEEE
PaleVioletRed;#DB7093
PapayaWhip;#FFEFD5
PeachPuff;#FFDAB9
Peru;#CD853F
Pink;#FFC0CB
Plum;#DDA0DD
PowderBlue;#B0E0E6
Purple;#800080
Red;#FF0000
RosyBrown;#BC8F8F
RoyalBlue;#4169E1
SaddleBrown;#8B4513
Salmon;#FA8072
SandyBrown;#F4A460
SeaGreen;#2E8B57
SeaShell;#FFF5EE
Sienna;#A0522D
Silver;#C0C0C0
SkyBlue;#87CEEB
SlateBlue;#6A5ACD
SlateGray;#708090
Snow;#FFFAFA
SpringGreen;#00FF7F
SteelBlue;#4682B4
Tan;#D2B48C
Teal;#008080
Thistle;#D8BFD8
Tomato;#FF6347
Turquoise;#40E0D0
Violet;#EE82EE
Wheat;#F5DEB3
White;#FFFFFF
WhiteSmoke;#F5F5F5
Yellow;#FFFF00
YellowGreen;#9ACD32"""
        render(template: '/page/colors', model: [colors: colors])
    }


    def settingsMain() {
        render(template: '/page/settings', model: [full: false])

    }

    def settingsFull() {
        render(template: '/page/settings', model: [full: true])

    }

    def heartbeat() {
        render 'ok'
    }

    def heartbeatJson() {
        def builder = new JSONBuilder()
        def json = builder.build {
            result = "ok"

        }
        render(status: 200, contentType: 'application/json', text: json)
    }


    def importbeat() {

        def r = ''
        def c = 0
        def f = ker.OperationController.getPath('root.rps1.path')
        if (f) {
            new File(f)?.listFiles().each() {
                if (it.isFile())
                    c++
                if (it.isDirectory() && it.name.length() > 1)
                    c++
            }
        }
        render '(' + c.toString() + ')'

    }

    def editHeartbeat() {

        def r = ''
        def c = 0
        def f = ker.OperationController.getPath('editBox.path')
        if (f) {
            new File(f)?.listFiles().each() {
                if (it.isFile() && it.name?.endsWith('.md'))
                    c++
//               if (it.isDirectory() && it.name.length() > 1)
//                    c++
            }
        }
        render c.toString()

    }

} // end of class