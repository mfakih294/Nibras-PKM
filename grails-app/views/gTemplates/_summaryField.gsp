<g:if test="${record.class.declaredFields.name.contains('goal')}">

    <g:set value="goal" var="field"></g:set>

    <a href="#" id="${field}${record.id}" class="${field}"
       data-type="select"
       data-value="${record[field]?.id}"
       data-name="${field}-${entityCode}"
       style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 0.95em; font-style: italic; padding-left: 1px; padding-right: 1px;"
       data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&recordId=${record.id}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
       data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
       data-title="Edit ${field}">
        ${record[field] ? (record[field]) : 'g'}
    </a>
    <script type="text/javascript">
        jQuery("#${field}${record.id}").editable();
    </script>

    <g:if test="${record.goal}">
        <g:remoteLink controller="generics" action="showSummary"
                      id="${record.goal?.id}"
                      params="[entityCode: 'G']"
                      update="below${entityCode}Record${record.id}"
                      title="Show goal">
        %{--<i>d</i>--}%
            &larr;
        %{--<b>${record.goal?.department?.code}</b>--}%
        %{--<i>${record.goal?.summary}</i>--}%

        </g:remoteLink>
    %{--<br/>--}%
    </g:if>
</g:if>




%{--<g:remoteLink controller="generics" action="showSummary"--}%
%{--params="${[id: record.id, entityCode: entityCode]}"--}%
%{--update="${entityCode}Record${record.id}"--}%
%{--title="ID ${record.id}. Click to refresh">--}%

%{--</g:remoteLink>--}%










%{--<span id="actionsButtons2${record.id}"--}%
%{--class="temp442 actionsButtons hiddenActions"--}%
%{--style="font-size: 9px !important; color: #4A5C69;">--}%

%{--</span>--}%




%{--<td class="record-statistics">--}%
%{--<span title="Statistics">--}%

%{--<g:if test="${params.action != 'luceneSearch'}">--}%
%{--<g:if test="${entityCode == 'G'}">--}%
%{--${Planner.countByGoal(record)} <sup>P</sup>--}%

%{--${Task.countByGoal(record)} <sup>T</sup>--}%

%{--</g:if>--}%



%{--<g:if test="${entityCode == 'T'}">--}%

%{--<g:remoteLink controller="task" action="showPlans" id="${record.id}"--}%
%{--update="below${entityCode}Record${record.id}"--}%
%{--title="Show plans">--}%
%{--${Planner.countByTask(record)} <sup>P</sup>--}%
%{--</g:remoteLink>--}%

%{--</g:if>--}%



%{--<td class="record-selection">--}%

%{--</td>--}%



%{--<td class="actionTd">--}%

%{----}%
%{--</td>--}%

%{--<tr id="appendRow${entityCode}-${record.id}">--}%
%{--<td colspan="2">--}%

%{--</td>--}%

%{--</table>--}%
%{--</div>--}%




%{--<g:if test="${entityCode == 'C'}">--}%
%{--<g:each in="${app.IndexCard.findAllByCourse(record, [max: 3, sort: 'dateCreated', order: 'desc'])}" var="n">--}%
%{--<b>${n.writtenOn ? n.writtenOn?.format('dd.MM.yyyy'): n.dateCreated?.format('dd.MM.yyyy')}</b>:--}%
%{--<i><pkm:summarize text="${n.description ?: ''}"--}%
%{--length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/>--}%
%{--</i>--}%
%{--${n.fileName ? 'file: ' + n.fileName : ''}--}%
%{--<br/>--}%
%{--</g:each>--}%
%{--</g:if>--}%


<div style="direction: rtl; text-align: right; border-left: 1px darkgray;">
    <g:each in="${app.IndexCard.findAllByEntityCodeAndRecordId(record.entityCode(), record.id, [max: 3, sort: 'dateCreated', order: 'desc'])}"
            var="n">
        &nbsp;&nbsp;<b
            style="color: darkgray;">${n.writtenOn ? n.writtenOn?.format('dd.MM.yyyy') : n.dateCreated?.format('dd.MM.yyyy')}</b>:
        <i><pkm:summarize text="${n.description ?: ''}"
                          length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/>
        </i>
        ${n.fileName ? 'file: ' + n.fileName : ''}
        <br/>
        <br/>
    </g:each>
</div>



<td>
%{--<g:if test="${session['showFullCard'] == 'on' || showFull}">--}%
%{--<br/>--}%


%{--                        removed for method code too large 422.20--}%
%{--                            <g:checkBox name="select-${record.id}-${entityCode}"--}%
%{--                                        title="Select record"--}%
%{--                                        value="${org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().getSession()[entityCode + record.id] == 1}"--}%
%{--                                style="height: 14px !important;"--}%
%{--                                        onclick="jQuery('#selectBasketRegion').load('${request.contextPath}/generics/select/${entityCode}${record.id}')"--}%
%{--                                        />--}%



%{--</g:if>--}%
%{--                    </td>--}%








%{--                                    <g:if test="${record.priority == 3}">--}%
%{--                                    --}%%{--&loz;--}%
%{--                                        <i style='color: darkorange'>p3</i>--}%
%{--                                    </g:if>--}%
%{--                                    <g:elseif test="${record.priority == 4}">--}%
%{--                                    --}%%{--&diams;--}%
%{--                                        <i style='color: darkred'>p4</i>--}%
%{--                                    </g:elseif>--}%
%{--                                    <g:elseif test="${record.priority == 5}">--}%
%{--                                    --}%%{--&diams;&diams;--}%
%{--                                        <i style='color: red'>p5</i>--}%
%{--                                    </g:elseif>--}%
%{--                                    <g:elseif test="${record.priority == 1}">--}%
%{--                                    --}%%{--&darr;--}%
%{--                                        <i style='color: gray'>p1</i>--}%
%{--                                    </g:elseif>--}%
%{--                                    <g:elseif test="${record.priority == 2}">--}%
%{--                                    --}%%{--&darr;--}%
%{--                                        <i style='color: gray'>p2</i>--}%
%{--                                    </g:elseif>--}%
%{--                                    <g:elseif test="${record.priority == 0}">--}%
%{--                                    --}%%{--&dArr;--}%
%{--                                        <i style='color: lightgray'>p0</i>--}%
%{--                                    </g:elseif>--}%



