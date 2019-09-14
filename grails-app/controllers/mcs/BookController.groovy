package mcs

//import cmn.UtilController
import grails.converters.JSON
import ker.OperationController
import mcs.parameters.ResourceStatus
import org.apache.commons.lang.StringUtils
import cmn.Setting

import java.text.DecimalFormat

import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class BookController { // entity id = 134

    def supportService

    def index() {
        redirect(action: "list", params: params)
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def list() {

        params.max = 6//Math.min(params.max ? params.int('max') : 10,  100)
        params.sort = (params.sort ? params.sort : 'lastUpdated')
        params.order = (params.order ? params.order : 'desc')

       render(template: '/book/add', model: [])

    }


    def show() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = "record.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Book not found with id ${params.id}"

        }
        [bookInstance: bookInstance]

    }

    def byCourse() {
        render(template: '/book/forCriteria', model: [list: Book.executeQuery("from Book where course = ? and status != ? and status != ?", [Course.get(params.id), ResourceStatus.get(1), ResourceStatus.get(3)], [sort: 'orderNumber', order: 'asc']), title: Course.get(params.id).title + ' - Uncategorized books'])
    }

    def byCourseTbk() {
        render(template: '/book/forCriteria', model: [list: Book.findAllByCourseAndStatus(Course.get(params.id), ResourceStatus.get(1), [sort: 'orderNumber', order: 'asc']), title: 'Textbooks for ' + Course.get(params.id).title])
    }

    def byCourseRef() {
        render(template: '/book/forCriteria', model: [list: Book.findAllByCourseAndStatus(Course.get(params.id), ResourceStatus.get(3), [sort: 'orderNumber', order: 'asc']), title: 'References for ' + Course.get(params.id).title])
    }

    def report() {
        switch (params.id) {
            case 'new': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByDateCreatedGreaterThan(new Date() - 3), title: 'Newly added books'])
                break
            case 'empty': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByStatus(ResourceStatus.get(11), [max: 4]), title: 'Empty records'])
                break
            case 'recent': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByDateCreatedGreaterThan(new Date() - 7), title: 'Newly added books'])
                break
            case 'bookmark': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByBookmarked(true, [sort: 'lastUpdated', order: 'desc', max: 30]), title: 'Bookmarked books'])
                break
            case 'tofix': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByStatusOrLegacyTitleIsNull(ResourceStatus.get(8), [max: 5]), title: 'To be fixed'])
                break
            case 'isbnNoTitle': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByIsbnIsNotNullAndTitleIsNull(), title: 'With ISBN but without title'])
                break

            case 'toupdate': render(template: '/gTemplates/recordListing', model: [list: Book.findAllByStatus(ResourceStatus.get(12), [max: 15]), title: 'To be updated'])
                break
            case 'uncategorized': render(template: '/gTemplates/recordListing', model: [list: Book.executeQuery("from Book where (status = ? or status = ?) and course is null",
                    [ResourceStatus.get(1), ResourceStatus.get(3)], [max: 5]), title: 'Unassigned to courses'])
                break

            case 'supplementary': render(template: '/gTemplates/recordListing', model: [list: Book.executeQuery("from Book where status = ?",
                    [ResourceStatus.get(2)], [max: 5]), title: 'Supplementary textbooks - ' + Book.executeQuery("select count(*) from Book where status = ?",
                    [ResourceStatus.get(2)])[0]
            ])
                break

        }

    }

    def openBook() {
        def bookInstance = Book.get(params.id)
//        println params.id
        if (!bookInstance) {
            render 'Book not found'
        }
        else {
            def program = ''
            switch (bookInstance.ext) {
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

                case 'chm': program = "okular"
                    break;
                case 'htm': program = "firefox"
                    break;
                case 'txt': program = "kate"
                    break;
            }
            try {
                "${program} ${supportService.getResourcePath(bookInstance.id, 'b')}".execute()
//                println supportService.getResourcePath(bookInstance.id, 'b')
                render 'Book opened'
            } catch (Exception e) {
                render 'Book CANNOT be opened'
                e.printStackTrace()
            }

        }
    }


    def download() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            redirect(action: 'list')
        }
        else {

            def path = supportService.getResourcePath(bookInstance.id, 'b')
            def filename = (bookInstance.course ? bookInstance.course.code : '0000') + 'c - ' + new DecimalFormat('0000').format(bookInstance.id) + 'b [' + (bookInstance.title ?: bookInstance.legacyTitle) +
                    '] (' + supportService.toWeekDate(new Date()) + '.12).' + bookInstance.ext

            if (new File(path).exists()) {
                response.setHeader("Content-disposition", "attachment; filename=\"${filename}\"")
//    		   response.contentType = "application/vnd.ms-word"
                response.outputStream << new FileInputStream(path)
            }
        }

    }

    def qshow() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = "record.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Book not found with id ${params.id}"
            redirect(action: 'list')
        }
        else {
            [bookInstance: bookInstance]
        }
    }



    def clearFields() {
        def bookInstance = Book.get(params.id)
        if (bookInstance) {
            try {
//        bookInstance.delete()
                //bookInstance.deletedOn = new Date()
                bookInstance.status = ResourceStatus.get(11)
                bookInstance.title = ''
                bookInstance.author = ''
                bookInstance.isbn = ''
                bookInstance.legacyTitle = ''
                
                bookInstance.tags = ' '
                bookInstance.bibEntry = ' '
                bookInstance.course = null
                bookInstance.publisher = ' '
                bookInstance.publicationDate = ' '

                bookInstance.edition = ' '
                bookInstance.nbPages = null

                new File("/todo/rjc/cvr/ebk/" + params.id + '.jpg').renameTo(new File("/todo/rjc/ebk/" + params.id + '.jpg'))


                def ant = new AntBuilder()
                ant.move(file: supportService.getResourcePath(bookInstance.id, 'b'),
                        tofile: '/todo/rjc/ebk/' + new DecimalFormat('0000').format(bookInstance.id) + 'b.' + bookInstance.ext)
//        if (bookInstance.status == ResourceStatus.get(1))
                //           new File("/todo/cvr/tbk/" + params.id + '.jpg').renameTo(new File("/todo/rjc/cvr/ebk/" + params.id + '.jpg'))
                //        else

                //                bookInstance.ext = ' '

                render(template: '/gTemplates/recordSummary', model: [record: bookInstance])
            }
            catch (Exception e) {
                e.printStackTrace()
                render(template: '/gTemplates/recordSummary', model: [record: bookInstance])
                render "Book ${params.id} could not be deleted" //redirect(action:'show',id:params.id)
            }
        }
        else {
            flash.message = "bookInstance.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Book not found with id ${params.id}"
            render "Book not found with id ${params.id}" //redirect(action:'list')
        }
    }


    def edit() {

        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            render "Book not found"
        }
        else {
            render (template: '/book/edit', model: [
                    bookInstance: bookInstance,
                    update: 'BRecord' + bookInstance.id])
        }

    }

    def update() {
        def bookInstance = Book.get(params.id)
        if (bookInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bookInstance.version > version) {
                    // was lowercase
                    bookInstance.errors.rejectValue("version", "optimistic.locking.failure", "Another user has updated this Book while you were editing")
                    render(view: 'edit', model: [bookInstance: bookInstance])
                }
            }
            bookInstance.properties = params
            if (!bookInstance.hasErrors() && bookInstance.save(flush: true)) {

                flash.message = "Book.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Book ${params.id} updated"
                redirect(action: 'show', id: bookInstance.id)
//                   redirect(action:'list')
            }
            else {
                render(view: 'edit', model: [bookInstance: bookInstance])
            }
        }
        else {
            flash.message = "book.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "book not found with id ${params.id}"
            redirect(action: 'list')

        }
    }

    def wb() {
        // new GroovyShell().evaluate("""
        //import mcs.Department
        Writing.list().each() {
            if (it.lastUpdated == null)
                it.lastUpdated = new Date()
            if (it.body == null)
                it.body = ' '
            if (it.dateCreated == null)
                it.dateCreated = new Date()
        }
        //""")

    }

    def qedit() {

        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = "Book.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Book not found with id ${params.id}"
            render 'Record not found'
        }
        else {
            render(view: '_edit', model: [bookInstance: bookInstance])
        }

    }

    def qupdate() {
        def bookInstance = Book.get(params.id)
        if (bookInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bookInstance.version > version) {
                    // was lowercase
                    bookInstance.errors.rejectValue("version", "optimistic.locking.failure", "Another user has updated this Book while you were editing")
                    render (template: '/book/edit', model: [
                            bookInstance: bookInstance,
                            update: 'BRecord' + bookInstance.id])
                }
            }
            bookInstance.properties = params
            if (!bookInstance.hasErrors() && bookInstance.save(flush: true)) {

                render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id), justUpdated: true])
            }
            else {
                render (template: '/book/edit', model: [
                        bookInstance: bookInstance,
                        update: 'BRecord' + bookInstance.id])
            }
        }
        else {
            render 'Record not found'
        }
    }




    def create() {

        def bookInstance = new Book()
        bookInstance.properties = params
        def breadCrumb = "Create new Book"
        [bookInstance: bookInstance, breadCrumb: breadCrumb]

    }

    def qcreate() {

        def bookInstance = new Book()
        bookInstance.properties = params
        render(view: 'qcreate', model: [bookInstance: bookInstance])

    }

    def save() {
        def bookInstance = new Book(params)
        def breadCrumb = "Create new Book"
        if (!bookInstance.hasErrors() && bookInstance.save(flush: true)) {
            // session['lastparentId'] =  bookInstance.parent.id
            flash.message = "book.created"
            flash.args = [bookInstance.id]
            flash.defaultMessage = "Book ${bookInstance.id} created"
//              render(view:'create',model:[bookInstance: new Book()])

            redirect(action: 'create', model: [bookInstance: new Book(params), breadCrumb: breadCrumb])
        }
        else {

            render(view: 'create', model: [bookInstance: bookInstance, breadCrumb: breadCrumb])
        }
    }

    def qsave() {
        def bookInstance = new Book(params)
        if (!bookInstance.hasErrors() && bookInstance.save(flush: true)) {
            // session['lastparentId'] =  bookInstance.parent.id
            render(view: 'qshow', model: [bookInstance: bookInstance, hide: true,
                    qmessage: "Book ${bookInstance.toString()} created"])
            //new Book(),
        }
        else {
            flash.message = null
            render(view: 'qcreate', model: [bookInstance: new Book()])
        }
    }




    def exportToExcel() {

        def header = [:]
        header.id = "Id"
        header.title = "Title"
        header.author = "Author"
        header.description = "Description"
        header.isbn = "Isbn"
        header.legacyTitle = "Legacy title"
        header.status = "Status"
        header.ext = "Ext"
        header.tags = "Tags"
        header.nbPages = "Nb pages"
        header.edition = "Edition"
        header.publisher = "Publisher"
        header.publicationDate = "Publication date"
        header.summary = "Summary"

        header.notes = "Notes"
        header.dateCreated = "Date Created"
        header.lastUpdated = "Last Updated"
        // set our header and content type
        response.setHeader("Content-disposition", "attachment; filename=BookList.xls")
        response.contentType = "application/vnd.ms-excel"
        //UtilController.writeExcel(response.outputStream, header, Book.list())
    } // end of exportToExcel

    def markTextbook() {
        try {
            Book.get(params.id).status = ResourceStatus.get(1)
        } catch (Exception e) {
            println e.printStackTrace()
        }
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])
    }

    def markRead() {
        Book.get(params.id).isRead = true
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])

    }

    def markToFix() {
        Book.get(params.id).status = ResourceStatus.get(8)
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])

    }

    def markToUpdate() {
        Book.get(params.id).status = ResourceStatus.get(12)
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])

    }

    def markReference() {
        try {
            Book.get(params.id).status = ResourceStatus.get(3)
        } catch (Exception e) {
            println e.printStackTrace()
        }
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])
    }

    def markFrench() {
        Book.get(params.id).language = 'fr'
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])

    }

    def markAsUndecided() {
        Book.get(params.id).status = ResourceStatus.get(9)
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])

    }

    def bookmark() {
        def b = Book.get(params.id)
        if (b.bookmarked == null || b.bookmarked)
            b.bookmarked = false
        else b.bookmarked = true
//        render "Book ${params.book.toLong()} is now bookmarked"
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])
    }

    def updateCourse() {
        def bookInstance = Book.get(params.id)
        bookInstance.course = Course.get(params.newvalue)
        render Course.get(params.newvalue).title
    }

    def courses() {
        def data = [:]

        Course.list([sort: 'title']).each() {
            data[it.id] = it.title.replaceAll('Introduction to ', '') + ' - ' + it.code
        }
        render data as JSON
    }


    def exportTextsIsbn() {
        def set = ''
        Book.findAllByStatusAndIsbnIsNotNull(ResourceStatus.get(3)).each() {
            set += "{{amazon>${it.isbn}}}\\\\ \n"
        }
        render set
    }


    def link() {
        supportService.createLink(params.id.toLong(), 'b')
        render 'Link created'
    }

    def updateOrder() {
        def bookInstance = Book.get(params.id)
        bookInstance.orderNumber = params.newvalue.toInteger()
        render params.newvalue
    }


    def viewImage() {

        //def photo = Photo.get( params.id )
        def f
        def bookInstance = Book.get(params.id)
//        if (bookInstance.status == ResourceStatus.get(1))
//        f = new File(OperationController.getPath('covers.sandbox.path') + '/' + params.id + '.jpg')
        if(new File(OperationController.getPath('root.rps1.path')  + '/R/cvr/' + bookInstance?.type?.code + '/' + params.id + '.jpg')?.exists())
            f = new File(OperationController.getPath('root.rps1.path') + '/R/cvr/' + bookInstance?.type?.code + '/' +  params.id + '.jpg')
        else if(new File(OperationController.getPath('root.rps2.path') + '/R/cvr/' + bookInstance?.type?.code + '/' +  params.id + '.jpg')?.exists())
        f = new File(OperationController.getPath('root.rps2.path') + '/R/cvr/' + bookInstance?.type?.code + '/' +  params.id + '.jpg')

        
//        else
//            f = new File("d:/todo/cvr/ebk/" + params.id + '.jpg')
//    println 'cover path is ' + "I:/ebk/cvr/" + params.id + '.jpg'
        if (f?.exists()) {
            byte[] image = f.readBytes()
            response.outputStream << image
        }
        //  else println 'cover not there for book ' + params.id

    }

    def viewExcerptImage() {

        def f
//        if (bookInstance.status == ResourceStatus.get(1))
//        f = new File(OperationController.getPath('covers.sandbox.path') + '/' + params.id + '.jpg')
        if(new File(OperationController.getPath('covers.sandbox.path')  + '/exr/'  + params.id + '.jpg')?.exists())
            f = new File(OperationController.getPath('covers.sandbox.path') + '/exr/'  +  params.id + '.jpg')
        else if(new File(OperationController.getPath('covers.repository.path') + '/exr/'  +  params.id + '.jpg')?.exists())
        f = new File(OperationController.getPath('covers.repository.path') + '/exr/'  +  params.id + '.jpg')

        if (f?.exists()) {
            byte[] image = f.readBytes()
            response.outputStream << image
        }

    }

//    public static void addImage(Long id) {
//        def b = Book.get(id)
//        if (b.imageUrl) {
//            println 'getting book cover...'
//            def file = new FileOutputStream("/todo/cvr/ebk/" + id + '.jpg')
//            def t = new File("/todo/cvr/ebk/" + id + '.jpg')
//            if (t.exists()) t.renameTo(new File("/todo/cvr/ebk/" + id + '-old.jpg'))
//            def out = new BufferedOutputStream(file)
//            out << new URL(b.imageUrl.substring(0, b.imageUrl.length() - 6)).openStream()
//            out.close()
//            if (t.exists()) println 'Cover is now there'
//            else 'Cover not found (from addImage)'
//
//        }
//    }
//

    def performOperationTEMP() {
        if (params.id != 'null') {
            switch (params.id.toInteger()) {
                case 1: bookmark(params.book.toLong())
                    break;
                case 2: markTextbook()
                    break;
                case 3: markReference() //
                    break;
                case 4: markRead()
                    break;


                case 5: markToFix()
                    render 'book marked to fixed'
                    break;

                case 6: markToUpdate()
                    render 'book marked to update'
                    break;


                case 7: supportService.addCoverDup(params.book.toLong())
                    render 'cover got'
                    break;
                case 8:
                    break;
                case 9: supportService.createLink(params.book.toLong(), 'b')
                    render 'Link created'
                    break;

            }

        }
    }

    def refresh() {
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])

    }

    def showDescription() {
        render(template: '/book/contents', model: [bookInstance: Book.get(params.id)])
    }

    def more() {
        render(template: '/book/more', model: [bookInstance: Book.get(params.id)])
    }

    def updateBookInfo() {
        supportService.updateBook(params.id.toLong())
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])
    }
 def addCover() {
        supportService.addCover(params.id.toLong())
        render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])
    }

    def importArticles() {

        def type = params.type
        def message = supportService.importResources(type)
        render(template: '/layouts/achtung', model: [message: message])
//        render(template: '/reports/recentBooks')

    }

    def importBooks() {

        def message = supportService.importBooks()
        render(template: '/layouts/achtung', model: [message: message])
//        render(template: '/reports/recentBooks')

    }

    def autoCompleteBooks() {
        def responce = ''
        //println params.q
        if (params.q && params.q != '' && params.q.length() >= 4) {
            Book.executeQuery("from Book where lower(title) like ? order by title", [params.q + '%'], [max: 30]).each() {
//                if (it.title?.toLowerCase()?.startsWith(params.q.toLowerCase()) ||
                //                        it.toLowerCase().contains(params.q.substring(2).toLowerCase()))
                responce += (it.title + ', ' + it.author + '|' + it.id + '\n')
            }

        }
        render responce
    }

    def search() {

        def results = null

        def queryWhere = ''
        def queryParams = []
        def count = 0

        params.max = 50

        def c = params.resourceStatus
        if (c != 'null') {
            queryWhere += 'status = ? and '
            queryParams.add(ResourceStatus.get(c.toLong()))
        }

        c = params.course
        if (c != 'null') {
            queryWhere += 'course = ? and '
            queryParams.add(Course.get(c))
        }

        c = params.department
        if (c != 'null') {
            queryWhere += 'course.department = ? and '
            queryParams.add(Department.get(c.toLong()))
        }

        queryWhere = StringUtils.removeEnd(queryWhere, ' and ')

        results = Book.executeQuery('from Book ' + (queryWhere != '' ? ' where ' : '') + queryWhere + '  order by course.department.departmentCode desc', queryParams, params)
        count = Book.executeQuery('select count(*) from Book ' + (queryWhere != '' ? ' where ' : '') + queryWhere, queryParams)[0]

        render(template: '/book/forCriteria', model: [list: results, count: count,
                title: "Search results - ${count} books found "
        ])

    }


    
     def markForSharing() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance.isPublic)
         bookInstance.isPublic = true
         else
            bookInstance.isPublic = false
         render(template: '/gTemplates/recordSummary', model: [record: Book.get(params.id)])
    }



    def addExcerpt = {
        def record = Book.get(params.id)
        if (params.text) {

//        record.description += ('\n' + params.text + ' (' + new Date().format('dd.MM.yyyy') + ')')
          //  record.description += ('\n\n' + params.text)
            def e = new Excerpt()
            e.book = record
            e.summary = params.text
            e.save(flush: true)
            render(template: '/gTemplates/recordSummary', model: [record: record])
            //render(template: '/gTemplates/recordDetails', model: [record: record])
        }

    }

} // end of class