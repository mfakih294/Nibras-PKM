
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
import mcs.parameters.GoalType
import mcs.parameters.WorkStatus
import security.User

class Goal implements Comparable {  // entity id = 126


    //   static belongsTo = [front: Front]

    static hasMany = [tags: Tag, contacts: Contact]

//    static searchable = [only: ['title', 'description', 'priority', 'goalStatus', 'goalType', 'notes']]

    static searchable = true

    User user


    // Fields

    String courseCode
    String title

    String summary
    String description

    Contact contact


    String code

    // Can link to:
    //  Front front
    Department department
    Course course
    Writing writing


    Integer nbFiles
    String filesList


    Integer nbFilesLib
    String filesListLib



    Integer priority = 2
    Integer percentCompleted
    Integer totalSteps
    Integer completedSteps
    String stepsHistory

    Float plannedDuration
    Float actualDuration
    Date completedOn
    Date startDate
    Date endDate

    Boolean bookmarked = false
    Boolean isPrivate = false
    // new value - migrate to it
    WorkStatus status

    GoalType type //new
    
    Integer orderNumber
    Integer orderInCourse

    String language = 'ar'


    String notes
    Date dateCreated
    Date lastUpdated
    Date deletedOn

    Integer reviewCount = 0
    Date lastReviewed


    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        //    front(nullable: false)
        type(nullable: true)

        priority()
        status()


        summary(nullable: false, blank: false)
        description()




        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        summary(sqlType: 'longtext')
        table 'goal'
        description(sqlType: 'longtext')
        stepsHistory(sqlType: 'longtext')
        //sort "id":"desc"
        //name (index:'name_index')
        notes(sqlType: 'longtext')
        filesList(sqlType: 'longtext')
        // null cascade: 'persist,merge,save-update'
    }




    static namedQueries = {
        active { isNull 'deletedOn' }
        deleted { isNotNull 'deletedOn' }
    }


    public String toString() {
        return summary
    }

    public String entityCode() {
        return 'G'
    }

    public String entityController() {
        return 'goal'
    }


    public String fullString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String exactString() {
        return toString() // ToStringBuilder.reflectionToString(this);
    }

    public String tooltipString() {
        return toString()
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
                entityId: '126', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Goal inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '126', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Goal was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '126', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Goal was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

