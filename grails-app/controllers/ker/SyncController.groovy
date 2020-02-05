package ker

import app.IndexCard
import app.parameters.*
import mcs.parameters.*
import grails.converters.XML
import grails.converters.JSON
import grails.web.JSONBuilder
import mcs.Book
import mcs.Goal
import mcs.Task
import mcs.Writing
import org.json.JSONArray
import org.springframework.http.HttpRequest
import sun.reflect.generics.factory.GenericsFactory


class SyncController {

    static entityMapping = [
            'G'            : 'mcs.Goal',
            'å'            : 'mcs.Goal',
            'T'            : 'mcs.Task',
            'Ú'            : 'mcs.Task',
            'P'            : 'mcs.Planner',
            'Î'            : 'mcs.Planner',

            'W'            : 'mcs.Writing',
            'ß'            : 'mcs.Writing',
            'N'            : 'app.IndexCard',
            'ä'            : 'app.IndexCard',

            'J'            : 'mcs.Journal',
            'Ð'            : 'mcs.Journal',
            'I'            : 'app.IndicatorData',
            'K'            : 'app.Indicator',

            'Q'            : 'app.Payment',
            'Ï'            : 'app.Payment',
            'L'            : 'app.PaymentCategory',

            'R'            : 'mcs.Book',
            'ã'            : 'mcs.Book',
            'C'            : 'mcs.Course',
            'æ'            : 'mcs.Course',
            'D'            : 'mcs.Department',
            'Ì'            : 'mcs.Department',
            'E'            : 'mcs.Excerpt',
            'Ý'            : 'mcs.Excerpt',
            'S'            : 'app.Contact',
            'Tag'          : 'app.Tag',

            'Y'            : 'cmn.Setting',
            'X'            : 'mcs.parameters.SavedSearch',
            'A'            : 'app.parameters.CommandPrefix',
//todo for all params
            'ResourceType' : 'app.parameters.ResourceType',
            'WorkStatus'   : 'mcs.parameters.WorkStatus',
            'WritingStatus': 'mcs.parameters.WritingStatus',
            'GoalType'     : 'mcs.parameters.GoalType',
            'JournalType'  : 'mcs.parameters.JournalType',
            'PlannerType'  : 'mcs.parameters.PlannerType',
            'WritingType'  : 'mcs.parameters.WritingType',
            'Context'      : 'mcs.parameters.Context',
            'Blog'         : 'app.parameters.Blog'

    ]

//    def restClient
    def syncNote() {
        def response = request

        def p = new IndexCard()//params.product)
        p.summary = request.JSON.summary
        p.description = request.JSON.description
        p.sourceFree = request.JSON.sourceFree
        p.originalId = request.JSON.id
//        p.dateCreated = Date.parse('ddMMyyy', request.JSON.dateCreated)
        p.lastUpdated = new Date()
//        p.lastReviewed = new Date()

        p.syncedOn = new Date()

        if (p.save(flush: true)) {
            render(['status': 'ok from remote PKM'])
        } else {
            println 'not saved'
            println p.errors
        }
    }

    def rssPile() {
        render(feedType: "rss", feedVersion: "2.0") {
            title = "PKM RSS"
            link = "http://192.168.1.126:1440/nibras/sync/rssPile"
            description = "..."

//NewsItem.findAllByApprovedOnIsNotNullAndByRss([sort: 'dateCreated', order: 'desc', max: 25]).each() { article ->

            def list
            list =
//                    IndexCard.findAllByDateCreatedGreaterThanAndReadOnIsNull(new Date() - 7, [sort: 'dateCreated', order: 'asc']) +
//                    IndexCard.findAllByDateCreatedGreaterThanAndBookmarked(new Date() - 7, true, [sort: 'dateCreated', order: 'asc']) +
//                            Book.findAllByDateCreatedGreaterThanAndReadOnIsNull(new Date() - 7, [sort: 'dateCreated', order: 'asc']) +
//                            Book.findAllByBookmarkedAndType(true, ResourceType.findByCode('art')) +
                    Book.findAllByBookmarked(true) +
                            Writing.findAllByBookmarked(true) +
                            IndexCard.findAllByBookmarked(true) +
                            Task.findAllByBookmarked(true) +
                            Goal.findAllByBookmarked(true)


            list.each() { r ->
                //def title =
                def style = r.language == 'ar' ? "text-align: right; direction: rtl" : ''

                entry((r.class.declaredFields.name.contains('summary') ? r.summary : '') + ' ' + (r.class.declaredFields.name.contains('title') && r.title ? r.title : '') + "") {
//  entry(article.title + ' (' + article.type.toString() + ' / ' + article.writingStatus.toString() + ' - ' + (article?.body ? article?.body?.count(' ') : '0') + ' words)') {
                    link = "http://phi:1440/nibras/sync/fetchFullText/${r.id}"
                    publishedDate = r.lastUpdated
//                    categories = "cat1,cat2"
                    author = r.entityCode() + (r.class.declaredFields.name.contains('type') && r.type ? ' / ' + r.type?.code : '') +
                            (r.class.declaredFields.name.contains('context') ? ' @' + r.context : '')
//                    content(type: 'text/html', value: 'tst')
                    content(type: 'text/html', value: "<div style='${style}'>" +
                            (r.description ? r.description?.replaceAll('\n', '<br/>') : '') + '<br/>' +
                            (r.class.declaredFields.name.contains('fullText') && r.fullText ? r.fullText?.replaceAll('\n', '<br/>') : '') + '</div>')
                    //.replaceAll('', '')
                }
            }
        }
    }

    def rssPile2() {
        render(feedType: "rss", feedVersion: "2.0") {
            title = "PKM RSS2"
            link = "http://192.168.1.131:1440/nibras/sync/rssPile2"
            description = "..."

//NewsItem.findAllByApprovedOnIsNotNullAndByRss([sort: 'dateCreated', order: 'desc', max: 25]).each() { article ->

            def list = []
            [mcs.Book,
             mcs.Writing,
             app.IndexCard
            ].each() {
                list += it.createCriteria().list() { tags { idEq(new Long(436)) } }
            }

            list.each() { r ->
                //def title =
                def style = r.language == 'ar' ? "text-align: right; direction: rtl" : ''

                entry((r.class.declaredFields.name.contains('summary') ? r.summary : '') + ' ' + (r.class.declaredFields.name.contains('title') && r.title ? r.title : '') + "") {
//  entry(article.title + ' (' + article.type.toString() + ' / ' + article.writingStatus.toString() + ' - ' + (article?.body ? article?.body?.count(' ') : '0') + ' words)') {
                    link = "http://192.168.1.126:1440/nibras/sync/fetchFullText/${r.id}"
                    publishedDate = r.lastUpdated
//                    categories = "cat1,cat2"
                    author = (r.class.declaredFields.name.contains('type') ? r.type : '#-')
//                    content(type: 'text/html', value: 'tst')
                    content(type: 'text/html', value: "<div style='${style}'>" +
                            (r.description ? r.description?.replaceAll('\n', '<br/>') : '') + '<br/>' + (r.class.declaredFields.name.contains('fullText') && r.fullText ? r.fullText?.replaceAll('\n', '<br/>') : '') + '</div>')
                    //.replaceAll('', '')
                }
            }
        }
    }

    def fetchFullText() {
        def b = mcs.Book.get(params.id)
        def t = ''
        if (b)// && b.fullText)
            t = b?.fullText?.replaceAll('\n', '<br/>') + b?.description?.replaceAll('\n', '<br/>')
        else
            t = 'No full text'

        render t

    }

    def exportJson = {
        def builder = new JSONBuilder()

        def records = []
        for (i in mcs.Planner.executeQuery("from Planner where bookmarked = ? order by startDate desc ", [true])) {
            records += [type : 'P', id: i.id,
                        meta : i.startDate?.format('dd.MM.yyyy'),
                        color: 'darkblue',
                        title: i.summary,
                        body : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in Task.executeQuery("from Goal where bookmarked = ?", [true])) {
            records += [type : 'G', id: i.id,
                        meta : (i.department ? 'd' + i.department?.code : '-') + ' ' + (i.type ? '#' + i.type?.code : '') +
                                ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        color: 'darkgreen',
                        title: i.summary,
                        body : i.description ? i.description?.replace('\n', '<br/>') : '']
        }


        for (i in Task.executeQuery("from Task where  bookmarked = ? order by lastUpdated desc", [true])) {
            records += [type : 'T', id: i.id,
                        meta : (i.context ? '@' + i.context?.code : '-') + ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        color: 'lightgreen',
                        title: i.summary,
                        body : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

        for (i in IndexCard.executeQuery("from IndexCard where  bookmarked = ? and lastUpdated > ? order by lastUpdated desc", [true, new Date() - 7])) {
            records += [type    : 'N', id: i.id,
                        meta    : (i.department ? 'd' + i.department?.code : '-'),
                        color   : 'darkorange',
                        title   : i.summary,
                        language: i.language,
                        body    : (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        for (i in IndexCard.executeQuery("from Writing where  bookmarked = ? order by lastUpdated desc", [true])) {
            records += [type : 'W', id: i.id,
                        meta : (i.department ? 'd' + i.department?.code : '-'),
                        color: 'lightorange',
                        title: i.summary,
                        body : (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }


        for (i in IndexCard.executeQuery("from Book where bookmarked = ? and lastUpdated > ? order by lastUpdated desc", [true, new Date() - 7])) {
            records += [type    : 'R', id: i.id,
                        meta    : '#' + i.type?.code + (i.publishedOn ? ' (' + i.publishedOn?.format('dd.MM.yyyy') + '' : ''),
                        color   : 'DarkSlateBlue',
                        language: i.language,
                        title   : i.title, body: i.fullText ?: '']
        }

//println 'records' + records
        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }
    def exportJsonP = {
        def builder = new JSONBuilder()

        def records = []
        for (i in mcs.Planner.executeQuery("from Planner where startDate >= ? and startDate <= ? and bookmarked = ? order by startDate desc ",
                [new Date() - 3, new Date() + 7, true])) {
            records += [type    : 'P', id: i.id, ecode: 'P',
                        meta    : i?.startDate?.format('dd-MM-yyyy-HH-mm'),
                        color   : 'darkblue',
                        title   : i.summary,
                        language: i.language,
                        body    : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

//println 'records' + records
        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

    def exportJsonCal = {
        def builder = new JSONBuilder()

        def records = []
        def c = 1
        //def t = ''
        for (d in (new Date() + 3..new Date() - 4)) {
            //t = ''
            for (i in mcs.Planner.executeQuery("from Planner p where date(p.startDate) = ? order by p.startDate desc ", [d])) {
                //    t += '<b>' +  i.summary + '</b><br/>' +( i.description  &&  i.description?.trim() != '?' ? i.description?.replace('\n', '<br/>'): '') + '<br/><br/>'
                records += [type    : 'Cal', id: i.id, ecode: 'P',
                            //meta:  i.type?.code ,//t.count('<b>') + ' #',
                            color   : 'darkblue',
                            meta    : i?.startDate?.format('dd-MM-yyyy-HH-mm'),
                            language: 'ar',
                            title   : i.summary, body: i.description]
//        }
//            if (t != '')

            }
        }
//println 'records' + records
        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportJsonT = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in Task.executeQuery("from Task where  bookmarked = ? order by lastUpdated desc", [true])) {
            records += [type    : (i.isTodo == true ? 'Todo' : 'T'), id: i.id, ecode: 'T',
                        meta    : (i.context ? '@' + i.context?.code : '-') + ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        color   : 'lightgreen',
                        title   : i.summary,
                        language: i.language,
                        body    : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportJsonTodo = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in Task.executeQuery("from Task where  bookmarked = ? and isTodo = ? order by lastUpdated desc", [true, true])) {
            records += [type    : 'Todo', id: i.id, ecode: 'T',
                        meta    : (i.context ? '@' + i.context?.code : '-') + ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        color   : 'lightgreen',
                        title   : i.summary,
                        language: i.language,
                        body    : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportJsonR = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from Book where type.code != ? and type.code != ? and  bookmarked = ? order by department.orderNumber asc, course.orderNumber asc, orderNumber asc",
                ['art', 'nws', true])) {
//            OperationController.countResourceFiles(i.id)
            records += [type    : 'R', id: i.id,
                        rtype   : i?.type?.code, ecode: 'R',
                        meta    : '#' + i.type?.code + (i.publishedOn ? ' (' + i.publishedOn?.format('dd.MM.yyyy') + '' : ''),
                        color   : 'DarkSlateBlue',
                        language: i.language,
                        files   : i.filesList,
                        nbFiles : i.nbFiles,
                        title   : i.title, body: (i.fullText?.replaceAll(/http[\S\.]*/, '')
                    ?.replaceAll(/www[\S\.]*/, '') ?: ' >> ') + (i.description ?: '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

    def exportJsonG = {

        //  syncMobile(params.tosync)


        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']
        for (i in Task.executeQuery("from Goal where bookmarked = ?", [true])) {
            records += [type    : 'G', id: i.id, ecode: 'G',
                        meta    : (i.department ? 'd' + i.department?.code : '-') + ' ' + (i.type ? '#' + i.type?.code : '') +
                                ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        color   : 'darkgreen',
                        language: i.language,
                        title   : i.summary,
                        body    : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

//println 'records' + records
        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportJsonArt = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from Book where type.code = ? and bookmarked = ? and fullText is not null order by priority desc, lastUpdated desc", ['art', true])) {
            records += [type    : 'Art', id: i.id, ecode: 'R',
                        meta    : '#' + i.type?.code + (i.publishedOn ? ' (' + i.publishedOn?.format('dd.MM.yyyy') + '' : ''),
                        color   : 'DarkSlateBlue',
                        language: i.language,
                        title   : i.title, body: i.fullText?.replace('\n', '<br/>')?.replaceAll(/http[\S\.]*/, '')
                    ?.replaceAll(/www[\S\.]*/, '') ?: '']
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }
    def exportJsonNws = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from Book where type.code = ? and bookmarked = ? order by priority desc, lastUpdated desc", ['nws', true])) {
            records += [type    : 'Nws', id: i.id, ecode: 'R',
                        meta    : '#' + i.type?.code + (i.publishedOn ? ' (' + i.publishedOn?.format('dd.MM.yyyy') + '' : ''),
                        color   : 'DarkSlateBlue',
                        language: i.language,
                        title   : i.title, body: (i.fullText?.replace('\n', '<br/>')?.replaceAll(/http[\S\.]*/, '')
                    ?.replaceAll(/www[\S\.]*/, '') ?: '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

    def exportJsonW = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']


        for (i in IndexCard.executeQuery("from Writing where  bookmarked = ? order by lastUpdated desc", [true])) {
            records += [type    : 'W', id: i.id, ecode: 'W',
                        meta    : (i.department ? 'd' + i.department?.code : '-'),
                        color   : 'lightorange',
                        title   : i.summary,
                        language: i.language,
                        body    : (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

    def exportJsonN = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from IndexCard where  bookmarked = ? order by lastUpdated desc", [true])) {
            records += [type    : 'N', id: i.id, ecode: 'N',
                        meta    : (i.department ? 'd' + i.department?.code : '-'),
                        color   : 'darkorange',
                        title   : i.summary,
                        language: i.language,
                        body    : (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportJsonK = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from IndexCard i where  i.type.code = ? and lastUpdated > ? order by lastUpdated desc", ['k', new Date() - 30])) {
            records += [type    : 'K', id: i.id, ecode: 'N',
                        meta    : (i.department ? 'd' + i.department?.code : '-'),
                        color   : 'darkorange',
                        title   : i.summary,
                        language: i.language,
                        body    : (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportJsonE = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from Excerpt i where  bookmarked = ? order by lastUpdated desc", [true])) {
            records += [type    : 'E', id: i.id, ecode: 'E',
                        meta    : (i.book?.department ? 'd' + i.book?.department?.code : '-'),
                        color   : 'darkred',
                        title   : i.summary,
                        files   : i.filesList,
                        nbFiles : i.nbFiles,
                        language: i.language,
                        body    : (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def mobilePush() {
        def c = 0
        params.tosync.split(',').each() { r ->
            if (r.trim() != '' && r != 'null') {
                //println 'r ' + r
                c++
                //     println GenericsController.markCompletedStatic(r.substring(1).toLong(), r.substring(0, 1).toUpperCase())

                def entityCode = r.substring(0, 1).toUpperCase()
                def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(r.substring(1).toLong())

                if (record.class.declaredFields.name.contains('bookmarked') && record.bookmarked)
                    record.bookmarked = false

                if ('GTP'.contains(entityCode)) {
                    record.completedOn = new Date()

//        record.percentComplete = new Date()
                    record.status = mcs.parameters.WorkStatus.findByCode('done')
                }

                if ('T'.contains(entityCode) && record.isRecurring) {
                    def t = new Task()
//            t.properties = record.properties
                    t.summary = 'rc: ' + t.summary
                    t.description = 'rc: ' + t.description
                    t.endDate = record.endDate + record.recurringInterval
                    t.recurringInterval = record.recurringInterval
                    t.isRecurring = true
                    t.completedOn = null
                    t.actualEndDate = null

                    t.status = WorkStatus.findByCode('not-s')

                    record.status = WorkStatus.findByCode('done')
                    record.actualEndDate = new Date()
//            println 'the new t: ' + t.dump()

                    t.save(flush: true)
                }

                if ('REN'.contains(entityCode)) {

                    if (!record.readOn) {
                        record.readOn = new Date()
                    }
                }
                if ('R'.contains(entityCode)) {
                    record.status = mcs.parameters.ResourceStatus.findByCode('core')
                }
                if ('W'.contains(entityCode)) {

                    if (!record.firstReviewed) {
                        record.firstReviewed = new Date()
                    }
                    if (!record.reviewCount) {
                        record.reviewCount = 1
                    } else record.reviewCount++

                    record.lastReviewed = new Date()
                    record.status = WritingStatus.findByCode('revised')
                }
            }
        }

        render c
    }


    def mobileWritings() {
        def builder = new JSONBuilder()
        def json
        //new File('d:/test.log').write(request.JSON.data, 'UTF-8')
        def data = request.JSON.data
        if (data && data?.trim() != '') {
            def c = 0
            def n = new app.IndexCard()
            n.summary = new Date().format('dd.MM.yyyy HH:mm') + ' k'
            n.description = data?.replace('::', ':\n')
            n.type = WritingType.findByCode('k')
            n.save(flush: true)

            json = builder.build {
                result = 'Note saved.'

            }
        } else {
            json = builder.build {
                result = 'Nothing to save.'

            }
        }
        render(status: 200, contentType: 'application/json', text: json)
    }


    def exportGold = {
        def result = ''
        for (i in mcs.Planner.executeQuery("from Planner where bookmarked = ? order by startDate desc ", [true])) {
            result += "|  ${i.startDate?.format('dd.MM.yyyy')}<br/>  <b>${i.summary}</b><br/>${i.description ?: ''}<br/>--------------------------------------<br/><br/>"
        }

//        def priorityMap = [5: 'A', 4: 'B', 3: 'C', 2: 'D', 1: 'E']
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']
        for (d in mcs.Department.list()) {
            if (Task.executeQuery("select count(*) from Goal where  bookmarked = ? and department = ? order by lastUpdated desc", [true, d])[0] > 0) {
                result += "<br/><center><big><b>" + d.code + '</b></big><p></center><br/>'
                for (i in Task.executeQuery("from Goal where bookmarked = ? and department = ?", [true, d])) {
                    result += "| <b>${i.summary}</b><br/><small>(${i.priority ? priorityMap[i.priority] : ''}) ${i.type ? '#' + i.type?.code : ''}  </small><br/>--------------------------------------<br/><br/>"
//            result += "(${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} ${i.type ? '#' + i.type?.code : ''} ${i.summary}\n"
                    //  ? i.parentGoal?.code : 'usr'}
                }
            }
        }

        //  for (i in Task.executeQuery("from Task where  bookmarked = ?", [ true])) {
        //      result += "(${i.priority ? priorityMap[i.priority] : ''}) +${i.department?.code ?: '?'} ${i.context ? '@' + i.context?.code : ''} T ${i.summary}\n"
//            result += "(${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} +${i.department?.code ?: '?'} ${i.context ? '@' + i.context?.code : ''} T ${i.summary}\n"
        //  ? i.parentGoal?.code : 'usr'}
        //   }
//        for (i in Task.executeQuery("from Task where status.code = ? order by priority asc, department asc, summary asc", ['done'])) {
//            result += "x ${i.completedOn ? i.completedOn.format('yyyy-MM-dd') : new Date().format('yyyy-MM-dd')} (${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} @${i.context ?: 'none'} ${i.summary}<br/>"
//        }
        //new File('d:/todo.txt').write(result, 'UTF-8')

        render result//.replace('\n', '')//.decodeHTML()
    }
    def exportT = {
        def focus = mcs.Planner.findByType(mcs.parameters.PlannerType.findByCode('move'), [sort: 'dateCreated', order: 'desc'])
        def result = '>> <b>' + focus.summary + '</b><br/>' + focus.description + '<br/><br/><hr/>'

        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (d in mcs.parameters.Context.list()) {
            if (Task.executeQuery("select count(*) from Task where  bookmarked = ? and context = ?", [true, d])[0] > 0) {
                result += "<br/><br/><big><b>@" + d.code + '</b></big><br/><br/>'
                for (i in Task.executeQuery("from Task where  bookmarked = ? and context = ? order by lastUpdated desc", [true, d])) {
                    result += "|  ${i.summary}<br/><small>${i.department ? 'd' + i.department?.code : ''}</small><br/>--------------------------------------<br/><br/>"
//            result += "(${i.priority ? priorityMap[i.priority] : ''}) +${i.department?.code ?: '?'} ${i.context ? '@' + i.context?.code : ''} T ${i.summary}\n"
//            result += "(${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} +${i.department?.code ?: '?'} ${i.context ? '@' + i.context?.code : ''} T ${i.summary}\n"
                    //  ? i.parentGoal?.code : 'usr'}
                }
            }
        }
//        for (i in Task.executeQuery("from Task where status.code = ? order by priority asc, department asc, summary asc", ['done'])) {
//            result += "x ${i.completedOn ? i.completedOn.format('yyyy-MM-dd') : new Date().format('yyyy-MM-dd')} (${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} +${i.parentGoal ? i.parentGoal?.code : 'usr'} @${i.context ?: 'none'} ${i.summary}<br/>"
//        }
        //new File('d:/todo.txt').write(result, 'UTF-8')

        render result//.replace('\n', '')//.decodeHTML()
    }
    def exportN = {
        def result = ''


        for (d in mcs.Department.list()) {
            result += "<big><b>" + d.code + '</b></big><p>'
            for (i in IndexCard.executeQuery("from IndexCard where  bookmarked = ? and department = ? and lastUpdated > ? order by lastUpdated desc", [true, d, new Date() - 7])) {
                result += "| <b>${i.summary}</b><br/> ${i.description}<br/><br/><br/>--------------------------------------<br/><br/>"
//            result += "(${i.priority ? priorityMap[i.priority] : ''}) +${i.department?.code ?: '?'} ${i.context ? '@' + i.context?.code : ''} T ${i.summary}\n"
//            result += "(${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} +${i.department?.code ?: '?'} ${i.context ? '@' + i.context?.code : ''} T ${i.summary}\n"
                //  ? i.parentGoal?.code : 'usr'}
            }
        }
//        for (i in Task.executeQuery("from Task where status.code = ? order by priority asc, department asc, summary asc", ['done'])) {
//            result += "x ${i.completedOn ? i.completedOn.format('yyyy-MM-dd') : new Date().format('yyyy-MM-dd')} (${i.priority ? priorityMap[i.priority] : 'C'}) ${i.dateCreated.format('yyyy-MM-dd')} +${i.parentGoal ? i.parentGoal?.code : 'usr'} @${i.context ?: 'none'} ${i.summary}<br/>"
//        }
        //new File('d:/todo.txt').write(result, 'UTF-8')

        render result//.replace('\n', '')//.decodeHTML()
    }


    def exportP = {
        def result = ''
        for (i in mcs.Planner.executeQuery("from Planner where bookmarked = ? order by startDate desc ", [true])) {
            result += "|  ${i.startDate?.format('dd.MM.yyyy')}<br/>  <b>${i.summary}</b><br/>${i.description ?: ''}<br/>--------------------------------------<br/><br/>"

        }

        render result//.replace('\n', '')//.decodeHTML()
    }

    def exportR = {
        def result = ''
        for (i in IndexCard.executeQuery("from Book where bookmarked = ? and lastUpdated > ? order by lastUpdated desc", [true, new Date() - 7])) {
            result += "| <b>${i.title}</b><br/> ${i.fullText}<br/>--------------------------------------<br/><br/>"
        }

        render result//.replace('\n', '')//.decodeHTML()
    }


}
