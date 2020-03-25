class UrlMappings {
    static mappings = {

        "/" (controller: 'page', action: 'appMain')

        "/main" (controller: 'page', action: 'appMain')

        "/cal" (controller: 'page', action: 'appCalendar')

        "/light" (controller: 'page', action: 'appLight')
        "/q" (controller: 'page', action: 'appLight')
        "/l" (controller: 'page', action: 'appLight')

        "/slides"(controller: 'page', action: 'slides')


        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }


        "500"(view:'/error')

	"/json"(controller: "sync", action: "exportJson")
    }
}