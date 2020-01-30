<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<div id="accordionWest" class="basic">

    <h3 class="accordionPanelBrowse" style="margin-top: 5px;"><a href="#">
        <g:message code="ui.lists0"></g:message>

    </a></h3>

    <div>

        <g:render template="/layouts/savedSearches" model="[entity: 'M']"/>

        <g:render template="/layouts/modulesAccordion"/>

    </div>

    %{--<g:if test="${Setting.findByName('courses.enabled')?.value == 'yes'}">--}%
    %{--<h4><a href="#">Courses</a></h4>--}%

    %{--<div>--}%
    %{--<g:render template="/layouts/coursesAccordion"/>--}%
    %{--</div>--}%

    %{--</g:if>--}%


    <h3 class="accordionPanelBrowse"><a href="#">
        <g:message code="ui.calendar"></g:message>
    </a></h3>

    <div>
        <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <h4>Export:</h4>
            <ul>
                <li><a href="${request.contextPath}/task/expotTodotxt"
                       style="" target="_blank">
                    G/T to Todo.txt
                </a></li>
                <li><a href="${request.contextPath}/expot/exportToIcal"
                       style="" target="_blank">
                    Export J/T/P to ics calendar
                </a></li>
            </ul>

        </g:if>


        <h4>Full-page calendars</h4>

        <ul>
            <g:each in="${mcs.parameters.SavedSearch.findAllByCalendarEnabled(true, [sort: 'code'])}" var="s">
                <li>
                    <a href="${request.contextPath}/generics/showCalendar/${s.id}"
                       style="" target="_blank">
                        %{--<span class="ui-icon ui-icon-calendar"></span>--}%
                        <b>${s.code}</b>
                        ${s.summary}
                    </a>

                </li>
            </g:each>

        </ul>
        %{--<ul>--}%
        %{--<li>--}%
        %{--<a href="${request.contextPath}/generics/showCalendar/Tcal"--}%
        %{--style="" target="_blank">--}%
        %{--<span class="ui-icon ui-icon-calendar"></span>--}%
        %{--<g:message code="ui.tasksCalendar"></g:message>--}%
        %{--</a>--}%

        %{--</li>--}%
        %{--<li>--}%
        %{--<a href="${request.contextPath}/generics/showCalendar/Pcal"--}%
        %{--style="" target="_blank">--}%
        %{--<span class="ui-icon ui-icon-calendar"></span>--}%
        %{--<g:message code="ui.plannerCalendar"></g:message>--}%
        %{--</a>--}%
        %{--</li>--}%
        %{--<li>--}%
        %{--<a href="${request.contextPath}/generics/showCalendar/Jcal" style="" target="_blank">--}%
        %{--<g:message code="ui.journalCalendar"></g:message>--}%
        %{--</a>--}%

        %{--</li>--}%

        %{--<li>--}%
        %{--<a href="${request.contextPath}/generics/showCalendar/Rcal" style="" target="_blank">--}%
        %{--<g:message code="ui.resourceCalendar"></g:message>--}%
        %{--</a>--}%

        %{--</li>--}%
        %{--<li>--}%
        %{--<a href="${request.contextPath}/generics/showCalendar/Ncal" style="" target="_blank">--}%
        %{--<g:message code="ui.notesCalendar"></g:message>--}%
        %{--</a>--}%

        %{--</li>--}%
        %{--</ul>--}%

        <br/>
        <br/>
        <h4>Browse records by date or range of dates</h4>
        <g:if test="${OperationController.getPath('rangeCalendar.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <span id="dateRange1" style="">
                <input type="hidden" class="startDate" id="range_start">
                <input type="hidden" class="endDate" id="range_end">
            </span>
        %{--<br/>--}%
        %{--Calendar report includes:--}%
            <br/>
            Show: <g:each in="['JP', 'P', 'J', 'Kanban', 'Jtrk', 'Qtrans', 'Qacc', 'log']" var="type">

            <g:remoteLink controller="report" action="setJPReportType" id="${type}"
                          update="${type}ResultSpan"
                          title="Toggle ${type}">
                <span id="${type}ResultSpan" style="font-weight: ${session[type] == 1 ? 'bold' : 'normal'}">
                    ${type}
                </span>
            </g:remoteLink>
        </g:each>
        %{--</div>--}%
            <br/>
        %{--<hr/>--}%
        %{--<br/>--}%

        </g:if>

    %{--<g:render template="/gTemplates/recordSummary"--}%
    %{--model="[abridged: 'yes', record: Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', ['knb'])[0]]"/>--}%
    %{--<g:render template="/layouts/coursesAccordionOnePanel"></g:render>--}%
    </div>

    <h3 class="accordionPanelBrowse"><a href="#">
        %{--<g:message code="ui.calendar"></g:message>--}%
        Courses
    </a></h3>

    <div>

        <g:if test="${Course.countByBookmarked(true) > 0}">
            <table>
                <g:each in="${mcs.Department.list([sort: 'code'])}" var="d">
                    <g:if test="${Course.countByDepartmentAndBookmarked(Department.get(d.id), true, [sort: 'code', order: 'asc']) > 0}">

                    %{--<h3 class="bowseTab">--}%
                    %{--<g:remoteLink controller="report" action="departmentCourses"--}%
                    %{--update="centralArea" params="[id: d.id]"--}%
                    %{--title="Actions">--}%
                    %{--<span style="padding: 1px;">--}%


                        <tr>
                            <td colspan="3"
                                style="text-align: center; background: #e0eee6; padding: 6px;margin-top: 6px;">
                                <a>

                                    <g:remoteLink controller="generics" action="recordsByDepartment" id="${d.id}"
                                                  before="jQuery.address.value(jQuery(this).attr('href'));"
                                                  style="font-weight: bold;"
                                                  update="centralArea">
                                        ${d.summary}
                                    </g:remoteLink>


                                    <span class="moduleCount">

                                        %{--(${Course.courses.size()})--}%
                                    </span>
                                    %{--<span class="I-bkg" style=" float: right;"--}%
                                    %{--style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">--}%
                                    %{--</span>--}%

                                </a>

                            </td>

                        </tr>
                    %{--</h3>--}%

                    %{--<br style="padding-left: 0">--}%
                        <g:each in="${Course.findAllByDepartmentAndBookmarked(Department.get(d.id), true, [sort: 'code', order: 'asc'])}"
                                var="record">

                            <tr>
                                <td style="border-bottom: 1px dashed darkgray;  text-align: left; padding-right: 3px !important;">

                                    <a href="${createLink(controller: 'page', action: 'appCourse', id: record.id)}"
                                       target="_blank" title="Open course records in a separate page">
                                    &nearr;

                                    </a>
                                </td>

                                <td style="border-bottom: 1px dashed darkgray; text-align: start; unicode-bidi: plaintext">
                                    %{--<g:remoteLink style="list-style-type: none" class="text${t.language}">--}%
                                    <g:remoteLink controller="generics" action="recordsByCourse" id="${record.id}"
                                                  title="Code: ${record.code ?: record.codeString}"
                                                  before="jQuery.address.value(jQuery(this).attr('href'));"
                                                  update="centralArea">
                                    %{--<b>${t.numberCode}</b>--}%
                                        ${org.apache.commons.lang.StringUtils.abbreviate(record.summary, 20)}
                                    </g:remoteLink>
                                    %{--<br/>--}%
                                </td>
                                <td style="border-bottom: 1px dashed darkgray; text-align: right;">

                                %{--<span style="padding: 2px;">--}%

                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'P']}"
                                                  update="centralArea"
                                                  title="Children">
                                        <g:if test="${Planner.countByCourse(record) > 0}">
                                            P<sup>${Planner.countByCourse(record)}</sup>
                                        </g:if>
                                    </g:remoteLink>

                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'J']}"
                                                  update="centralArea"
                                                  title="Children">

                                        <g:if test="${Journal.countByCourse(record) > 0}">
                                            J<sup>${Journal.countByCourse(record)}</sup>
                                        </g:if>
                                    </g:remoteLink>

                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'W']}"
                                                  update="centralArea"
                                                  title="Children">

                                        <g:if test="${Writing.countByCourse(record) > 0}">
                                            W<sup>${Writing.countByCourse(record)}</sup>
                                        </g:if>
                                    </g:remoteLink>
                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'N']}"
                                                  update="centralArea"
                                                  title="Children">
                                        <g:if test="${IndexCard.countByCourse(record) > 0}">
                                            N<sup>${IndexCard.countByCourse(record)}</sup>
                                        </g:if>
                                        <g:if test="${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id) > 0}">
                                            +<sup>${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id)}</sup>
                                        </g:if>
                                    </g:remoteLink>
                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'B']}"
                                                  update="centralArea"
                                                  title="Children">
                                        <g:if test="${Book.countByCourseAndStatus(record, ResourceStatus.findByCode('mkt'))}">
                                            B<sup>${Book.countByCourseAndStatus(record, mcs.parameters.ResourceStatus.findByCode('mkt'))}</sup>
                                        </g:if>
                                    </g:remoteLink>


                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'R']}"
                                                  update="centralArea"
                                                  title="Children">
                                        <g:if test="${Book.countByCourseAndStatusNot(record, ResourceStatus.findByCode('mkt')) + Book.countByCourseAndStatusIsNull(record) > 0}">
                                            R<sup>${Book.countByCourseAndStatusNot(record, ResourceStatus.findByCode('mkt')) + Book.countByCourseAndStatusIsNull(record)}</sup>
                                        </g:if>
                                    </g:remoteLink>

                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'G']}"
                                                  update="centralArea"
                                                  title="Children">

                                        <g:if test="${mcs.Goal.countByCourse(record) > 0}">
                                            G<sup>${Goal.countByCourse(record)}</sup>
                                        </g:if>
                                    </g:remoteLink>
                                    <g:remoteLink controller="generics" action="showSubChildren"
                                                  params="${[id: record.id, entityCode: 'C', childType: 'T']}"
                                                  update="centralArea"
                                                  title="Children">

                                        <g:if test="${Task.countByCourse(record) > 0}">
                                            T<sup>${Task.countByCourse(record)}</sup>
                                        </g:if>

                                    </g:remoteLink>
                                %{--</span>--}%

                                </td>

                            </tr>                                  %{--</g:remoteLink>--}%
                        </g:each>

                    </g:if>

                </g:each>
            </table>

        </g:if>

        <g:else>
            <span class="message">
                %{--<g:message code="help.recent.records.no"></g:message>--}%
                No bookmarked courses yet.
            </span>

        </g:else>



    %{--<ul style="padding-left: 17px; list-style-type: circle">--}%

    %{--<g:if test="${OperationController.getPath('kanban.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
    %{--<li><g:link controller="page" action="kanbanCrs"--}%
    %{--target="_blank"--}%
    %{--title="Kanban">--}%
    %{--<span class="ui-icon ui-icon-check"></span>--}%
    %{--Kanban--}%
    %{--</g:link>--}%
    %{--</li>--}%

    %{--</g:if>--}%

    %{--</ul>--}%


    %{--<h5>Search records</h5>--}%

    %{--<h4><a href="#">Search</a></h4>--}%
    %{--<div id='searchPanel'>--}%

    </div>

%{--<h4><a href="#">--}%
%{--<g:message code="ui.lists0"></g:message>--}%

%{--</a></h4>--}%

%{--<div dir="rtl" style="text-align: right;">--}%


%{--</div>--}%
    <g:if test="${Setting.findByName('tags.enabled')?.value == 'yes'}">
        <h3 class="accordionPanelBrowse"><a href="#">
            <g:message code="ui.tags"></g:message>

        </a></h3>

        <div>

            <g:if test="${Tag.count() == 0}">
                <span class="message">
                    %{--<g:message code="help.recent.records.no"></g:message>--}%
                    No tag entered yet on any record.
                </span>
            </g:if>

        %{--before="jQuery('#accordionEast').accordion({ active: 6});"--}%

            <br/>
            Filter: <g:remoteField style="height: 20px; width: 90px;" controller="operation" action="filterTags"
                                   update="tagsPanel" elementId="tagsPanelElementId" name="filter" value=""/>
            &nbsp;       <g:remoteLink controller="generics" action="tagCloud"
                                       update="tagsPanel"
                                       style="text-decoration: underline;"
                                       title="Tag cloud">
                Clear / full list
            </g:remoteLink>

            <br/>



            %{--<g:remoteLink controller="generics" action="updateTagCount" update="notificationArea"--}%
            %{--class="fg-button ui-widget ui-state-default ui-corner-all">--}%
            %{--Refresh tag count--}%
            %{--</g:remoteLink>--}%


            %{--<g:remoteLink controller="generics" action="updateContactCount" update="notificationArea">--}%
            %{--Update contact count--}%
            %{--</g:remoteLink>--}%


            <span id='tagsPanel'></span>

        </div>
    </g:if>
    <g:if test="${Setting.findByName('contacts.enabled')?.value == 'yes'}">
        <h3 class="accordionPanelBrowse"><a href="#">
            <g:message code="ui.contacts"></g:message>

        </a></h3>

        <div>
            %{--before="jQuery('#accordionEast').accordion({ active: 6});"--}%
            <g:remoteLink controller="generics" action="contactCloud"
                          update="contactPanel"
                          style="text-decoration: underline;"
                          title="Contact cloud">
                Refresh list
            </g:remoteLink>
            %{--<g:remoteLink controller="generics" action="updateContactCount" update="notificationArea">--}%
            %{--Update contact count--}%
            %{--</g:remoteLink>--}%




            <span id='contactPanel'>
            </span>
        </div>
    </g:if>

    <h3><a href="#">
        <g:message code="ui.calendar.and.search"></g:message>

    </a></h3>

    <div>

        <g:formRemote name="genericSearch" url="[controller: 'generics', action: 'hqlSearch']"
                      update="centralArea" method="post" style="display: inline;" onComplete="">

            Search for    <g:select name="resultType"
                                    from="${
                                        [
                                                [enabled: OperationController.getPath('goals.enabled')?.toLowerCase() == 'yes', code: 'G', name: 'Goals'],
                                                [enabled: OperationController.getPath('tasks.enabled')?.toLowerCase() == 'yes', code: 'T', name: 'Tasks'],
                                                [enabled: OperationController.getPath('planner.enabled')?.toLowerCase() == 'yes', code: 'P', name: 'Planner'],
                                                [enabled: OperationController.getPath('journal.enabled')?.toLowerCase() == 'yes', code: 'J', name: 'Journal'],
                                                [enabled: OperationController.getPath('writings.enabled')?.toLowerCase() == 'yes', code: 'W', name: 'Writing'],
                                                [enabled: OperationController.getPath('notes.enabled')?.toLowerCase() == 'yes', code: 'N', name: 'Notes'],
                                                [enabled: OperationController.getPath('resources.enabled')?.toLowerCase() == 'yes', code: 'R', name: 'Resources']

                                        ].grep { it.enabled == true }
                                    }" optionKey="code" optionValue="name"
                                    style="direction: ltr; text-align: left; width: 185px !important"
                                    noSelection="${['null': 'Choose type']}"
                                    onchange="jQuery('#searchForm').load('${request.contextPath}/generics/hqlSearchForm/' + this.value);"
                                    value=""/>


            <br/>

            <span id="searchForm">

            </span>

            <br/>
            Group by:
            <g:select name="groupBy" noSelection="${['null': 'No grouping']}"
                      from="${['department', 'course', 'priority', 'context', 'status', 'type']}"/>
            <br/>
            Sort by:
            <g:select name="sortBy"
                      from="${['id', 'summary', 'status', 'department', 'course', 'type', 'orderNumber', 'dateCreated', 'lastUpdated']}"/>
            <br/>
            Order:
            <g:select name="order"
                      from="${['Asc', 'Desc']}"/>
           Max:
            <g:select name="max" value="3"
                      from="${['1', '3', '5', '10', '20', '50', '100', '500']}"/>
            <br/>

            <g:submitButton class="fg-button ui-icon-left ui-widget ui-state-default ui-corner-all" name="submit"
                            style="height: 30px; width:90%"
                            value="Search"
                            onsubmit="jQuery('#searchResults').html('')"/>

        </g:formRemote>

    </div>

</div>
<script type="text/javascript">

    jQuery('#range_start').val('')
    jQuery('#range_end').val('')

    jQuery("#dateRange1").continuousCalendar({
        "selectToday": false,
        "weeksBefore": "40",//"1/1/2012",
        "weeksAfter": "8",
        "minimumRange": "-1",
        %{--"disabledDates": "${filledInDates}",--}%
        "disabledDatesMy": "${[]}",
        "fadeOutDuration": "0",
        isPopup: false,
        callback: function () {
            jQuery('#centralArea').load('${createLink(controller: 'report', action: 'saveDateSelection')}?date1=' +
                    jQuery('#range_start').val() + '&date2='
                    + jQuery('#range_end').val())//      + '&level=d')
        }
    })



</script>