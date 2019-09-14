<b>${message}</b>
<g:formRemote name="batch" url="[controller: 'journal', action: 'batch']" update="batchBox" method="post"
              onComplete="jQuery('#input').focus();">
    <g:textArea name="input" id="input" style="width:600px;" value="${multiline ? multiline : ''}"/>
    <g:submitButton name="batch" value="add" accessKey="s"
                    class="fg-button  ui-widget ui-state-default ui-corner-all"/>
</g:formRemote>

%{--<g:render template="/journal/line" collection="${list}" var="journalInstance"/>--}%
<!--onComplete="location.reload();"-->