<style>

</style>


%{--<i>Auto-complete suggestions</i>--}%
%{--<br/>--}%
%{--<hr/>--}%
%{--<br/>--}%
<g:set var="s" value="${1}"/>
    <g:each in="${hints?.split('\n')}" var="c">
        <g:if test="${c?.trim() != ''}">

        <div style="display: block; margin: 7px; padding: 2px;"
              id="${c.encodeAsMD5()}">
            [${s++}] ${c}
        </div>

        <script>
            jQuery("#notificationAreaHidden").load('${request.contextPath}/generics/verifySmartCommand', {'line': "${c}"}, function (response, status, xhr) {
                jQuery("#${c.encodeAsMD5()}").attr('class', response);
            })
        </script>
        </g:if>
    </g:each>

<g:if test="${hints.length() > 1800}">
    <span style="color: red">
    length: ${hints.length()} / 1867
    </span>
</g:if>
<g:else>
    length: ${hints.length()} / 1867
</g:else>

