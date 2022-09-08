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

import cmn.DataChangeAudit
import app.Contact
import app.Tag
import mcs.Course
import mcs.Department
import security.User

class Contact implements Comparable {  // entity id = 26

    def springSecurityService

     static searchable = true //[only:['description', 'summary', 'notes' ]]

//    static hasMany = [tags: Tag, contacts: Contact]

    // Fields

    User user

    String code
	String email
	String address
	String telephones
	String jobTitle
	
    Department department
    Course course

    String summary
    String description


    Integer occurrence

    Boolean bookmarked
    Integer priority = 2

    String notes

    String language = 'ar'

    Date dateCreated
    Date lastUpdated
    Date deletedOn



    Integer nbFiles
    String filesList


    Integer nbFilesLib
    String filesListLib


    String createdBy
    String insertedBy = 'me'
    String editedBy



    static constraints = {
        code(unique: true)

        summary(blank: false, nullable: false)

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {

        // name (index:'name_index')
        description(sqlType: 'longtext')
        notes(sqlType: 'longtext')
    }




    static namedQueries = {
        deleted { isNotNull 'deletedOn' }
    }

    public String toString() {
        return summary
    }

    public String entityCode() {
        return 'S'
    }

    public String entityController() {
        return 'contact'
    }



    public String fullString() {
        return 'name||' + summary + ';;'
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

//    def beforeInsert() {
////        new NoteEvent(type: "CREATED", note: this).save()
//
//        editedBy = springSecurityService.authentication.name.encodeAsHTML() ?: 'Anonymous'
//        insertedBy = springSecurityService.authentication.name.encodeAsHTML() ?: 'Anonymous'
//    }
//
////    def afterInsert() {
////        new NoteEvent(type: "CREATED", note: this).save()
//        editedBy = springSecurityService.authentication.name.encodeAsHTML() ?: 'Anonymous'
//        insertedBy = springSecurityService.authentication.name.encodeAsHTML() ?: 'Anonymous'
//    }
//
//    def beforeValidate() {
//        println 'asdfasdfvalida'
////        new NoteEvent(type: "UPDATED", note: this).save()
//        editedBy = springSecurityService.authentication.name.encodeAsHTML() ?: 'Anonymous'
//    }



    def onSave = {

        DataChangeAudit dca = new DataChangeAudit([
                userName: springSecurityService.authentication.name.encodeAsHTML() ?: 'Anonymous',
                operationType: 'Create',
                entityId: '26', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "New  WordSource inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Delete',
                entityId: '26', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A WordSource was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '26', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A WordSource was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

} // end of class
