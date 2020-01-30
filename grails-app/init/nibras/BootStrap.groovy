package nibras

import security.*


class BootStrap {

    def init = { servletContext ->


        def adminRole = new Role(authority: 'ROLE_ADMIN').save()

        def testUser = new User(username: 'nibras', password: 'nibras').save()

        UserRole.create testUser, adminRole

        UserRole.withSession {
            it.flush()
            it.clear()
        }

        assert User.count() == 1
        assert Role.count() == 1
        assert UserRole.count() == 1


    }
    def destroy = {
    }
}
