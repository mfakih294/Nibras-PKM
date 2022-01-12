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

package mcs

import app.Contact
import app.parameters.Blog
import app.parameters.ResourceType

//import app.NewsCategory
//import app.NewsScope
//import app.NewsSource
import mcs.parameters.ResourceStatus
import app.Tag
import security.User

class Book implements Comparable {  // entity id = 134


    static hasMany = [excerpts: Excerpt, tags: Tag, contacts: Contact]

    static searchable = {
        only = ['title', 'author', 'description', 'fullText', 'resourceType', 'comments', 'highlights',
                'isbn', 'legacyTitle', 'ext', 'publisher', 
                    'publicationDate', 'notes', 'textTags']
        title (nullValue:  'Empty')
        
        description (nullValue: 'Empty')
        
        //        course(component: true)
        //        status(component: true)
    }
    //static searchable = true

    // Fields


    User user

    Book book

//    NewsCategory category
    String url
    String sourceFree

//    NewsScope scope

    String highlights

    String comments

    String code

    String title

    String shortFileName

    String description

    String fullText


    String author
    String authorInfo
    String authorInBib
    String translator
    String editor


    String isbn

    String legacyTitle

    ResourceStatus status

    ResourceType type
    String resourceType = 'ebk'

    Department department
    Course course
    String ext



    String language = 'ar'

    Integer nbPages
    String pages

    Integer nbFiles
    String filesList

    String edition

//    NewsSource source
    String citation
    String citationText
    String citationHtml
    String citationAsciicode

    String publisher
    String imageUrl
    String publicationDate
    String publicationCity

    Contact person
    String journal
    String month
    String year
    String volume
    String number
    String series


    Boolean bookmarked = false
    Boolean isPrivate = false
    Boolean keepSecret = false


    Boolean withAudiobook = false
    Boolean isAudiobook = false
    Boolean isPaperOnly = false
    Boolean hasExercises = false

    Boolean isRead = false


    Date readOn

    Integer reviewCount = 0
    Date firstReviewed
    Date lastReviewed
    String reviewHistory


    Integer totalSteps
    Integer completedSteps
    String stepsHistory

    Integer percentCompleted
    Boolean isPublic = false   // for sharing online
    Boolean withMarkdown = false   // description or full text is in markdown format

    String bibEntry

    Integer orderNumber
    Integer orderInCourse
    Integer priority

//    Blog blog
//    String blogCode
    Date publishedOn
//    Integer publishedNodeId


    String textTags
    String notes
    Date dateCreated
    Date lastUpdated
    Date deletedOn

    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        title()
        author()
        description()
        isbn()
        legacyTitle()
        status()
        ext()
        nbPages()
        edition()
        publisher()
        publicationDate()
        resourceType(nullable: true)
        type(nullable: true)
        excerpts()

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        //id(generator: 'assigned')
        title(sqlType: 'longtext')
        author(sqlType: 'longtext')
        authorInfo(sqlType: 'longtext')
        description(sqlType: 'longtext')
        fullText(sqlType: 'longtext')
        bibEntry(sqlType: 'longtext')
        highlights(sqlType: 'longtext')
        comments(sqlType: 'longtext')
        reviewHistory(sqlType: 'longtext')
        stepsHistory(sqlType: 'longtext')
        filesList(sqlType: 'longtext')

        table 'book'
        //sort "id":"desc"
        //name (index:'name_index')
        textTags(sqlType: 'longtext')
        notes(sqlType: 'longtext')
        imageUrl(sqlType: 'longtext')
        url(sqlType: 'longtext')
        citation(sqlType: 'longtext')
        citationText(sqlType: 'longtext')
        citationHtml(sqlType: 'longtext')
        citationAsciicode(sqlType: 'longtext')

        // excerpts: Excerpt cascade: 'persist,merge,save-update'
    }




    static namedQueries = {
        active { isNull 'deletedOn' }
        deleted { isNotNull 'deletedOn' }
    }


    public String toString() {
        return  (code ? '@' + code + ': ' : '') +  ( title ?: legacyTitle) +  (author ? ' - ' + author : '')
    }

    public String entityCode() {
        return 'R'
    }

    public String entityController() {
        return 'book'
    }


    public String fullString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String exactString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String tooltipString() {
        return description ? description : 'No description'
    }

    int compareTo(obj) {
        if (id && obj.id)
        return id.compareTo(obj.id)
        else return 1
    }

    private formatDate(Date d) {
        return new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm").format(d)
    }
    /*    static auditable = [handlersOnly: true]

    def onSave = {
    DataChangeAudit dca = new DataChangeAudit([
    userName: 'Me',
    operationType: 'Create',
    entityId: '134', recordId: id,
    operationDetails: fullString(), datePerformed: new Date()])
    if (!dca.hasErrors() && dca.save()) {
    println "New  Book inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
    }
    else {
    println "Something went wrong in logging the change to record " + id
    }
    }

    def onDelete = {
    DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
    entityId: '134', recordId: id, operationDetails: fullString(),
    datePerformed: new Date()])
    if (!dca.hasErrors() && dca.save()) {
    println "A Book was deleted with id " + id  + " by " + dca.userName + " at " + formatDate(new Date())
    }
    else {
    println "Something went wrong in logging the change to record " + id
    }
    }

    def onChange = {oldMap, newMap ->

    String message = ''
    String exactMessage = ''

    oldMap.each({key, oldVal ->
    if (oldVal != newMap[key]) {
    message += key + '||' + oldVal + '||' + newMap[key] + ";;"
    ////////////////////////////////


    if (!newMap[key].class.name != 'java.lang.String'
    && !newMap[key].class.name != 'java.lang.Integer'
    && !newMap[key].class.name != 'java.lang.Long'
    && !newMap[key].class.name != 'java.lang.Double'
    && !newMap[key].class.name != 'java.lang.Boolean'
    && !newMap[key].class.name != 'java.lang.Date'
    && !newMap[key].class.name != 'java.lang.BigInteger'
    && !newMap[key].class.name != 'java.lang.Float' ){
    exactMessage += key + '||' + oldVal.id + '||' + newMap[key].id + ";;"
    }
    else
    exactMessage += key + '||' + oldVal + '||' + newMap[key] + ";;"
    /////////////////////////////////////////
    }
    })

    DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Update',
    entityId: '134', recordId: id, operationDetails: message,
    datePerformed: new Date()])
    if (!dca.hasErrors() && dca.save()) {
    println "A Book was changed with id " + id  + " by " + dca.userName + " at " + formatDate(new Date())
    }
    else {
    println "Something went wrong in logging the change to record " + id
    }
    }
     */
} // end of class

