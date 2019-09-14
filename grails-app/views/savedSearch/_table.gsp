<%@ page import="mcs.parameters.SavedSearch"%>

<script language="javascript" type="text/javascript">

  jQuery(document).ready(function() {
  
  });
</script>


<g:if test="${list}">

  <table id="tableList">
    <thead>
    <tr>
    
            <util:remoteSortableColumn property="queryType" titleKey="savedSearch.queryType" controller="savedSearch" action="list" update="centralArea"/>
            
            <util:remoteSortableColumn property="summary" titleKey="savedSearch.summary" controller="savedSearch" action="list" update="centralArea"/>
            <util:remoteSortableColumn property="onHomepage" titleKey="savedSearch.onHomepage" controller="savedSearch" action="list" update="centralArea"/>

            <util:remoteSortableColumn property="query" titleKey="savedSearch.query" controller="savedSearch" action="list" update="centralArea"/>
            
            <util:remoteSortableColumn property="entity" titleKey="savedSearch.entity" controller="savedSearch" action="list" update="centralArea"/>
            
    <util:remoteSortableColumn property="lastUpdated" titleKey="Last updated" controller="savedSearch" action="list" update="centralArea"/>
    
    <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${list}" status="i" var="instance">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
   
          <td>
     ${fieldValue(bean:instance, field:'queryType')} 
 </td> 
          <td>
     ${fieldValue(bean:instance, field:'summary')} 
 </td> 
    <td>
     ${fieldValue(bean:instance, field:'onHomepage')}
 </td>
          <td>
     ${fieldValue(bean:instance, field:'query')} 
 </td> 
          <td>
     ${fieldValue(bean:instance, field:'entity')} 
 </td> 
<td title="${(instance.lastUpdated ? instance.lastUpdated.format('dd.MM.yyyy HH:mm'): 'No date')}">

    <g:if test="${instance.lastUpdated}">
        %{--<prettytime:display date="${instance.lastUpdated}"/>--}%
    </g:if>
      </td>
 

      <td>
        <g:render template="/savedSearch/actions" model="[recordId: instance.id]"/>
      </td>
      </tr>
    </g:each>
    </tbody>
  </table>
  %{--<div class="paginateButtons" style="display:inline !important;">--}%
  %{--<util:remotePaginate controller="savedSearch" action="list" total="${total}"--}%
                                     %{--update="centralArea"/>--}%
  %{--</div>--}%
  
</g:if>
<g:else>
  <i>No records found</i>
</g:else>
