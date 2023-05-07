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

import app.IndexCard
import app.Tag
import mcs.Book
import mcs.Course
import mcs.Department
import mcs.Goal
import mcs.Planner
import mcs.Writing
import mcs.parameters.ResourceStatus

import com.intuit.fuzzymatcher.component.MatchService;
import com.intuit.fuzzymatcher.domain.Document;
import com.intuit.fuzzymatcher.domain.Element;
import static com.intuit.fuzzymatcher.domain.ElementType.ADDRESS;
import static com.intuit.fuzzymatcher.domain.ElementType.NAME;
import com.intuit.fuzzymatcher.domain.Match;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import grails.converters.JSON
import grails.web.JSONBuilder

import com.ibm.icu.text.Transliterator;

import grails.plugin.springsecurity.annotation.Secured



@Secured(['ROLE_ADMIN','ROLE_READER'])
class ReportController {

    def supportService


    def heartbeat() {
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
        render(template: '/reports/heartbeat', model: [dates: datesHb])
    }

    def taskCompletionTrack() {
        def datesTc = [:]
        for (c in [[mcs.Task, 'Task']]) {
            for (t in c[0].findAllByDateCreatedGreaterThan(new Date() - 90, [sort: 'dateCreated', order: 'asc'])) {
                def date = t.dateCreated.format('yyyy-MM-dd')
                if (!datesTc[date])
                    datesTc[date] = ['newTasks'      : 0,
                                     'completedTasks': 0
                    ]

                datesTc[date]['newTasks'] += 1
            }

            for (t in c[0].findAllByDateCreatedGreaterThan(new Date() - 90, [sort: 'dateCreated', order: 'asc'])) {
                if (t.completedOn) {
                    def date = t.completedOn.format('yyyy-MM-dd')
                    if (!datesTc[date])
                        datesTc[date] = ['newTasks'      : 0,
                                         'completedTasks': 0
                        ]

                    datesTc[date]['completedTasks'] += 1
                }
            }
        }

        def datesNr = [:]
        for (c in [[app.IndexCard, 'Note']]) {
            for (t in c[0].findAllByDateCreatedGreaterThan(new Date() - 90, [sort: 'dateCreated', order: 'asc'])) {
                def date = t.dateCreated.format('yyyy-MM-dd')
                if (!datesNr[date])
                    datesNr[date] = ['newNotes' : 0,
                                     'readNotes': 0
                    ]

                datesNr[date]['newNotes'] += 1
            }

            for (t in c[0].findAllByDateCreatedGreaterThan(new Date() - 90, [sort: 'dateCreated', order: 'asc'])) {
                if (t.readOn) {
                    def date = t.readOn.format('yyyy-MM-dd')
                    if (!datesNr[date])
                        datesNr[date] = ['newNotes' : 0,
                                         'readNotes': 0
                        ]

                    datesNr[date]['readNotes'] += 1
                }
            }
        }
        render(template: '/reports/taskCompletionTrack', model: [datesTc: datesTc, datesNr: datesNr])
    }


    def whereIsMyData() {
        render(template: '/reports/whereismydata', model: [])
    }

    def statistics() {
        render(template: '/reports/statistics', model: [])
    }

    def departmentCourses() {
        render(template: '/reports/departmentCourses', model: [id: params.id])
    }

    def indicatorsByCategory() {
        render(template: '/reports/indicatorsByCategory', model: [id: params.id])
    }

    def indicatorPanorama() {
        render(template: '/reports/indicatorPanorama')
    }
  def paymentPanorama() {
        render(template: '/reports/paymentPanorama')
    }
 def enterTasksWithContext() {
        render(template: '/reports/taskContextEntry')
    }
def enterJournalWithType() {
        render(template: '/reports/journalSheetEntry')
    }


    def convertWeekDate() {
        render(template: '/reports/convertWeekDate')
    }


    def textbooksPanorama() {
        def currentTextbooks = Book.executeQuery("select concat(course.code, ' ', course.title), id, title from Book where status = ? and orderNumber = course.currentTextbookLevel order by course.code", [ResourceStatus.get(1)])
        def textbooks = Book.executeQuery("select course.department.name, concat(course.code, ' ', course.title), id, title from Book where status is ? order by course.code", ResourceStatus.get(1))
        render(template: '/reports/textbooksPanorama', model: [textbooks: textbooks, currentTextbooks: currentTextbooks])
    }


    def random() {

        def list = [:]
        def listw = [:]
        Book.findAllByTitleIsNotNull().eachWithIndex() { b, i ->
//            if (b.id)
            list[i] = b.id
        }
        Writing.list().eachWithIndex() { b, i ->
//            if (b.id)
            listw[i] = b.id
        }
        render(template: '/gTemplates/recordListing', model: [list:
                                                                      [
                                                                              mcs.Book.get(list[Math.floor(Math.random() * mcs.Book.countByTitleIsNotNull()).toInteger()]),
                                                                              mcs.Writing.get(listw[Math.floor(Math.random() * mcs.Writing.count()).toInteger()])
                                                                      ]
        ])

    }

    def duplicateIsbnBooks() {
        def books = []
        def previousIsbn = ''
        def previousBook = null
        def found = 0
        Book.findAllByIsbnIsNotNull(sort: 'isbn').each() {
            if (found < 20) {
                if (previousIsbn == '') {
                    previousIsbn = it.isbn.trim()
                    previousBook = it
                } else if (it.isbn == previousIsbn) {
                    books.add(previousBook)
                    books.add(it)
                    found++
                } else {
                    previousBook = it
                    previousIsbn = it.isbn.trim()
                }
            }
        }
        render(template: '/gTemplates/recordListing', model: [list: books])
    }


    def longestWrt() {

        def m1 = [:]
        def longestWrt = []
        mcs.Writing.list().each() {
            m1[it.id] = it.body?.length() ?: 0
        }
        def map = m1.sort { a, b -> b.value <=> a.value }
        def limit = 30
        def i = 0
        map.each() {
            if (i < limit) {
                longestWrt.add(mcs.Writing.get(it.key))
                i++
            }
        }

        render(template: '/writing/line', collection: longestWrt, var: 'writingInstance')

    }


    def courses() {
        render(template: '/reports/courses')
    }


    def writingGroupByCourseFlat() {
        def courses
        def department
        if (params.id)
            [courses   : Course.findAllByDepartment(Department.get(params.id), [sort: 'code']),
             department: Department.get(params.id)]
        else
            [courses: Course.findAll([sort: 'code'])]

        render(template: '/reports/writingGroupByCourseFlat', model: [courses: courses, department: department])

    }


    def updateIps() {

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


        render(template: '/reports/ips', model: [ips: ips])
    }

    def tagCloud() {

        Tag.list().each() { t ->
            def count = 0
            taggedClasses.each() {
                count += it.createCriteria().count() { tags { idEq(t.id) } }
            }
            t.occurrence = count
        }
        render(template: '/reports/tagCloud', model: [])
    }

    def contactCloud() {

            Tag.list().each() { t ->
                def count = 0
                taggedClasses.each() {
                    count += it.createCriteria().count() { tags { idEq(t.id) } }
                }
                t.occurrence = count
            }

        render(template: '/reports/contactCloud', model: [])
    }


    def detailedAdd() {
        render(template: '/reports/detailedAdd', model: [])
    }


    def reviewPile() {
        //  def list = []

//       def activeCourses = Planner.executeQuery('select course from Planner p where p.startDate < current_date and p.endDate > current_date and p.course is not null')
//       println 'ac ' + activeCourses
        def resources =
                Book.executeQuery('from Book r where r.course.bookmarked = ? ' +
//                        in ' +
//                        '(select course from Planner p where p.startDate < current_date and p.endDate > current_date and p.course is not null)' +
                        ' and r.priority >= ? and r.readOn is null' +
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

        render(template: '/gTemplates/recordListing', model: [list: excerpts + resources])


    }


    def paymentCategories() {
        render(template: '/reports/paymentCategories', model: [])
    }

    def saveDateSelection() {

//        def date
//        if (params.date)
//        date = Date.parse("dd.MM.yyyy", params.date)

        try {
            def startDate
            def endDate
            if (params.date1) {
                session['startDate'] = Date.parse("d.M.yyyy HH:mm", params.date1 + ' ' + ' 00:00')
                session['endDate'] = Date.parse("d.M.yyyy HH:mm", params.date2 + ' ' + ' 23:59')
                startDate = Date.parse("d.M.yyyy HH:mm", params.date1 + ' ' + ' 00:00')
                endDate = Date.parse("d.M.yyyy HH:mm", params.date2 + ' ' + ' 23:59')

//        render(template: '/reports/jpReport', model: [level: params.level,
//                title: '', plans: Planner.executeQuery('from Planner where date(startDate) >= ? and date(endDate) <= ?', [startDate, endDate]),
//                journals: Journal.findAll('from Journal where date(startDate) >= ? and date(endDate) <= ?', [startDate, endDate]),
//                startDate: startDate, endDate: endDate])
//
                def title = // 'Activity log and agenda for: ' +
                        (startDate.format('dd.MM.yyyy') == endDate.format('dd.MM.yyyy') ? startDate.format('EE dd.MM.yyyy') :
                                startDate.format('EE dd.MM.yyyy') + ' - ' + endDate.format('EE dd.MM.yyyy')) + ''


                def list = []
                for (c in [
                        mcs.Goal, mcs.Task]) {
                    list += c.executeQuery(' from ' + c.name + ' where endDate between ? and ? ', [startDate, endDate])
                }

                if (session['log'] == 1) {
                    for (c in [
                            mcs.Goal, mcs.Task, mcs.Planner, mcs.Journal,
                            mcs.Writing, app.IndexCard, mcs.Book]) {
                        list += c.executeQuery(' from ' + c.name + ' where dateCreated between ? and ? ', [startDate, endDate])
                    }

                    for (c in [
                            mcs.Planner, mcs.Journal]) {
                        list += c.executeQuery(' from ' + c.name + ' where startDate between ? and ? ', [startDate, endDate])
                    }
                    for (c in [
                            app.Payment, app.IndicatorData]) {
                        list += c.executeQuery(' from ' + c.name + ' where date between ? and ? ', [startDate, endDate])
                    }
                }

                render(template: '/gTemplates/recordListing', model: [list: list, title: title])


//                if (session['Kanban'] == 1)
                    render(template: '/reports/kanbanCalendar', model: [startDate: startDate, endDate: endDate])
//                if (session['P'] == 1)
                    render(template: '/reports/pCalendar', model: [startDate: startDate, endDate: endDate])
//                if (session['J'] == 1)
                    render(template: '/reports/jCalendar', model: [startDate: startDate, endDate: endDate])

//                if (session['Jtrk'] == 1)
                    render(template: '/reports/jtrkReport', model: [startDate: startDate, endDate: endDate])

//                if (session['Qtrans'] == 1)
                if (ker.OperationController.getPath('payments.enabled')?.toLowerCase() == 'yes') {
                    render(template: '/reports/financialReportTrans', model: [startDate: startDate, endDate: endDate])

//                if (session['Qacc'] == 1)

                    render(template: '/reports/financialReportAcc', model: [startDate: startDate, endDate: endDate])
                }



//                            Planner.executeQuery('from Planner where (date(dateCreated) >= ? and date(dateCreated) <= ?) or (date(startDate) >= ? and date(startDate) <= ?) order by dateCreated desc', [startDate, endDate, startDate, endDate]) +
//
//
//
//                                    Goal.findAll('from Goal where date(dateCreated) >= ? and date(dateCreated) <= ? order by dateCreated desc', [startDate, endDate], [max: 40]) +
//                                    Task.findAll('from Task where date(dateCreated) >= ? and date(dateCreated) <= ? order by dateCreated desc', [startDate, endDate], [max: 40]) +
//
//                                    Journal.executeQuery('from Journal where (date(dateCreated) >= ? and date(dateCreated) <= ?) or (date(startDate) >= ? and date(startDate) <= ?) order by dateCreated desc', [startDate, endDate, startDate, endDate]) +
//                                    IndicatorData.findAll('from IndicatorData where date(date) >= ? and date(date) <= ? order by dateCreated desc', [startDate, endDate]) +
//                                    Payment.findAll('from Payment where date(date) >= ? and date(date) <= ? order by dateCreated desc', [startDate, endDate]) +
//                                    Writing.findAll('from Writing where date(dateCreated) >= ? and date(dateCreated) <= ? order by dateCreated desc', [startDate, endDate]) +
//                                    IndexCard.findAll('from IndexCard where date(dateCreated) >= ? and date(dateCreated) <= ? order by dateCreated desc', [startDate, endDate]) +
//                                    Book.findAll('from Book where date(lastUpdated) >= ? and date(lastUpdated) <= ? order by dateCreated desc', [startDate, endDate], [max: 20]) +
//                                    Excerpt.findAll('from Excerpt where date(lastUpdated) >= ? and date(lastUpdated) <= ? order by dateCreated desc', [startDate, endDate], [max: 20])
//                            ,
//                            title: title
//                    ])

            }
            //  else render ''
        } catch (Exception e) {
            println e.toString()
        }
    }

    def setJPReportType = {

        if (session[params.id] == 1) {
            session[params.id] = 0
            render params.id
        } else {
            session[params.id] = 1
            render '<b>' + params.id + '</b>'
        }
//        render params.id + ' is now ' + session[params.id]
    }
    def showLine1Only = {

        session['showLine1Only'] = 'on'
        session['showFullCard'] = 'off'

        render(template: '/layouts/achtung', model: [message: "Only the first line of the card will be shown in future listings"])
    }
    def showFullCard = {
        session['showLine1Only'] = 'off'
        session['showFullCard'] = 'on'
        render(template: '/layouts/achtung', model: [message: "The full card will be shown in future listings"])
    }

    def homepageSavedSearches() {
        render(template: '/reports/homepageSavedSearches')
    }


    def xcd2epub() {
        render(view: '/reports/xcd2epub')
    }


    def coursePercentages() {
        Goal.list().each() {
            if (!it.percentCompleted)
                it.percentCompleted = 30
        }
        def total = 0
        def ps = 0
        for (c in Course.list()) {
            total = 0
            ps = 0
            total = Goal.countByCourseAndDeletedOnIsNull(c)
            for (g in Goal.findAllByCourseAndDeletedOnIsNull(c)) {
                ps += g.percentCompleted
            }
            c.percentCompleted = total != 0 ? ps / total : 0

        }
    }

    def surahReport() {

        def list = IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ? order by i.orderInWriting', [params.id, 'aya'])
        def writing = Writing.get(params.id)
        def title = //'[' + writing.id + '] ' +
                writing.orderInBook + ' ' + writing.summary + ' (' + writing.slug + ')'

        render(template: '/reports/ayatReport', model: [list: list, title: title, writing: writing])
    }
 def surahReportWithNotes() {

        def writing = Writing.get(params.id)
        def title = //'[' + writing.id + '] ' +
                writing.orderInBook + ' ' + writing.summary + ' (' + writing.slug + ')'

//     def subNotes = []
//     def tlist
     def notes = IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ? and i.notes != null ', [writing.id.toString(), 'aya'])
//     IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ?', [writing.id.toString(), 'aya']).each(){ n->
//
//          tlist = IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.entityCode = ?', [n.id.toString(), 'N'])
//         if (tlist.size() > 0) {
//             subNotes += n
//             if (!n.notes)
//                 n.notes = 'Sub notes available.'
//             else n.notes = 'Sub notes available.\n\n' + n.notes
//             n.save(flush: true)
//         }
//     }
//     IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.entityCode = ?', [n.id.toString(), 'N']).each(){
//
//     }



        render(template: '/gTemplates/recordListing', model: [list: notes, title: title, writing: writing])




    }

    def matrixReport() {

        def list = []
        def title = 'Salat matrix report'
        render(template: '/reports/matrixReport', model: [list: list, title: title])
    }

    def memorizationReport() {

        def list = []
        def title = 'Memorization report'
        render(template: '/reports/memorizationReport', model: [list: list, title: title])
    }

    def staticMemorizationReport() {

        def f = new File(OperationController.getPath('qurani.path') + '/memorization.html')
        f.write(g.include([controller: 'report', action: 'memorizationReport']).toString(), 'UTF-8')
        render 'Generation done: ' + new Date().format('HH:mm:ss')

    }

    def quranReport() {

        // def list = IndexCard.executeQuery('from IndexCard i where i.type.code = ? order by i.writing.orderInBook, i.orderInWriting',['aya'])
        //def writing = Writing.get(params.id)
//        def title = 'Quran report' + writing.id + '] ' + writing.orderInBook + ' ' + writing.summary + ' (' + writing.slug + ')'

        render(view: '/reports/quranReport', model: [])
    }

 def readRouba() {

        def list = IndexCard.executeQuery('from IndexCard i where i.type.code = ? and i.orderNumber = ? order by i.orderInBook',['aya', params.id.toInteger()])
        //def writing = Writing.get(params.id)
//        def title = 'Quran report' + writing.id + '] ' + writing.orderInBook + ' ' + writing.summary + ' (' + writing.slug + ')'

        render(template: '/reports/ayatReport', model: [list: list, title: 'J: ' + (params.id.toInteger() % 8 == 0 ? params.id.toInteger() / 8  : params.id.toInteger() / 8 + 1).toInteger() + ' / ' + (params.id.toInteger() % 8 == 0 ? 8 : params.id.toInteger() % 8 ) + ' - #R: ' + params.id])
    }
 def readJouza() {
         def a = 8*(params.id.toInteger() - 1) + 1
     def b = 8*(params.id.toInteger() - 1) + 8
        def list = IndexCard.executeQuery('from IndexCard i where i.type.code = ? and i.orderNumber <= ? and i.orderNumber >= ? order by i.orderInBook',
                ['aya', b , a])
        //def writing = Writing.get(params.id)
//        def title = 'Quran report' + writing.id + '] ' + writing.orderInBook + ' ' + writing.summary + ' (' + writing.slug + ')'

        render(template: '/reports/ayatReport', model: [list: list, title: 'Jouzo2: ' + params.id])
    }


    def quranReportToString() {
        render(view: '/reports/quranReport')
    }



    def staticQuranReport() {

        def f = new File(OperationController.getPath('root.rps1.path') + '/quran.html')
//        f.text(g.include([controller: 'report', action: 'quranReportToString']).toString())
        f.write(g.include([controller: 'report', action: 'quranReportToString']).toString(), 'UTF-8')
        render 'Generation done: ' + new Date().format('HH:mm:ss')

    }
  def staticQuranReportTex() {

        def f = new File(OperationController.getPath('root.rps1.path') + '/ayat.tex')
//        f.text(g.include([controller: 'report', action: 'quranReportToString']).toString())
        f.write(g.include([controller: 'report', action: 'quranReportToTex']).toString(), 'UTF-8')
        render 'Generation done: ' + new Date().format('HH:mm:ss')

    }
    def quranReportToTex() {
        render(view: '/reports/quranReportTex')
    }


    def indicators() {
        render(template: '/reports/indicators', model: [])
    }


    def wordsForReview() {

        def words =
                Book.executeQuery("from IndexCard i where i.type.code = 'word' and i.course.code = 'farsi'" +
                        ' and (i.lastReviewed < ? or i.lastReviewed is null) and ( i.reviewCount is null or i.reviewCount < ?)' +
                        ' order by i.reviewCount asc, length(i.description) asc',
                        [new Date() + 3, 5], [max: 3])

        render(template: '/gTemplates/recordListing', model: [list: words])


    }


    def duplicateCandidates(){


        def results = []
        Goal.list([sort: 'id', order: 'desc']).each(){a->
        Goal.findAllByIdLessThan(a.id, [sort: 'id', order: 'desc']).each() { b ->

            if (supportService.similarity(a.summary, b.summary) > 0.85)
                results.add(a)
                results.add(b)

        }

        }

        render(template: '/gTemplates/recordListing', model: [list: results])

    }

    def duplicatesList2(){




//        String anything = "ш щ ч ц х ф г я चंब्रिद्गॆ цамбридге كَمبرِدگِ かんぶりでげ";
        String id = "Any-Latin";


        ;


        String[][] input = [
        ];

        def summary = ''
        Goal.list().each(){
            summary = it.summary + ' ' + Transliterator.getInstance(id).transform(it.summary?: it.id.toString())
            input  += [[it.id.toString(), summary , '']]
        }
//        println input

        List<Document> documentList = Arrays.asList(input).stream().map({contact ->
            return new Document.Builder(contact[0])
                    .addElement(new Element.Builder<String>().setValue(contact[0]).setType(NAME).createElement())
                    .addElement(new Element.Builder<String>().setValue(contact[1]).setType(NAME).createElement())
//                    .addElement(new Element.Builder<String>().setValue(contact[2]).setType(ADDRESS).createElement())
                    .createDocument();
        }).collect(Collectors.toList());

        MatchService matchService = new MatchService();
        Map<String, List<Match<Document>>> result =
                matchService.applyMatchByDocId(documentList);

        result.entrySet().forEach({ entry ->
            entry.getValue().forEach({ match ->
//
                render("<br/><br/>f g i" + match.getData().getKey() + ' -- ' +  match.getData() + // "  Matched With:<br/> " + match.getMatchedWith() + " Score: " + new java.text.DecimalFormat('#.##').format(match.getScore().getResult()) + '<br/><br/><br/>');
                "<br/>f g i" + match.getMatchedWith().getKey() + ' -- ' +  match.getMatchedWith() ) // "  Matched With:<br/> " + match.getMatchedWith() + " Score: " + new java.text.DecimalFormat('#.##').format(match.getScore().getResult()) + '<br/><br/><br/>');
                // render("Data: " + match.getData() + " Matched With:<br/> " + match.getMatchedWith() + " Score: " + new java.text.DecimalFormat('#.##').format(match.getScore().getResult()) + '<br/><br/><br/>');
            });
        });


    render 'done.'

}

    def customReport1(){
        /*

mcs.Book.list().each(){


  if (it.author && it.title)
  it.title = it.title + ' - ' + it.author
   else if (it.author && !it.title)
  it.title = it.author

  it.author = null

}
*/


    def list = mcs.Book.executeQuery("from Book r where (r.type.code = 'paintings' or r.type.code = 'sculptures' ) order by r.status.name, r.title asc")

render (view: '/reports/customReport1', model: [list: list, i: 1])


    }



// trn charts
    def chartData = {


        def dataAll = []

        def x = []
        def y = []
        def data = [:]
        def lastValue = 0

        for (c in [
                [app.IndexCard, 'IndexCard', 'Notes', 'fa8042'],
                [mcs.Book, 'Book', 'Resources', 'c38ea3'],
                [mcs.Journal, 'Journal', 'Jounal', '90accf'],
                [mcs.Planner, 'Planner', 'Planner', '238cCC'],
                [mcs.Goal, 'Goal', 'Goals', 'a1c650'],
                [mcs.Task, 'Task', 'Tasks', 'cbe0a1']
        ]) {

            x = []
            y = []
            data = [:]
            lastValue = 0

            for (t in c[0].executeQuery('select date(dateCreated), count(*) from ' + c[1] + ' where dateCreated > ? group by date(dateCreated) order by date(dateCreated)',
                    [new Date() - 14])) {
//				def date = t[0].format('yyyy-MM-dd')
                x+= t[0].format('yyyy-MM-dd') // + '-' + t[1] + t[2] // '-01'//
//                println 'in chart data '  + t[0]
//                println 'in chart data '  + t[0].class
//                println 'in chart data '  + t[0].format('yyyy-MM-dd')
                println ''
                println ''
//				x+= date
                y += t[1] // + lastValue // cumulative value
//				lastValue = t[2] + lastValue
            }

            data =	[x: x, //                       x[1..-1], y: y[1..-1],
                       y: y,

                       name: '' + c[2] + ' ',
                       type: 'line', // scatter, lines, markers,
                       line: [
                               color: "#${c[3]}", // 'rgb(' + Math.random() * 255 + ', ' + Math.random() * 255 + ',' +  Math.random() * 255 + ')',
                               width: 2
                       ]
            ]
            dataAll += [data]
        }
        render dataAll as JSON
    }

} // end of class