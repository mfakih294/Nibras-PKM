<%@ page import="mcs.parameters.SavedSearch"%>

<table>
  <tbody>
  
<tr class="prop">
                    <td valign="top" class="value ${hasErrors(bean:savedSearchInstance,field:'queryType','errors')}">
                        <label for="queryType"  >
                        <g:message code="savedSearch.queryType" default="Query type"/>
                            
                            </label>
  	<g:select name="queryType" from="${['hql', 'lucene', 'adhoc']}" value="${savedSearchInstance?.queryType}"/>
</td> 


                    <td valign="top" class="value ${hasErrors(bean:savedSearchInstance,field:'summary','errors')}">
                        <label for="summary"  >
                        <g:message code="savedSearch.summary" default="Summary"/>
                            
                            </label>
  	<g:textField id="summary" name="summary" value="${savedSearchInstance?.summary}"/>	
  	<g:checkBox id="onHomepage" name="onHomepage" value="${savedSearchInstance?.onHomepage}" style="width: 15px;"/> On homepage?
  	<g:checkBox id="onMobile" name="onMobile" value="${savedSearchInstance?.onMobile}" style="width: 15px;"/> On mobile?
</td>
   </tr>
  <tr>

                    <td valign="top" class="value ${hasErrors(bean:savedSearchInstance,field:'query','errors')}">
                        <label for="query"  >
                        <g:message code="savedSearch.query" default="Query"/>
                            
                            </label>
  	<g:textArea cols="80" rows="5" id="query" name="query" value="${savedSearchInstance?.query}"/>
</td> 


                    <td valign="top" class="value ${hasErrors(bean:savedSearchInstance,field:'entity','errors')}">
                        <label for="entity"  >
                        <g:message code="savedSearch.entity" default="Entity"/>
                            
                            </label>
  	<g:textField id="entity" name="entity" value="${savedSearchInstance?.entity}" style="width: 30px;"/>
</td> 


</tr>


  </tbody>
</table>


<script>
//  jQuery("#input:text').get(1).focus()"};
</script>