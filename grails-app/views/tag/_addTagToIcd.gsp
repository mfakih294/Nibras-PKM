<g:formRemote name="addTag" url="[controller: 'tag', action: 'addTagToIcd']"
              onComplete="jQuery('#newTag${instance.id}').val('')" update="tags${instance.id}">
    <g:hiddenField name="id" value="${instance.id}"/>
    <g:textField id="newTag${instance.id}" name="tag" class="ui-corner-all"
                 style="width:150px; display: inline; padding:3px;" value=""/>
    <g:submitButton name="add" value="add" style="display:none;"
                    class="fg-button  ui-widget ui-state-default ui-corner-all"/>
</g:formRemote>

%{--<span id="plus${instance.id}" style="cursor:pointer"--}%
%{--onclick="jQuery('#newTag${instance.id}').css('display', 'inline');jQuery('#newTag${instance.id}').focus();jQuery('#plus${instance.id}').css('display', 'none');">--}%
%{--&nbsp;&nbsp;<i>add tags</i>&nbsp;&nbsp;--}%
%{--</span>--}%


<script type="text/javascript">
    jQuery("#newTag${instance.id}").autocomplete('${contextPath}/tag/autoCompleteTags', {
        mustMatch:false, minChars:0, highlight:false, autoFill:false,
        delay:10, matchSubset:0, matchContains:1, selectFirst:false,
        cacheLength:100, multiple:false
    });
</script>