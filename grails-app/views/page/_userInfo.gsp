



<h4>New password for user: ${username}</h4>
<br/>
<g:formRemote name="batchAdd3"
              url="[controller: 'page', action: 'changePassword']"
              update="responceArea" style="display: inline"
              method="post">

%{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%

    <g:textField name="password" value="" id="speedsearch"
                 autocomplete="off"
                 style="display: inline;  width: 220px !important; height: 24px; padding: 3px; margin: 1px; font-size: 11px;"
                 placeholder="New password"
                 class=""/>

    <g:submitButton name="Set" value="Update"
                    style="margin: 0px;"
                    id=" "
                    class="ui-widget ui-state-default"/>

</g:formRemote>

<div id="responceArea"></div>

<br/>
<br/>
<br/>
<br/>

