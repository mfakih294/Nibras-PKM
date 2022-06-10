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

import java.time.format.DateTimeFormatter

import static com.cronutils.model.CronType.QUARTZ;
import static com.cronutils.model.CronType.UNIX;
import static com.cronutils.model.field.expression.FieldExpressionFactory.always;
import static com.cronutils.model.field.expression.FieldExpressionFactory.between;
import static com.cronutils.model.field.expression.FieldExpressionFactory.on;
import static com.cronutils.model.field.expression.FieldExpressionFactory.questionMark;

import com.cronutils.builder.CronBuilder;
import com.cronutils.descriptor.CronDescriptor;
import com.cronutils.mapper.CronMapper;
import com.cronutils.model.Cron;
import com.cronutils.model.definition.CronConstraintsFactory;
import com.cronutils.model.definition.CronDefinition;
import com.cronutils.model.definition.CronDefinitionBuilder;
import com.cronutils.model.time.ExecutionTime;
import com.cronutils.parser.CronParser;

import java.time.ZonedDateTime;
import java.util.Locale;



@Secured(['ROLE_ADMIN','ROLE_READER'])
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
                    (it.task ? 'T-' + StringUtils.abbreviate(it.task?.summary, 60) + ' / ' : '') +
                    (it.goal ? 'G-' + StringUtils.abbreviate(it.goal?.summary, 80) + ' / ' : '') + //it.goal?.code + ' '
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
                            allDay         : (it.level != 'm' || it.startDate.hours < 5 ? true : false)])
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

            Task.executeQuery("from Journal t where t.bookmarked = 1 and  t.startDate  between :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title =  '' + (it.type?.code ? '#' + it.type?.code + ' ' : '') + '' +
                    (it.task ? 'T-' + StringUtils.abbreviate(it.task?.summary, 60) + ' / ' : '') +
                    (it.goal ? 'G-' + StringUtils.abbreviate(it.goal?.summary, 80) + ' / ' : '') + //it.goal?.code + ' '
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
                            allDay         : (it.level != 'm' || it.startDate.hours < 5 ? true : false)])
            }
      Task.executeQuery("from Planner t where t.bookmarked = 1 and t.startDate between :start and :end",
                    //[new Date(Long.parseLong(params.start) * 1000), new Date(Long.parseLong(params.end) * 1000)]).each() {
                    [start: Date.parse('yyyy-MM-dd', params.start) - 20, end: Date.parse('yyyy-MM-dd', params.end) + 20]).each() {

                def title = '' + (it.type?.code ? '#' + it.type?.code : '') + ' ' +
                    (it.task ? 'T-' + StringUtils.abbreviate(it.task?.summary, 60) + ' / ' : '') +
                    (it.goal ? 'G-' + StringUtils.abbreviate(it.goal?.summary, 80) + ' / ' : '') + //it.goal?.code + ' '
                        (it.course ? '(' + it.course?.code + ') ' : '') +
                        (it.summary ? it.summary + '  ' : '')
//                    (it.description ? StringUtils.abbreviate(it.description, 40) : ' ')
                events.add([id             : it.id,
                            start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.startDate),
                            end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(it.endDate ?: it.startDate),
                            //it.type?.name +
                            title          : StringUtils.abbreviate(title, 80),
                            description    : it.summary + '|' + it.description,
                            classNames: it.completedOn != null ? ['done'] : [''],
                            backgroundColor: 'Chocolate',//it.type?.color ?: '#F7F9EE',
                            borderColor    : 'Chocolate',
                            textColor      : 'white',//it.type?.style ?: '#515150',

                            url            : request.contextPath + '/page/record/' + it.id + '?entityCode=P',
                            allDay         : (it.level != 'm' || it.startDate.hours < 7 || it.task != null ? true : false)])
            }

            Task.executeQuery("from Task t where t.bookmarked = 1 and t.endDate between :start and :end",
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
                            allDay         : false   ])
            }


    Task.executeQuery("from Goal t where t.bookmarked = 1 and t.endDate between  :start and :end",
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
                            allDay         : false   ])
            }



            Task.executeQuery("from Book t where t.bookmarked = 1 and t.readOn between :start and :end",
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
                            allDay         : false   ])
            }
/*
        def cc = 1000

        [
                ['Oil every month on Monday', '0 15 1 * 1'],
                ['Internet every 14th of month', '0 15 14 * *'],
                ['Filter every two month on Monday', '0 15 1 /2 1'],
                ['Every Friday', '0 15 * * 5'],
                ['Every day', '0 15 * * *'],
                ['Every last of month', '0 15 29 * *']
        ].each() { jobTitle, quartzCronExpression ->


            //String quartzCronExpression = "0 0 1 2 7";
            CronParser quartzCronParser =
                    new CronParser(CronDefinitionBuilder.instanceDefinitionFor(UNIX));

// parse the QUARTZ cron expression.
            Cron parsedQuartzCronExpression =
                    quartzCronParser.parse(quartzCronExpression);

// Create ExecutionTime for a given cron expression.


//    DateTimeFormatter formatter0 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a z");
//    ZonedDateTime dateTime = ZonedDateTime.parse("2020-06-01 00:00:00 AM +02:00", formatter0);
            ZonedDateTime now = ZonedDateTime.now();


            ExecutionTime executionTime =
                    ExecutionTime.forCron(parsedQuartzCronExpression);

            //  render 'quartz ' + parsedQuartzCronExpression.asString()

// Given a Cron instance, we can ask for next/previous execution
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("w E dd.MM.yyyy HH:mm Z");

//            render(String.format(
//                    "%s <b>%s</b>,  last was<br/>w%s, next will be<br/>w%s<br/><br/>",
//                    parsedQuartzCronExpression.asString(), jobTitle,
//                    //executionTime.lastExecution(now).get().format(formatter),
//                    Date.from(executionTime.lastExecution(now).get().toInstant()).format("w E dd.MM.yyyy HH:mm"),
//                    Date.from(executionTime.nextExecution(now).get().toInstant()).format("w E dd.MM.yyyy HH:mm")
//                    //executionTime.nextExecution(now).get().format(formatter)
//            ))

            events.add([id             : cc++,
                        start          : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(Date.from(executionTime.nextExecution(now).get().toInstant())),
                        end            : new SimpleDateFormat("yyyy-MM-dd'T'HH:mm':00'").format(Date.from(executionTime.nextExecution(now).get().toInstant())),
                        //it.type?.name +
                        title          : jobTitle,
                        description    : 'cron generated',
                        backgroundColor: 'DarkRed',//it.type?.color ?: '#F7F9EE',
                        borderColor    : 'DarkRed',
                        textColor      : 'white',//it.type?.style ?: '#515150',
                        url            : request.contextPath + '/page/record/' + cc + '?entityCode=T',
                        allDay         : false   ])
        }


*/
        render events as JSON

    }


    def combineCourseWritingsAsTex() {

        def c = Course.get(params.id)

        def path = (OperationController.getPath('editBox.path') && new File(OperationController.getPath('editBox.path')).exists() ?: OperationController.getPath('root.rps1.path')) + "/out-C-" + (c.code?: c.id) + '.tex'

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
        render(template: '/layouts/achtung', model: [message: 'Course notes exported in markdown format to : ' + path])
    }
def combineCourseWritings() {

        def c = Course.get(params.id)

        def path = (OperationController.getPath('editBox.path') && new File(OperationController.getPath('editBox.path')).exists() ?: OperationController.getPath('root.rps1.path')) + "/out-C-" + (c.code?: c.id) + '.md'

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
    render(template: '/layouts/achtung', model: [message: 'Course notes exported in markdown format to : ' + path])
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
        render(view: '/appStatic/site')
    }


    def staticWebsite() {

        def f = new File('/' + (OperationController.getPath('root.rps1.path') ?: '') + '/site.html')
        f.write(g.include([controller: 'export', action: 'staticWebsiteToString']).toString(), 'UTF-8')
        render 'Generation done: ' + new Date().format('HH:mm:ss')

    }

  def currentBookToScreen() {
        render(template: '/reports/currentBook')
    }


    def currentBookToFile() {

        def f = new File('/' + (OperationController.getPath('root.rps1.path') ?: '') + '/currentBook.md')
        f.write(g.include([controller: 'export', action: 'currentBookToScreen']).toString(), 'UTF-8')
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

    def cron2Calendar(){

        // min, hour, day of month
            // month, day of week (sunday = 0), /2 = every 2
[
        ['Oil every month on Monday', '0 15 1 * 1'],
        ['Internet every 14th of month', '0 15 14 * *'],
        ['Filter every two month on Monday', '0 15 1 /2 1'],
        ['Every Friday', '0 15 * * 5'],
        ['Every day', '0 15 * * *'],
        ['Every last of month', '0 15 29 * *']
].each() { jobTitle, quartzCronExpression ->





    //String quartzCronExpression = "0 0 1 2 7";
    CronParser quartzCronParser =
            new CronParser(CronDefinitionBuilder.instanceDefinitionFor(UNIX));

// parse the QUARTZ cron expression.
    Cron parsedQuartzCronExpression =
            quartzCronParser.parse(quartzCronExpression);

// Create ExecutionTime for a given cron expression.


//    DateTimeFormatter formatter0 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a z");
//    ZonedDateTime dateTime = ZonedDateTime.parse("2020-06-01 00:00:00 AM +02:00", formatter0);
    ZonedDateTime now = ZonedDateTime.now();


    ExecutionTime executionTime =
            ExecutionTime.forCron(parsedQuartzCronExpression);

    //  render 'quartz ' + parsedQuartzCronExpression.asString()

// Given a Cron instance, we can ask for next/previous execution
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("w E dd.MM.yyyy HH:mm Z");

    render(String.format(
            "%s <b>%s</b>,  last was<br/>w%s, next will be<br/>w%s<br/><br/>",
            parsedQuartzCronExpression.asString(), jobTitle,
            //executionTime.lastExecution(now).get().format(formatter),
            Date.from(executionTime.lastExecution(now).get().toInstant()).format("w E dd.MM.yyyy HH:mm"),
            executionTime.nextExecution(now).get().format(formatter)
             ));
    ; render(String.format(
            "%s <b>%s</b>,  last was<br/>w%s, next will be<br/>w%s<br/><br/>",
            parsedQuartzCronExpression.asString(), jobTitle,
            //executionTime.lastExecution(now).get().format(formatter),
            Date.from(executionTime.lastExecution(now).get().toInstant()).format("w E dd.MM.yyyy HH:mm"),
            executionTime.nextExecution(executionTime.nextExecution(now).get()).get().format(formatter)
             ));
    def t =  new Task()
    t.summary = jobTitle
    t.startDate =  Date.from(executionTime.nextExecution(now).get().toInstant())
    long HOUR = 3600*1000; // in milli-seconds.
    t.endDate  = new Date(Date.from(executionTime.nextExecution(now).get().toInstant()).getTime() + 1 * HOUR)
    t.recurringCron = parsedQuartzCronExpression.asString()
//    t.endDate = DateUtils.addHours(executionTime.nextExecution(now).get(), 1);
    t.save()

}

    }


    def generateNextRecurringPlans(Long id){

        def t = Task.get(id)

////////////////////
            CronParser quartzCronParser =
                    new CronParser(CronDefinitionBuilder.instanceDefinitionFor(UNIX));
            Cron parsedQuartzCronExpression =
                    quartzCronParser.parse(t.recurringCron);



            DateTimeFormatter formatter0 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a z");
         //   ZonedDateTime dateTime = ZonedDateTime.parse("2021-01-01 00:00:00 AM +02:00", formatter0);

            ZonedDateTime now = ZonedDateTime.now();

            ExecutionTime executionTime =
                    ExecutionTime.forCron(parsedQuartzCronExpression);
////////////////

            def ref = now
        def i = 1
        while (i <= (t.recurringInterval ?: 4)){
//            while (Date.from(executionTime.nextExecution(now).get().toInstant()) < new Date() + 40){
                def p = new Planner()
                p.summary = '...' //t.summary
                p.task = t

                p.startDate =  Date.from(executionTime.nextExecution(now).get().toInstant())
                long HOUR = (t.plannedDuration?.toInteger() ?: 30)*60*1000; // 30min in milli-seconds.
                p.endDate  = new Date(Date.from(executionTime.nextExecution(now).get().toInstant()).getTime() + 1 * HOUR)
                p.language = t.language
                p.bookmarked = true
                p.save()
            i++
            now = executionTime.nextExecution(now).get()

            render 'Generated plan record with ID: ' + p.id + '<br/>'
            }


    }

    def showNextRecurringDates(Long id){

        def t = Task.get(id)

////////////////////
            CronParser quartzCronParser =
                    new CronParser(CronDefinitionBuilder.instanceDefinitionFor(UNIX));
            Cron parsedQuartzCronExpression =
                    quartzCronParser.parse(t.recurringCron);



            DateTimeFormatter formatter0 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a z");
         //   ZonedDateTime dateTime = ZonedDateTime.parse("2021-01-01 00:00:00 AM +02:00", formatter0);

            ZonedDateTime now = ZonedDateTime.now();

            ExecutionTime executionTime =
                    ExecutionTime.forCron(parsedQuartzCronExpression);
////////////////

            def ref = now
        def dates = []
        def i = 1
        render 'Dates in the next 40 days:<br/><br/>'
//            while (Date.from(executionTime.nextExecution(now).get().toInstant()) < new Date() + 40){
        while (i <= (t.recurringInterval ?: 4)){
            render i++ + ': '  + Date.from(executionTime.nextExecution(now).get().toInstant())?.format('EEE dd.MM.yyyy HH:mm') + '<br/>'

            now = executionTime.nextExecution(now).get()
            }




    }
} // end of class