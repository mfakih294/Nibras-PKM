<%@ page import="mcs.parameters.SavedSearch; mcs.Task" %>
<g:if test="${!params.disableSavedSearch}">
    <g:each in="${SavedSearch.findAllByEntityLike(entity, [sort: 'orderNumber'])}" var="i">

          
            <g:set var="split" value="\\{"/>

            <g:set var="count"
                   value="${i.countQuery ? Task.executeQuery(i.countQuery)[0] : null}"/>

            <g:remoteLink controller="generics" action="executeSavedSearch"
                          style="direction: rtl; padding-right: 5px; padding-left: 5px; text-align: right;  color: #${count > 0 ? '003366' : (count == 0 ? 'ccc' : 'bbb')}; ${i.onHomepage ? 'text-decoration: underline' : ''}"
                          id="${i.id}"
                          before="jQuery.address.value(jQuery(this).attr('href'));"
                          update="centralArea">
                 <span title="${i.summary + ': ' + i.query}" style="font-weight: bold;">
                %{--${i.summary} --}%
                     ${i.code}
                </span>
                <span style="font-size: small">(${count != null ? '' + count + '' : null})</span>
            </g:remoteLink>
<g:if test="${1 ==2}">
       <div class="showhim">
	    	<span class="testhide">
		  <g:remoteLink controller="generics" action="fetchAddForm" id="${i.id}"
                          params="[entityController: 'mcs.parameters.SavedSearch',
                                  updateRegion: 'centralArea',
                                  finalRegion: 'centralArea']"
                          update="centralArea"
                          title="Edit">
                *
            </g:remoteLink>

			     <g:if test="${i.queryType == 'hql'}">
           <sup>
            <g:remoteLink controller="generics" action="executeSavedSearch"
                          style=" color: gray"
                          before="jQuery.address.value(jQuery(this).attr('href'));"
                          id="${i.id}" params="[reportType: 'random']"
                          update="centralArea">
                rn

            </g:remoteLink>
           </sup>
                <sup>
            <g:link controller="generics" action="executeSavedSearch"
                          style=" color: gray"
                          id="${i.id}" params="[reportType: 'tab']"
                          target="_blank">
                tb
            </g:link>
           </sup>
           
                <g:if test="${i.calendarEnabled}">
                <sub>
            <g:link controller="generics" action="executeSavedSearch"
                    style=" color: gray"
                          id="${i.id}" params="[reportType: 'cal']"
                          target="_blank">
                cl
            </g:link>

           </sub>
		       </g:if>
          
            </g:if>

       </span>

			</div>
</g:if>
    </g:each>
</g:if>
