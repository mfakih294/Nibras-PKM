package ker

import app.IndexCard
import app.parameters.*
import cmn.Setting
import mcs.Department
import mcs.Operation
import mcs.parameters.*
import grails.converters.XML
import grails.converters.JSON
import grails.web.JSONBuilder
import mcs.Book
import mcs.Goal
import mcs.Task
import mcs.Writing
import grails.converters.JSON
import org.grails.web.json.JSONObject
import org.json.JSONArray
import org.springframework.http.HttpRequest
import security.User
import sun.reflect.generics.factory.GenericsFactory


class SyncController {

    static entityMapping = [
            'G'            : 'mcs.Goal',
            'ه'            : 'mcs.Goal',
            'T'            : 'mcs.Task',
            'ع'            : 'mcs.Task',
            'P'            : 'mcs.Planner',
            'خ'            : 'mcs.Planner',

            'W'            : 'mcs.Writing',
            'ك'            : 'mcs.Writing',
            'N'            : 'app.IndexCard',
            'ن'            : 'app.IndexCard',

            'J'            : 'mcs.Journal',
            'ذ'            : 'mcs.Journal',
            'I'            : 'app.IndicatorData',
            'K'            : 'app.Indicator',

            'Q'            : 'app.Payment',
            'د'            : 'app.Payment',
            'L'            : 'app.PaymentCategory',

            'R'            : 'mcs.Book',
            'م'            : 'mcs.Book',
            'C'            : 'mcs.Course',
            'و'            : 'mcs.Course',
            'D'            : 'mcs.Department',
            'ج'            : 'mcs.Department',
            'E'            : 'mcs.Excerpt',
            'ف'            : 'mcs.Excerpt',
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

    def supportService

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
            link = "https://localhost:1441/nibras/sync/rssPile"
            description = "Your Nibras bookmared records in RSS format"

//NewsItem.findAllByApprovedOnIsNotNullAndByRss([sort: 'dateCreated', order: 'desc', max: 25]).each() { article ->

            def list
            list =
//                    IndexCard.findAllByDateCreatedGreaterThanAndReadOnIsNull(new Date() - 7, [sort: 'dateCreated', order: 'asc']) +
//                    IndexCard.findAllByDateCreatedGreaterThanAndBookmarked(new Date() - 7, true, [sort: 'dateCreated', order: 'asc']) +
//                            Book.findAllByDateCreatedGreaterThanAndReadOnIsNull(new Date() - 7, [sort: 'dateCreated', order: 'asc']) +
//                            Book.findAllByBookmarkedAndType(true, ResourceType.findByCode('art')) +
                    Book.findAllByBookmarked(true, [sort: 'priority', order: 'desc']) +
                            Writing.findAllByBookmarked(true, [sort: 'priority', order: 'desc']) +
                            IndexCard.findAllByBookmarked(true, [sort: 'priority', order: 'desc']) +
                            Task.findAllByBookmarkedAndCompletedOnIsNull(true, [sort: 'priority', order: 'desc']) +
                            Goal.findAllByBookmarkedAndCompletedOnIsNull(true, [sort: 'priority', order: 'desc'])


            list.each() { r ->
                //def title =
                def style = r.language == 'ar' ? "text-align: right; direction: rtl" : ''

                entry((r.priority ? 'p' + r.priority + ' ' : 'p2 ') + (r.class.declaredFields.name.contains('summary') ? r.summary : '') + ' ' + (r.class.declaredFields.name.contains('title') && r.title ? r.title : '') + "") {
//  entry(article.title + ' (' + article.type.toString() + ' / ' + article.writingStatus.toString() + ' - ' + (article?.body ? article?.body?.count(' ') : '0') + ' words)') {
                    link = "https://localhost:1442/nibras/page/rssPage/${r.id}-${r.entityCode()}"
                    publishedDate = r.dateCreated
                    categories = [new com.sun.syndication.feed.synd.SyndCategoryImpl([name: r.course?.summary])]
//,new com.sun.syndication.feed.synd.SyndCategoryImpl("cat2")]
                    author = r.entityCode() + (r.class.declaredFields.name.contains('type') && r.type ? ' #' + r.type?.code : '') +
                            (r.class.declaredFields.name.contains('context') && r.context ? ' @' + r.context : '')
//                    content(type: 'text/html', value: 'tst')
                    content(type: 'text/html', value: "<div style='${style}'>" +
                            (r.description ? r.description?.replaceAll('\n', '<br/>') : '') + '<br/>---' +
                            (r.notes ? r.notes?.replaceAll('\n', '<br/>') : '') + '<br/>---' +
                            (r.class.declaredFields.name.contains('fullText') && r.fullText ? r.fullText?.replaceAll('\n', '<br/>') : '') +
                            '</div>')
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
        for (i in mcs.Planner.executeQuery("from Planner t where t.startDate >= ? and t.startDate <= ? and t.completedOn is null and (t.user.username = ? or t.isPrivate = true) order by t.startDate asc",
                [new Date() - 7, new Date() + 7, params.id])) {
            records += [type    : 'P', id: i.id, ecode: 'P',
                        meta    : i?.startDate?.format('dd-MM-yyyy-HH-mm'),
                        date    : i?.startDate?.format('dd-MM-yyyy'),
                        datediff: i?.startDate - new Date(),
                        color   : 'darkblue',
                        filesList   : i.filesList,
                        nbFiles : i.nbFiles,
                        summary   : (i.task ? ('[' + i.task?.summary + '] ') : '') + i.summary,
                        language: i.language,
                        description    : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

        for (i in mcs.Planner.executeQuery("from Planner t where t.bookmarked = true and (t.user.username = ? or t.isPrivate = true) order by t.startDate asc",
                [params.id])) { // new Date() - 20, new Date() + 20
            records += [type    : 'P', id: i.id, ecode: 'P',
                        meta    : i?.startDate?.format('dd-MM-yyyy-HH-mm'),
                        date    : i?.startDate?.format('dd-MM-yyyy'),
                        datediff: i?.startDate - new Date(),
                        color   : 'darkblue',
                        filesList   : i.filesList,
                        nbFiles : i.nbFiles,
                        summary   : (i.task ? ('[' + i.task?.summary + '] ') : '') + i.summary,
                        language: i.language,
                        description    : i.description ? i.description?.replace('\n', '<br/>') : '']
        }

//println 'records' + records
        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

    def exportJsonJ = {

        supportService.updateBookmarkedRecordsFileCount()


        def builder = new JSONBuilder()

//        println ' in jsonJ, username: ' + params.id

        def records = []
        for (i in mcs.Planner.executeQuery("from Journal t where t.startDate >= ? and t.startDate <= ? and t.bookmarked = ? and (t.user.username = ? or t.isPrivate = true) order by t.startDate desc ",
                [new Date() - 4, new Date() + 1, true, params.id])) {
            records += [type       : 'J',
                        id         : i.id,
                        ecode      : 'J',
                        meta       : i?.startDate?.format('dd-MM-yyyy-HH-mm'),
                        color      : 'darkblue',
                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,
                        summary    : i.summary,
                        language   : i.language,
                        description: i.description ? i.description?.replace('\n', '<br/>') : '']
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
        for (d in (new Date() + 13..new Date() - 14)) {
            //t = ''
            for (i in mcs.Planner.executeQuery("from Planner p where date(p.startDate) = ? order by p.startDate desc ", [d])) {
                //    t += '<b>' +  i.summary + '</b><br/>' +( i.description  &&  i.description?.trim() != '?' ? i.description?.replace('\n', '<br/>'): '') + '<br/><br/>'
                records += [type    : 'Cal', id: i.id, ecode: 'P',
                            //meta:  i.type?.code ,//t.count('<b>') + ' #',
                            color   : 'darkblue',
                            meta    : i?.startDate?.format('dd-MM-yyyy-HH-mm'),
                            language: 'ar',
                            title   : i.summary, description: i.description]
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

        for (i in Task.executeQuery("from Task t where  t.bookmarked = ?  and (t.user.username = ? or t.isPrivate = true) order by t.priority desc, t.id desc", [true, params.id])) {
            // t.context.code asc, t.priority todo: fix
            records += [type       : (i.isTodo == true ? 'Todo' : 'T'),
                        id         : i.id,
                        ecode      : 'T',
                        meta       : (i.context ? '@' + i.context?.code : '-') + ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        context       : (i.context ? '@' + i.context?.code : '-'),
                        date    : i?.endDate?.format('dd-MM-yyyy-HH-mm'),
                        textDate    : i?.endDate?.format('EEE dd, HH-mm'),
                        color      : 'lightgreen',
                        summary    : i.summary,
                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,
                        language   : i.language,
                        description: i.description ? i.description?.replace('\n', '<br/>') : '']
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

def exportJsonV = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']


        for (i in Task.executeQuery("from Task t where t.endDate >= ? and t.endDate <= ? and t.completedOn is null  and (t.user.username = ? or t.isPrivate = true) order by t.priority desc, t.id desc", [new Date() - 14, new Date() + 32, params.id])) {
            // t.context.code asc, t.priority todo: fix
            records += [type       : (i.isTodo == true ? 'Todo' : 'T'),
                        id         : i.id,
                        ecode      : 'T',
                        meta       : (i.context ? '@' + i.context?.code : '-') + ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        context       : (i.context ? '@' + i.context?.code : '-'),
                        date    : i?.endDate ? i?.endDate?.format('dd-MM-yyyy-HH-mm') : null,
                        color      : 'lightgreen',
                        summary    : i.summary,
                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,
                    bookmarked: i.bookmarked ? '1' : '0',
                        language   : i.language,
                        description: i.description ? i.description?.replace('\n', '<br/>') : '']
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
// order by department.orderNumber asc, course.orderNumber asc, orderNumber asc
        for (i in IndexCard.executeQuery("from Book b where b.bookmarked = ? and (b.user.username = ? or b.isPrivate = true) order by b.lastUpdated desc", //  b.priority desc // b.type.code asc, b.title asc
                [true, params.id])) {
//            OperationController.countResourceFiles(i.id)
            records += [type        : 'R',
                        id          : i.id,
                        resourceType: i?.type?.code,
                        ecode       : 'R',
                        meta        : '#' + i.type?.code, // + (i.publishedOn ? ' ' + i.publishedOn?.format('yyyy') + '' : ''),
                        color       : 'DarkSlateBlue',
                        language    : i.language,
                        filesList   : i.filesList,
                        nbFiles     : i.nbFiles,
                        summary     : i.title + (i.legacyTitle ? ' [' + i.legacyTitle + ' ]' : ''),
                        description : (i.description ? i.description?.replace('\n', '<br/>'): '') + ' <br/> ' + (i.fullText?.replace('\n', '<br/>')?.replaceAll(/http[\S\.]*/, '')
                                ?.replaceAll(/www[\S\.]*/, '') ?: '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }

    def exportJsonG = {


        //  syncMobile(params.tosync)
//println ' in jsonG' + params.id

        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']
        for (i in Task.executeQuery("from Goal g where g.bookmarked = ? and (g.user.username = ? or g.isPrivate = true) order by g.priority desc, g.id desc", [true, params.id])) {
            // g.department.code asc, g.priority desc todo:
            records += [type       : 'G',
                        id         : i.id,
                        ecode      : 'G',
                        meta       : (i.department ? 'd' + i.department?.code : '-') + ' ' + (i.type ? '#' + i.type?.code : '') +
                                ' ' + (i.priority ? priorityMap[i.priority] : ''),
                        color      : 'darkgreen',
                        language   : i.language,
                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,
                        summary    : i.summary,

                        description: i.description ? i.description?.replace('\n', '<br/>') : '']
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
            records += [
                    type    : 'Art',
                    rtype   : 'art',
                    id      : i.id,
                    ecode   : 'R',

                    meta    : '#' + i.type?.code + (i.publishedOn ? ' (' + i.publishedOn?.format('dd.MM.yyyy') + '' : ''),
                    color   : 'DarkSlateBlue',
                    language: i.language,
                    title   : i.title,
                    description    : i.fullText?.replace('\n', '<br/>')?.replaceAll(/http[\S\.]*/, '')
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
            records += [type    : 'Nws',
                        rtype   : 'nws',
                        id      : i.id,
                        ecode   : 'R',
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
            records += [type       : 'W',
                        id         : i.id,
                        ecode      : 'W',
                        meta       : (i.department ? 'd' + i.department?.code : '-'),
                        color      : 'lightorange',
                        summary    : i.summary,
                        language   : i.language,

                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,

                        description: (i.description ? i.description?.replace('\n', '<br/>') : '') +
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

        for (i in IndexCard.executeQuery("from IndexCard t where  t.bookmarked = ?  and (t.user.username = ? or t.isPrivate = true) order by t.lastUpdated desc", [true, params.id])) {
            records += [type       : 'N',
                        id         : i.id,
                        ecode      : 'N',
                        meta       : (i.department ? 'd' + i.department?.code : '-'),
                        color      : 'darkorange',
                        summary    : i.summary,
                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,
                        language   : i.language,
                        description: (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }
    def exportJsonO = {
        def builder = new JSONBuilder()

        def records = []
        def priorityMap = [5: 'p5', 4: 'p4', 3: 'p3', 2: 'p2', 1: 'p1']

        for (i in IndexCard.executeQuery("from Operation where  bookmarked = ? and deletedOn is null order by lastUpdated desc", [true])) {
            // todo
            if (i.newSystem)
                records += [type       : i.type, id: i.id, ecode: 'O',
                            meta       : i.type + ' ' + i?.date?.format('dd.MM.yyyy_HHmm'),
                            color      : 'darkgreen',
                            summary    : i.summary,
                            files      : '',
                            nbFiles    : '',
                            language   : 'ar',
                            description: i.description]
            else
                records += [type       : 'O', id: i.id, ecode: 'O',
                            meta       : i?.summary?.split(/\(/)[1],
                            color      : 'darkgreen',
                            summary    : i.description?.split('\n')[0],
                            filesList  : '',
                            nbFiles    : '',
                            language   : 'ar',
                            description: (i.description ? i.description?.replace('\n', '<br/>') : '') + '<br/>']

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
                        language: i.language, // todo: replace 'body' by 'description'
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
            records += [type       : 'E', id: i.id, ecode: 'E',
                        meta       : (i.book?.department ? 'd' + i.book?.department?.code : '-'),
                        color      : 'darkred',
                        summary    : i.summary,
                        filesList  : i.filesList,
                        nbFiles    : i.nbFiles,
                        language   : i.language,
                        description: (i.description ? i.description?.replace('\n', '<br/>') : '') +
                                (i.notes ? '<br/>===<br/>' + i.notes?.replace('\n', '<br/>')?.replace('__________________________________________________', '---') : '')]
        }

        def json = builder.build {
            result = "ok"
            data = records
        }

        render(status: 200, contentType: 'application/json', text: json)
    }


    def mobilePushSplit() {


        sleep((Math.random() * 4000).toInteger()) // wait for pandoc to finish converting the document


        if (Setting.findByName('lastMobileSync'))
            OperationController.setPath('lastMobileSync', new Date().format('dd.MM.yyyy HH:mm'))
        else {
            new Setting([name: 'lastMobileSync', value: new Date().format('dd.MM.yyyy HH:mm')]).save(flush: true)
        }

        def builder = new JSONBuilder()
        def json

//        try {
//            new File('/nbr/mbl.log').write('\n Mobile push request, ' + new Date()?.format('dd.MM.yyyy HH:mm') + ':\n')
//            new File('/nbr/mbl.log').write(request.JSON.data?.toString(), 'UTF-8')
//        } catch (Exception e){
//            println 'Error write mobile push log file'
//        }

        def key = request.JSON.key
        def value = request.JSON.value


        def id =  key.substring(6).split('=')[0]
        def entityCode = key.substring(4,5)

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)




        switch(key.substring(2,3)){
            case 'a':

                println 'in split operationType append to record ' + id +  ' and entityCode ' + entityCode + ' with value ' + value

                    if (!record.notes)
                        record.notes = value
                    else record.notes += '\n\n' + value



                    break;
            case 'd':
                println 'in split operationType done to record ' + id +  ' and code ' + entityCode


                    if (record.class.declaredFields.name.contains('bookmarked') && record.bookmarked)
                        record.bookmarked = false

                    if ('GTP'.contains(entityCode)) {
                        record.completedOn = new Date()

//        record.percentComplete = new Date()
                        record.status = mcs.parameters.WorkStatus.findByCode('done')
                    }

                if ('REN'.contains(entityCode)) {

                    if (!record.readOn) {
                        record.readOn = new Date()
                    }
                }
                if ('R'.contains(entityCode)) {

                    //todo
                    record.status = mcs.parameters.ResourceStatus.findByCode('read')
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



                break;

        }

        json = builder.build {
            result = key + ' update committed'
        }

        render(status: 200, contentType: 'application/json', text: json)


    }



    def mobilePush() {


        if (Setting.findByName('lastMobileSync'))
        OperationController.setPath('lastMobileSync', new Date().format('dd.MM.yyyy HH:mm'))
        else {
            new Setting([name: 'lastMobileSync', value: new Date().format('dd.MM.yyyy HH:mm')]).save(flush: true)
        }


        def builder = new JSONBuilder()
        def json

//        try {
//            new File('/nbr/mbl.log').write('\n Mobile push request, ' + new Date()?.format('dd.MM.yyyy HH:mm') + ':\n')
//            new File('/nbr/mbl.log').write(request.JSON.data?.toString(), 'UTF-8')
//        } catch (Exception e){
//            println 'Error write mobile push log file'
//        }

        def data = request.JSON.data

//        println 'new data ' + data

        def c = 0

//        println 'in mobile push json ' + params.dump()
        //      println 'in mobile push json ' + params.tosyncText
//println 'dump ' +        params.dump()
        if (params.tosyncText)
//            println 'array ' + params.tosyncText
        data.each() { r ->

//            r = JSON.parse(r)
//            println ' processing row ' + r
            c++
            //     println GenericsController.markCompletedStatic(r.substring(1).toLong(), r.substring(0, 1).toUpperCase())

            def entityCode = r['ecode']
            def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(r.id)
            if (r['textToAppend']) {
if (!record.notes)
    record.notes = r['textToAppend']
                else record.notes += '\n\n' + r['textToAppend']
            } else {

                if (record.class.declaredFields.name.contains('bookmarked') && record.bookmarked)
                    record.bookmarked = false

                if ('GTP'.contains(entityCode)) {
                    record.completedOn = new Date()

//        record.percentComplete = new Date()
                    record.status = mcs.parameters.WorkStatus.findByCode('done')
                }

                if (1 == 2 && 'T'.contains(entityCode) && record.isRecurring) {
                    def t = new Task()
//            t.properties = record.properties
                    t.summary = 'rc: ' + t.summary
                    t.description = 'rc: ' + t.description
                    if (record.endDate)
                        t.endDate = record.endDate + record.recurringInterval
                    else
                        t.endDate = new Date() + record.recurringInterval
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

                    //todo
                    record.status = mcs.parameters.ResourceStatus.findByCode('read')
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


        json = builder.build {
            result = c + ' processed updates'
        }

    render(status: 200, contentType: 'application/json', text: json)
}

    def mobilePush0() {
        def c = 0
        if (params.tosyncText && params.tosyncText?.contains(','))
            params.tosyncText.split(',').each() { r ->
                if (r.trim() != '' && r != 'null') {
//                println 'r ' + r
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

                    if (1 == 2 && 'T'.contains(entityCode) && record.isRecurring) {
                        def t = new Task()
//            t.properties = record.properties
                        t.summary = 'rc: ' + t.summary
                        t.description = 'rc: ' + t.description
                        if (record.endDate)
                            t.endDate = record.endDate + record.recurringInterval
                        else
                            t.endDate = new Date() + record.recurringInterval
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

                        //todo
                        record.status = mcs.parameters.ResourceStatus.findByCode('read')
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

        render (c + ' processed updates')
    }


    def mobileWritings() {
        def builder = new JSONBuilder()
        def json
        //new File('d:/test.log').write(request.JSON.data, 'UTF-8')
        def data = request.JSON.data
        if (data && data?.trim() != '') {
            def c = 0
//            def n = new app.IndexCard()//mcs.Journal()
//            n.summary = 'Notes on ' + new Date().format('EEE dd MMM yyyy HH:mm')
//            n.description = data?.replace('::', '')
//            n.type = JournalType.findByCode('usr')
//            n.writtenOn = new Date()

//            n.bookmarked = true


            for (b in data?.replace('::', '').split(/\n\*\*\*/)) {
                if (b?.trim() != '')
                    def op = new Operation([summary: b.split('--')[0], description: b.split('--')[1], bookmarked: true]).save()


            }

            println data?.replace('::', '').split(/\n\*\*\*/).size() + ' operations found.'

//            n.save(flush: true)

            json = builder.build {
                result = 'Notes exported.'
            }
        } else {
            json = builder.build {
                result = 'Nothing to save.'

            }
        }
        render(status: 200, contentType: 'application/json', text: json)
    }

    def mobileWritingsNew() {
        def builder = new JSONBuilder()
        def json
        //new File('d:/test.log').write(request.JSON.data, 'UTF-8')
        def data = request.JSON.data
//       println 'data is ' + data
        if (data) {
            def c = 0
//            def n = new app.IndexCard()//mcs.Journal()
//            n.summary = 'Notes on ' + new Date().format('EEE dd MMM yyyy HH:mm')
//            n.description = data?.replace('::', '')
//            n.type = JournalType.findByCode('usr')
//            n.writtenOn = new Date()

//            n.bookmarked = true


            data.each() { b ->
//                if (b?.trim() != '')
//                 [[rtype:t, meta:4, id:2022_06.06.1506_21, type:t, title:new title, body:new body, priority:4, ecode:n]]

                def op = new Operation([newSystem : true, summary: b.summary, description: b.description, priority: b.priority, type: b.module,
                                        bookmarked: true, date: Date.parse('dd.MM.yyyy_HH:mm', b.date)]).save()


            }

            println data.size() + ' records found.'

//            n.save(flush: true)

            json = builder.build {
                result = 'Notes exported.'
            }
        } else {
            json = builder.build {
                result = 'Nothing to save.'

            }
        }
        render(status: 200, contentType: 'application/json', text: json)
    }

    def commitMobileRecord() {
        def builder = new JSONBuilder()
        def json
//        new File('/home/maitham/test.log').write(request.JSON.data, 'UTF-8')
        def data = request.JSON.data
      //  println 'data is ' + data

        /** for non-json requests!!! ionic 6
         *    def data = JSON.parse(params['data'])
         println 'data is ' + data

         * */
        if (data) {
            def c = 0
//            def n = new app.IndexCard()//mcs.Journal()
//            n.summary = 'Notes on ' + new Date().format('EEE dd MMM yyyy HH:mm')
//            n.description = data?.replace('::', '')
//            n.type = JournalType.findByCode('usr')
//            n.writtenOn = new Date()

//            n.bookmarked = true


            def o = data//.each(){b->
//                if (b?.trim() != '')
//                 [[rtype:t, meta:4, id:2022_06.06.1506_21, type:t, title:new title, body:new body, priority:4, ecode:n]]

//                def op = new Operation([newSystem: true, summary: b.title, description: b.body, priority: b.priority, type: b.type,
//                                            bookmarked: true, date:  Date.parse('dd.MM.yyyy_HHmm', b.textDate)]).save()


            def module = o.module
            def record = grailsApplication.classLoader.loadClass(entityMapping[module?.toUpperCase()]).newInstance()


            if (module == 'r') {
                record.title = o.summary?.trim() //inconsistancy

                record.type = ResourceType.findByCode('doc') ?: new ResourceType([code: 'doc', name: 'Document']).save(flush: true)

                record.fullText = o.description?.trim()

            } else {
                record.summary = o.summary?.trim()
                record.description = o.description?.trim()

            }


            // if set to true, new records will be synced back to reader

            //  record.bookmarked = true


            record.department = Department.findByCode(o.department)
            record.priority = o.priority
            record.nbFiles = o.nbFiles
            record.filesList = o.filesList?.join(',')

            if (module == 'j' || module == 'p')
                record.startDate = Date.parse('dd.MM.yyyy_HHmm', o.textDate)
            else if (module == 't')
                record.endDate = Date.parse('dd.MM.yyyy_HHmm', o.textDate)
            else if (module == 'q')
                record.date = Date.parse('dd.MM.yyyy_HHmm', o.textDate)

            else if (module == 'n')
                record.writtenOn = Date.parse('dd.MM.yyyy_HHmm', o.textDate)

            else if (module == 'r')
                record.publishedOn = Date.parse('dd.MM.yyyy_HHmm', o.textDate)



//            println ' entered by ' + request.JSON.username + ' is found ' + security.User.findByUsername(request.JSON.username)
            record.user = security.User.findByUsername(request.JSON.username)


//            def savedRecord = record.save(flush: true)

            if (!record.hasErrors() && record.save(flush: true)) {

                def newPath = supportService.getResourcePath(record.id, module.toUpperCase(), false)

                def path

                if (new File(OperationController.getPath('root.rps1.path') + '/new').exists()) {
                    new File(OperationController.getPath('root.rps1.path') + '/new').eachFileMatch(~/${o.operationId} [\S\s]*/) { f ->
                        path = f.path
                    }

                    if (path) {
                        //println 'found a folder for this operation'
                        //OperationController.getPath('root.rps1.path') + '/O/' + o.id
                        new File(newPath).mkdirs()
                        def ant = new AntBuilder()
                        new File(path).eachFile() {
                            ant.move(file: it.path,
                                    tofile: newPath + '/' + it.name)
                        }
                        new File(path).delete()

                    }


                }

//            println data.size() + ' records found.'

//            n.save(flush: true)

                json = builder.build {
                    result = 'Record imported to Nibras Desktop'// with id ' + record.id
                }
            }

            else {

                println 'Errors in record ' + record.dump() + ' errors are: '
                record.errors.each() { println it }

            }
        } else {
            json = builder.build {
                result = 'Nothing to save.'

            }
        }
        render(status: 200, contentType: 'application/json', text: json)
    }


    ////

    def types() {

//        println 'here in modules \n\n\n'

        def types = []

        [
                [id: 'T', name: 'Task', code: 'tasks'],
                [id: 'P', name: 'Plan', code: 'plans'],
                [id: 'G', name: 'Goal', code: 'goals'],
                [id: 'N', name: 'Note', code: 'notes'],
                [id: 'W', name: 'Writing', code: 'writings'],
                [id: 'J', name: 'Journal', code: 'journal'],
//                [id: 'Jt', name: 'Yesterday journal', code: 'journal'],
                [id: 'P', name: 'Planner', code: 'planner'],
                [id: 'R', name: 'Resource', code: 'resources']
        ].each(){
            if (OperationController.getPath(it.code + '.enabled') == 'yes'){
                types += it
//                println 'here in modules \n\n\n' + it.name
            }

        }




        def builder = new JSONBuilder()
        def json

            json = builder.build {
                result = 'yes'
                modules = types
            }

            render(status: 200, contentType: 'application/json', text: json)
    }

    def departments() {

//        println 'here in deparmtns \n\n\n'
        def builder = new JSONBuilder()
        def json

            json = builder.build {
                result = 'yes'
                departments = Department.findAllByBookmarked(true, [sort: 'code', order: 'asc'])
            }

            render(status: 200, contentType: 'application/json', text: json)


    }

    def nibrasFilesNestedById() {

        def builder = new JSONBuilder()
        def json
       // def result = 'no'
//
    def resourceNestedById = 'no'

        if (OperationController.getPath('resourceNestedById') == 'yes') {
            resourceNestedById = 'yes'


            json = builder.build {
                result = 'yes'
            }

            render(status: 200, contentType: 'application/json', text: json)
        }

        else {
            json = builder.build {
            result = 'no'
        }

            render(status: 200, contentType: 'application/json', text: json)

        }
    }

    def nibrasFilesNestedByType() {

        def builder = new JSONBuilder()
        def json
      //  def result = 'no'
//
    def resourceNestedByType = 'no'

    if (OperationController.getPath('resourceNestedByType') == 'yes') {
        resourceNestedByType = 'yes'


        json = builder.build {
            result = 'yes'
        }

        render(status: 200, contentType: 'application/json', text: json)
    }
        else {
        json = builder.build {
            result = 'no'
        }

        render(status: 200, contentType: 'application/json', text: json)
    }



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
