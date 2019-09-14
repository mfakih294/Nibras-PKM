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

package mcs.parameters

import app.Tag
import mcs.*
      import mcs.parameters.*

      import cmn.*
      import grails.converters.*
      import java.text.SimpleDateFormat
    

class SavedSearch implements Comparable {  // entity id = 451


    // static auditable = true

    static hasMany = [tags: Tag]

	// static searchable = [only:['queryType', 'summary', 'query', 'entity', 'notes' ]]

    // Fields


  String queryType = 'hql'
  String reportType = 'list'
  Boolean ownTab = false

  String code
  String summary

  String query 
  String countQuery

    String style

  String entity
  String panel
    String orderNumber

    Boolean onHomepage = false
    Boolean onMobile = false
    Boolean bookmarked = false
    Boolean calendarEnabled = false

    Integer priority

	
	String enteredBy
	String lastUpdatedBy
	String notes

	Date dateCreated
	Date lastUpdated
	Date deletedOn

	static constraints = {
     queryType (nullable: false, blank: false)
      summary (nullable: false, blank: false)
      query (nullable: false, blank: false)
      entity (nullable: false, blank: false)

		dateCreated()
		lastUpdated()
		deletedOn()
    }

    public String entityCode() {
        return 'X'
    }

    public String entityController() {
        return 'savedSearch'
    }

	static mapping = {
     table 'saved_search'
      
	  query (sqlType: 'longtext')
	  countQuery (sqlType: 'longtext')
	  notes (sqlType: 'longtext')
    }
    
    static namedQueries = {
		active{ isNotNull 'deletedOn' }    
    }

    public String toString(){
      return summary
    }

    int compareTo(obj){
      if (id && obj.id)
        return id.compareTo(obj.id)
                else return 1
      }

} // end of class
