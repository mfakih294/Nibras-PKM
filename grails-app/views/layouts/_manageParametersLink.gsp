<g:remoteLink controller="generics" action="fetchAddForm"
              params="[entityController: controller, isParameter: true,
                       updateRegion    : 'centralArea']"
              update="centralArea">
    <span style="font-size: 1em;">
        ${name} (${grailsApplication.classLoader.loadClass(controller).count()})
    </span>
    </br/>
</g:remoteLink>