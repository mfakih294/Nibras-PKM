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
import security.User

class Indicator implements Comparable {  // entity id = 22


    static searchable = [only:['code', 'summary', 'description', 'notes' ]]

    static hasMany = [tags: Tag]


    // Fields
    User user

    String summary
    String description

    Boolean bookmarked
    Integer priority = 2


    String code

    String name

    // Fields for auto-calculations (db or folder counts)
    String query
    String path
    String extensions

    String scale

    String frequency = 'daily'

    Date startDate

    Date endDate



//    Integer category

    String language = 'ar'

    String notes

    Integer orderNumber

    Date dateCreated
    Date lastUpdated
    Date deletedOn

    static constraints = {
        code()
        name()
        scale()
        frequency()
        startDate()
        endDate()
        description()

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        table 'indicators'
        // name (index:'name_index')
        notes(sqlType: 'long varchar')
    }


    public String entityCode() {
        return 'K'
    }

    public String entityController() {
        return 'indicator'
    }

    static namedQueries = {
        deleted { isNotNull 'deletedOn' }
    }

    public String toString() {
        return name
    }

    public String fullString() {
        return 'code||' + code + ';;' + 'name||' + name + ';;' + 'scale||' + scale + ';;' + 'frequency||' + frequency + ';;' + 'startDate||' + startDate + ';;' + 'endDate||' + endDate + ';;' + 'description||' + description + ';;'
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
                entityId: '22', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "New  Indicator inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Delete',
                entityId: '22', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A Indicator was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '22', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A Indicator was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

} // end of class
