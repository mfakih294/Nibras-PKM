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

package app

import app.parameters.Blog
import app.parameters.Markup
import cmn.DataChangeAudit
import mcs.Book
import mcs.Course
import mcs.Department
import mcs.Writing
import mcs.parameters.WritingType
//import app.parameters.WordSource
import mcs.parameters.WritingStatus
import security.User

//import com.bloomhealthco.jasypt.GormEncryptedStringType

class IndexCard implements Comparable {  // entity id = 16


    static hasMany = [tags: Tag, contacts: Contact]

//    static searchable = [only: ['title', 'contents', 'mainHighlights', 'sideHighlights', 'reaction', 'extractedWords', 'notes']]

    static searchable = true

    // Fields

    User user

    Markup markup
    Boolean withMarkdown = false   // description is in markdown format

    IndexCard parent

    Contact contact

    Book book

    String entityCode
    String recordId

    String fileName

    String sourceFree
    String url

    String summary = ''
    String shortDescription
    String description = '...'
    String password

    String descriptionHTML // blog content
    String code // slug
    Boolean isPage = false


    Writing writing
    Department department
    Course course



    Integer nbFiles
    String filesList


    Integer nbFilesLib
    String filesListLib

    String pages


    Date readOn
    Integer reviewCount = 0
    Date firstReviewed
    Date lastReviewed
    String reviewHistory



    WritingType type
    WritingStatus writingStatus
    WritingStatus status //new

    String contents
  //  String context
    Integer priority = 2


    Date writtenOn
    Boolean approximateDate = false


    Integer orderInArticle
    Integer orderNumber

    String wbsNumber
    IndexCard wbsParent


    Integer orderInWriting

    Integer orderInBook
    String bookCode

    String language = 'ar'

    Blog blog
    String blogCode
    Date publishedOn
    Integer publishedNodeId

    String mainHighlights

    String sideHighlights

    String reaction

    String extractedWords

    String notes

    Boolean bookmarked = false
    Boolean keepSecret = false
    Boolean isPrivate = true

    Boolean isMerged = false
    Date mergedOn
    Boolean isConverted = false

    Boolean isNewSection = false


    Date dateCreated
    Date lastUpdated
    Date deletedOn

    static constraints = {
        writing()
        book()
        pages()
        type(nullable: true)
        summary()//blank: false, nullable: false)
        contents()
        description()
        mainHighlights()
        sideHighlights()
        reaction()
        extractedWords()

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        description(sqlType: 'long varchar')
        shortDescription(sqlType: 'long varchar')
        descriptionHTML(sqlType: 'long varchar')
        mainHighlights(sqlType: 'long varchar')
        sideHighlights(sqlType: 'long varchar')
        reaction(sqlType: 'long varchar')
        extractedWords(sqlType: 'long varchar')
        sourceFree(sqlType: 'long varchar')
        url(sqlType: 'long varchar')
        notes(sqlType: 'long varchar')
        filesList(sqlType: 'long varchar')
//        password type: GormEncryptedStringType
    }

    static namedQueries = {
        deleted { isNotNull 'deletedOn' }
    }

    public String toString() {
        return summary
    }

    public String entityCode() {
        return 'N'
    }

    public String entityController() {
        return 'indexCard'
    }


    public String fullString() {
        return 'writing||' + writing + ';;' + 'book||' + book + ';;' + 'pages||' + pages + ';;' + 'type||' + type + ';;' + 'summary||' + summary + ';;' + 'contents||' + contents + ';;' + 'mainHighlights||' + mainHighlights + ';;' + 'sideHighlights||' + sideHighlights + ';;' + 'reaction||' + reaction + ';;' + 'extractedWords||' + extractedWords + ';;'
    }

    int compareTo(obj) {
        if (id && obj.id)
        return id.compareTo(obj.id)
        else return 1
    }

    private formatDate(Date d) {
        return new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm").format(d)
    }

    static auditable = [handlersOnly: true]

    def onSave = {
        DataChangeAudit dca = new DataChangeAudit([
                userName: ('System'),
                operationType: 'Create',
                entityId: '16', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "New  IndexCard inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Delete',
                entityId: '16', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A IndexCard was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onChange = {oldMap, newMap ->

        String message = ''

        oldMap.each({key, oldVal ->
            if (oldVal != newMap[key]) {
                message += key + '||' + oldVal + '||' + newMap[key] + ";;"
            }
        })

        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Update',
                entityId: '16', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A IndexCard was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

} // end of class
