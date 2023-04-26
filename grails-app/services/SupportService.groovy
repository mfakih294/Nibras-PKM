

import app.IndexCard
import app.Indicator
import app.IndicatorData
import app.Tag
import app.parameters.Blog
import app.parameters.ResourceType
import cmn.Setting

//import com.itextpdf.text.pdf.PdfReader
//import com.itextpdf.text.pdf.PdfStamper
//import com.itextpdf.text.xml.xmp.XmpWriter
import ker.OperationController
import mcs.Book
import mcs.Course
import mcs.Task
import mcs.parameters.ResourceStatus

//import mcs.parameters.Writing
import mcs.Goal

//import mcs.WritingType

import net.bican.wordpress.CustomField
import net.bican.wordpress.MediaItem
import net.bican.wordpress.MediaItemUploadResult

//import net.bican.wordpress.Post

import net.bican.wordpress.Post
import net.bican.wordpress.Term

//import net.bican.wordpress.Term
import net.bican.wordpress.Wordpress

import org.apache.commons.logging.LogFactory
import org.w3c.dom.Document
import org.w3c.dom.Node
import redstone.xmlrpc.XmlRpcArray

import javax.xml.parsers.DocumentBuilder
import javax.xml.parsers.DocumentBuilderFactory
import java.text.DecimalFormat
import java.text.NumberFormat

class SupportService {

    boolean transactional = false
    def grailsApplication

//    private static final log = LogFactory.getLog(this)

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
            'O'            : 'mcs.Operation',
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




    String getResourcePath(Long id, String type, Boolean relative) {
        if (type == 'R') {
            def bookInstance = Book.get(id)

            def record = Book.get(id)//grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
            def typeSandboxPath

            def resourceNestedById = false
            def resourceNestedByType = false

            if (OperationController.getPath('resourceNestedById') == 'yes')
                resourceNestedById = true

            if (OperationController.getPath('resourceNestedByType') == 'yes')
                resourceNestedByType = true


                typeSandboxPath = (!relative ? OperationController.getPath('root.rps1.path') : '')  + 'R' + //todo parametric
                        (resourceNestedByType ?  '/' +  record.type.code : '') +
                        (resourceNestedById ?  '/' +   (record.id / 100).toInteger() : '') +
                        '/' + record.id
//            } else { //todo
//                typeSandboxPath = OperationController.getPath('root.rps' + params.repository + '.path') + '' + params.entityCode + '/' + record.id
//            }


            return typeSandboxPath
        } else if (type == 'O') {
            def operation = mcs.Operation.get(id)
            def date = operation.summary?.split(/\(/)[1]
            def path = (!relative ? OperationController.getPath('root.rps1.path') : '')  + '/' + type + //todo parametric
                    '/' + id

            /** code for later - to import operations from mobile

            new File(OperationController.getPath('root.rps1.path') + '/new').eachFileMatch(~/${date}_[\S\s] (todo add star here, removed for the comment stars) /) { f ->
                println 'inside new '
            path = f.path
                println 'found ' + f.path
            }
            */

//            def typeSandboxPath = (!relative ? OperationController.getPath('root.rps1.path') : '')  + '/new/' + //todo parametric
//                    '/' +
//            } else { //todo
//                typeSandboxPath = OperationController.getPath('root.rps' + params.repository + '.path') + '' + params.entityCode + '/' + record.id
//            }
            return path
        }
        else {

            def typeSandboxPath = (!relative ? OperationController.getPath('root.rps1.path') : '')  + '/' + type + //todo parametric
                    '/' + id
//            } else { //todo
//                typeSandboxPath = OperationController.getPath('root.rps' + params.repository + '.path') + '' + params.entityCode + '/' + record.id
//            }
            return typeSandboxPath
        }
    }


    String createLink(Long id, String type) {
        def path = getResourcePath(id, type)
        def i = Book.get(id)
        def course = i.course ? i.course.code + ' ' + i.course.title : '9090'

        DecimalFormat nf = new DecimalFormat("000")
        DecimalFormat nfb = new DecimalFormat("0000")

        def label = //StringUtils.abbreviate(
                "B-${nf.format(i.id)} ${i.title ? i.title.replaceAll(':', ' ').replaceAll(/\?/, ' ').replaceAll(/\!/, ' ').replaceAll(';', ' ').replaceAll('&', 'and').replaceAll('"', '') : ''}".trim()
// + ".${i.ext}"
//            , 120)


        def folder = i.type.repositoryPath
        //    grailsApplication.config.ebk.path
        +'/' + new DecimalFormat('0000').format(id).substring(0, 2)
        def initial = new DecimalFormat('0000').format(id) + 'b'
        def ant = new AntBuilder()

        new File(folder).eachFileMatch(~/${initial}[\S\s]*/) { f ->

            println """mkdir -p /todo/"${course}" && ln -f "${f.path}" "/todo/${course}/${
                label
            }${f.name.contains('-') ? ' - ' + f.name.split('-')[1] : '.' + f.name.split(/\./)[1]}" """//.execute()
//replace('.', label + '.')
        }

        //"""d:\\mcs\\scr\\linkw "d:\\mcd\\lnk\\ebk\\links\\${bookInstance.course?.code ?: '1'}\\${label}" ${FilenameUtils.separatorsToSystem(path)}""".execute()

    }


    String getResourceLabel(Long id, String type) {
        def i = Book.get(id)

        //return (bookInstance.course.code ?: '') + (bookInstance.orderNumber ?: 'x ') + ' ' + bookInstance.id + ' ' + (bookInstance.legacyTitle && bookInstance.legacyTitle != '' ? bookInstance.legacyTitle : bookInstance.title)// + (bookInstance.isbn ?: '')
    }

    String toWeekDate(Date date) {
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


    String fromWeekDate(String weekDate) {

        def year = '20' + weekDate.substring(4, 6)
        //weekDate = weekDate.substring(0, 3)
        int week = Integer.parseInt(weekDate.substring(0, 2))
        int day = Integer.parseInt(weekDate.substring(2, 3))
        if (week == 0 || week > 53 || day < 0 || day > 7) {
            log.error "Invalid weekDate ranges"
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
//
//    Date fromWeekDateAsDate(String weekDate) {
//
//        def year = '20' + weekDate.substring(4, 6)
//        def time = weekDate.substring(7)
//        //        weekDate = weekDate.substring(0, 3)
//        int week = Integer.parseInt(weekDate.substring(0, 2))
//        int day = Integer.parseInt(weekDate.substring(2, 3))
//        if (week == 0 || week > 53 || day < 0 || day > 7) {
//            log.warn "Invalid weekDate ranges"
//            throw new IOException()
//        }
//
//        Calendar c = new GregorianCalendar()
//        c.setLenient(false)
//        c.setMinimalDaysInFirstWeek(4)
//        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
//        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
//        int javaDay = (day == 7) ? 1 : (day + 1)
//        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
//        c.set(java.util.Calendar.YEAR, year.toInteger())
//        return Date.parse("yyyy-MM-dd HH:mm", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time)
//        //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)
//
//    }
//
//    Date fromWeekDateAsDateGeneral(String weekDate) {
//        try {
//            def year = new Date().format('yyyy')
//            if (weekDate.length() == 6)
//                year = '20' + weekDate.substring(4)
//            def time = ' 00:00'
//            if (weekDate.length() > 6)
//                time = weekDate.substring(7, 9) + ':' + weekDate.substring(9)
//            //        weekDate = weekDate.substring(0, 3)
//            int week = Integer.parseInt(weekDate.substring(0, 2))
//            int day = Integer.parseInt(weekDate.substring(2, 3))
//            if (week == 0 || week > 53 || day < 0 || day > 7) {
//                log.warn "Invalid weekDate ranges"
//                throw new IOException()
//            }
//
//            Calendar c = new GregorianCalendar()
//            c.setLenient(false)
//            c.setMinimalDaysInFirstWeek(4)
//            c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
//            c.set(java.util.Calendar.WEEK_OF_YEAR, week)
//            int javaDay = (day == 7) ? 1 : (day + 1)
//            c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
//            c.set(java.util.Calendar.YEAR, year.toInteger())
//
//            Date.parse("yyyy-MM-dd HH:mm", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time)
//            //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)
//        }
//        catch (Exception e) {
//            e.printStackTrace()
//            println e.toString()
//
//        }
//
//    }
//
//    Date fromWeekDateAsDateTime(String weekDate) {
//
//        def year = '2012'// + weekDate.substring(4, 6)
//        def time = weekDate.substring(4)
//        //        weekDate = weekDate.substring(0, 3)
//        int week = Integer.parseInt(weekDate.substring(0, 2))
//        int day = Integer.parseInt(weekDate.substring(2, 3))
//        if (week == 0 || week > 53 || day < 0 || day > 7) {
//            log.warn "Invalid weekDate ranges"
//            throw new IOException()
//        }
//
//        Calendar c = new GregorianCalendar()
//        c.setLenient(false)
//        c.setMinimalDaysInFirstWeek(4)
//        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
//        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
//        int javaDay = (day == 7) ? 1 : (day + 1)
//        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
//        c.set(java.util.Calendar.YEAR, year.toInteger())
//        return Date.parse("yyyy-MM-dd HH:mm", c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time + ':00')
//        //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)
//
//    }
//

//    def copyWrt(Long id, String destination) {
//        def b = Writing.get(id)
//        if (b) {
//            def ant = new AntBuilder()
//            //        if (new File(getResourcePath(id, 'b')).exists() && !new File(destination + '/' + b.course.code + '/' + (b.orderNumber ?: '') + ' ' + nf.format(b.id) + 'b.' + b.ext).exists())
//            ant.copy(file: getResourcePath(id, 'w'), tofile: destination + '/' + b.course.code + '/' + (b.orderNumber ?: '') + ' ' + b.id + 'w ' + b.title + '.tex')
//            //        else {
//            //            if (!new File(getResourcePath(id, 'b')).exists())
//            //            println 'missed file for book: ' + b.id + '\n'
//            //        }
//        }
//    }

    //def report1(){
    //  def r = ''
    //  Task.list([sort: 'goal']).each(){
    //    r += it.goal.toString() + ': ' + it.name + '<p>'
    //  }
    //  r
    //}


    private static String fetchTitle(String requestUrl) {
        String title = null;
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            Node titleNode = doc.getElementsByTagName("Author").item(0);
            title = titleNode.getTextContent();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return title;
    }

    String updateInfo() {
        try {

            def b = Book.get(params.id)
            updateBook(b.id)
            addBibtex(b.id)

            render 'Book info updated'
        } catch (Exception e) {
            e.printStackTrace()
            render 'Something wrong happened during updating.'
        }

    }


    String addBibtex(Long id) {

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
                }
            }
            catch (Exception e) {
                log.warn('problem in getting bib entry of b' + it.id) //e.printStackTrace()
            }
        }

    }

    static String addCover(Long id) {
        def b = Book.get(id)
        //def path = CH.config.covers.repository.path + '/ebk'

        def path = OperationController.getPath('covers.sandbox.path') + '/' + b.type?.code

        if (b.imageUrl) {
            def t = new File(path + '/' + id + '.jpg')
            if (t.exists()) t.renameTo(new File(path + '/' + id + '-old.jpg'))
            try {
                t << new URL(b.imageUrl.substring(0, b.imageUrl.length() - 6)).openStream()
            }
            catch (Exception e) {
                e.printStackTrace()
            }
            if (!t.exists())
                println('Cover not found ' + t.path)// 'Cover is now there'
        } else
            println('No image url for b' + b.id)
    }


    static Integer indicatorLastSavedValue(Long id) {
        def d = IndicatorData.findByIndicator(Indicator.get(id), [sort: 'dateCreated', order: 'desc'])
        if (d)
            return d?.value
        else return null
    }

    static Integer indicatorCurrentValue(Long id) {
        Integer result
        def i = Indicator.get(id)
        if (i.path)
            result = countFolder(i.path, i.extensions)
        else if (i.query)
            result = Goal.executeQuery("select count(*)" + i.query)[0] // todo: why select count(*) was removed!

        return result
    }


    static Date indicatorLastSavedDate(Long id) {
        def d = IndicatorData.findByIndicator(Indicator.get(id), [sort: 'date', order: 'desc'])
        if (d)
            return d?.date
        else return null
    }


    static Integer countFolder(String path, String extensions) {
        def count = 0
        try {
            extensions.split(';').each() { ext ->
                new File(path).eachFileRecurse { f ->
                    if (f.name.toLowerCase().matches(~/^[\s\S]*.${ext}/))
                        count++
                }
            }
            return count
        } catch (Exception e) {
            return null
        }
    }


    int postToBlog(Long blogId, String code, String title, String categoriesString, String tags, String fullText,
                   String excerpt, String entityCode, Integer publishedNodeId, String coverPath, String[] files, String uploadBase) {

        try {
            def username
            def password
            def link

            ArrayList<String> categories = categoriesString.split(',')


            Blog blog

            if (blogId)
            blog = Blog.get(blogId)
            else
             blog = Blog.findByCode(OperationController.getPath('blog.current.code'))

            username = blog.username
            password = blog.password
            link = blog.link


            net.bican.wordpress.Wordpress wp = new net.bican.wordpress.Wordpress(username, password, link)
            def post
            if (!publishedNodeId) {
            post = new Post()//wp.getPost(publishedNodeId.toInteger())
                post.setPost_type("post")
           } else
                post = wp.getPost(publishedNodeId.intValue())
//                post = wp.getPost(publishedNodeId)

//            if (entityCode == 'W') {
//                post.setPost_type("page")
//            }
//            else {

//            if (!publishedNodeId)
//            post.setPost_type("post")
//            }

//            else{
//                    post = new Post()
//            }
//                Post post
            //    println 'all cat ' + wp.getTerms("category")//.categoryName
            //     final List terms = wp.getTerms("category")//.each(){
//            final Term term = wp.getTerm(1)//
            // new Term()
            //term.setName("test85");
            //term.setTaxonomy("tag");
            //    println terms
//            println 'blog cat ' + ' vale ' + it
//        }
//
            //   wp.newTerm(term)

//            categories.each() {
//                if (it?.trim() != '') {
//                    if (!wp.getTerms("category").categoryName*.toLowerCase()?.contains(it?.toString()?.toLowerCase()?.trim())) {
//                        wp.newTerm(it?.toString(), it?.toString()?.toLowerCase())
//                    }
//
//                }
//            }

            //n.language == 'ar' ?
            //  ('<span style="direction: rtl; text-align: right">' + n.title + ' (' + n.source.name + ', //' + n.publishedOn.format('dd.MM.yyyy') + ')</span>') :

            post.setPost_title(title)
            post.setPost_excerpt(excerpt)


            def links = []

            if (files){
                files.each(){
                    links += '<a href="' + uploadBase + '/' + code + '/' + it + '">' + it + '</a>'

                }
            }
            if (fullText && links)
            post.setPost_content(fullText + '<br/><br/><b>Files:</b><br/>' +  links.join('<br/>'))
            else if (fullText && !links)
            post.setPost_content(fullText)
            else if (!fullText && links)
            post.setPost_content( '<br/><b>Files:</b><br/>' +  links.join('<br/>'))
            //   post.setPage_status('published')
            post.setPost_status('publish')
            post.setPost_name(code)

//            def mi = new MediaItem()
//            mi.setLink('https://khuta.org/cover.jpg')

if (coverPath) {
    InputStream media = new FileInputStream(new File(coverPath))
    final String fileName = "cover.jpg";
    final MediaItemUploadResult mediaUploaded = wp.uploadFile(media, fileName);
    final MediaItem r = wp.getMediaItem(mediaUploaded.getId());
    post.setPost_thumbnail(r);
}
//                Integer p = wp.newPost(post);

//            post.setPost_thumbnail(mi)


            final List<Term> terms = wp.getTerms("post_tag");
            def postTags = []

            tags.split(',').each() { tag ->
                if (tag != null && tag != '' && tag != 'null') {
                    def term = Term.builder().name(tag).taxonomy("post_tag").build();
                    def termId = null;
                    try {
                        termId = wp.newTerm(term);
                    } catch (Exception e) {
                        for (Term t : terms) {
                            if (t.getName().equals(tag)) {
                                termId = t.getTerm_id();
                                break;
                            }
                        }
                    }
//                term.setName(tag);
//                term.setTaxonomy("post_tag");

                    println 'termId ' + termId
                    postTags.add(wp.getTerm("post_tag", termId));
                }
            }

            // setting up categories


            final List<Term> termsCat = wp.getTerms("category");
            def postCats = []

            categoriesString.split(',').each() { tag ->
                if (tag != null && tag != '' && tag != 'null') {
                    def term = Term.builder().name(tag).taxonomy("category").build();
                    def termId = null;
                    try {
                        termId = wp.newTerm(term);
                    } catch (Exception e) {
                        for (Term t : termsCat) {
                            if (t.getName().equals(tag)) {
                                termId = t.getTerm_id();
                                break;
                            }
                        }
                    }
//                term.setName(tag);
//                term.setTaxonomy("post_tag");

                    println 'catId ' + termId
                    postCats.add(wp.getTerm("category", termId));
                }
            }

            post.setTerms(postTags + postCats);
            // final Integer pId = wp.newPost(pp);
            //    println 'new id ' +  wp.getPost(pId);

//            XmlRpcArray array = categories as String[]
//            post.setCategories(array)

//            post.setTerms([term])

            //recentPost.setExcerpt(StringUtils.abbreviate(content, 250))

            //   XmlRpcArray array = categories as String[]
            //   post.setTerms(array)

//            XmlRpcArray custom_fields = new XmlRpcArray();
//            CustomField cf = new CustomField();
//            cf.setKey("use_blogtext");
//            cf.setValue("on");
//            custom_fields.add(cf);

            //  post.setCustom_fields(custom_fields) // to enable BlogIt syntax

//     post.setTerms(tags)
//
            //   post.setMt_keywords(tags)

            def result

            if (!publishedNodeId) {
                result = wp.newPost(post)
                println ' new post'
            }
            else {
//                final Integer p = wp.newPost(wp.newPost(post))
                wp.editPost(publishedNodeId, post)
//                final Post ep = WP.getPost(p);
              //  result = wp.getPost(publishedNodeId.intValue())
            }

           println 'resut is: ' + result

            println 'post link is: ' + post.getLink()
//            render 'post link is: ' + post.getLink()

            if (!publishedNodeId ) {
//                println 'here'
                return result
            } else if (publishedNodeId) {
//                println 'here2'
                return publishedNodeId
            }
//            println("Record WAS posted")
        }
        catch (Exception e) {
//            e.printStackTrace()
            println e.printStackTrace()
            log.error(e.printStackTrace())
            println("Record could NOT be posted.")
            log.error(e.toString())
            return 0
        }

    }
    /*
     Long post2xcd(String blogCode, Integer postId) {

         def username
         def password
         def link


         Blog blog = Blog.findByCode(blogCode)
         username = blog.username
         password = blog.password
         link = blog.link



         Wordpress wp = new Wordpress(username, password, link)

         Post post = wp.getPost(postId)


         println 'Title:' + post.title
         println 'Desc:' + post.description
         println 'Cat:' + post.categories
         println 'Date:' + post.dateCreated
         println 'Tags:' + post.mt_keywords

         def n = new IndexCard()
         n.summary = post.title
         n.description = post.description
         n.blogCode = blogId
         n.publishedOn = post.dateCreated
         n.publishedNodeId = post.postid
         n.save(flush: true)
         if (post.mt_keywords) {
             post.mt_keywords.split(',').each() {
                 n.addToTags(Tag.findByName(it) ?: new Tag([name: it]).save(flush: true))
             }
         }

         post.categories.each() {
             n.addToTags(Tag.findByName(it) ?: new Tag([name: it, isKeyword: true]).save(flush: true))
         }

         return n.id

     }

    */


    // this is the method to use - mcs notation implementation
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
            //    println "Invalid weekDate ranges"
            throw new IOException()
        }

        Calendar c = new GregorianCalendar()
        c.setLenient(false)
        c.setMinimalDaysInFirstWeek(4)
        c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
        c.set(java.util.Calendar.WEEK_OF_YEAR, week)
        int javaDay = (day == 7) ? 1 : (day + 1)
        c.set(java.util.Calendar.DAY_OF_WEEK, javaDay)
//      c.set(java.util.Calendar.YEAR, year.toInteger())

        Date.parse("yyyy-MM-dd HH:mm", year + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE) + ' ' + time)
        //        return c.get(Calendar.YEAR) + '-' + (c.get(Calendar.MONTH) + 1) + '-' + c.get(Calendar.DATE)

    }


    Task[] getOverdueTasks(){
        def list =
 Task.executeQuery('from Task where date(endDate) < current_date() and status.code != ? and bookmarked = true order by context asc',
         ['done'])
        return list
//        return [Task.get(683)]
    }
     Task[] getTasksPile(){
         def list =
                 Task.executeQuery('from Task where (endDate is null or date(endDate) != current_date()) and bookmarked = ? order by context asc', [true])
         return list
    }
     Task[] getTasksTodayInProgress(){
         def list =
                 Task.executeQuery('from Task where date(endDate) = current_date() and status.code = ? order by context asc',
                 ['inp'])
         return list
    }
     Task[] getTasksTodayCompleted(){
         def list =
                 Task.executeQuery('from Task where date(endDate) = current_date() and status.code = ? order by context asc',
                         ['done'])
         return list
    }
     Task[] getTasksTodayNotStarted(){
         def list =
                 Task.executeQuery('from Task where date(endDate) = current_date() and status.code != ? and status.code != ? order by context asc',
                         ['inp', 'done'])
         return list
    }

    Task[] getTasksActiveNotStarted(){
         def list =
//                 Task.executeQuery('from Task where bookmarked = true and ((status.code != ? and status.code != ?) or status = null)',   ['inp', 'done'])
                 Task.executeQuery('from Task where bookmarked = true order by context asc')
//        println 'list: ' + list
         return list
    }

    def updateBookmarkedRecordsFileCount(){

//         println 'In support service counting files...'



        if (OperationController.getPath('panel.integrations.currentPlan.enabled') == 'yes') {
            def path = OperationController.getPath('panel.integrations.currentPlan.path')
            if (mcs.Planner.executeQuery('select count(*) from Planner where startDate <= ? and endDate >= ? ', [new Date(), new Date()])[0] > 0) {
                def p =
                        mcs.Planner.executeQuery('from Planner where startDate <= ? and endDate >= ? ', [new Date(), new Date()])[0]

                new File(path).write('>' + p.endDate?.format('HH:mm') + ' ' + p.summary, 'UTF-8')
            } else {
                new File(path).write('*** No plan set!', 'UTF-8')
            }
        }


        def results = []
        [mcs.Course,
         mcs.Goal,
         mcs.Task,
         mcs.Planner,
         mcs.Journal,

         mcs.Writing,
         app.IndexCard,

         mcs.Book,
         mcs.Excerpt,
         app.Contact
        ].each() {
            it.findAllByBookmarked(true).each(){
                OperationController.countResourceFilesStatic(it.id, it.entityCode())
            }
        }



    }

    def loadRecord(String entitCode, Long id){
        return grailsApplication.classLoader.loadClass(entityMapping[entitCode]).get(id)
    }



    /**
     * Calculates the similarity (a number within 0 and 1) between two strings.
     */
    public static double similarity(String s1, String s2) {
        String longer = s1, shorter = s2;
        if (s1.length() < s2.length()) { // longer should always have greater length
            longer = s2; shorter = s1;
        }
        int longerLength = longer.length();
        if (longerLength == 0) { return 1.0; /* both strings are zero length */ }
        /* // If you have StringUtils, you can use it to calculate the edit distance:
        return (longerLength - StringUtils.getLevenshteinDistance(longer, shorter)) /
                                                             (double) longerLength; */
        return (longerLength - editDistance(longer, shorter)) / (double) longerLength;

    }

    // Example implementation of the Levenshtein Edit Distance
    // See http://r...content-available-to-author-only...e.org/wiki/Levenshtein_distance#Java
    public static int editDistance(String s1, String s2) {
        s1 = s1.toLowerCase();
        s2 = s2.toLowerCase();

        int[] costs = new int[s2.length() + 1];
        for (int i = 0; i <= s1.length(); i++) {
            int lastValue = i;
            for (int j = 0; j <= s2.length(); j++) {
                if (i == 0)
                    costs[j] = j;
                else {
                    if (j > 0) {
                        int newValue = costs[j - 1];
                        if (s1.charAt(i - 1) != s2.charAt(j - 1))
                            newValue = Math.min(Math.min(newValue, lastValue),
                                    costs[j]) + 1;
                        costs[j - 1] = lastValue;
                        lastValue = newValue;
                    }
                }
            }
            if (i > 0)
                costs[s2.length()] = lastValue;
        }
        return costs[s2.length()];
    }

    public static void printSimilarity(String s, String t) {
//		System.out.println
        render (String.format(
                "%.3f is the similarity between \"%s\" and \"%s\"", similarity(s, t), s, t));
    }

}
