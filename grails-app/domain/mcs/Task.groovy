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
//import mcs.parameters.Location
import mcs.parameters.Context
import mcs.parameters.WorkStatus

class Task implements Comparable {  // entity id = 127


 //   static belongsTo = [goal: Writing]
    static hasMany = [tags: Tag, contacts: Contact]

//    static searchable = [only: ['priority', 'taskStatus', 'plannedDuration', 'name', 'description', 'location', 'notes']]

    static searchable = true

    // Fields

    Integer priority
    Course course
    Department department
    Goal goal
    Integer orderNumber
    Integer orderInGoal
    Integer orderInCourse
    Integer sequenceNumber

    String summary
    String description

    Contact contact


    // new value - migrate to it
    WorkStatus status

    Integer percentCompleted

    Float plannedDuration
    Float actualDuration

    String deliverable

    String recurringText

    String recurringCron

    Boolean isRecurring
    Boolean isRecycable
    Boolean permissiveRecurring
    Integer recurringInterval

//    Location location
    Context context

    Integer nbFiles
    String filesList


    Boolean isTodo = false
    Boolean isTopic = false

    Boolean bookmarked
    Boolean isPrivate = false


    String notes

    Date startDate// = new Date()
    String startTime
    Date actualStartDate


    Date endDate// = new Date()
    String endTime
    Date actualEndDate

    String language = 'ar'


    Date dateCreated
    Date completedOn
    Date almostCompletedOn

    Date lastUpdated
    Date deletedOn

    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        priority()
        plannedDuration()
        description()


        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        description(sqlType: 'longtext')

        table 'task'
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


    public String entityCode(){
        return 'T'
    }

 public String entityController(){
        return 'task'
    }

    public String toString() {
        return summary
    }

    public String fullString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String exactString() {
        return toString() // ToStringBuilder.reflectionToString(this);
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
                entityId: '127', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Task inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '127', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Task was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '127', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Task was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

