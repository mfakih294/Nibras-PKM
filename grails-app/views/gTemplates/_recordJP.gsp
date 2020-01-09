<%@ page import="mcs.parameters.PlannerType; mcs.parameters.JournalType" %>
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


<div class="recordDetailsBody" style="margin: 5px;" id="detailsRegion${entityCode}${record.id}">


<g:if test="${'CTGREW'.contains(entityCode)}">
    <h3>Add planner</h3>
        <g:formRemote name="scheduleTask" url="[controller: 'task', action: 'assignRecordToDate']"
                      style="display: inline;" update="detailsRegion${entityCode}${record.id}"
                      method="post">
            <!-- Type/Level/Weight -->

            %{--<g:select name="type" from="['J', 'P']" value="P"/>--}%
            <g:hiddenField name="type" value="P"/>
            l<g:select name="level" from="['l', 'e', 'y', 'A', 'M', 'r', 'w', 'd', 'm']" value="m"/>
            p<g:select name="priority" from="${1..4}" value="3" title="priority"/>
            #<g:select name="type.id"
                      from="${mcs.parameters.PlannerType.list([sort: 'code'])}"
                      value="${mcs.parameters.PlannerType.findByCode('assign').id}"
                      optionKey="id" optionValue="code"
                      title="Type"/>
            (<input type="text" name="date" title="Format: wwd [hh]" placeholder="Date"
                   style="width: 70px;"
                   value="${mcs.UtilsController.toWeekDate(new Date() + 1)}_15"/>
            ) <input type="text" name="endDate" title="Format: wwd [hh]" placeholder="End date"
                     style="width: 70px;"
                     value="${mcs.UtilsController.toWeekDate(new Date())}_${new Date().format('HH').toInteger() + 1}"/>

            <input type="text" name="summary" title="" placeholder="Summary"
                   style="width: 300px;"
                   value=""/>


            <g:hiddenField name="recordType" value="${entityCode}"/>
            <g:hiddenField name="recordId" value="${record.id}"/>
            <g:submitButton name="scheduleTask" value="ok" style="display: none;"
                            class="fg-button ui-widget ui-state-default ui-corner-all"/>
        </g:formRemote>
   <br/>
   <br/>
    <h3>Add journal</h3>
      <g:formRemote name="scheduleTask" url="[controller: 'task', action: 'assignRecordToDate']"
                      style="display: inline;" update="detailsRegion${entityCode}${record.id}"
                      method="post">
            <!-- Type/Level/Weight -->

            %{--<g:select name="type" from="['J', 'P']" value="J"/>--}%
          <g:hiddenField name="type" value="J"/>
            l <g:select name="level" from="['l', 'e', 'y', 'M', 'r', 'w', 'd', 'm']" value="m"/>
            p <g:select name="priority" from="${1..4}" value="3" title="priority"/>
            #<g:select name="type.id" from="${mcs.parameters.JournalType.list([sort: 'code'])}"
                      value="${JournalType.findByCode('act').id}"
                      optionKey="id" optionValue="code"
                      title="Type"/>
            (<input type="text" name="date" title="Format: wwd [hh]" placeholder="Date"
                   style="width: 70px;"
                   value="${mcs.UtilsController.toWeekDate(new Date())}_${new Date().format('HH')}"/>


         ) <input type="text" name="endDate" title="Format: wwd [hh]" placeholder="End date"
                 style="width: 70px;"
                 value="${mcs.UtilsController.toWeekDate(new Date())}_${new Date().format('HH').toInteger() + 1}"/>


            <input type="text" name="summary" title="" placeholder="Summary"
                   style="width: 300px;"
                   value=""/>


            <g:hiddenField name="recordType" value="${entityCode}"/>
            <g:hiddenField name="recordId" value="${record.id}"/>
            <g:submitButton name="scheduleTask" value="ok" style="display: none;"
                            class="fg-button ui-widget ui-state-default ui-corner-all"/>
        </g:formRemote>

    </g:if>

</div>