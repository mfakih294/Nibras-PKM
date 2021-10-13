package app


import app.*
import app.parameters.*

import cmn.*
import grails.converters.*
import ker.OperationController
import mcs.Book
import mcs.Journal
import mcs.parameters.GoalType
import mcs.parameters.JournalType
import mcs.parameters.WorkStatus
import org.apache.commons.lang.StringUtils
import java.text.SimpleDateFormat

//import jxl.*
//import jxl.format.*
//import jxl.write.*
import mcs.Writing
import org.apache.commons.lang.WordUtils
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_READER'])
class IndexCardController { // entity id = 16

    def supportService

    static allClasses = [
            mcs.Goal,
            mcs.Task,
            mcs.Planner,

            mcs.Journal,
            app.IndicatorData,
            app.Payment,

            mcs.Writing,
            app.IndexCard,
            mcs.Course,

            mcs.Book,
            mcs.Excerpt,

//            app.parameters.WordSource,
            app.Indicator,
            app.PaymentCategory,
            app.Contact,
            mcs.parameters.SavedSearch
    ]

    static allClassesWithCourses = allClasses -
            [mcs.Excerpt, mcs.Course,
             app.IndicatorData, app.Payment, app.PaymentCategory, app.Indicator, mcs.parameters.SavedSearch]


    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def list() {

        //params.max = (params.max ?: 15)
        params.sort = (params.sort ? params.sort : 'lastUpdated')
        params.order = (params.order ? params.order : 'desc')

        render(template: "/indexCard/list", model: [
                list : IndexCard.list(params),
                total: IndexCard.count()
        ])

    }

    def report() {

        params.max = (params.max ?: 3)
        params.sort = (params.sort ? params.sort : 'lastUpdated')
        params.order = (params.order ? params.order : 'desc')

        render(template: "/indexCard/report", model: [
                list : IndexCard.list(params),
                total: IndexCard.count()
        ])

    }

    def changes() {
        def changes = DataChangeAudit.findAllByEntityIdAndRecordId(16, params.id)
        render(template: "/indexCard/changes", model: [changes: changes])
    }

    def documents() {
        def documents = Document.executeQuery("from Document where entityId = ? and recordId = ?",
                [new Long(16), params.id.toLong()], [sort: 'dateCreated', order: 'desc'])

        render(template: "/indexCard/documents", model: [changes: changes])
    }


    def delete() {
        def indexCardInstance = IndexCard.get(params.id)
        if (indexCardInstance) {
            try {
                indexCardInstance.delete()
                //indexCardInstance.deletedOn = new Date()

                flash.message = "IndexCard.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndexCard ${params.id} deleted"
                render "IndexCard ${params.id} deleted"
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "indexCardInstance.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndexCard ${params.id} could not be deleted"
                render "IndexCard ${params.id} could not be deleted" //redirect(action:'show',id:params.id)
            }
        } else {
            flash.message = "indexCardInstance.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndexCard not found with id ${params.id}"
            render "IndexCard not found with id ${params.id}" //redirect(action:'list')
        }
    } // end of delete

    def update() {
        def indexCardInstance = IndexCard.get(params.id)
        if (indexCardInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (indexCardInstance.version > version) {
                    indexCardInstance.errors.rejectValue("version", "optimistic.locking.failure", "Another user has updated this IndexCard while you were editing")

                    render(template: "/indexCard/edit", model: [indexCardInstance: indexCardInstance])
                }
            }
            indexCardInstance.properties = params
            if (!params['book.id'])
                indexCardInstance.book = null


            if (!indexCardInstance.hasErrors() && indexCardInstance.save(flush: true)) {
                flash.message = "IndexCard.updated"
                flash.args = [params.id]
                flash.defaultMessage = "IndexCard ${params.id} updated"

                render(template: "/gTemplates/recordSummary", model: [record: indexCardInstance, justUpdated: true])
            } else {
                render(template: "/indexCard/edit", model: [indexCardInstance: indexCardInstance])
            }
        } else {
            render("indexCard.not.found")

        }
    } // end of update

    def edit() {

        def indexCardInstance = IndexCard.get(params.id)
        if (!indexCardInstance) {
            flash.message = "IndexCard.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndexCard not found with id ${params.id}"

            render 'Record not found'
        } else {
            render(template: "/indexCard/edit", model: [indexCardInstance: indexCardInstance, updateRegion: "CRecord${params.id}"])
        }

    } // end of edit

    def attach() {

        def indexCardInstance = new IndexCard(params)
//        indexCardInstance.book = Book.findByCode(params['book.id'])
        if (!indexCardInstance.hasErrors() && indexCardInstance.save(flush: true)) {
            /* save the last entered value to speed up data entry */
            session['lastIcdTypeId'] = indexCardInstance.type?.id
//			session['lastSourceType'] = indexCardInstance.sourceType?.id
//            session['lastSource'] = indexCardInstance.source?.id
            flash.message = "indexCard.created"
            flash.args = [indexCardInstance.id]
            flash.defaultMessage = "IndexCard ${indexCardInstance.id} created"

            // params.max = (params.max ?: 10)
            params.sort = (params.sort ? params.sort : 'lastUpdated')
            params.order = (params.order ? params.order : 'desc')

//			render(template: "/gTemplates/recordListing", model: [
//				list: IndexCard.findAllByEntityCodeAndRecordId(indexCardInstance.entityCode, indexCardInstance.recordId, params)
//			])
            def recordEntityCode = indexCardInstance.entityCode
            def recordId = indexCardInstance.recordId ?: indexCardInstance.bookId

            if (indexCardInstance.writing) {
                recordEntityCode = 'W'
                recordId = indexCardInstance?.writing?.id
            }
            else if (indexCardInstance.book) {
                recordEntityCode = 'R' // fixed a bug here... 10.02.2017
//                recordId = indexCardInstance?.book?.id
            }

            render(template: "/indexCard/add", model: [
                    indexCardInstance: new IndexCard(),
                    recordEntityCode : recordEntityCode,
                    recordId         : recordId,
                    writingId        : indexCardInstance?.writing?.id,
                    bookId           : indexCardInstance?.book?.id

            ])
        } else {
            render(template: "/indexCard/add", model: [
                    indexCardInstance: indexCardInstance,
                    recordEntityCode : indexCardInstance.entityCode,
                    recordId         : indexCardInstance.recordId
            ])

            indexCardInstance.errors.each() { println it }

        }
    } // end of save
    def save() {

        def indexCardInstance = new IndexCard(params)

        if (!indexCardInstance.hasErrors() && indexCardInstance.save(flush: true)) {
            /* save the last entered value to speed up data entry */
            session['lastIcdTypeId'] = indexCardInstance.type?.id
            session['lastSourceType'] = indexCardInstance.sourceType?.id
            session['lastSource'] = indexCardInstance.source?.id
            flash.message = "indexCard.created"
            flash.args = [indexCardInstance.id]
            flash.defaultMessage = "IndexCard ${indexCardInstance.id} created"

            // params.max = (params.max ?: 10)
            params.sort = (params.sort ? params.sort : 'lastUpdated')
            params.order = (params.order ? params.order : 'desc')

//			render(template: "/gTemplates/recordListing", model: [
//				list: IndexCard.findAllByEntityCodeAndRecordId(indexCardInstance.entityCode, indexCardInstance.recordId, params)
//			])
            render(template: "/indexCard/list", model: [
                    indexCardInstance: new IndexCard(), list: IndexCard.list(params), total: IndexCard.count()

            ])
        } else {
            render(template: "/indexCard/list", model: [
                    indexCardInstance: indexCardInstance,
                    list             : IndexCard.list(params),
                    total            : IndexCard.count()
            ])
        }
    } // end of save

    def rss() {
        render(feedType: "rss", feedVersion: "2.0") {
            title = "Index cards"
            link = "/nibras/indexCard/rss"
            description = "Index cards"

//NewsItem.findAllByApprovedOnIsNotNullAndByRss([sort: 'dateCreated', order: 'desc', max: 25]).each() { article ->
            IndexCard.findAll([sort: 'course', order: 'asc']).each() { article ->
                //def title =
                entry(article?.title) {
//  entry(article.title + ' (' + article.type.toString() + ' / ' + article.writingStatus.toString() + ' - ' + (article?.body ? article?.body?.count(' ') : '0') + ' words)') {
                    link = "/writing/show/${article.id}"
                    publishedDate = article.dateCreated
                    author = (article.course ? article.course?.toString() : '')
                    content(type: 'text/html', value: article.contents?.replaceAll('\n', '</p><p>'))
                    //.replaceAll('', '')
                }
            }
        }
    }


    def addXcdFormNgs() {
        if (params.description) {

            /*
              def f = new File('/mhi/mdd/log/xcd-add-' + new Date().format('dd.MM.yyyy') + '.txt')
           if(!f.exists()){
             f.write ''
       //	  print ' No add log file found'
           }
              f.text += ('>>> ' +  params.summary + '\n' + params.description + '\n\n')

           */

            def n = new IndexCard(params)
            if (params['writing.id']){
                if (IndexCard.executeQuery('select count(*) from IndexCard i where' +
                        ' i.recordId = ? and i.entityCode = ? and i.orderNumber is not null',
                        [params['writing.id'], 'W'])[0] == 0)
                    n.orderNumber = 1
                else
                n.orderNumber = IndexCard.executeQuery('select i.orderNumber from IndexCard i where' +
                        ' i.recordId = ? and i.entityCode = ? and i.orderNumber is not null order by i.orderNumber desc',
                        [params['writing.id'], 'W'])[0] + 1
            }
            else if (n.course){
                if (IndexCard.executeQuery('select count(*) from IndexCard i where' +
                        ' i.course = ? and i.orderNumber is not null',
                        [n.course])[0] == 0)
                    n.orderNumber = 1
                else
                n.orderNumber = IndexCard.executeQuery('select i.orderNumber from IndexCard i where' +
                        ' i.course = ? and i.orderNumber is not null order by i.orderNumber desc', [n.course])[0] + 1
            }

            if (params['writing.id'] && params['writing.id'] != 'null') {
                n.recordId = params['writing.id']
                n.entityCode = 'W'
//                n.writing = null
            }
            if (params.chosenTags) {
                if (params.chosenTags && params.chosenTags.class == String) {
                    n.addToTags(Tag.get(params.chosenTags))
                } else {
                    params.chosenTags.each() {
                        n.addToTags(Tag.get(it))
                    }
                }
            }
            n.summary = new Date()?.format('EEE dd MMM, yyyy HH:mm')
            n.save()
            render(template: "/gTemplates/recordSummary", model: [record: n])
        } else {
            render 'No text entered.'
        }
    }

    def addXcdFormDaftar() {
        if (params.title || params.description) {

            if (params.title)
            params.title = params.title.trim()

            if (params.description)
            params.description = params.description.trim()

            /*

            def f = new File('/mhi/xcd-add-' + new Date().format('dd.MM.yyyy') + '.txt')
            if (!f.exists()) {
                f.write ''
//	  print ' No add log file found'
            }
            f.text += ('>>> \n' + params.description + '\n\n')
            */
                 def n
            if (params.type == 'N'){
               n = new IndexCard()
            n.summary = params.title ?: '...'//extractTitleReturn(params.description)
            n.description = params.description //extractDescriptionReturn(params.description)
//            n.type = mcs.parameters.WritingType.findByCode('daftar')
            n.writtenOn = new Date()

            n.save()
        } else  if (params.type == 'W'){
               n = new Writing()
                n.summary = params.title//extractTitleReturn(params.description)
                n.description = params.description //extractDescriptionReturn(params.description)
            n.type = mcs.parameters.WritingType.findByCode('art')
//            n.writtenOn = new Date()
            n.save()
        }
            else if (params.type == 'Jy'){
                n = new Journal()
                n.summary = params.title//extractTitleReturn(params.description)
                n.description = params.description //extractDescriptionReturn(params.description)
                n.startDate = new Date() - 1
                n.level = 'i'
                n.type = JournalType.findByCode('act')
                n.save()
            }
            else if (params.type == 'Jt'){
                n = new Journal()
                n.summary = params.title//extractTitleReturn(params.description)
                n.description = params.description //extractDescriptionReturn(params.description)
                n.startDate = new Date()
                n.level = 'i'
                n.type = JournalType.findByCode('act')
                n.save()
            }
           else if (params.type == 'T'){
                n = new mcs.Task()
                n.summary = params.title//extractTitleReturn(params.description)
                n.description = params.description //extractDescriptionReturn(params.description)
                n.status = WorkStatus.findByCode('pending')
                if (params.context)
                    n.context = mcs.parameters.Context.get(params.context)
                n.save()
            }
             else if (params.type == 'G'){
                n = new mcs.Goal()
                n.summary = params.title//extractTitleReturn(params.description)
                n.description = params.description //extractDescriptionReturn(params.description)
                n.type = GoalType.findByCode('goal')
                n.status = WorkStatus.findByCode('pending')
                n.save()
            }
          else if (params.type == 'R'){
                n = new mcs.Book()
                n.title = params.title//extractTitleReturn(params.description)
                n.fullText = params.description //extractDescriptionReturn(params.description)
                if (params.resourceType && params.resourceType != 'null')
                n.type = ResourceType.get(params.resourceType.toLong())
                else
                    n.type =  ResourceType.findByCode((OperationController.getPath('resource.add.type.default') ?: 'nws'))
//                n.status = WorkStatus.findByCode('pending')
                n.save()
            }

        if (params['courseNgs'] && params['courseNgs'] != 'null') {
            n.course = mcs.Course.get(params['courseNgs'].toLong())
            n.department = n.course.department
            n.save()
        }

        n.language = params.language
        n.bookmarked = true


        render(template: "/gTemplates/recordSummary", model: [record: n, justSaved: true])
            render(template: '/layouts/achtung', model: [message: 'Record saved with id: ' + n.id])


            def recentRecords = []
//            allClassesWithCourses.each() {
//                recentRecords += it.findAllByDateCreatedLessThanAndDateCreatedGreaterThan(new Date() + 1, new Date() - 2, [sort: 'dateCreated', order: 'desc', max: 1])
//                //    recentRecords += it.findAllByLastUpdatedGreaterThan(new Date() - 7, [max: 7])
//            }

            recentRecords = recentRecords.sort({ it.dateCreated })//.reverse()
            //recentRecords.unique()

//            if (recentRecords.size() > 0)
//                render(template: '/gTemplates/recordListing', model: [
//                        title: '',
//                        list : recentRecords - n
//                ])


//            render('<i style="font-size: tiny">' + params.description + '</i>')
        } else {
//            render 'No content entered.'
            render(template: '/layouts/achtung', model: [message: 'No content entered'])
        }
    }

    def addArticleFormNgs() {
        if (params.fullText) {

           /*
            def f = new File('/mhi/art-add-' + new Date().format('dd.MM.yyyy') + '.txt')
            if (!f.exists()) {
                f.write ''
//	  print ' No add log file found'
            }
            f.text += ('>>> ' + params.summary + '\n' + params.description + '\n\n')
           */


            def n = new mcs.Book(params)
//            n.type = ResourceType.findByCode('art')
            if (params.chosenTags) {
                if (params.chosenTags && params.chosenTags.class == String) {
                    n.addToTags(Tag.get(params.chosenTags))
                } else {
                    params.chosenTags.each() {
                        n.addToTags(Tag.get(it))
                    }
                }
            }
            n.save()
            render(template: "/gTemplates/recordSummary", model: [record: n])
        } else {
            render 'No full text entered'
        }
    }

    def toggleAsNewSection() {

        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = IndexCard.get(id)

        record.isNewSection = (record.isNewSection == true ? false : true)
        if (record.isNewSection)
            render('&crarr;')
        else render('! &crarr;')
    }

    def linkNoteToResource() {

        def id = params.id.toLong()
        def record = IndexCard.get(id)

        if (params.bookId) {
            def book = Book.findByCode(params.bookId)
            if (book) {
                record.book = book
                render('Linked to resource: ' + book.toString())
            } else render('Resource not found')

        } else {
            render('Invalid ID')
        }

    }


    def viewImage() {
        //def photo = Photo.get( params.id )
        def f
//        def bookInstance = IndexCard.get(params.id)
//        if (bookInstance.status == ResourceStatus.get(1))
//        f = new File(OperationController.getPath('covers.sandbox.path') + '/' + params.id + '.jpg')
        def code = params.entityCode
        f = new File(OperationController.getPath('root.rps1.path') + "/${code}/" + params.id + '/' + params.id +  code.toLowerCase() + '.jpg')
        if (!f?.exists())
            f = new File(OperationController.getPath('root.rps2.path') + "/${code}/" + params.id + '/' + params.id +  code.toLowerCase() + '.jpg')

//        else
//            f = new File("d:/todo/cvr/ebk/" + params.id + '.jpg')
//    println 'cover path is ' + "I:/ebk/cvr/" + params.id + '.jpg'
        if (f?.exists()) {
            byte[] image = f.readBytes()
            response.outputStream << image
        }
        //  else println 'cover not there for book ' + params.id

    }

    def extractTitle(String typing) {
        render extractTitleReturn(typing)
    }

    def extractTitleReturn(String typing) {
        def title = '...'
        def draft = ''
        if (typing && typing.length() > 0) {
            if (typing.contains('\n'))
                draft = typing.split('\n')[0]
            else
                draft = typing

            if (draft.length() < 180 && draft.length() > 2) {
                title = draft
            }
        }
        return title
    }

    def extractDescriptionReturn(String typing) {
        def title = extractTitleReturn(typing)
        def draft = (title != typing ? StringUtils.removeStart(typing, title) : '...')
        return draft
    }


    def generateWritingsBook(){
        render(template: "/appCourse/writingsBookHtml", model: [record: mcs.Course.get(params.id)])
    }
    def generateWritingsBookToFile() {
        def f = new File('/' + (OperationController.getPath('root.rps1.path') ?: '') + '/crs' + params.id + '.md')
        f.write(g.include([controller: 'indexCard', action: 'generateWritingsBook', id: params.id]).toString(), 'UTF-8')
        render 'Generation done: ' + new Date().format('HH:mm:ss')
    }
    def sortNotes(){
        render(template: "/appCourse/sortNotes", model: [record: mcs.Course.get(params.id)])
    }
} // end of class