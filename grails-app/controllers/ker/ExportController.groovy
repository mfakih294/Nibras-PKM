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

//import org.scribe.model.Response
//import org.scribe.model.Token
//import uk.co.desirableobjects.oauth.scribe.OauthService

import app.IndexCard
import grails.converters.XML
import app.Indicator
import app.IndicatorData
import app.Payment
import grails.converters.JSON
import mcs.*
import mcs.parameters.ResourceStatus
import mcs.parameters.SavedSearch
import mcs.parameters.WritingType
import org.apache.commons.lang.StringUtils
import org.apache.commons.lang.WordUtils
//import org.eclipse.mylyn.wikitext.core.parser.MarkupParser
//import org.eclipse.mylyn.wikitext.markdown.core.MarkdownLanguage


//import org.apache.pdfbox.PDFToImage
//import org.apache.pdfbox.util.Splitter
//import org.apache.pdfbox.pdmodel.PDDocument



import java.text.DecimalFormat
import java.text.SimpleDateFormat


import grails.plugin.springsecurity.annotation.Secured



@Secured('ROLE_ADMIN')
class ExportController {

    def supportService

    def generateAuthors() {
//        Book.findAllByBibEntryIsNotNullAndStatus(ResourceStatus.findByCode('zbk')).each() {
        def t = 'code|latinName|bio\n'
        Book.findAllByBibEntryIsNotNullAndCodeIsNotNull([sort: 'lastUpdated', order: 'desc']).each() {
            t += it.code + '|' + it.authorInBib + '|' + it.authorInfo + '\n'
        }

        def f = new File(OperationController.getPath('editBox.path') + '/bib/authors.csv')
        f.write(t, 'UTF-8')
        render(template: '/layouts/achtung', model: [message: 'Ok... ' + Book.countByBibEntryIsNotNullAndCodeIsNotNull() + ' authors info exported'])

        }
   def generateAllBibs() {
//        Book.findAllByBibEntryIsNotNullAndStatus(ResourceStatus.findByCode('zbk')).each() {
        Book.findAllByBibEntryIsNotNullAndCodeIsNotNull([sort: 'lastUpdated', order: 'desc']).each() {
            OperationController.generateBibEntrySt(it.id)
        }
        render(template: '/layouts/achtung', model: [message: 'Ok... ' + Book.countByBibEntryIsNotNullAndCodeIsNotNull() + ' re-generated'])

        }
    def textbooks2Bib() {
        def nf = new DecimalFormat("0000")
        def f = new File(OperationController.getPath('editBox.path') + '/bib/zbk.bib')
        f.text = ''
        def t = ''
//        Book.findAllByBibEntryIsNotNullAndStatus(ResourceStatus.findByCode('zbk')).each() {
        Book.findAllByBibEntryIsNotNullAndCodeIsNotNull([sort: 'dateCreated', order: 'desc']).each() {
//            OperationController.generateBibEntrySt(it.id)
//            if (it.bibEntry.count(/\{/) % 2 == 0 && it.bibEntry.count(/\}/) % 2 == 0 && it.bibEntry.contains('isbn = ')) {
                def e = (it.bibEntry)
//                            .replace('author = ',
//                            'bid = {' + nf.format(it.id) + '},\n file = {:' + nf.format(it.id) + 'b.' + (it.ext ?: 'pdf') + ':' +
//                                    (it.ext ? it.ext?.toUpperCase() : 'PDF') + '},\n' + ' author = ') + '\n\n')
//                e = e.replaceAll(/%/, '\\%').replaceAll(/#/, '\\#').replaceAll(/&/, '\\&').replaceAll(/_/, '\\_')
                t += e  + '\n\n'
//            } else log.warn 'textbook without bib entry ' + it.id
        }
        f.write(t, 'UTF-8')
        render(template: '/layouts/achtung', model: [message: 'Bib file generated'])


    }


    def calendarEvents() {
        def events = []

        def savedSearch = SavedSearch.get(params.id)

        if ('JP'.contains(savedSearch.entity)) {


            Task.executeQuery(savedSearch.query + " and t.startDate between ? and ?",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [Date.parse('yyyy-MM-dd', params.start) - 20, Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' + it.type?.code + ' ' +
                    (it.task ? 'T-' + StringUtils.abbreviate(it.task?.summary, 60) + ' ' : '') +
                    (it.goal ? 'G-' + StringUtils.abbreviate(it.goal?.summary, 80) + ' ' : '') + //it.goal?.code + ' '
                        (it.course ? '(' + it.course?.code + ') ' : '') +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.startDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate ?: it.startDate),
                            //it.type?.name +
                            title          : title,
                            description    : it.description,
                            backgroundColor: it.type?.color ?: '#F7F9EE',
                            borderColor    : 'darkgray',
                            textColor      : it.type?.style ?: '#515150',

                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=' + savedSearch.entity,
                            allDay         : (it.level != 'm' || it.startDate.hours < 6 ? true : false)])
            }

        }
  if ('T'.contains(savedSearch.entity)) {


            Task.executeQuery(savedSearch.query + " and t.endDate between ? and ?",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [Date.parse('yyyy-MM-dd', params.start) - 20, Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' +
                        (it.context ? '@' + it.context?.code + ' ' : '') +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate),
                            //it.type?.name +
                            title          : title,
                            description    : it.description,
                            backgroundColor: '#F7F9EE',
                            borderColor    : 'darkgray',
                            textColor      : it.context?.style ?: '#515150',

                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=' + savedSearch.entity,
                            allDay         : true   ])
            }

        }

        if ('R'.contains(savedSearch.entity)) {


            Task.executeQuery(savedSearch.query + " and t.readOn between ? and ?",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [Date.parse('yyyy-MM-dd', params.start) - 20, Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' +
                        (it.title ? it.title + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.readOn),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.readOn),
                            //it.type?.name +
                            title          : title,
                            description    : StringUtils.abbreviate(it.description, 600),
                            backgroundColor: '#F7F9EE',
                            borderColor    : 'darkgray',
                            textColor      : 'black',//it.context?.style ?: '#515150',
                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=' + savedSearch.entity,
                            allDay         : true   ])
            }

        }
    if ('N'.contains(savedSearch.entity)) {


            Task.executeQuery(savedSearch.query + " and t.readOn between ? and ?",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [Date.parse('yyyy-MM-dd', params.start) - 20, Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.readOn),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.readOn),
                            //it.type?.name +
                            title          : title,
                            description    : StringUtils.abbreviate(it.description, 600),
                            backgroundColor: '#F7F9EE',
                            borderColor    : 'darkgray',
                            textColor      : 'black',//it.context?.style ?: '#515150',
                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=' + savedSearch.entity,
                            allDay         : true   ])
            }

        }


        render events as JSON

    }

    def allCalendarEvents() {
        def events = []


            Task.executeQuery("from Journal t where t.startDate between :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title =  '' + (it.type?.code ? '#' + it.type?.code : '') + '' +
                    (it.task ? 'T-' + StringUtils.abbreviate(it.task?.summary, 60) + ' ' : '') +
                    (it.goal ? 'G-' + StringUtils.abbreviate(it.goal?.summary, 80) + ' ' : '') + //it.goal?.code + ' '
                        (it.course ? '(' + it.course?.code + ') ' : '') +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.startDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate ?: it.startDate),
                            //it.type?.name +
                            title          : StringUtils.abbreviate(title, 80),
                            description    : it.summary + '|' + it.description,
                            backgroundColor: 'CadetBlue',//it.type?.color ?: '#F7F9EE',
                            borderColor    : 'CadetBlue',
                            textColor      : 'white',//it.type?.style ?: '#515150',

                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=J',
                            allDay         : (it.level != 'm' || it.startDate.hours < 6 ? true : false)])
            }
      Task.executeQuery("from Planner t where t.startDate between :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' + (it.type?.code ? '#' + it.type?.code : '') + ' ' +
                    (it.task ? 'T-' + StringUtils.abbreviate(it.task?.summary, 60) + ' ' : '') +
                    (it.goal ? 'G-' + StringUtils.abbreviate(it.goal?.summary, 80) + ' ' : '') + //it.goal?.code + ' '
                        (it.course ? '(' + it.course?.code + ') ' : '') +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.startDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate ?: it.startDate),
                            //it.type?.name +
                            title          : StringUtils.abbreviate(title, 80),
                            description    : it.summary + '|' + it.description,
                            backgroundColor: 'Chocolate',//it.type?.color ?: '#F7F9EE',
                            borderColor    : 'Chocolate',
                            textColor      : 'white',//it.type?.style ?: '#515150',

                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=P',
                            allDay         : (it.level != 'm' || it.startDate.hours < 6 ? true : false)])
            }

            Task.executeQuery("from Task t where t.endDate between :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' +
                        (it.context ? '@' + it.context?.code + ' ' : '') + '' +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate),
                            //it.type?.name +
                            title          : StringUtils.abbreviate(title, 50),
                            description    : it.summary + '|' + it.description,
                            backgroundColor: 'MediumSeaGreen',//it.type?.color ?: '#F7F9EE',
                            borderColor    : 'MediumSeaGreen',
                            textColor      : 'white',//it.type?.style ?: '#515150',
                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=T',
                            allDay         : true   ])
            }


    Task.executeQuery("from Goal t where t.endDate between  :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' +
                        (it.type ? '#' + it.type?.code + ' ' : '') +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate),
                            //it.type?.name +
                            title          : StringUtils.abbreviate(title, 50),
                            description    : it.summary + '|' + it.description,
                            backgroundColor: 'LightSlateGray',//it.type?.color ?: '#F7F9EE',
                            borderColor    : 'LightSlateGray',
                            textColor      : 'white',//it.type?.style ?: '#515150',

                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=T',
                            allDay         : true   ])
            }



            Task.executeQuery("from Book t where t.readOn between :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' +
                        (it.title ? it.title + ' ' : '')+
                (it.type?.code ? '#' + it.type?.code : '') + ' '
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.readOn),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.readOn),
                            //it.type?.name +
                            title          : title,
                            description    : title +'|' + StringUtils.abbreviate(it.description, 600),
                            backgroundColor: 'DarkKhaki',//it.type?.color ?: '#F7F9EE',
                            borderColor    : 'DarkKhaki',
                            textColor      : 'white',//it.type?.style ?: '#515150',
                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=R',
                            allDay         : true   ])
            }

        render events as JSON

    }


    def combineCourseWritingsAsTex() {

        def c = Course.get(params.id)

        def path = OperationController.getPath('editBox.path') + "/out-C-" + (c.code?: c.id) + '.tex'

        def file = new File(path)


        def text = """ """
        Writing.executeQuery('from Writing w where w.course = ? and w.priority > 2 order by orderNumber asc', [c]).each() {
//            text += "\n\n# " + it.summary + '\n\n'
            text += "\n\n\\section{" + it.summary + '}\n\n'
            text += it.description ?: '' //.replaceAll(';; ' , '').replaceAll(';;--' , '')

            IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ? and priority > 2 order by orderNumber asc', [it.id.toString(), 'W']).each() { n ->
//                text += "\n\n## " + n.summary + '\n\n'
                text += "\n\n\\subsection{" + n.summary + '}\n\n'
                text += n.description//.replaceAll(';; ' , '').replaceAll(';;--' , '')
            }
        }
        text += "\n\n\\section{Other}\n\n"
        Writing.executeQuery('from IndexCard w where w.recordId = ? and w.course = ? and w.priority > 2 order by orderNumber asc', [null, c]).each() { n->
            text += "\n\n\\subsection{" + n.summary + '}\n\n'
            text += n.description//.replaceAll(';; ' , '').replaceAll(';;--' , '')
        }

        file.write(text, 'UTF-8')
        render('Course chapters combined')
    }
def combineCourseWritings() {

        def c = Course.get(params.id)

        def path = OperationController.getPath('editBox.path') + "/out-C-" + (c.code?: c.id) + '.md'

        def file = new File(path)


        def text = """ """
        Writing.executeQuery('from Writing w where w.course = ? and w.priority > 1 order by orderNumber asc', [c]).each() {
//            text += "\n\n# " + it.summary + '\n\n'
            text += "\n\n#" + it.summary + '\n\n'
            text += it.description ?: '' //.replaceAll(';; ' , '').replaceAll(';;--' , '')

            IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ? and priority > 1 order by orderNumber asc', [it.id.toString(), 'W']).each() { n ->
                text += "\n\n## " + n.summary + '\n\n'
                text += n.description//.replaceAll(';; ' , '').replaceAll(';;--' , '')
            }
        }


        file.write(text, 'UTF-8')
        render('Course chapters combined')
    }

    def combineWritingNotes() {

        def c = Writing.get(params.id)

        def path = OperationController.getPath('editBox.path') + "/out-W-" + (c.id) + '.md'

        def file = new File(path)


        def text = """ """
            text += "\n\n# " + c.summary + '\n\n'
            text += c.description ?: '' //.replaceAll(';; ' , '').replaceAll(';;--' , '')

            IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ? and priority >= 2 order by orderNumber asc',
                    [c.id.toString(), 'W']).each() { n ->
                text += "\n\n## " + n.summary + '\n\n'
                text += n.description//.replaceAll(';; ' , '').replaceAll(';;--' , '')
            }



        file.write(text, 'UTF-8')
        render('Writing notes combined')
    }

    def generateCoursePresentation() {
        // todo if !.adoc generate else leave
        def path = "/host/todo/new/C/9155/prs.gen" // /mdd/tmp/${new Date().format('yyMMddHHmmss')}"
        def file = new File(path)
        def c = Course.get(params.id)

        def text = """
= ${c.summary}
:title: Integrating Work and Knowledge Management using Pomegranate PKM
:description: Integrating Work and Knowledge Management using Pomegranate PKM
:keywords:  Integrating Work and Knowledge Management using Pomegranate PKM
:author: Mohamad F. Fakih <mail at khuta.org>
:copyright: Mohamad F. Fakih
:Date:   14th March, 2014
:Email:  mail at khuta.org
:max-width!: 25em
:slidebackground:

:backend:   slidy2
:max-width: 45em
:data-uri:
:icons:


This presentation aims to give an overview of Pomegranate PKM system.


"""

        def frag
        for (w in Writing.findAllByCourseAndDeletedOnIsNull(c, [sort: 'orderInCourse', order: 'asc'])) {
            text += "\n== " + w.summary + '\n\n'

            w.description?.trim()?.eachLine() {
                if (it.startsWith(';;--'))
                    text += "\n\n\nifdef::backend-slidy2[<<<]\n\n\n"
                else if (it.startsWith(/\/\//) || it.startsWith(';;')) {
                    frag = it.substring(3)
                    text += (frag.startsWith('*') ? '' : '') + frag + '\n\n'
                } else if (it.startsWith('=')) {
                    frag = it//.substring(3)
                    text += frag + '\n\n'
                }
            }


        }
        file.text = text + '\n'

//        response.setHeader("Content-disposition", "attachment; filename='toc-generated.tex'")
//        response.outputStream << new FileInputStream(path)

//        org.asciidoctor.Asciidoctor asciidoctor = org.asciidoctor.Asciidoctor.Factory.create();

//         Attributes attributes = attributes().tableOfContents(true).sectionNumbers(true).get();

//        Options options = options().attributes(attributes).get();

        render file.text//asciidoctor.render(file.text, options)
    }


    def staticWebsiteToString() {
        render(view: '/static/site')
    }


    def staticWebsite() {

        def f = new File('/' + (OperationController.getPath('rootFolder') ?: 'mhi') + '/mcd/site.html')
        f.write(g.include([controller: 'export', action: 'staticWebsiteToString']).toString(), 'UTF-8')
        render 'Generation done: ' + new Date().format('HH:mm:ss')

    }



    def exportTxtToBeamer() {
        // config
        def documentPath = 'D:/tmp'


        def f = new File(documentPath + '/outline.txt')
        def out = new File(documentPath + '/contents.gen')

        def map = []
        f.eachLine(){
            map.add([it.count('\t'), it.trim()])
        }

        def beamer = ''
        map.eachWithIndex(){ l, i ->

            def nextLevel
            if (i < map.size() - 1)
                nextLevel = map[i+1][0]

            def currentLevel = map[i][0]
            def text = map[i][1]

            switch(currentLevel){
                case 0: beamer += """\n\n\n\\section{${text}}\n"""
                    break;
                case 1: beamer += """\n\n\t\\subsection{${text}}\n"""
                    break;
                case 2: beamer += """\t\t\\begin{frame}{${text}}\n\n\t\t\t\\begin{itemize}\\RTList\n"""
                    break;
                case 3: beamer += """\t\t\t\t\\item ${text}\n \n"""
                    break;
            }

            if (i < map.size() - 1 && currentLevel == 3 && nextLevel != 3)
                beamer += """\n\t\t\t\\end{itemize}\n\t\t\\end{frame}\n"""
        }


        beamer += """\n\t\t\t\\end{itemize}\n\t\t\\end{frame}\n"""

        out.write(beamer, 'UTF-8')

        render 'Converted to ' + out.name


    }


    def exportToIcal = {
        def items = Journal.executeQuery('from Journal j where j.type.code != ? and j.startDate > ?', ['Assigned', new Date() - 90])
        def eventsList = []
        render(contentType: 'text/calendar',  filename: 'cal.ics', characterEncoding: 'UTF-8') {
            calendar {
                events {
                    items.each(){
                        event(start: it.startDate , end: it.endDate ?: it.startDate, descrition: it.summary, summary: it.description,  timezone: 'Asia/Beirut', characterEncoding: 'UTF-8')
                    }
                }
            }
        } // end of render

    }
} // end of class