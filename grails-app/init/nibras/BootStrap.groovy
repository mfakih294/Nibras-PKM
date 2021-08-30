package nibras

import ker.OperationController
import security.*


class BootStrap {

    def init = { servletContext ->

        if (User.count() == 0) {
            def adminRole = new Role(authority: 'ROLE_ADMIN').save()
            def standardRole = new Role(authority: 'ROLE_READER').save()

            def adminUser = new User(username: 'admin', password: 'admin').save()
            def standardUser = new User(username: 'reader', password: 'reader').save()

            UserRole.create adminUser, adminRole
            UserRole.create standardUser, standardRole

            UserRole.withSession {
                it.flush()
                it.clear()
            }

            assert User.count() == 2
            assert Role.count() == 2
            assert UserRole.count() == 2
        }

        println """



   _   _   _   _   _   _     _   _   _  
  / \\ / \\ / \\ / \\ / \\ / \\   / \\ / \\ / \\ 
 ( N | i | b | r | a | s ) ( P | K | M ) 
  \\_/ \\_/ \\_/ \\_/ \\_/ \\_/   \\_/ \\_/ \\_/  v1.7




"""
        println ''
        println ' ************************************************************'
        println ' *                                                          *'
        println ' * Nibras has launched. You can access it from:             *'
        println ' *                                                          *'
        println ' * https://localhost:1441/nibras                            *'
        println ' *                                                          *'
//	println ' * Note: To stop Nibras, press ctrl+c in this window, or          *'
//	println ' * run ./scripts/stop script.                               *'
// 	println ' *                                                          *'
        println ' ************************************************************'
        println ''
        println ''

        if (org.apache.commons.lang.SystemUtils.IS_OS_WINDOWS) {
            """c:\\windows\\explorer  "" https://localhost:1441/nibras/""".execute()
        } else if (org.apache.commons.lang.SystemUtils.IS_OS_LINUX){
            """/usr/bin/xdg-open https://localhost:1441/nibras/""".execute()
        }


    }
    def destroy = {

        println '************************************************************'
        println '*                                                          *'
        println '* Nibras is stopping...                                    *'
        println '*                                                          *'
        println '************************************************************'

    }
}
