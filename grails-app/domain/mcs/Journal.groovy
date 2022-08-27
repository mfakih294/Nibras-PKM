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
import mcs.parameters.JournalType
import mcs.parameters.Location
import security.User

class Journal implements Comparable {  // entity id = 125


//    static searchable = [only: ['startDate', 'endDate', 'body', 'type', 'notes']]
    static searchable = true

    static hasMany = [tags: Tag, contacts: Contact]

    // Fields

    User user

    String level = 'm'



    Date startDate = new Date()
    Date endDate
    Integer priority = 2
//  String title


    Markup markup

    Integer weight
    String summary
    String description = '?'


    JournalType type
    Location location

    // Can link to:
    Department department
    Course course

    Contact contact

    Writing writing
    Goal goal
    Task task

    Book book
    Excerpt excerpt

    Integer nbFiles
    String filesList


    Integer nbFilesLib
    String filesListLib



    // end of links

    Integer energyLevel
    Boolean onPlanner = false
    Boolean isInstant = false
    Boolean isParsed = false
    Boolean isEstimated = false

    Boolean bookmarked

    Boolean keepSecret = false

    Boolean isPrivate = false


    Integer reviewCount = 0
    Date firstReviewed
    Date lastReviewed

    Blog blog
    Date publishedOn
    Integer publishedNodeId

    String language = 'ar'


    String notes

    Boolean isMerged = false
    Date mergedOn


    Date dateCreated
    Date lastUpdated
    Date deletedOn

    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {

        type()
        level(inList: ['l', 'y', 'e','A', 'M', 'r', 'w', 'd', 'm', 'i'])
        startDate(nullable: false)
        summary()
        description()

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {

        table 'journal'
        //sort "id":"desc"
        //name (index:'name_index')
        description(sqlType: 'longtext')
        notes(sqlType: 'longtext')
        filesList(sqlType: 'longtext')
        // null cascade: 'persist,merge,save-update'
    }




    static namedQueries = {
        active { isNull 'deletedOn' }
        deleted { isNotNull 'deletedOn' }
    }


    public String toString() {
        return 'record ' + id
    }

    public String entityCode() {
        return 'J'
    }

    public String entityController() {
        return 'journal'
    }


    public String fullString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String exactString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String tooltipString() {
        return 'record ' + id
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
                entityId: '125', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Journal inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '125', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Journal was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '125', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Journal was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

