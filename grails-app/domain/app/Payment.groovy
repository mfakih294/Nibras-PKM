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
import security.User

class Payment implements Comparable {  // entity id = 24


//     static searchable = [only:['category', 'date', 'amount', 'description', 'intendedUse', 'reality', 'notes' ]]

    static hasMany = [tags: Tag, contacts: Contact]

    static searchable = true

    // Fields
    User user

    PaymentCategory category

    Date date = new Date()

    Float amount

    String summary
    String description

    String intendedUse
    Date paidOn

    String reality

    String language = 'ar'

    String notes

    Date dateCreated
    Date lastUpdated
    Date deletedOn
    Integer priority
    Boolean bookmarked

    Integer nbFiles
    String filesList


    static constraints = {
        category(nullable: false)
        date(nullable: false)
        amount(nullable: false, blank: false)
        description()
        intendedUse()
        reality()

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        table 'payment'
        description(sqlType: 'longtext')
        intendedUse(sqlType: 'longtext')
        reality(sqlType: 'longtext')

        // name (index:'name_index')
        notes(sqlType: 'longtext')
        filesList(sqlType: 'longtext')
    }

    static namedQueries = {
        deleted { isNotNull 'deletedOn' }
    }

    public String toString() {
        return amount
    }

    public String entityCode() {
        return 'Q'
    }

    public String entityController() {
        return 'payment'
    }


    public String fullString() {
        return 'category||' + category + ';;' + 'date||' + date + ';;' + 'amount||' + amount + ';;' + 'description||' + description + ';;' + 'intendedUse||' + intendedUse + ';;' + 'reality||' + reality + ';;'
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
                entityId: '24', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "New  Payment inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Delete',
                entityId: '24', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A Payment was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '24', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A Payment was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

} // end of class
