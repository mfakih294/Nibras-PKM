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
import mcs.parameters.PlannerType
import mcs.parameters.WorkStatus

class Planner implements Comparable {  // entity id = 137


    static hasMany = [tags: Tag, contacts: Contact]


//    static searchable = [only: ['description', 'planLevel', 'planDate', 'reality', 'startTime', 'endTime', 'notes']]

    static searchable = true

    // Fields
    PlannerType type
    String summary
    String description


    Integer percentCompleted
    Integer totalSteps
    Integer completedSteps


    String planLevel = 'm'
    String level = 'm'

    Integer taskIdOld
    Integer goalIdOld

    // Can link to:
    Department department
//    Front front
    Course course



    Writing writing
    Goal goal
    Task task

    Book book
    Excerpt excerpt

    Contact contact

    String language = 'ar'

    // end of links



    WorkStatus taskStatus
    WorkStatus status // new

    Date startDate = new Date()
    Date actualStartDate

    String startTime
    Date endDate// = new Date()
    Date actualEndDate
    String endTime

    Date completedOn

    Boolean partiallyCompleted

    Boolean onTheSpot = false
    Boolean wasDone = true

    String reality

    Boolean isDayChallenge
    Boolean bookmarked
    Boolean isPrivate = false



    Integer priority

    Integer reviewCount = 0
    Date firstReviewed
    Date lastReviewed



    String notes
    Date dateCreated
    Date lastUpdated
    Date deletedOn

    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        level(inList: ['l', 'y', 'e', 'A', 'M', 'r', 'w', 'd', 'm', 'i'])
        startDate(nullable: false)
        endDate()

        description()
        reality()

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        description(sqlType: 'longtext')
        reality(sqlType: 'longtext')

        table 'planner'
        //sort "id":"desc"
        //name (index:'name_index')
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
        return 'P'
    }

    public String entityController() {
        return 'planner'
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
                entityId: '137', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Planner inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '137', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Planner was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '137', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Planner was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

