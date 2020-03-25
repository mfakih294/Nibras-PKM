package nibras

import security.*


class BootStrap {

    def init = { servletContext ->

        if (User.count() == 0) {
            def adminRole = new Role(authority: 'ROLE_ADMIN').save()
//            def standardRole = new Role(authority: 'ROLE_STANDARD').save()

//            def adminUser = new User(username: 'admin', password: 'admin').save()
            def standardUser = new User(username: 'nibras', password: 'nibras').save()

//            UserRole.create adminUser, adminRole
            UserRole.create standardUser, adminRole //standardRole

            UserRole.withSession {
                it.flush()
                it.clear()
            }

            assert User.count() == 1
            assert Role.count() == 1
            assert UserRole.count() == 1
        }

        println ''
        println ''
        println ' ************************************************************'
        println ' *                                                          *'
        println ' * Nibras has launched.                                     *'
        println ' * In the standard configuration, you can access it from:   *'
        println ' *                                                          *'
        println ' * http://localhost/nibras       (on Windows)               *'
        println ' * http://localhost:2020/nibras  (on Linux)                 *'
        println ' *                                                          *'
        println ' ************************************************************'
        println ''
        println ''

    }
    def destroy = {

        println '************************************************************'
        println '*                                                          *'
        println '* Nibras is being stopped...                               *'
        println '*                                                          *'
        println '************************************************************'

    }
}
