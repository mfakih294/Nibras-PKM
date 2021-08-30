<%@ page import="mcs.parameters.SavedSearch; mcs.Task" %>
<g:if test="${!params.disableSavedSearch}">
    <g:each in="${SavedSearch.findAllByEntityLikeAndBookmarked(entity, true, [sort: 'orderNumber'])}" var="i">
<li>
          
            <g:set var="split" value="\\{"/>
            <g:set var="count"
                   value="${i.countQuery ? Task.executeQuery(i.countQuery)[0] : null}"/>

    %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
            <g:remoteLink controller="generics" action="executeSavedSearch"
                          style="direction: rtl; text-align: right;  color: #${count > 0 ? '003366' : (count == 0 ? 'ccc' : 'bbb')}; ${i.onHomepage ? 'text-decoration: underline' : ''}"
                          id="${i.id}"
                          update="centralArea">

                 <span style="font-weight: bold" title="${i.query}">   ${i.summary} </span> <b style="color: darkgray">${i.code}</b>
                <span style="font-size: small">(${count != null ? '' + count + '' : null})</span>

            </g:remoteLink>


        %{--<br/>--}%
        %{--<br/>--}%
</li>
    </g:each>
    <sec:ifAnyGranted roles="ROLE_ADMIN">
       <g:each in="${SavedSearch.findAllByEntityLikeAndBookmarked(entity, false, [sort: 'orderNumber'])}" var="i">
<li>
          
            <g:set var="split" value="\\{"/>

            <g:set var="count"
                   value="${i.countQuery ? Task.executeQuery(i.countQuery)[0] : null}"/>

    %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
            <g:remoteLink controller="generics" action="executeSavedSearch"
                          style="direction: rtl; text-align: right;  color: #${count > 0 ? '003366' : (count == 0 ? 'ccc' : 'bbb')}; ${i.onHomepage ? 'text-decoration: underline' : ''}"
                          id="${i.id}"
                          update="centralArea">

                 <span title="${i.query}">   ${i.summary} </span> <b style="color: darkgray">${i.code}</b>
                <span style="font-size: small">(${count != null ? '' + count + '' : null})</span>

            </g:remoteLink>


        %{--<br/>--}%
        %{--<br/>--}%
</li>
    </g:each>
    </sec:ifAnyGranted>
</g:if>
