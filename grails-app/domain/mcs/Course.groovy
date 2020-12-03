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
import app.parameters.Markup
import cmn.DataChangeAudit
import security.User

class Course implements Comparable {  // entity id = 130


    static belongsTo = [department: Department]

    static searchable = [only: ['code', 'summary', 'description', 'notes']]

    // Fields

    static hasMany = [tags: Tag, contacts: Contact]

    User user


  //  String summary

    Boolean bookmarked
    Integer priority = 2
    Integer percentCompleted


    String code
    Integer numberCode
    String codeString

    Integer goalCount
    Integer bookCount
    Integer exrCount
    Integer icdCount

    Integer currentTextbookLevel = 1

    Integer orderInDepartment
    Integer orderNumber

    Markup markup


    String summary
    String description
    Boolean isActive

    String language = 'ar'

    String notes
    Date dateCreated
    Date lastUpdated
    Date deletedOn

    Integer nbFiles
    String filesList


    //static transients = ['numberOfTasks']
    //long getNumberOfTasks() { return tasks ? tasks.size() : 0 }

    static constraints = {
        code(unique: true)
        department(nullable: false)
//        c(unique: true)
        code(unique: true)
        numberCode(unique: true)
        summary(nullable: false, blank: false)
        description()


        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        description(sqlType: 'longtext')

        table 'course'
        //sort "id":"desc"
        //name (index:'name_index')
        notes(sqlType: 'longtext')
        filesList(sqlType: 'longtext')
        // null cascade: 'persist,merge,save-update'
    }



    public String entityCode() {
        return 'C'
    }

    public String entityController() {
        return 'course'
    }

    static namedQueries = {
        active { isNull 'deletedOn' }
        deleted { isNotNull 'deletedOn' }
    }


    public String toString() {
        return (bookmarked ? '* ' : '') + (code ? '' + code + ' ': '') + summary
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
                entityId: '130', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "New  Course inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: 'Me', operationType: 'Delete',
                entityId: '130', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Course was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '130', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            println "A Course was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            println "Something went wrong in logging the change to record " + id
        }
    }

} // end of class

