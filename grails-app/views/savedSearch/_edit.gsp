
<div id="modalBoxBody">

  <g:hasErrors bean="savedSearchInstance">
    <div class="errors">
      <g:renderErrors bean="savedSearchInstance" as="list"/>
    </div>
  </g:hasErrors>

  <g:formRemote name="qedit" url="[controller: 'savedSearch', action:'update']" update="centralArea" method="post">
    <g:hiddenField name="id" value="${savedSearchInstance?.id}"/>
    <g:hiddenField name="version" value="${savedSearchInstance?.version}"/>
    <div class="dialog">
        <g:render template="/savedSearch/form" model="['savedSearchInstance':savedSearchInstance]"/>
    </div>

    <g:submitButton name="update" action="update" value="${message(code: 'button.update')}"
            class="fg-button ui-widget ui-state-default ui-corner-all"/>
  </g:formRemote>
  
</div>
