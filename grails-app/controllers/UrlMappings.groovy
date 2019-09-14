class UrlMappings {
    static mappings = {

        "/"(controller: 'page', action: 'main')
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