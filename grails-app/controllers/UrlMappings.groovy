class UrlMappings {
    static mappings = {

        "/" (controller: 'page', action: 'appMain')

        "/main" (controller: 'page', action: 'appMain')
        "/new" (controller: 'page', action: 'appModern')

        "/m" (controller: 'page', action: 'mobile')
        "/media" (controller: 'page', action: 'mobile')


        "/cal" (controller: 'page', action: 'appCalendar')
        "/calm" (controller: 'page', action: 'appMobileCalendar')

        "/kanban" (controller: 'page', action: 'appKanban')
        "/notes" (controller: 'page', action: 'appNotes')
        "/daftar" (controller: 'page', action: 'appDaftar')

        "/dash" (controller: 'page', action: 'appDashboard')
        "/d" (controller: 'page', action: 'appDashboard')

        "/light" (controller: 'page', action: 'appLight')
        "/l" (controller: 'page', action: 'appLight')

        "/slides"(controller: 'page', action: 'slides')
        "/filed"(controller: 'operation', action: 'filed')

        "/irfan"(controller: 'page', action: 'appIrfan')
    //    "/jabal-amel"(controller: 'indexCard', action: 'generateWritingsBook')
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }


        "500"(view:'/error')

	"/json"(controller: "sync", action: "exportJson")
    }
}
