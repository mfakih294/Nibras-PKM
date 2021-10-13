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

class Rating implements Comparable {  // entity id = 26

    // Fields

    String source
	String title
	String link
	Integer rating
	String tag

    Date newsDate

    Date dateCreated
    Date lastUpdated


    static constraints = {
//        summary(blank: false, nullable: false)
    }

    static mapping = {
        // name (index:'name_index')
        title(sqlType: 'longtext')
    }

    int compareTo(obj) {
        if (id && obj.id)
        return id.compareTo(obj.id)
        else return 1
    }

} // end of class
