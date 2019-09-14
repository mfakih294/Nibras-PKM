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

class Tag implements Comparable {  // entity id = 12


    static searchable = [only:['name', 'notes' ]]

    // Fields

    String name
    Boolean isKeyword = false
    Boolean bookmarked = false

    Long count
    Long occurrence

    String language = 'ar'

    String notes

    Date dateCreated
    Date lastUpdated
    Date deletedOn

    static constraints = {
        name(unique: true, nullable: false, blank: false)

        notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {

        // name (index:'name_index')
        notes(sqlType: 'longtext')
    }

    static namedQueries = {
        deleted { isNotNull 'deletedOn' }
    }

    public String toString() {
        return name
    }

    public String entityCode() {
        return 'Tag'
    }

    public String entityController() {
        return 'tag'
    }



    public String fullString() {
        return 'name||' + name + ';;'
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
                entityId: '12', recordId: id,
                operationDetails: fullString(), datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "New  Tag inserted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

    def onDelete = {
        DataChangeAudit dca = new DataChangeAudit([userName: ('System'), operationType: 'Delete',
                entityId: '12', recordId: id, operationDetails: fullString(),
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A Tag was deleted with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
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
                entityId: '12', recordId: id, operationDetails: message,
                datePerformed: new Date()])
        if (!dca.hasErrors() && dca.save()) {
            log.info "A Tag was changed with id " + id + " by " + dca.userName + " at " + formatDate(new Date())
        }
        else {
            log.error "Something went wrong in logging the change to record " + id
        }
    }

} // end of class
