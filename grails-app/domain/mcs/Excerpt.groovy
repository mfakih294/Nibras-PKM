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
import cmn.DataChangeAudit

class Excerpt implements Comparable {  // entity id = 143


    static belongsTo = [book: Book]

    static hasMany = [tags: Tag, contacts: Contact]




    static searchable = [only: ['book', 'writing', 'title', 'chapter', 'chapters', 'notes']]

    // Fields

    String title
    String summary
    String description


    Writing writing
    Integer chapter
    String chapters
    String reviewDates

    String notes
    Date dateCreated
    Date lastUpdated


    Date readOn

    Integer reviewCount = 0
    Date firstReviewed
    Date lastReviewed

    String language = 'ar'


    Boolean bookmarked = false



    Integer priority

    Integer orderNumber
    Integer orderInCourse

    Date deletedOn

    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        book(nullable: false)
        title()
        chapter()


        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {

        table 'excerpt'
        //sort "id":"desc"
        //name (index:'name_index')
        description(sqlType: 'longtext')
        notes(sqlType: 'longtext')
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
        return 'E'
    }

    public String entityController() {
        return 'excerpt'
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
                entityId: '143', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Excerpt inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '143', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Excerpt was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '143', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Excerpt was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

