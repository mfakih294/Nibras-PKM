//


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
import app.Indicator
import app.parameters.ResourceType
import grails.converters.JSON
import mcs.Book
import mcs.Excerpt
import mcs.Writing
import mcs.parameters.WritingType
import org.springframework.util.FileCopyUtils

import grails.plugin.springsecurity.annotation.Secured

import com.gravity.goose.Article
import com.gravity.goose.Configuration
import com.gravity.goose.Goose


@Secured(['ROLE_ADMIN','ROLE_READER'])
class ImportController {

    def supportService

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


    def commitWritings() {
        // should be the same as the checkout folder, to avoid commiting editor changes, without merging, and so destroy web changes
        new File(OperationController.getPath('wrt.path')).eachFileRecurse() {

            if (it.path.endsWith('.tex') && !it.path.endsWith('wrt.tex')) {
                try {
                    def w = Writing.get(it.name.split(/\./)[0].toInteger())
//          println w.id
                    //    w.title = StringUtils.remove(it.name.split('_')[1], '.tex')//.trim()
                    if (w.description != new File(it.path).text)
                        w.description = new File(it.path).text//.trim()

                } catch (Exception e) {
                    log.warn 'Non-compliant tex file found'
                }
            }
        }
//         searchableService.reindex()
        render 'Your writings have been committed'
    }

    def chooseImportType() {
        session['import-type'] = params.id
        render 'ok ' + params.id
    }

    def importIndicators() {
        new File('/todo/indicators-import.csv').text.eachLine() { line, number ->

            if (number > 0) {
                def i = new Indicator()
                i.code = line.split(',')[1]
                i.name = line.split(',')[1]
                i.frequency = 'r'
                i.startDate = new Date()
                i.query = line.split(',')[3]
                i.path = line.split(',')[4]
                i.extensions = line.split(',')[5]
                i.category = line.split(',')[0].toInteger()
                i.save()

            }
        }
        render 'Indicators imported'
    }

    /*
        Used
    */

    def importIndividualFile() {

        def entityCode = params.entityCode
        def path = params.path
        def parentPath = params.parentPath
        def rootPath = params.rootPath
        def count = 0
        def folder = new File(path)
        def name = params.name
        def type
        def finalName = ''



        def resourceNestedById = false
        def resourceNestedByType = false


        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true

        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true



        java.util.regex.Matcher matcher2 = name =~ /(?i)([\S\s ;-_]*)\.([\S]*)/
//                def id = matcher[0][1]

        def title = matcher2[0][1]
        def ext = matcher2[0][2]


        def b
        if (params.smart != 'yes') {
            if (entityCode == 'R') {
                type = ResourceType.findByCode(params.type)

                def isbn

                if (type.captureIsbn == true) {
                    try {
                        java.util.regex.Matcher matcher = name =~ /(\d{13}|\d{12}X|\d{12}x|\d{9}X|\d{9}x|\d{10})[^\d]*/
                        // todo: fix it to be exact match, anythwere in the filename
                        isbn = matcher[0][1]
                    }
                    catch (Exception e) {
                        println 'isbn not found in ' + name
                    }

                    def dup = isbn ? Book.findByIsbn(isbn) : null
                    if (dup && isbn) {
                        def ant = new AntBuilder()
                        ant.copy(file: parentPath + '/' + name, tofile: parentPath + '/backup/' + name)

                        def newPath = parentPath + '/' + (dup.id / 100).toInteger()
                        def c = 1
                        // was path + '/' + nf.format(dup.id).substring(0, 2)
                        while (new File(newPath + '/' + dup.id + 'b-' + name).exists())
                            c++
                        ant.move(file: parentPath + '/' + name, tofile: newPath + '/' + dup.id + 'b-' + c + '-' + name)
                        render 'Moved to original book folder'
                        return
                    } else {
                        b = new Book([isbn: isbn])
                        // todo remove ext
                        b.legacyTitle = title
                    }
//                    b.isbn = isbn
                } else {
                    b = new Book()

                    b.title = title
                }

                b.type = type
                finalName = params.type + '.' + ext
            } else {
                b = grailsApplication.classLoader.loadClass(entityMapping[entityCode.toUpperCase()]).newInstance()
                b.summary = title
                finalName = entityCode.toLowerCase() + '.' + ext


            }


            if (ext == 'txt') {
                if (entityCode.toLowerCase() == 'r')
                    b.fullText = folder.text
                else
                    b.description = folder.text
            }
            //      println 'text is ' + folder.text

            //b.description = 'Imported on ' + new Date().format(OperationController.getPath('date.format') ?: 'dd.MM.yyyy')
        } else {

            b = grailsApplication.classLoader.loadClass(entityMapping[entityCode.toUpperCase()]).newInstance()
            b.properties = GenericsController.transformMcsNotation(title)['properties']

            if (!b.language) {
            b.language = OperationController.getPath('default.language') ?: 'en'
            }


                finalName = entityCode.toLowerCase() + '.' + ext
        }

        if (ext == 'txt') {
            if (entityCode.toLowerCase() == 'r')
                b.fullText = folder.text
            else
                b.description = folder.text
        }

        //b.notes = 'Imported on ' + new Date().format(OperationController.getPath('date.format') ?: 'dd.MM.yyyy')

        if (!b.hasErrors() && b.save(flush: true)) {

            render(template: '/gTemplates/recordSummary', model: [record: b])
            def ant = new AntBuilder()
            if (entityCode == 'R') {


                        type = b.type
                //  ant.move(file: path, tofile: type.newFilesPath + '/' + (b.id / 100).toInteger() + '/' + b.id + '' + finalName)
                // inline move 22.10.2016
                ant.move(file: path, tofile: rootPath + '/' + entityCode +
                        (resourceNestedByType ?  '/' +  type.code : '') +
                        (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '') +
                        '/' + b.id + '/' + b.id + '' + finalName)
            } else
            //ant.move(file: path, tofile: OperationController.getPath('module.sandbox.' + entityCode + '.path') + '/' + b.id + '' + finalName)
            // inline move 22.10.2016
                ant.move(file: path, tofile: rootPath + '/' + entityCode + '/' + b.id + '/' + b.id + finalName)

        } else {
            b.errors.each() {
                println 'error ' + it
            }
            println 'Error saving the resource'
        }

    }

    /*
        Used
    */

    def importIndividualFolder() {

        def entityCode = params.entityCode
        def path = params.path
        def parentPath = params.parentPath
        def rootPath = params.rootPath
        def count = 0
        def folder = new File(path)
        def name = params.name
        def type
        def finalName = ''


        java.util.regex.Matcher matcher2 = name =~ /(?i)([\S\s ;-_]*)/
//                def id = matcher[0][1]

        def title = matcher2[0][1]
        // def ext = matcher2[0][2]


        def b


        b = grailsApplication.classLoader.loadClass(entityMapping[entityCode.toUpperCase()]).newInstance()
        b.properties = GenericsController.transformMcsNotation(title)['properties']

        if (!b.language) {
            b.language = OperationController.getPath('default.language') ?: 'en'
        }

        finalName = ''//entityCode.toLowerCase()

        //b.notes = 'Imported on ' + new Date().format(OperationController.getPath('date.format') ?: 'dd.MM.yyyy')

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true

         if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true




        if (!b.hasErrors() && b.save(flush: true)) {




            def ant = new AntBuilder()
            if (entityCode == 'R') {
                type = b.type
                //    ant.move(file: path, tofile: type.newFilesPath + '/' + (b.id / 100).toInteger() + '/' + b.id + '' + finalName)
                ant.move(file: path, tofile: rootPath + '/' + entityCode +
                        (resourceNestedByType ?  '/' +  type.code : '') +
                        (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '') +
                        '/' + b.id + '' + finalName)
            } else
            //ant.move(file: path, tofile: OperationController.getPath('module.sandbox.' + entityCode + '.path') + '/' + b.id + '' + finalName)

                ant.move(file: path, tofile: rootPath + '/' + entityCode + '/' + b.id + '' + finalName)

            OperationController.countResourceFilesStatic(b.id, entityCode)
            render(template: '/gTemplates/recordSummary', model: [record: b])
        } else {
            b.errors.each() {
                println 'error ' + it
            }
            println 'Error saving the resource'
        }

    }

    /*
        Used
    */

    def importLocalFiles() {



        def files = []
        def rootPath = OperationController.getPath('root.rps2.path')

//        new java.io.File(rootPath).eachFileRecurse() {
        if (new File(rootPath).exists()) {
            new java.io.File(rootPath).eachFile() {
                if (it.name ==~ /(?i)[a-z] [\S\s ;-_]*\.[\S]*/) {
                    files += it
                }

            }

            render(template: '/import/importLocalFiles', model: [files: files, rootPath: rootPath])
        } else {
            render(template: '/import/importLocalFiles', model: [files: files, rootPath: rootPath])
            render "Folder " + rootPath + " does not exist."
        }
    }


    def upload() {
//        println 'params ' + params.dump()

        String contentType = request.getHeader("Content-Type")
        String fileName = URLDecoder.decode(request.getHeader('X-File-Name'), 'UTF-8')
        long fileSize = (request.getHeader('X-File-Size') != "undefined") ? request.getHeader('X-File-Size') as long : 0
        String name = URLDecoder.decode(request.getHeader('X-Uploadr-Name'), 'UTF-8')
        def info = session.getAttribute('uploadr')
        def myInfo = (name && info && info.containsKey(name)) ? info[name] : [:]
        String savePath = myInfo.path ?: "/tmp"
//        println 'path ' + myInfo.path
        def dir = new File(savePath)
        def file = new File(savePath, fileName)
        def namePart = ""
        def extension = ""
        def testName = ""
        int status = 0
        def statusText = ""

        response.contentType = 'application/json'

        // update lastUsed stamp in session
        if (name && info && info.containsKey(name)) {
            session.uploadr[name].lastUsed = new Date()
            session.uploadr[name].lastAction = "upload"
        }

        if (!dir.exists()) {
            try {
                dir.mkdirs()
            //    println 'dir created'
            } catch (e) {
                response.sendError(500, "could not create upload path ${savePath}")
                render([written: false, fileName: file.name] as JSON)
                return false
            }
        }

        def freeSpace = dir.getUsableSpace()
        if (fileSize > freeSpace) {
            response.sendError(500, "cannot store '${fileName}' (${fileSize} bytes), only ${freeSpace} bytes of free space left on device")
            render([written: false, fileName: file.name] as JSON)
            return false
        }

        if (!dir.canWrite()) {
            if (!dir.setWritable(true)) {
                response.sendError(500, "'${savePath}' is not writable, and unable to change rights")
                render([written: false, fileName: file.name] as JSON)
                return false
            }
        }

        // make sure the file name is unique
        int dot = fileName.lastIndexOf(".")
        namePart = (dot) ? fileName[0..dot - 1] : fileName
        extension = (dot) ? fileName[dot + 1..fileName.length() - 1] : ""
        int testIterator = 1
        while (file.exists()) {
            testName = "${namePart}-${testIterator}.${extension}"
            file = new File(savePath, testName)
            testIterator++
        }

        // handle file upload
        try {
            FileCopyUtils.copy(request.inputStream, new FileOutputStream(file))
            status = 200
            statusText = "'${file.name}' upload successful!"
        } catch (e) {
            status = 500
            statusText = e.message
        }

        // make sure the file was properly written
        if (status == 200 && fileSize > file.size()) {
            // whoops, looks like the transfer was aborted!
            status = 500
            statusText = "'${file.name}' transfer incomplete, received ${file.size()} of ${fileSize} bytes"
        }

        // got an error of some sorts?
        if (status != 200) {
            // then -try to- delete the file
            try {
                file.delete()
            } catch (ignored) {
            }
        }

        // render json response
        response.setStatus(status)
        render([written: (status == 200), fileName: file.name, status: status, statusText: statusText] as JSON)
    }
  def uploadCover2() {
//        println 'params ' + params.dump()

        String contentType = request.getHeader("Content-Type")
        String fileName = URLDecoder.decode(request.getHeader('X-File-Name'), 'UTF-8')
        long fileSize = (request.getHeader('X-File-Size') != "undefined") ? request.getHeader('X-File-Size') as long : 0
        String name = URLDecoder.decode(request.getHeader('X-Uploadr-Name'), 'UTF-8')
        def info = session.getAttribute('uploadr')
        def myInfo = (name && info && info.containsKey(name)) ? info[name] : [:]
      String savePath = myInfo.path ? myInfo.path?.split('-')[0]: "/tmp"
      String saveId = myInfo.path ? myInfo.path?.split('-')[1]: "/tmp"

//        println 'path ' + myInfo.path
        def dir = new File(savePath)
        def file = new File(savePath, saveId)
        def namePart = ""
        def extension = ""
        def testName = ""
        int status = 0
        def statusText = ""

        response.contentType = 'application/json'

        // update lastUsed stamp in session
        if (name && info && info.containsKey(name)) {
            session.uploadr[name].lastUsed = new Date()
            session.uploadr[name].lastAction = "upload"
        }

        if (!dir.exists()) {
            try {
                dir.mkdirs()
            //    println 'dir created'
            } catch (e) {
                response.sendError(500, "could not create upload path ${savePath}")
                render([written: false, fileName: file.name] as JSON)
                return false
            }
        }

        def freeSpace = dir.getUsableSpace()
        if (fileSize > freeSpace) {
            response.sendError(500, "cannot store '${fileName}' (${fileSize} bytes), only ${freeSpace} bytes of free space left on device")
            render([written: false, fileName: file.name] as JSON)
            return false
        }

        if (!dir.canWrite()) {
            if (!dir.setWritable(true)) {
                response.sendError(500, "'${savePath}' is not writable, and unable to change rights")
                render([written: false, fileName: file.name] as JSON)
                return false
            }
        }

        // make sure the file name is unique
        int dot = fileName.lastIndexOf(".")
        namePart = saveId
        extension = ''//(dot) ? fileName[dot + 1..fileName.length() - 1] : ""

/*
        int testIterator = 1
        while (file.exists()) {
            testName = "${namePart}"//-${testIterator}.${extension}"
            file = new File(savePath, testName)
            testIterator++
        }
*/


        // handle file upload
        try {
            FileCopyUtils.copy(request.inputStream, new FileOutputStream(file))
            status = 200
            statusText = "'${file.name}' upload successful!"
        } catch (e) {
            status = 500
            statusText = e.message
        }

        // make sure the file was properly written
        if (status == 200 && fileSize > file.size()) {
            // whoops, looks like the transfer was aborted!
            status = 500
            statusText = "'${file.name}' transfer incomplete, received ${file.size()} of ${fileSize} bytes"
        }

        // got an error of some sorts?
        if (status != 200) {
            // then -try to- delete the file
            try {
                file.delete()
            } catch (ignored) {
            }
        }

        // render json response
        response.setStatus(status)
        render([written: (status == 200), fileName: file.name, status: status, statusText: statusText] as JSON)
    }

    def upload0() {

//        if (new File(CH.config.data.location + '/' + params.name).exists())
//            new File(CH.config.data.location + '/' + params.name).renameTo(
//                    CH.config.data.location + '/' + params.name + '-' + new Date().format('dd.MM.yyyy-hh.mm'))

        def status = ''
        try {
            def a = new IndexCard([recordId: params.recordId, entityCode: params.entityCode, fileName: params.qqfile])
            a.type = WritingType.findByCode('doc')
            a.summary = params.qqfile//'File'
            a.description = '...'
            a.save(flush: true)

            def path = OperationController.getPath('root.rps1.path') + '/N/' + a.id + '/' + a.id + '.' + params.qqfile.split(/\./).last()
            new File(OperationController.getPath('root.rps1.path') + '/N/' + a.id).mkdirs()
            new File(path) << request.inputStream

            if (new File(path).exists()) {
                return render(text: [id: a.id, entityCode: a.entityCode()] as JSON, contentType: 'text/json')
            }

        } catch (Exception e) {
            println 'problem uploading the file ' + params.qqfile
            status = 'File could not be saved!'
            e.printStackTrace()
        }
//        render(contentType: "text/json") {
//            [status]
//        }

        //render(text: [success: true] as JSON, contentType: 'text/json')
//        render(template: '/layouts/achtung', model: [message: 'Document uploaded'])

    }

    /*
        Used
    */

    def addToRecordFolder() {



        def resourceNestedById = false

        def resourceNestedByType = false


        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true

        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true


        def status = ''
        try {

            def tmpFilename = new Date().format('ddMMyyyyHHmmss') + (Math.random() * 1000).toInteger()
            def f = new File(OperationController.getPath('tmp.path') + '/' + tmpFilename) << request.inputStream

            def path

            if (params.entityCode == 'R') {
                def b = Book.get(params.recordId)
                path = OperationController.getPath('root.rps1.path') + '/R' +


                        (resourceNestedByType ?  '/' +  b.type.code : '') +
                        (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '') +



                        '/' + b.id + '/' + params.qqfile
            } else {
                path = OperationController.getPath('root.rps1.path') + '/' + params.entityCode + '/' +
                        params.recordId + '/' + params.qqfile
            }

            def ant = new AntBuilder()
            ant.move(file: f.path, tofile: path)
            return render(['Ok'] as JSON)
        } catch (Exception e) {
            println 'problem uploading the file ' + params.qqfile
            status = 'File could not be saved!'
            e.printStackTrace()
        }

    }


    def uploadCover() {

        def status = ''
        try {

            def tmpFilename = new Date().format('ddMMyyyyHHmmss') + (Math.random() * 1000).toInteger()
            def f = new File(OperationController.getPath('tmp.path') + '/' + tmpFilename) << request.inputStream

            def path

            if (params.entityCode == 'R') {
                def b = Book.get(params.recordId)
                path = OperationController.getPath('root.rps1.path') + '/R/cvr/' + b.id + '.jpg'
            } else {
                path = OperationController.getPath('root.rps1.path') + '/' + params.entityCode + '/cvr/' +
                        params.recordId + '.jpg'
            }

            def ant = new AntBuilder()
            ant.move(file: f.path, tofile: path)
            return render(['Ok'] as JSON)
        } catch (Exception e) {
            println 'problem uploading the file ' + params.qqfile
            status = 'File could not be saved!'
            e.printStackTrace()
        }

    }


    def editBox() {
        render(template: '/reports/editBoxShow')
    }

    def addToRecordFolder2() {
        println params.dump()
    }


    def scrapHtmlPage() {

        try {

            def r = Book.get(params.id)
            String url = r.url

            Configuration configuration = new Configuration()
            configuration.setMinBytesForImages(4500)
            configuration.setLocalStoragePath("/tmp/goose")
            // i don't care about the image, just want text, this is much faster!
            configuration.setEnableImageFetching(false);
            //   configuration.setImagemagickConvertPath("/opt/local/bin/convert");
            Goose goose = new Goose(configuration);

            Article article = goose.extractContent(url)
            r.fullText = article.cleanedArticleText()
            //r.publishedOn = article.publishDate()
            r.title = article.title()
            r.notes = article.metaDescription()
            r.textTags = article.metaKeywords()
            r.imageUrl = article.topImage().getImageSrc()


            if (r.imageUrl) {

                def path = OperationController.getPath('covers.sandbox.path')// + '/' + r.type?.code

                def t = new File(path + '/' + r.id + '.jpg')
                if (t.exists()) t.renameTo(new File(path + '/' + r.id + '-old.jpg'))
                try {
                    t << new URL(r.imageUrl.substring(0, r.imageUrl.length() - 6)).openStream()
                }
                catch (Exception e) {
                    e.printStackTrace()
                }
            }
            render(template: '/gTemplates/recordSummary', model: [record: r, expandedView: true])
        }
            catch (Exception e){
                println 'Error while scrapping: ' + e
        }

    }

    def scrapHtmlAll() {
        def url

        Configuration configuration = new Configuration()
        configuration.setMinBytesForImages(4500)
        configuration.setLocalStoragePath("/tmp/goose")
        // i don't care about the image, just want text, this is much faster!
        configuration.setEnableImageFetching(false);
        //   configuration.setImagemagickConvertPath("/opt/local/bin/convert");
        Goose goose = new Goose(configuration);


        for (r in Book.findAllByType(ResourceType.findByCode('link'))) {
            if (r.url && !r.fullText) {
                try {
                    url = r.url
                    Article article = goose.extractContent(url)
                    r.fullText = article.cleanedArticleText()
                    //r.publishedOn = article.publishDate()

//                    if (article.title() && article.title()?.trim() != '')
                        r.title = article.title()

                    r.notes = article.metaDescription()
                    r.textTags = article.metaKeywords()
                    println 'scrapping ' + r.id + '>> ' + url
                    r.save(flush: true)
                    // r.imageUrl = article.topImage().getImageSrc()
                }
                catch (Exception e) {
                    println 'ERROR scrapping ' + r.id + '>> ' + url + '\n' + e.toString() + '\n\n'
                    //   render(template: '/gTemplates/recordSummary', model: [record: r, expandedView: true])
                }
            }
        }
    }

    } // end of class