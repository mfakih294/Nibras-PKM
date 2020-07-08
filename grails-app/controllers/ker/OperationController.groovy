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

import app.*
import app.parameters.Blog
import app.parameters.Markup
import app.parameters.ResourceType
import cmn.Setting
import grails.converters.JSON
import mcs.*
import mcs.parameters.*
import grails.plugin.springsecurity.annotation.Secured
import org.apache.pdfbox.PDFToImage


@Secured('ROLE_ADMIN')
class OperationController {

    static entityMapping = [
            'G': 'mcs.Goal',
            'T': 'mcs.Task',
            'P': 'mcs.Planner',

            'W': 'mcs.Writing',
            'N': 'app.IndexCard',

            'J': 'mcs.Journal',
            'I': 'app.IndicatorData',
            'K': 'app.Indicator',

            'Q': 'app.Payment',
            'L': 'app.PaymentCategory',

            'R': 'mcs.Book',
            'C': 'mcs.Course',
            'D': 'mcs.Department',
            'E': 'mcs.Excerpt',
            'S': 'app.Contact',

            'Y': 'cmn.Setting',
            'X': 'mcs.parameters.SavedSearch'
    ]
    def supportService
    def searchableService
    private java.lang.Object object

    def actions() {
        render(template: '/import/importLocalFiles')
    }

    def updateAllWithoutTitle() {
        def count = 0
        Book.findAllByIsbnIsNotNullAndTitleIsNull().each() {
            supportService.updateBook(it.id)
            supportService.addBibtex(it.id)
            count++
        }
        render(template: '/layouts/achtung', model: [message: count + ' books updated'])
    }

    def toggleState() {
        def course = Course.get(params.id)
        def field = 'bookmarked' // isActive
        if (course[field] == true)
            course[field] = false
        else
            course[field] = true

        render("<span class='" + course[field] ? 'activeCourse' : '' + "'>" + course.title + "</span>")
    }

    def addInBatch() {

        def count = 0
        def message = ''

        if (params.input == '')
            render ''
        else {
            render "<b>Processed input:</b> " + params.input.replaceAll('\n', '<br/>') + '<br/><br/>'

            if (params.input.startsWith('icd')) {
                params.input.split(/\*/).each() {
//                render(template: "/indexCard/card", model: [indexCardInstance:supportService.importIcard(it)])
                    render(template: "/gTemplates/recordSummary", model: [record: supportService.importIcard(it)])
                    count++
                }
            } else {
                params.input.eachLine() {
                    count++
                    def input = it.trim()

                    try {

                        if (input && (input.startsWith('jrn') || input.startsWith('pln')) &&
                                input ==~ /(jrn|pln) [\w-]* \d{3}\.\d\d [\S\s]* ; [\S\s]*/) {

                            def isJournal = input.substring(0, 3) == 'jrn'

                            // fields always present
                            def type

                            if (isJournal)
                                type = JournalType.findByNameLike(input.split(/ /)[1])
                            else
                                type = PlannerType.findByNameLike(input.split(/ /)[1])

                            Date startDate
                            String startDateString = supportService.fromWeekDate(input.split(/ /)[2])
                            def description = input.substring(input.indexOf(';') + 2)

                            def tail = input.substring(4, input.length())
                            def rest = tail.substring(
                                    tail.indexOf(/ /) + 8,
                                    tail.length()
                            )

                            def goal = null
                            def task = null
                            def course = null
                            def writing = null

                            Date endDate

                            def level

                            // minute-level record, with or without a parent record (goal/task/course)
                            if (rest ==~ /\d{4} \d{4} [\S\s]*/) {

                                def startTime = rest.split(/ /)[0].substring(0, 2) + ':' + rest.split(/ /)[0].substring(2, 4)
                                def endTime = rest.split(/ /)[1].substring(0, 2) + ':' + rest.split(/ /)[1].substring(2, 4)

                                startDate = Date.parse('yyyy-MM-dd HH:mm', startDateString + ' ' + startTime)
                                endDate = Date.parse('yyyy-MM-dd HH:mm', startDateString + ' ' + endTime)
                                level = 'm'

                            }
                            // range-level record
                            else if (rest ==~ /\d{3}\.\d\d [\S\s]*/) {
                                startDate = Date.parse('yyyy-MM-dd', startDateString)

                                def endDateString = supportService.fromWeekDate(rest.split(/ /)[0])
                                endDate = Date.parse('yyyy-MM-dd', endDateString)

                                level = 'r'
                            }
                            // legacy journal format
                            else if (rest ==~ /\S [\S\s]*/) {
                                startDate = Date.parse('yyyy-MM-dd', startDateString)
                                endDate = startDate
                                level = rest.split(/ /)[0]
                            }
                            // instant journal format
                            else if (rest ==~ /\d{4} [\S\s]*/) {
                                level = 'i'
                                def startTime = rest.split(/ /)[0].substring(0, 2) + ':' + rest.split(/ /)[0].substring(2, 4)
                                startDate = Date.parse('yyyy-MM-dd HH:mm', startDateString + ' ' + startTime)
                                endDate = startDate
                            } else render "Input didn't matching any JP format!"

                            if (rest ==~ /[\S\s]* \d{4}[gctw] ; [\S\s]*/) { // there is a parent record for it.

                                def matcher = (rest =~ /[\S\s]* (\d{4})([gctw]) ; [\S\s]*/)
                                def parentType = matcher[0][2]
                                def parentId = matcher[0][1]

                                if (parentType == 'g')
                                    goal = Goal.get(parentId)
                                else if (parentType == 't')
                                    task = Task.get(parentId)
                                else if (parentType == 'c')
                                    course = Course.findBycode(parentId)
                                else if (parentType == 'w')
                                    writing = Writing.get(parentId)
                            }

                            // finally we save the record, of all types
                            if (isJournal) {
                                def j = new Journal([description: description, startDate: startDate, endDate: endDate, type: type, task: task, goal: goal, writing: writing, course: course, level: level])
                                if (!j.hasErrors() && j.save(flush: true))
//                          render(template: '/journal/line', model: [journalInstance: j])
                                    render(template: "/gTemplates/recordSummary", model: [record: j])
                                else render "J could not be saved"
                            } else {
                                def p = new Planner([description: description, startDate: startDate, endDate: endDate, type: type, task: task, goal: goal, writing: writing, course: course, level: level])
                                if (!p.hasErrors() && p.save(flush: true))
//                            render(template: '/planner/line', model: [plannerInstance: p])
                                    render(template: "/gTemplates/recordSummary", model: [record: p])
                                else render "P could not be saved"
                            }

                        } else if (input && input.startsWith('task ')) {
                            if (input ==~ /task [\w] [\S\s]*/) {// = [\S\s]*/) {
                                def body = input.substring(7)//input.indexOf(';') + 2)
//                        def deliverable = input.substring(input.indexOf('=') + 2)
                                def t = new Task([name                             : body,
                                                  department                       : Department.findByCodeLike(input.split(/ /)[1]), status:
                                                          WorkStatus.get(2), isTodo: false//, deliverable: deliverable
                                ])
                                if (!t.hasErrors() && t.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: t])
                                else render 'Task could not be saved'

                            } else render 'Format not matching'
                        } else if (input && input.startsWith('todo ')) {
                            if (input ==~ /todo [\w] [\S\s]*/) {// = [\S\s]*/) {
                                def body = input.substring(7)//input.indexOf(';') + 2)
//                        def deliverable = input.substring(input.indexOf('=') + 2)
                                def t = new Task([summary                          : body,
                                                  department                       : Department.findByCodeLike(input.split(/ /)[1]), status:
                                                          WorkStatus.get(2), isTodo: true//, deliverable: deliverable
                                ])
                                if (!t.hasErrors() && t.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: t])
                                else render 'Task could not be saved'

                            } else render 'Format not matching <br/>'
                        } else if (input && input.startsWith('topic ')) {
                            if (input ==~ /topic [\w] [\S\s]*/) {// = [\S\s]*/) {
                                def body = input.substring(7)//input.indexOf(';') + 2)
//                        def deliverable = input.substring(input.indexOf('=') + 2)
                                def t = new Task([summary                           : body,
                                                  department                        : Department.findByCodeLike(input.split(/ /)[1]), status:
                                                          WorkStatus.get(2), isTopic: true//, deliverable: deliverable
                                ])
                                if (!t.hasErrors() && t.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: t])
                                else render 'Task could not be saved'

                            } else render 'format not matching <br/>'
                        } else if (input && input.startsWith('goal ')) {
                            if (input ==~ /goal [\w]* [\w] ; [\S\s]*/) {
                                def goalType = GoalType.findByCode(input.split(/ /)[1])
                                def department = Department.findByCodeLike(input.split(/ /)[2])
                                //      def writing = Writing.get(input.split(/ /)[2])
                                //                        def department = writing.course?.department//
                                def title = input.substring(input.indexOf(';') + 2)//, input.indexOf('='))
                                //   def body = input.substring(input.indexOf('=') + 2)
                                //                        def g = new Goal([title: title, description: body, writing: writing, department: department,
                                //                                goalType: goalType, goalStatus: WorkStatus.get(1)])
                                def g = new Goal([summary: title, department: department,
                                                  type   : goalType, status: WorkStatus.get(1)])
//                        println g.dump()
                                if (!g.hasErrors() && g.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: g])
                                else {
                                    render 'Goal could not be saved'
                                    g.errors.each() {
                                        println it
                                    }
                                }

                            } else render 'format not matching <br/>'
                        } else if (input && input.startsWith('> ')) {
                            if (input ==~ /> [\w]* ; [\S\s]*/) {
                                def body = input.substring(input.indexOf(';') + 2).trim()
                                def id = input.split(/ /)[1]
                                Writing.get(id).description += '\n\n' + body + ' (' + new Date().format('dd.MM.yyyy HH:mm') + ')'
                                render(template: "/gTemplates/recordSummary", model: [record: Writing.get(id)])

                            } else render 'format not matching <br/>'
                        } else if (input && input.startsWith('wrt ')) {
                            if (input ==~ /wrt \d\d\d\d [\S\s]* = [\S\s]*/) {
                                def n = Writing.findByType(WritingType.get(22))
//                        n.title = input.substring(input.indexOf(';') + 2).trim()
                                n.summary = input.substring(9, input.indexOf('=') - 1).trim()
                                n.type = WritingType.get(10)
                                n.status = WritingStatus.get(1)
                                n.description = input.substring(input.indexOf('=') + 2).trim()
                                n.orderNumber = 9//input.split(/ /)[2].toFloat()
                                n.course = Course.findBycode(input.split(/ /)[1])

                                n.save(flush: true)
                                render(template: "/gTemplates/recordSummary", model: [record: n])

                            } else render 'format not matching <br/>'
                        }

                        // new writing with new id (for future use)
                        //                else if (input && input.startsWith('w')) {
                        //                    def type = WritingType.findByNameLike(input.split(/ /)[1])
                        //                    def course = Course.findBycodeLike(input.split(/ /)[2])
                        //                    def title = input.substring(input.indexOf(';') + 2, input.indexOf('|'))
                        //                    def body = input.substring(input.indexOf('|') + 2)
                        //                    def j = new Writing([title: title, body: body, type: type, course: course, writingStatus: WritingStatus.get(1)]).save(flush: true)
                        //                    render(template: '/writing/line', model: [writingInstance: j])
                        //                }
                        //                else if (input && input.startsWith('exr ')) {
                        //                    if (input ==~ /exr \d\d\d\d ; [\S\s]*/) {
                        //                        def book = Book.get(input.split(/ /)[1])
                        //                        def chapter = input.split(/ /)[2]
                        //                        def title = input.substring(input.indexOf(';') + 2)
                        //                        def j = new Excerpt([title: title, book: book]).save(flush: true)
                        //                        render(template: '/excerpt/line', model: [excerptInstance: j])
                        //                    } else render 'format not matching <br/>'
                        //                }
                        else if (input && input.startsWith('ind ')) {
                            if (input ==~ /ind \d{3}\.\d\d [\d]* [\d\.]*/) {
                                Date date = Date.parse('yyyy-MM-dd', supportService.fromWeekDate(input.split(/ /)[1]))
                                def indicator = Indicator.findByCode(input.split(/ /)[2])
                                def value = input.split(/ /)[3]
                                def d = new IndicatorData([indicator: indicator, date: date, value: value])
                                if (!d.hasErrors() && d.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: d])
                                else "Ind could not be saved"
                            } else if (input ==~ /ind \d{3}\.\d\d [\d]* [\d\.]* ; [\S\s]*/) {
                                Date date = Date.parse('yyyy-MM-dd', supportService.fromWeekDate(input.split(/ /)[1]))
                                def indicator = Indicator.findByCode(input.split(/ /)[2])
                                def value = input.split(/ /)[3]
                                def notes = null
                                if (input.indexOf(';') > 0)
                                    notes = input.substring(input.indexOf(';') + 2)?.trim()
                                def d = new IndicatorData([indicator: indicator, date: date, value: value, notes: notes])
                                if (!d.hasErrors() && d.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: d])
                                else "Ind could not be saved"
                            } else render 'format not matching <br/>'

                        } else if (input && input.startsWith('exp ')) {
                            if (input ==~ /exp \d{3}\.\d\d [\d]* [\d]*/) {
                                Date date = Date.parse('yyyy-MM-dd', supportService.fromWeekDate(input.split(/ /)[1]))
                                def category = PaymentCategory.findByCode(input.split(/ /)[2])
                                def value = input.split(/ /)[3]
                                def d = new Payment([category: category, date: date, amount: value])
                                if (!d.hasErrors() && d.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: d])
                                else "exp could not be saved"
                            } else if (input ==~ /exp \d{3}\.\d\d [\d]* [\d]* ; [\S\s]*/) {
                                Date date = Date.parse('yyyy-MM-dd', supportService.fromWeekDate(input.split(/ /)[1]))
                                def category = PaymentCategory.findByCode(input.split(/ /)[2])
                                def value = input.split(/ /)[3]
                                def notes = null
                                if (input.indexOf(';') > 0)
                                    notes = input.substring(input.indexOf(';') + 2)?.trim()
                                def d = new Payment([category: category, date: date, amount: value, description: notes])
                                if (!d.hasErrors() && d.save(flush: true))
                                    render(template: "/gTemplates/recordSummary", model: [record: d])
                                else "exp could not be saved"

                            } else render 'format not matching <br/>'

                        } else render '<br/><b>Line format not matching any defined format!</b>'
                    } catch (Exception e) {
                        render "An error has happened. See the logs."
                        e.printStackTrace()
                    }

                }

            }
            render '<br/> ' + count + ' lines were processed.'
        }

    }


    def fixWritingOrder() {
        Course.list().each() { c ->
            def o = 1
            Writing.findAllByCourse(c, [sort: 'orderNumber']).each() {
                println c.code + ' ' + it.orderNumber + ' - > ' + o
                it.orderNumber = o
                it.save(flush: true)
                println '            after ' + it.orderNumber + ' - > ' + o

                o++
            }
        }
    }


    def reindex() {
        searchableService.reindexAll()
//        searchableService.reindex()

        render(template: '/layouts/achtung', model: [message: 'Indexing completed'])
    }


    def lookup() {
        def q = params.q
        try {
            switch (params.entity) {
                case 'book':
                    if (Book.get(q.toLong()))
                        render(template: "/book/line", model: [bookInstance: Book.get(q.toLong())])
                    break
                case 'writing':
                    if (Writing.get(q.toLong()))
                        render(template: "/writing/line", model: [writingInstance: Writing.get(q.toLong())])
                    break
                case 'goal':
                    if (Goal.get(q.toLong()))
                        render(template: "/goal/line", model: [goalInstance: Goal.get(q.toLong())])
                    break
                case 'task':
                    if (q ==~ /\d\d\d\d/ && Book.get(q.toLong()))
                        render(template: "/task/line", model: [taskInstance: Task.get(q.toLong())])
                    break
            }
        } catch (Exception e) {
            render '?'
        }

    }


    def changedIndicatorData() {
        render(template: '/reports/changedIndicatorData')
    }

    def moveFile() {

        def path = session[params.id]

        def filename = path.split('/').last()
        def ant = new AntBuilder()
        ant.move(file: path, tofile: '/todo/ebk/' + filename)

    }

    def download() {

        def path = session[params.id]

        // todo to make it smarter!

        def f = new File(path)

        def corename = f.getName().split(/\./)[0]
        def entityCode = corename.substring(corename.length() - 1, corename.length())
        def id = corename.substring(0, corename.length() - 1)

        def title = ''
        /*       try {
            switch (entityCode) {
                case 'a':
                    title = Book.findById(id.toLong()).title
                    break
                case 'r':
                    title = (Book.findById(id.toLong()).title ?: '') + ' ' + (Book.findById(id.toLong()).legacyTitle ?: '')
                    break
                case 'n':
                    title = Book.findById(id.toLong()).title
                    break
                case 'e':
                    title = Excerpt.findById(id.toLong()).chapters + ' ' + Excerpt.findById(id.toLong()).summary
                    break

                case 'd':
                    title = IndexCard.findById(id.toLong()).summary
                    break
                case 'c':
                    title = IndexCard.findById(id.toLong()).summary
                    break

            }
            title = title.split(/\./)[0]

        }
        catch (Exception e) {
            title = ''
        }
    */

        def fileName = f.getName().split(/\./)[0]?.replaceAll(/\./, '-') + '_' + '.' + f.getName().split(/\./)[1]
        //+ new Date().format('yy') + 'y-' + getSupportService().toWeekDate(new Date())
        // + ' _ ' + title

//        println title + '  sad ' + entityCode + ' 2nd  ' + URLEncoder.encode(filename, "UTF-8")

        def finaln = fileName//.replaceAll(' ', '-')//URLDecoder.decode(fileName, 'UTF-8')
//        println URLEncoder.encode(finaln, 'UTF-8')

        if (f.exists()) {
            response.setCharacterEncoding("UTF-8");
            //response.setContentType("application/octet-stream")
//            response.setHeader("Content-disposition", "attachment; filename=\"" + finaln + "\"")
//            response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + finaln);

            response.setHeader("Content-Disposition",
                    "inline;filename*=UTF-8''${URLEncoder.encode(finaln, 'UTF-8').replaceAll(/\+/, '%20')}")

            // todo post
//                response.setHeader("Content-disposition", "attachment; filename=\"${filename}\"")
            response.outputStream << new FileInputStream(path)
        }

    }

    def openFile() {
        def path = session[params.id.toString()]

        def extension = path.split(/\./).last()
        def program
        switch (extension) {
            case 'pdf': program = "okular"
                break;

            case 'mobi': program = "calibre"
                break;

            case 'epub': program = "okular"
                break

            case 'djvu': program = "okular"
                break;
            case 'djv': program = "okular"
                break;

            case 'zip': program = "ark"
                break;

            case 'rar': program = "ark"
                break;

            case 'doc': program = "okular"
                break;

            case 'chm': program = "kchmviewer"
                break;
            case 'htm': program = "firefox"
                break;
            case 'txt': program = "kate"
                break;
        }
        try {
            println "${program} ${path}"
            "${program} ${path}".execute()

            render 'Book opened'
        } catch (Exception e) {
            render 'File CANNOT be opened'
            log.error e
        }

    }

    def test = {
        supportService.createLink(616, 'b')
    }

    /* used */

    def orderRecords() {

        def listtemp = params.table1

        def paramList = []
        if (listtemp && listtemp != 'null') {
            (listtemp?.class?.isArray()) ? paramList << (listtemp as List) : paramList << (listtemp)
            paramList = paramList.flatten()
        }
        def list = paramList


        def type = params.type
        def child = params.child
        def i = 1

        def lastId // id of last non-letter row
        params['table' + params.tableId].each() {

            try {
                def j = Integer.parseInt(it)
                def f
                f = grailsApplication.classLoader.loadClass(entityMapping[child]).get(j)
                f.orderNumber = i
                i++
//                if (type == 'W')
//                    f.orderInWriting = i
//                else if (type == 'B')
//                    f.orderInBook = i
//                else if (type == 'G')
//                    f.orderInGoal = i
//                else if (type == 'C')
//                    f.orderInCourse = i
//                else if (type == 'D')
//                    f.orderInDepartment = i


            } catch (Exception e) {
                println 'Problem in sorting the records'
                println e.printStackTrace()
            }
        }

        render('Records ordered')

    }


    def folderPdfMetadataTitleUpdate() {
        def path = OperationController.getPath('onyx.path')
        new File(path).eachFileMatch(~/[\w\W\S\s]*\.pdf/) { file ->
            supportService.pdfTitleUpdate(path, file.name, '')
        }
    }


    static def getPath(String code) {
        if (Setting.findByName('appFolder'))
            return Setting.findByName(code)?.value?.replace(/[appFolder]/, Setting.findByName('appFolder')?.value)
        //System.properties['catalina.base'] ?: '.')
        else
            return Setting.findByName(code)?.value?.replace(/[appFolder]/, '.')
    }


    def generateBibEntry(Long id) {
        render OperationController.generateBibEntrySt(id)
    }

    static String generateBibEntrySt(Long id) {
        def r = Book.get(id)

        if (!r.code)
            r.code = r.id.toString()

        if (!r.authorInBib && r.author)
            r.authorInBib = r.author?.replace('ال', '')

        def entry
        def language

        switch (r.language) {
            case 'ar':
                language = '1'
                break;
            case 'ar':
                language = '1'
                break;
            case 'fa':
                language = '2'
                break;
            default:
                language = '3'
                break;
        }

        def type = ''

        switch (r.type?.code) {
            case 'ebk':
                type = '1'
                break;
            case 'art':
                type = '2'
                break;
            case 'sfc':
                type = '3'
                break;
            default:
                type = '4'
                break;
        }

        if (type == '1' && r.bookmarked == true)
            type = type + 'a'
        else
            type = type + 'b'

        if (r.type?.code != 'art')
            entry = """
@BOOK{${r.code ?: r.id + ''},
author = "${r.author ?: ''}",${r.translator ? "\ntranslator = {" + r.translator + '},' : ''} ${
                r.editor ? "\neditor = {" + r.editor + '},' : ''
            }
language = "${r.authorInBib ? r.authorInBib : ''}",
note = {${type + language ?: ''}},
title = "${r.title ?: ''}",
titleaddon = "${r.legacyTitle ?: ''}",
publisher = "${r.publisher ?: ''}",
edition = "${r.edition ?: ''}",
year = "${r.year ? r.year?.replace('-', '') : (r.publicationDate ?: '')}",${
                r.month ? "\nmonth = {" + r.month + '},' : ''
            }
address = "${r.publicationCity ?: ''}"
}
"""
        else if (r.type?.code == 'art')
            entry = """
@ARTICLE{${r.code ?: r.id + ''},
author = "${r.author ?: ''}",
language = "${r.authorInBib ? r.authorInBib : ''}",
note = {${type + language ?: ''}},
title = "${r.title ?: ''}",
titleaddon = "${r.legacyTitle ?: ''}",
journal = "${r.journal ?: r.book?.title}",
url = "${r.sourceFree ?: ''}",
urldate = {${r.dateCreated.format('yyyy-MM-dd')}},
year = "${r.year ?: ''}",
month = "${r.month ?: ''}",
series = "${r.series ?: ''}",
volume = "${r.volume ?: ''}",
number = "${r.number ?: ''}",
pages = "${r.pages ?: ''}"
}
"""
        else if (r.type?.code == 'sfc')
            entry = """
@SOFTWARE{${r.code ?: r.id + ''},
author = "${r.author ?: ''}",
publisher = "${r.publisher ?: ''}",
language = "${r.authorInBib ? r.authorInBib : ''}",
note = "${type + language ?: ''}",
title = "${r.title ?: r.legacyTitle}",
url = "${r.sourceFree ?: ''}",
version = "${r.number ?: ''}",
date = "${r.year ?: ''}"
}
"""
//        Todo: nbpages -> pages
        r.bibEntry = entry
//        render entry?.replace('\n', '<br/>')
        return entry?.replace('\n', '<br/>')


    }

    def addBibtex(Long id) {

        def it = Book.get(id)
        if (it.isbn) {
            def url = new URL("http://www.ottobib.com/isbn/${it.isbn}/bibtex")
            def connection = url.openConnection()
            try {
                if (connection.responseCode == 200) {
                    sleep(200)
                    def t = connection.content.text
                    def f = t.substring(t.indexOf('@'))
                    def ff = f.substring(f.indexOf('@'), f.indexOf('<'))
                    //                    println ff
                    //java.util.regex.Matcher matcher2 = ff =~ /[\W\w]* author = \{([\w ,]*)\}[\W\w]
                    //      println 'author is ' + matcher2[0]
                    it.bibEntry = ff
                    //                    println it.id
                    it.save(flush: true)
                    //object
                    render ff
//                    render(template: '/gTemplates/recordDetails', model: [record:
//                            it
//                    ])

                }
            }
            catch (Exception e) {
                render(template: '/layouts/achtung', model: [message: "Problem..."])
                log.warn('problem in getting bib entry of b' + it.id) //e.printStackTrace()
            }
        }

    }


    def autoCompleteTagsJSON() {
        def responce = []

//        if (params.query && params.query.trim() != '') {
//            Tag.findAllByNameLike(params.query + '%', [sort: 'id']).each() {
//                println 'here'
//                responce += [
//                        id: it.id,
//                        value: it.value,
//                        text: it.name]
//            }
//        } else {
        Tag.findAll([sort: 'id']).each() {
            responce += [
                    id   : it.id,
                    value: it.name,
                    text : it.name]
        }
//    }
        render responce as JSON
    }

    def autoCompleteContactsJSON() {
        def responce = []
//        if (params.query && params.query.trim() != '') {
//            Tag.findAllByNameLike(params.query + '%', [sort: 'id']).each() {
//                println 'here'
//                responce += [
//                        id: it.id,
//                        value: it.value,
//                        text: it.name]
//            }
//        } else {
        Contact.findAll([sort: 'id']).each() {
            responce += [
                    id   : it.id,
                    value: it.summary,
                    text : it.summary]
        }
//    }
        render responce as JSON
    }

    def autoCompleteBlogsJSON() {
        def responce = []

//        if (params.term && params.term.trim() != '') {
//            Tag.findAllByNameLike(params.term + '%', [sort: 'name']).each() {
//                responce += it.name + '\n'
//            }
//        } else {
        Blog.findAll([sort: 'code']).each() {
            responce += [
                    value: it.id,
                    text : it.code]
        }
//        }
        render responce as JSON
    }

    def autoCompleteTags() {
        def responce = ''

        if (params.term && params.term.trim() != '') {
            Tag.findAllByNameLike(params.term + '%', [sort: 'name']).each() {
                responce += it.name + '\n'
            }
        } else {
            Tag.findAll([sort: 'name']).each() {
                responce += it.name + '\n'
            }
        }
        render responce
    }

    def autoCompleteContacts() {
        def responce = ''

        if (params.q && params.q.trim() != '') {
            Contact.findAllBySummaryLike('%' + params.q + '%', true, [sort: 'summary']).each() {
                responce += it.summary + '\n'
            }
        } else {
            Contact.findAll([sort: 'summary']).each() {
                responce += it.summary + '\n'
            }
        }
        render responce
    }


    def downloadNoteFile = {
        def file = IndexCard.get(params.id)

        if (new File(OperationController.getPath('module.sandbox.N.path') + '/' + file.id).exists()) {
            response.setHeader("Content-disposition", "attachment; filename=\"${file.fileName}\"")
            //   response.contentType = "application/vnd.ms-word"
            response.outputStream << new FileInputStream(OperationController.getPath('module.sandbox.N.path') + '/' + file.id)
        } else if (new File(OperationController.getPath('module.repository.N.path') + '/' + file.id).exists()) {
            response.outputStream << new FileInputStream(OperationController.getPath('module.repository.N.path') + '/' + file.id)
        } else {
            render "Document was not found."
        }

    }


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

    static Date fromWeekDateAsDateTimeFullSyntax(String weekDate) {
        def year = new Date().format('yyyy')
        if (weekDate.contains('.'))
            year = '20' + weekDate.substring(4, 6)
        def time = '00:00'

        if (weekDate.contains('_')) {
            def chunk = weekDate.split('_')[1].trim()

            if (chunk.length() > 2) {

                if (chunk.length() == 3)
                    chunk = '0' + chunk

                time = chunk.substring(0, 2) + ':' + chunk.substring(2, 4)
            } else {
                time = weekDate.split('_')[1] + ':00'
            }
        }

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


    def getQuickEditValues() {
        def entity = params.entity.toString()
        def field = params.field
        def responce = []
        if (field == 'blog') {
            Blog.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if (field == 'pomegranate') {
            Pomegranate.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if (field == 'department') {
            Department.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if (field == 'language') {
            OperationController.getPath('repository.languages').split(',').each() {
                responce += [value: it,
                             text : it]
            }
        } else if (field == 'course') {
//            def n = grailsApplication.classLoader.loadClass(entityMapping[params.entity]).get(params.rid)
//            if (n.department) {
//                Course.executeQuery('from Course c where c.department = ? and c.bookmarked = true order by c.orderNumber asc',
            Course.executeQuery('from Course c where c.bookmarked = true order by c.orderNumber asc',
                    []).each() {
                responce += [value: it.id,
                             text : '[' + it.code + '] ' + it.summary]
            }
//            } else
//                responce += [value: 0,
//                             text : 'No department set.']

        } else if (field == 'markdown') {
            Markup.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.summary]
            }
        } else if (entity == 'T' && field == 'context') {
            Context.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if (entity == 'G' && field == 'type') {
            GoalType.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('W' == entity && field == 'type') {
            WritingType.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('J' == entity && field == 'type') {
            JournalType.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('P' == entity && field == 'type') {
            PlannerType.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('N' == entity && field == 'type') {
            WritingType.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('R' == entity && field == 'type') {
            ResourceType.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('R' == entity && field == 'status') {
            ResourceStatus.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ("NW".contains(entity) && field == 'status') {
            WritingStatus.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('GTP'.contains(entity) && field == 'status') {
            WorkStatus.findAll([sort: 'code']).each() {
                responce += [value: it.id,
                             text : it.code]
            }
        } else if ('RTPJ'.contains(entity) && field == 'goal') {
            def n = grailsApplication.classLoader.loadClass(entityMapping[params.entity]).get(params.recordId)
            if (n.course) {
                Book.executeQuery('from Goal r where r.course = ? and r.status.code = ? order by orderNumber asc', [n.course, 'inp']).each() {
                    responce += [value: it.id,
                                 text : it.summary]
                }
            } else {
                Book.executeQuery('from Goal r where r.course.bookmarked = ? and r.status.code = ? order by orderNumber asc', [true, 'inp']).each() {
                    responce += [value: it.id,
                                 text : it.summary]
                }
            }
        } else if ('N' == entity && field == 'writing') {
            def n = app.IndexCard.get(params.recordId.toLong())
            if (n.course) {
                Writing.executeQuery('from Writing w where w.course = ? order by course, orderNumber', [n.course], [sort: 'orderNumber']).each() {
                    responce += [value: it.id,
                                 text : it.course.code + ': ' + it.summary]
                }
            } else {
                Writing.executeQuery('from Writing w where w.course.bookmarked = ? order by w.course.department.orderNumber asc, w.course.orderNumber asc, w.orderNumber asc', [true]).each() {
                    responce += [value: it.id,
                                 text : it.course?.code + ': ' + it.summary]
                }
            }//       else if ('NJ'.contains(entity) && field == 'writing') {
//            Writing.executeQuery('from Writing w where w.course.bookmarked = ? ', [true], [sort: 'summary']).each() {
//                responce += [value: it.id,
//                             text : it.summary]
//            }   ToDo: N linked to J?
        } else if (field == 'book') {
            def n = grailsApplication.classLoader.loadClass(entityMapping[params.entity]).get(params.recordId)

            if (n.class.declaredFields.name.contains('course') && n.course) {

                Book.executeQuery('from Book r where r.course = ? and r.status.code = ? order by orderNumber asc', [n.course, 'zbk']).each() {
                    responce += [value: it.id,
                                 text : '@' + it.code + ': ' + it.title]
                }
            } else {
                Book.executeQuery('from Book r where r.course.bookmarked = ? and r.status.code = ? order by orderNumber asc', [true, 'zbk']).each() {
                    responce += [value: it.id,
                                 text : '@' + it.code + ': ' + it.title]
                }
            }
        } else if (field == 'plannedDuration') {
            (1..10).each() {
                responce += [value: it,
                             text : it]
            }
        } else if (field == 'priority') {
            (1..4).each() {
                responce += [value: it,
                             text : it]
            }
        } else if (field == 'percentCompleted') {
            (1..10).each() {
                responce += [value: it * 10,
                             text : it * 10]
            }
        } else if (field == 'recurringInterval') {
            (1..9).each() {
                responce += [value: it,
                             text : it]
            }
            (1..10).each() {
                responce += [value: it * 10,
                             text : it * 10]
            }
        }
        render responce as JSON
    }

    def quickSave2() {
        def id = params.pk
        def newValue = params.value
        def field = params.name.split('-')[0]
        def entity = params.name.split('-')[1]

        def record = grailsApplication.classLoader.loadClass(entityMapping[entity]).get(id)

        if (field == 'blog')
            record[field] = Blog.get(newValue)
        if (field == 'language')
            record[field] = newValue

        else if (field == 'pomegranate')
            record[field] = Pomegranate.get(newValue)
        else if (field == 'course') {
            record[field] = Course.get(newValue)
            if (!record.department)
                record.department = Course.get(newValue).department
        } else if (field == 'book') {
            record[field] = Book.get(newValue)
            if (!record.department)
                record.department = Book.get(newValue).department
        } else if (field == 'goal')
            record[field] = Goal.get(newValue)
        else if (field == 'writing') {
            record.entityCode = 'W'
            record.recordId = newValue
            if (!record.department)
                record.department = Writing.get(newValue).department
        } else if (field == 'context')
            record[field] = Context.get(newValue)

        else if (field == 'location')
            record[field] = Location.get(newValue)

        else if ('WN'.contains(entity) && field == 'type')
            record[field] = WritingType.get(newValue)
        else if (entity == 'G' && field == 'type')
            record[field] = GoalType.get(newValue)
        else if (entity == 'P' && field == 'type')
            record[field] = PlannerType.get(newValue)
        else if (entity == 'J' && field == 'type')
            record[field] = JournalType.get(newValue)
        else if (entity == 'R' && field == 'type')
            record[field] = ResourceType.get(newValue)

        else if ('GTP'.contains(entity) && field == 'status')
            record[field] = WorkStatus.get(newValue)
        else if ('R'.contains(entity) && field == 'status')
            record[field] = ResourceStatus.get(newValue)
        else if ('WN'.contains(entity) && field == 'status')
            record[field] = WritingStatus.get(newValue)

        else if (field == 'plannedDuration')
            record[field] = newValue.toInteger()
        else if (field == 'priority')
            record[field] = newValue.toInteger()
        else if (field == 'recurringInterval')
            record[field] = newValue.toInteger()
        else if (field == 'percentCompleted')
            record[field] = newValue.toInteger()
        else if (field == 'department')
            record[field] = Department.get(newValue.toLong())

        render(['ok'] as JSON)
    }


    def generateCover() {

        String pdfPath = params.path

        if (params.module == 'E')
            params.type = 'exr'

        //config option 2:convert page 1 in pdf to image
        String[] args_2 = new String[7];
        args_2[0] = "-startPage";
        args_2[1] = "1"
        args_2[2] = "-endPage";
        args_2[3] = "1";
        args_2[4] = "-outputPrefix"
        args_2[5] = OperationController.getPath('root.rps1.path') + '/cvr/' + (params.type ? '/' + params.type : '') + '/' + params.id;
        args_2[6] = pdfPath;

        try {
            // will output "my_image_2.jpg"
            PDFToImage.main(args_2);
            def ant = new AntBuilder()
            ant.move(file: args_2[5] + '1.jpg', tofile: (args_2[5] + '.jpg'))

        }
        catch (Exception e) {
            e.printStackTrace()
        }
    }

    def checkoutFile() {

        String pdfPath = params.path

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true
        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true

        def outPath

        if (params.module == 'R')
            outPath = OperationController.getPath('root.rps1.path') + '/' + params.module +
                    (resourceNestedByType ?  '/' +  params.type : '') +
                    (resourceNestedById ?  '/' +   (params.id.toLong() / 100).toInteger() : '') +
                    '/' + params.id
        else
            outPath = OperationController.getPath('root.rps1.path') + '/' + params.module + '/' + params.id


        try {
            // will output "my_image_2.jpg"
            def ant = new AntBuilder()
            ant.copy(file: pdfPath, tofile: outPath + '/' + params.name)

            render(template: '/layouts/achtung', model: [message: params.name + ' checked out to: ' + outPath])
        }
        catch (Exception e) {
            render(template: '/layouts/achtung', model: [message: 'Problem while checking out ' + params.name])
            e.printStackTrace()
        }

    }


    def checkoutFileOut() {

        String pdfPath = params.path
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.module]).get(params.id)
        def outPath
        outPath = OperationController.getPath('root.out.path') + '/' + params.name.split(/\./)[1] + '/' +
                '/' + params.id + ' ' + clean(record.title) + '-' + params.name.replace(params.id + 'r', '').replace(params.id + 'b', '').trim()


        try {
            def ant = new AntBuilder()
            ant.copy(file: pdfPath, tofile: outPath)
            render(template: '/layouts/achtung', model: [message: params.name + ' checked out as: ' + outPath])
        }
        catch (Exception e) {
            render(template: '/layouts/achtung', model: [message: 'Problem while checking out ' + params.name])
            e.printStackTrace()
        }

    }


    def copyToRps1() {

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true
        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true

        def b
        if (params.entityCode == 'R')
            b = Book.findById(params.id)
        else
            b = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)


        if (b) {

            def filesList = []

            def rps1Folder
            def rps2Folder
            if (params.entityCode == 'R') {
                rps1Folder =
                        OperationController.getPath('root.rps1.path') + '/R' +
                (resourceNestedByType ?  '/' +  b.type.code : '') +
                        (resourceNestedById ?  '/' +   (params.id.toLong()/ 100).toInteger() : '') +
                        '/' + params.id

                rps2Folder =
                        OperationController.getPath('root.rps2.path') + '/R' +
                        (resourceNestedByType ?  '/' +  b.type.code : '') +
                        (resourceNestedById ?  '/' +   (params.id.toLong()/ 100).toInteger() : '') +
                        '/' + params.id
            } else {
                rps1Folder = OperationController.getPath('root.rps1.path') + '/' + params.entityCode + '/' + params.id
                rps2Folder = OperationController.getPath('root.rps2.path') + '/' + params.entityCode + '/' + params.id
            }

            new File(rps1Folder).mkdirs()

            if (new File(rps2Folder).exists()) {
                new File(rps2Folder).eachFileMatch(~/[\S\s]*\.[\S\s]*/) {
                    filesList.add(it)
                }
            }

            def ant = new AntBuilder()

            filesList.each() { f ->
                ant.copy(file: f.path, tofile: rps1Folder + '/' + f.name)
            }
            render filesList.size() + ' file(s) copied.'
        } else {
            render 'Record not found.'
        }
    }


    def deleteFile() {

        def path = session[params.id]
        def f = new File(path)
        f.delete()

        try {
            if (!f.exists()) {
                render "<b style='color: darkred'>File deleted: " + path + '</b>'
            } else {
                render 'File was not deleted: ' + path

            }
        } catch (
                Exception e
                ) {
            render 'Problem deleting file: ' + path + ': ' + e.toString()
            log.error e.printStackTrace()
        }
    }

    def countResourceFiles() {

        def typeSandboxPath
        def typeLibraryPath

        def typeRepositoryPath

        def filesCount
        def filesList = []
        def folders

        def list

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true
        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true


        if (params.entityCode == 'R') {

            if (params.id)
                list = [Book.get(params.id)]
            else list = [Book.get(1)] //Todo

            for (b in list) {
                filesCount = 0
                folders = []
                typeSandboxPath = OperationController.getPath('root.rps1.path') + '/R' +
                (resourceNestedByType ?  '/' +  b.type.code : '') + '/'
//            typeLibraryPath = OperationController.getPath('root.rps3.path') + 'R/' + b.type?.code
                //ResourceType.findByCode(type).libraryPath
                typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/R' +
                        (resourceNestedByType ?  '/' +  b.type.code : '') + '/'

                folders.add(
                        [typeSandboxPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')])
                if (!b.bookmarked)
                    folders.add(
                            [typeRepositoryPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')])
//                    typeLibraryPath + '/' + (b.id / 100).toInteger()
                //     ]
                folders.each() { folder ->
                    if (new File(folder[0]).exists()) {
                        new File(folder[0]).eachFileMatch(~/${b.id}[a-z][\S\s]*\.[\S\s]*/) {
                            filesCount++
                            filesList += it.name// + '\n'
                        }
                    }
                }
                folders = []
                folders.add(
                        [typeSandboxPath +  (resourceNestedById ? '/' + (b.id / 100).toInteger() : '') + '/' + b.id])
//                    typeLibraryPath + '/' + (b.id / 100).toInteger() + '/' + b.id,
                if (!b.bookmarked)
                    folders.add([typeRepositoryPath + (resourceNestedById ? '/' + (b.id / 100).toInteger() : '') + '/' + b.id])
//                ]

                folders.each() { folder ->
//                    println 'fld ' + folder + ' class ' + folder.class
                    if (new File(folder[0]).exists()) {
                        new File(folder[0]).eachFileRecurse() {
//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                            if (!it.isFile())
                                filesList += '*** ' + it.name
                            else {
                                filesCount++
                                filesList += it.name
                            }
                        }
                    }
                }
                //println filesCount
                b.nbFiles = filesCount
                b.filesList = filesList.join('\n')


            }
        } else {

            list =
                    [grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)]

            for (b in list) {
                filesCount = 0
                folders = []
                typeSandboxPath = OperationController.getPath('root.rps1.path') + '/' + params.entityCode + '/'

                typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/' + params.entityCode + '/'
                folders.add([typeSandboxPath + '/' + (b.id)])
                if (!b.bookmarked)
                    folders.add([typeRepositoryPath + '/' + (b.id)])



                folders.each() { folder ->
                    if (new File(folder[0]).exists()) {
                        new File(folder[0]).eachFileRecurse() {
//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                            if (!it.isFile())
                                filesList += '*** ' + it.name
                            else {
                                filesCount++
                                filesList += it.name
                            }
                        }
                    }
                }
                //println filesCount
                b.nbFiles = filesCount
                b.filesList = filesList.join('\n')
            }
        }

        render '<br/>' + filesCount + ' files: <br/>' + filesList.join('\n').replace('\n', '<br/>')
    }
  static void countResourceFilesStatic(Long id, String entityCode) {

        def typeSandboxPath
        def typeLibraryPath

        def typeRepositoryPath

        def filesCount
        def filesList = []
        def folders

        def list

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true
        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true


        if (entityCode == 'R') {

                list = [Book.get(id)]

            for (b in list) {
                filesCount = 0
                folders = []
                typeSandboxPath = OperationController.getPath('root.rps1.path') + '/R' +
                (resourceNestedByType ?  '/' +  b.type.code : '') + '/'
//            typeLibraryPath = OperationController.getPath('root.rps3.path') + 'R/' + b.type?.code
                //ResourceType.findByCode(type).libraryPath
                typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/R' +
                        (resourceNestedByType ?  '/' +  b.type.code : '') + '/'

                folders.add(
                        [typeSandboxPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')])
                if (!b.bookmarked)
                    folders.add(
                            [typeRepositoryPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')])
//                    typeLibraryPath + '/' + (b.id / 100).toInteger()
                //     ]
                folders.each() { folder ->
                    if (new File(folder[0]).exists()) {
                        new File(folder[0]).eachFileMatch(~/${b.id}[a-z][\S\s]*\.[\S\s]*/) {
                            filesCount++
                            filesList += it.name// + '\n'
                        }
                    }
                }
                folders = []
                folders.add(
                        [typeSandboxPath +  (resourceNestedById ? '/' + (b.id / 100).toInteger() : '') + '/' + b.id])
//                    typeLibraryPath + '/' + (b.id / 100).toInteger() + '/' + b.id,
                if (!b.bookmarked)
                    folders.add([typeRepositoryPath + (resourceNestedById ? '/' + (b.id / 100).toInteger() : '') + '/' + b.id])
//                ]

                folders.each() { folder ->
//                    println 'fld ' + folder + ' class ' + folder.class
                    if (new File(folder[0]).exists()) {
                        new File(folder[0]).eachFileRecurse() {
//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                            if (!it.isFile())
                                filesList += '*** ' + it.name
                            else {
                                filesCount++
                                filesList += it.name
                            }
                        }
                    }
                }
                //println filesCount
                b.nbFiles = filesCount
                b.filesList = filesList.join('\n')
//                println 'filesList '  + filesList.join('\n')
                b.save(flush: true)


            }
        } else {
switch (entityCode){
    case 'T':
        list = [Task.get(id)]
        break;
    case 'G':
        list = [Goal.get(id)]
        break;
    case 'N':
        list = [IndexCard.get(id)]
        break;
    case 'W':
        list = [Writing.get(id)]
        break;
    case 'P':
        list = [Planner.get(id)]
        break;
    case 'J':
        list = [Journal.get(id)]
        break;

}

            for (b in list) {
                filesCount = 0
                folders = []
                typeSandboxPath = OperationController.getPath('root.rps1.path') + '/' + entityCode + '/'

                typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/' + entityCode + '/'
                folders.add([typeSandboxPath + '/' + (b.id)])
                if (!b.bookmarked)
                    folders.add([typeRepositoryPath + '/' + (b.id)])



                folders.each() { folder ->
                    if (new File(folder[0]).exists()) {
                        new File(folder[0]).eachFileRecurse() {
//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                            if (!it.isFile())
                                filesList += '*** ' + it.name
                            else {
                                filesCount++
                                filesList += it.name
                            }
                        }
                    }
                }
                //println filesCount
                b.nbFiles = filesCount
                b.filesList = filesList.join('\n')
                b.save(flush: true)
            }
        }


       // render '<br/>' + filesCount + ' files: <br/>' + filesList.join('\n').replace('\n', '<br/>')
    }


    def updateTotalSteps() {
//        println 'id is  ' + params.id
        def issue = mcs.Goal.findById(params.id?.toLong())
        issue.totalSteps = params.text?.toInteger()

        issue.save()
        render issue.totalSteps
    }

    def updateCompletedSteps() {
//        println 'id is  ' + params.id
        def issue = mcs.Goal.findById(params.id?.toLong())
        issue.completedSteps = params.text?.toInteger()

        issue.save()
        render issue.completedSteps
    }

    String shortForm(String i) {
        def b = mcs.Book.findByCode(i)
        if (b.language == 'ar')
            return b.author?.replace('{', '').replace('}', '') + '، ' + b.title + ' \\مس' //+ b.publisher
        else
            return b.author + ', ' + b.title + 'Ibid'
    }

    String longForm(Long i) {
        return 'abc'
    }

    def filterTags() {
        if (params.value && params.value.length() > 1)
            render(template: '/reports/tagCloud', model: [filter: params.value])
        else if (params.value && params.value.length() == 1) {
            render('Please enter at least two characters.')
            render(template: '/reports/tagCloud', model: [])
        } else// if (params.value == '' || !params.value || params.value == 'null')
            render(template: '/reports/tagCloud', model: [])

    }

    def generateCitationsInline() {

        def text = new File('d:/t1.tex').text
//println 'text '+ text
        def t2 = ''
        def found = false
        def lmatch = ''
        java.util.regex.Matcher matcher
        def past = []
        text.eachLine() { l ->
            println 'current line: ' + l

            if (l ==~ /\\م[\S]\{([\S_-]*)\}/) {
                println 'current line: ' + l
                matcher = l =~ /\\م[\S]\{([\S_-]*)\}/
                //println 'match' +  matcher.match[0]
                matcher.eachWithIndex() { match, i ->
                    lmatch = match[1]
                    if (past.contains(match[1]))
                        println ' found before' + shortForm(match[1])
                    else println ' new ' + shortForm(match[1])
                    t2 += l + '\n'
                    found = true
                    past += match[1]
                }
            } else if (found == true) {
                found = false
                t2 += "{" + shortForm(lmatch) + '}\n'

            } else {
                t2 += l + '\n'
            }
        }

//println "t2: "  + t2
        new File('d:/t3.out').write(t2, 'UTF-8')

/*
def authors = []
past.each(){
//authors+= 'someone'

}
*/

//past.each(){
//  println "\\item " + shortForm(17166)
//}
        ''

    }

    def generateStaticBlogMenu() {
        def h = """
<html dir="rtl" lang="ar-LB">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>menu</title>
	    <link rel="stylesheet" href="./css/menu.css" type="text/css" media="screen" title="Menu" charset="utf-8" />
    </head>
    <body>
        <div style="text-align:center;" class="menuTitle">
            <a href="./guide/index.html" target="mainFrame"></a>
        </div>

        <h1 class="menuTitle">لائحة المقالات</h1>
"""

        def f = """

    </body>
</html>
"""

        def s = ''

        Book.executeQuery('select distinct course  from app.IndexCard i where i.blog.code = ? and i.course is not null order by i.course.department.orderNumber asc, i.course.orderNumber asc', ['khuta'],
                [sort: 'id', order: 'desc']).each() { c ->

            s += """
<h4>
(${c.department?.code ?: ''}) ${c.summary}
</h4>\n\n"""


            mcs.Book.executeQuery('from app.IndexCard r where r.blog.code = ? and r.course = ? order by r.id desc', ['khuta', c]).each() {
                s += "${it?.writing?.summary ?: ''} :: <br/>"
                s += """<div class='menuUsageItem'>
+ <a href="art/N-${it.id}.md.html" target="mainFrame">
(${it.status?.code ?: ''}) ${it.summary}</a>
</div>\n\n"""
            }
        }


        new File('d:/t/menu.html').write(h + s + f, 'UTF-8')
        render s.encodeAsHTML()
    }

    def updateSettings() {
        def s = Setting.get(params.id)
        s.value = params.newValue
        render s.value
    }

// todo: added the ability to update a single setting, but its code name.
    def updateSettingsByName() {

        def s = Setting.findByName(params.settingName)
        s.value = params.newValue
//        render '>> ' + s.value
//        println 'pa ' + s.value
        render(template: '/layouts/achtung', model: [message: 'Value set to ' + s.value])
    }

    def addFromCalendar() {

//           println 'title ' +  params.title

        def j

        if (params.type == 'J')
            j = new mcs.Journal([startDate  : Date.parse('dd.MM.yyyy HH:mm', params.start),
                                 endDate    : Date.parse('dd.MM.yyyy HH:mm', params.end),
                                 description: params.description ?: '...'])
        else if (params.type == 'P') {//(params.title.startsWith('p ') ||  params.title.startsWith('م ')) {
            j = new mcs.Planner([startDate  : Date.parse('dd.MM.yyyy HH:mm', params.start),
                                 endDate    : Date.parse('dd.MM.yyyy HH:mm', params.end),
                                 description: params.description ?: '...'])
        }
//	if (j.startDate == j.endDate)
//	j.level = 'd'
//	else
        j.level = 'm'

        if (params.title?.contains('--'))
            j.properties = ker.GenericsController.transformMcsNotation(params.title?.replace('--', ' -- '))['properties']
        else j.summary = params.title//?.substring(2)

        if (params.description)
            j.description = params.description

        if (params.type == 'P' && !j.type)
            j.type = PlannerType.findByCode('act')
        else if (!j.type)
            j.type = JournalType.findByCode('act')

//        if (j.level == 'd')
//            j.endDate = null

        if (!j.hasErrors()) {
            j.save(flash: true)
//            render 'Saved with id: ' + ' ' + j.id + ': ' + j.summary
            //render (template: '/layouts/addToCalendar', model: [record: j])
            render(template: '/gTemplates/box', model: [record: j])
        } else {
            render 'Problem saving the entry'
        }
    }

    def clean(String name) {
        def cleaned = org.apache.commons.lang.WordUtils.abbreviate(name, 20, 30, org.apache.commons.lang.StringUtils.EMPTY)
        ",.+-:;!?~_-|/\\".each() {
            cleaned = cleaned.replace(it, ' ')
        }
        return cleaned.trim().replace('  ', ' ')
    }

    def pandoc() {
        def w = Writing.get(params.id)
        def command = "D:\\app\\pandoc281\\pandoc -f markdown --html-q-tags --toc --metadata rtl=true -i r:/W/W-${w.id}.md -o r:/W/W-${w.id}.md.html"
        try {
            println 'command: ' + command
            println 'exit: ' + command.execute().exitValue()
            println 'out: ' + command.execute().outputStream
            println 'err: ' + command.execute().errorStream
            render 'done'
        } catch (Exception e) {
            println e.toString()
            render 'done'
        }
    }

    def htmlPublishedPosts() {
        def html = "<body style='direction: rtl; text-align: right; margin-left: 20%;margin-right: 20%;'>"
        Writing.executeQuery('from Writing w where w.blog.code = ? and w.publishedNodeId is not null order by id desc', ['khuta']).each() {

            html += "<h3> i" + it.id + ' =' + it.code + ' ' + it.summary + "</h3>"
            html += it.descriptionHTML
        }

        render html

    }

    def sortNotes2() {

//        println 'id = ' + params.id
        def sub = 1
        def roots = 1
        params.id?.split('_').eachWithIndex() { i, j ->

            def id = i.split('=')[0].replace('menuItem[', '').replace(']', '')
            def n = IndexCard.get(id)//.orderNumber
            def parent = i.split('=')[1]

            //            println (j++) +': ' + id +   " --- " + parent

            if (parent != 'null') {
                def p = IndexCard.get(parent)
                n.wbsParent = p// + '.' + sub
                n.orderNumber = j+1
                n.wbsNumber = j+1
//                sub++
                n.save(flush: true)
            //    println 'found a child with id ' + n.id // + +'.' + (sub++) + '\n'
            } else {
//                sub = 1
                n.wbsParent = null
                n.orderNumber = roots
                n.wbsNumber = roots
                n.save(flush: true)
                roots++
             //   println 'found a root with id ' + n.orderNumber// + +'.' + (sub++) + '\n'
            }
        }

        IndexCard.findAllByCourseAndWbsParentIsNull(mcs.Course.get(params.crs), [sort: 'orderNumber', order: 'asc'] ).eachWithIndex() { n, i ->
            n.wbsNumber = i+1
            n.orderNumber = i+1
            n.wbsParent = null
            orderChildren(n.id)
            n.save(flush: true)
        }


//        println params.dump()
        render 'Done. '// + new Date().format('HH:mm:ss')
    }

    def orderChildren(Long id) {
        def parent = IndexCard.get(id)
        IndexCard.findAllByWbsParent(parent, [sort: 'orderNumber', order: 'asc']).eachWithIndex() {
            n, i ->
                n.wbsNumber = parent.wbsNumber + '.' + (i + 1)
                n.orderNumber = (i + 1)
                orderChildren(n.id)
        }
    }


} // end of class