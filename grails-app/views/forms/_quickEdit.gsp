<%@ page import="app.parameters.Blog" %>
%{--<g:formRemote name="addTag" url="[controller: 'generics', action: 'quickSave']"--}%
    %{--update="TRecord312"--}%
              %{--style="display: inline;">--}%
    %{--<g:hiddenField name="id" value="${id}"/>--}%
    %{--<g:hiddenField name="entityCode" value="${entityCode}"/>--}%
    %{--<g:textField id="newTagField${entity}${instance.id}" name="tag" class="ui-corner-all"--}%
                 %{--style="width:100px; display: inline; background: #e7f8e6" value=""/>--}%
                 
                 
    <g:if test="${field == 'resourceStatus'}">
    <g:select name="newValue" from="${mcs.parameters.ResourceStatus.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>
  <g:if test="${field == 'workStatus'}">
    <g:select name="newValue" from="${mcs.parameters.WorkStatus.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>


 <g:if test="${field == 'writingStatus'}">
    <g:select name="newValue" from="${mcs.parameters.WritingStatus.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>

 <g:if test="${field == 'taskLocation'}">
    <g:select name="newValue" from="${mcs.parameters.Location.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>
 <g:if test="${field == 'writingType'}">
    <g:select name="newValue" from="${mcs.parameters.WritingType.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>
 <g:if test="${field == 'goalType'}">
    <g:select name="newValue" from="${mcs.parameters.GoalType.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>

 <g:if test="${field == 'journalType'}">
    <g:select name="newValue" from="${mcs.parameters.JournalType.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>

 <g:if test="${field == 'plannerType'}">
    <g:select name="newValue" from="${mcs.parameters.PlannerType.list([sort: 'name'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>
 <g:if test="${field == 'priority'}">
    <g:select name="newValue" from="${(1..4)}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>

 <g:if test="${field == 'percentCompleted'}">
    <g:select name="newValue" id="percentCompleted" from="${[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>



 <g:if test="${field == 'plannedDuration'}">
    <g:select name="newValue" from="${[1,2,3,4,5,6,7,8,9,10,11,12]}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>



     <g:if test="${field == 'blog'}">
    <g:select name="newValue" from="${Blog.list([sort: 'code'])}" optionKey="id" optionValue="code"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['null': '']}"/>
    </g:if>


     <g:if test="${field == 'pomegranate'}">
    <g:select name="newValue" from="${Pomegranate.list([sort: 'code'])}" optionKey="id" optionValue="code"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['null': '']}"/>
    </g:if>



  <g:if test="${field == 'department'}">
    <g:select name="newValue" from="${mcs.Department.list([sort: 'code'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>


     <g:if test="${field == 'course'}">
    <g:select name="newValue" from="${mcs.Course.findAllByCodeIsNotNull([sort: 'code'])}"
              onchange="jQuery('#${updateDiv}').load('${request.contextPath}/generics/quickSave/' + '${id}-${entityCode}-${field}-' + this.value)"
              optionKey="id" optionValue="code" value="${valueId}" style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
    </g:if>

    
    
    %{--<g:submitButton name="add" value="add" style="display:none;"--}%
                    %{--class="fg-button  ui-widget ui-state-default ui-corner-all"/>--}%
%{--</g:formRemote>--}%

<script type="text/javascript">
</script>