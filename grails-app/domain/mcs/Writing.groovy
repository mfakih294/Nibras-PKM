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
import app.Tag
import app.parameters.Blog
import app.parameters.Markup
import cmn.DataChangeAudit
import mcs.parameters.WritingStatus
import mcs.parameters.WritingType
import security.User

//import ys.wikiparser.WikiParser

class Writing implements Comparable {  // entity id = 144


    static hasMany = [goals: Goal, tags: Tag, contacts: Contact]

    def grailsApplication

    static searchable = true
//            {
//        only = ['title', 'body', 'bornOn', 'priority', 'notes', 'orderNumber']
//        course(component: true)
//        type(component: true)
//        writingStatus(component: true)
//    }

    // Fields

    User user

    String summary
    String description
    String shortDescription // teaser
    String descriptionHTML
    String slug // temporary
    String code // slug
    Boolean isPage = true

    Boolean withMarkdown = false   // description is in markdown format


    String language = 'ar'

    Markup markup

    String source
    Department department
    Course course
    Book book



    WritingStatus writingStatus

    // new
    WritingStatus status

    Integer reviewCount = 0
    Date firstReviewed
    Date lastReviewed

    Contact contact

    Integer nbFiles
    String filesList


    Integer nbFilesLib
    String filesListLib


    WritingType type
    Boolean isLatex = true

    Date bornOn
    Boolean bookmarked = false
    Boolean isPrivate = true
    Boolean keepSecret = false

    Integer priority = 2

    Integer orderNumber

    Integer orderInBook
    Integer orderInCourse
    
    String bookCode

 //   Integer blogId
    Integer publishedPostId

    String blogCode
    Blog blog
    Date publishedOn
    Integer publishedNodeId






    String notes
    Date dateCreated
    Date lastUpdated
    Date deletedOn

    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        summary(nullable: false, blank: false)
        description()
        type(nullable: true)
        status()
        description()

        notes()
        bornOn()
        priority()

        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        description(sqlType: 'long varchar')
        shortDescription(sqlType: 'long varchar')
	    descriptionHTML(sqlType: 'long varchar')

        table 'writing'
        //sort "id":"desc"
        //name (index:'name_index')
        notes(sqlType: 'long varchar')
        filesList(sqlType: 'long varchar')
        // null cascade: 'persist,merge,save-update'
    }




    static namedQueries = {
        active { isNull 'deletedOn'}
        deleted { isNotNull 'deletedOn' }
    }


    public String toString() {
        return summary
    }

//  public void setDescription(String text) {
//      this.description = text
//     if (new File(grailsApplication.config.wrt.path.toString() + '/' + id + '.txt').exists())
//     new File(grailsApplication.config.wrt.path.toString() + '/' + id + '.txt').text = text
//  }



//  public String getDescription() {
//      def f = new File(grailsApplication.config.wrt.path.toString() + '/' + id + '.tex')
//      if (f.exists())
//          return f.text
//      else return "No text found!"

//      this.descriptionHTML = WikiParser.renderXHTML(this.description)
//      return this.description
//    }




    public String entityCode() {
        return 'W'
    }

    public String entityController() {
        return 'writing'
    }


    public String fullString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String exactString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String tooltipString() {
        return summary
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
                userName: 'Me',
                operationType: 'Create',
                entityId: '144', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Writing inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '144', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Writing was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                /*


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
                */
            }
        })

        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Update',
                entityId: '144', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Writing was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

