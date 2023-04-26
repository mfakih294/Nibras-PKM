<%@ page import="app.IndicatorData; mcs.*; app.IndexCard;" %>


<g:remoteLink controller="generics" action="showChildren"
              tabindex="-1"
              params="${[id: record.id, entityCode: entityCode]}"
              update="below${entityCode}Record${record.id}"
              title="Children">
    <g:if test="${entityCode == 'R'}">
        <g:if test="${mcs.Excerpt.countByBook(record)}">
            E <sup>${Excerpt.countByBook(mcs.Book.get(record.id))}</sup>
        </g:if>
        <g:if test="${mcs.Book.countByBook(record) > 0}">
            ${Book.countByBook(mcs.Book.get(record.id))} books
        </g:if>

        <g:if test="${IndexCard.countByBook(record)}">
            ${app.IndexCard.countByBook(mcs.Book.get(record.id))} notes
        </g:if>
        <g:if test="${Planner.countByBook(record)}">
            ${Planner.countByBook(record)} plans
        </g:if>
        <g:if test="${Journal.countByBook(record)}">
            ${Journal.countByBook(record)} journal
        </g:if>

    </g:if>

    <g:if test="${entityCode == 'D'}">

        <g:if test="${Course.countByDepartment(record) > 0}">
            ${mcs.Course.countByDepartment(record)} courses
        </g:if>
        <g:if test="${Writing.countByDepartment(record) > 0}">
            ${Writing.countByDepartment(record)} writings
        </g:if>

        <g:if test="${Task.countByDepartment(record) > 0}">
            ${Task.countByDepartment(record)} tasks
        </g:if>
        <g:if test="${Goal.countByDepartment(record) > 0}">
            ${Goal.countByDepartment(record)} goals
        </g:if>
        <g:if test="${Journal.countByDepartment(record) > 0}">
            ${Journal.countByDepartment(record)} journals
        </g:if>
        <g:if test="${Planner.countByDepartment(record) > 0}">
            ${Planner.countByDepartment(record)} planners
        </g:if>
        <g:if test="${Book.countByDepartment(record) > 0}">
            ${Book.countByDepartment(record)} resources
        </g:if>
        <g:if test="${IndexCard.countByDepartment(record) > 0}">
            ${IndexCard.countByDepartment(record)} notes
        </g:if>


    </g:if>
    <g:if test="${entityCode == 'C'}">

        <g:if test="${mcs.Planner.countByCourse(record) > 0}">
            ${Planner.countByCourse(record)} plans
        </g:if>
        <g:if test="${Journal.countByCourse(record) > 0}">
            J <sup>${Journal.countByCourse(record)}</sup>
        </g:if>
        <g:if test="${Writing.countByCourse(record) > 0}">
            W <sup>${Writing.countByCourse(record)}</sup>
        </g:if>
        <g:if test="${IndexCard.countByCourse(record) > 0}">
            N <sup>${IndexCard.countByCourse(record)}</sup>
        </g:if>
        <g:if test="${Book.countByCourse(record) > 0}">
            R <sup>${Book.countByCourse(record)}</sup>
        </g:if>
        <g:if test="${Goal.countByCourse(record) > 0}">
            G <sup>${mcs.Goal.countByCourse(record)}</sup>
        </g:if>
        <g:if test="${Task.countByCourse(record) > 0}">
            T <sup>${Task.countByCourse(record)}</sup>
        </g:if>
    </g:if>


    <g:if test="${entityCode == 'T'}">

        <g:if test="${Planner.countByTask(record) > 0}">
            ${Planner.countByTask(record)} plans
        </g:if>
        <g:if test="${Journal.countByTask(record) > 0}">
            ${Journal.countByTask(record)} journal
        %{--todo--}%
        </g:if>
    %{--                                    <g:if test="${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id) > 0}">--}%
    %{--                                        N <sup>${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id)}</sup>--}%
    %{--                                    </g:if>--}%

    </g:if>
    <g:if test="${entityCode == 'G'}">

        <g:if test="${Task.countByGoal(record) > 0}">
            ${Task.countByGoal(record)} tasks
        </g:if>
    </g:if>

    <g:if test="${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id) > 0}">
        ${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id)} notes
    </g:if>



    <g:if test="${entityCode == 'K'}">
        ${app.IndicatorData.countByIndicator(record)} instances
    </g:if>

%{--<g:if test="${entityCode == 'Q'}">--}%
%{--# <sup>${PaymentData.countByCategory(record)}</sup>--}%
%{--todo--}%
%{--</g:if>--}%
%{--</g:if>--}%
%{--</span>--}%
%{--</td>--}%


%{--<g:if test="${'CW'.contains(entityCode)}">--}%

%{--<td class="actionTd">--}%

%{--<g:link controller="page" action="publish" target="_blank"--}%
%{--params="${[id: record.id, entityCode: entityCode]}"--}%
%{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
%{--title="Publish">--}%
%{--<span class="ui-icon ui-icon-script"></span>--}%
%{--</g:link>--}%

%{--<g:link controller="page" action="presentation" target="_blank"--}%
%{--params="${[id: record.id, entityCode: entityCode]}"--}%
%{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
%{--title="presentation">--}%
%{--<span class="ui-icon ui-icon-script"></span>--}%

%{--</g:link>--}%


</g:remoteLink>

<g:if test="${record.class.declaredFields.name.contains('nbFiles') && record.nbFiles}">
%{--<g:if test="${record.nbFiles}">--}%
    <span title="${record.filesList?.replace('"', '')}" style="display: inline-block; font-weight: bold; direction: ltr">${record.nbFiles ?: ''} files
    </span>

</g:if>
