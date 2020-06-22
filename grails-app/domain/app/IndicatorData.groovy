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

class IndicatorData implements Comparable {  // entity id = 21

    static hasMany = [tags: Tag, contacts: Contact]

     static searchable = [only:['indicator', 'date', 'value', 'notes' ]]

    // Fields

    User user

    Indicator indicator

    Date date = new Date()
    mcs.Department department

    Float value

    String summary
    String description
    String trackSequence

    Float averageDifficulty



    String notes

    Date dateCreated
    Date lastUpdated
    Date deletedOn

    Integer priority

    Boolean bookmarked = false
    Boolean isPrivate = false

    static constraints = {
        indicator(nullable: false)
        date(unique: ['indicator', 'department'], nullable: false)
        value(nullable: false, blank: false)

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
        return value
    }

    public String entityCode() {
        return 'I'
    }

    public String entityController() {
        return 'indicatorData'
    }


    public String fullString() {
        return 'indicator||' + indicator + ';;' + 'date||' + date + ';;' + 'value||' + value + ';;'
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
                entityId: '21', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "New  IndicatorData inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Delete',
                entityId: '21', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A IndicatorData was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '21', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A IndicatorData was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

} // end of class
