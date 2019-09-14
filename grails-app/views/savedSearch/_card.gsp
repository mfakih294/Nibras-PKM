<%@ page import="mcs.parameters.SavedSearch"%>


<g:if test="${savedSearchInstance}">
	<div id="savedSearchCard${savedSearchInstance.id}" class="card">

	<table>
		<tr class="savedSearchCard">
			<td style="width:80%;">
			
    <div class="showLabel">
        <g:message code="savedSearch.queryType"/>:
    </div>
    <div class="showvalue">
   ${savedSearchInstance?.queryType?.encodeAsHTML()}

</div> 
    <div class="showLabel">
        <g:message code="savedSearch.summary"/>:
    </div>
    <div class="showvalue">
   ${savedSearchInstance?.summary?.encodeAsHTML()}

</div> 
    <div class="showLabel">
        <g:message code="savedSearch.query"/>:
    </div>
    <div class="showvalue">
   ${savedSearchInstance?.query?.encodeAsHTML()}

</div> 
    <div class="showLabel">
        <g:message code="savedSearch.entity"/>:
    </div>
    <div class="showvalue">
   ${savedSearchInstance?.entity?.encodeAsHTML()}

</div> 
			</td>

			<td style="width:20%;">
				<g:remoteLink controller="savedSearch" action="refresh" id="${recordId}"
						update="savedSearchCard${savedSearchInstance.id}"
                   title="Refresh data">
                    <span class="fg-button fg-button-icon-right ui-widget ui-state-default ui-corner-all">refresh</span>
                </g:remoteLink>
				
				<br/>
				<br/>
			<g:render template="/savedSearch/actions" model="[recordId: savedSearchInstance.id]"/>
			
			</td>
		</tr>
	</table>
  
	</div>

</g:if>