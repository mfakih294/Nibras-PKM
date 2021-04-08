
grails.gorm.default.constraints = {
    '*'(nullable: true)
}


grails.plugin.console.enabled = true

// Added by the Spring Security Core plugin:

grails.plugin.springsecurity.password.algorithm = 'bcrypt'


grails.plugin.springsecurity.userLookup.userDomainClassName = 'security.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'security.UserRole'
grails.plugin.springsecurity.authority.className = 'security.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
//	[pattern: '/',               access: ['permitAll']],
//	[pattern: '/**',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/json/**',      access: ['permitAll']], // working! 19.07.2019
	[pattern: '**/json/**',      access: ['permitAll']], // working! 19.07.2019
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/plugins/**',       access: ['permitAll']],
	[pattern: '/**/console/**',       access: ['permitAll']],
	[pattern: '/dbconsole/**',   access: ['permitAll']],
	[pattern: '/dbconsole/',   access: ['permitAll']],
	[pattern: '/**/static/console/**',       access: ['permitAll']],
	[pattern: '/**/page/heartbeat*/**',       access: ['permitAll']],
	[pattern: '/**/download/**',       access: ['permitAll']],
	[pattern: '/**/page/mobile*/**',       access: ['permitAll']],

	[pattern: '/**/sync/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/file-icons/**',      access: ['permitAll']],
//	[pattern: '/**/slides/**',      access: ['permitAll']],
	[pattern: '/**/fonts/**',   access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/page/heartbeat*/**',      filters: 'none'],
	[pattern: '/page/mobile*/**',      filters: 'none'],
	[pattern: '/sync/**',      filters: 'none'],
	[pattern: '**/sync/**',      filters: 'none'],
	[pattern: '/**/download/**',      filters: 'none'],
	[pattern: '/json/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/file-icons/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/fonts/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
//		[pattern: '/**',             filters: 'none']
	[pattern: '/**',             filters: 'JOINED_FILTERS'] // comment the line above and uncomment this line to enable security
]

// todo: war file
grails.project.war.file = "/dev/${appName}.war"

grails.config.locations = [
		"classpath:myconfig.properties",
		"file:///nbr/myconfig.properties",
		"file:${catalina.base}/myconfig.properties",
		"~//myconfig.properties"
]



environments {
	production {
		//grails.serverURL = "http://www.changeme.com"
		grails.dbconsole.enabled = true
//		grails.dbconsole.urlRoot = '/admin/dbconsole'
	}
	development {
		grails.dbconsole.enabled = true
//		grails.dbconsole.urlRoot = "${appName}/dbc"
	}
	h2 {
		grails.dbconsole.enabled = true
	}
}
