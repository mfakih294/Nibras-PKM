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

import security.User


class Operation implements Comparable {  // entity id = 


    static searchable = [only: [ 'description', 'notes']]

    // Fields

    User user


    String summary

    Boolean bookmarked
    Integer priority = 2
    String module = 'n'
    String type
    Date date


  

    String description
    String language = 'ar'
    Boolean validOn
    Boolean newSystem = false

 
    String notes
    Date dateCreated
    Date lastUpdated
    Date deletedOn

    Integer nbFiles
    String filesList


    static constraints = {
    
        description(nullable: false, blank: false)
      notes()
        dateCreated()
        lastUpdated()
        deletedOn()
    }

    static mapping = {
        description(sqlType: 'longtext')
        table 'operation'
        //sort "id":"desc"
        //name (index:'name_index')
        notes(sqlType: 'longtext')
        filesList(sqlType: 'longtext')
        // null cascade: 'persist,merge,save-update'
    }

    public String entityCode() {
        return 'O'
    }

    public String entityController() {
        return 'operation'
    }

    static namedQueries = {
        active { isNull 'deletedOn' }
        deleted { isNotNull 'deletedOn' }
    }


    public String toString() {
        return (bookmarked ? '* ' : '') + description
    }
//   public boolean isValid() {
//        return ker.GenericsController.verifySmartCommandStatic(this.description.trim())
//    }

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


} // end of class

