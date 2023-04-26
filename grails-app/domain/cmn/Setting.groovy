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

import security.User

class Setting {  // entity id = 51

    User user

    String name
    String summary
    String value
    Boolean bookmarked = false
    String description
    String allowedValues
    String explanation
    Date dateCreated
    Date lastUpdated

    String notes

    static constraints = {
        name(unique: true, nullable: false, blank: false)
        dateCreated(nullable: true)
        lastUpdated(nullable: true)

    }

    static mapping = {
        // table "SETTINGS"
        value(sqlType: 'long varchar')
//        summary(sqlType: 'long varchar')
        description(sqlType: 'long varchar')
        allowedValues(sqlType: 'long varchar')
        explanation(sqlType: 'long varchar')
        notes(sqlType: 'long varchar')
    }

    public String entityCode() {
        return 'Y'
    }

    public String entityController() {
        return 'setting'
    }

    public String toString() {
        return 'record ' + id

        // new SimpleDateFormat("MMM dd yyyy HH:mm:ss").format(dateCreated)
    }


}
