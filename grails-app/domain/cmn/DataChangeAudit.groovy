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

package cmn

class DataChangeAudit implements Comparable {  // entity id = 18

//static searchable = [only:['userName', 'operationType', 'recordId', 'entityId', 'operationDetails', 'datePerformed', 'dateCreated', 'lastUpdated']]
    // Fields

    String userName

    String operationType

    Integer recordId

    Integer entityId

    String operationDetails
    String exactOperation
    Date datePerformed
    Date dateCreated
    Date lastUpdated

    //static transients = ['numberOfBranches']
    //String getNumberOfBranches() { return 0 }

    static constraints = {
        userName(nullable: true)
        operationType(nullable: true)
        recordId(nullable: true)
        entityId(nullable: true)
        operationDetails(nullable: true)
        exactOperation()
        datePerformed(nullable: true)
        dateCreated(nullable: true)
        lastUpdated(nullable: true)

    }

    static mapping = {
        operationDetails(sqlType: 'longtext')
        exactOperation(sqlType: 'longtext')
        datePerformed(sqlType: 'datetime')

        table 'data_change_audits'
        //sort "id":"desc"
        //name (index:'name_index')
        // TODO  cascade: 'persist,merge,save-update'
        //version false
    }

    public String toString() {
        return 'record ' + id

        // new SimpleDateFormat("MMM dd yyyy HH:mm:ss").format(dateCreated)
    }

    public String fullString() {
        return 'User Name: ' + userName + "<br/>" +
                'Operation Type: ' + operationType + "<br/>" +
                'Record Id: ' + recordId + "<br/>" +
                'Entity Id: ' + entityId + "<br/>" +
                'Operation Details: ' + operationDetails + "<br/>" +
                'Date Performed: ' + datePerformed + "<br/>"
    }

    public String tooltipString() {
        return 'User Name: ' + userName + "<br/>" +
                'Operation Type: ' + operationType + "<br/>" +
                'Record Id: ' + recordId + "<br/>" +
                'Entity Id: ' + entityId + "<br/>" +
                'Operation Details: ' + operationDetails + "<br/>" +
                'Date Performed: ' + datePerformed + "<br/>"  // TODO:
    }

    int compareTo(obj) {
        if (id && obj.id)
            return id.compareTo(obj.id)
        else return 1
    }

    private formatDate(Date d) {
        return new java.text.SimpleDateFormat("dd MMM yyyy HH:mm").format(d)
    }


}
