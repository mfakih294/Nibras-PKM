<div class="taskList" style="margin-left: 20px; margin-right: 20px;">
    %{--todo: dynamic height --}%

    <b>Add task/goal</b>
    <br/>
    <br/>
    <g:formRemote name="addXcdFormDaftar" id="addXcdFormDaftar"
                  url="[controller: 'indexCard', action: 'addXcdFormDaftar']"
                  update="underArea"
                  style="direction: ltr; text-align: left; margin:  2px; padding: 3px 0px; border: 1px solid darkgray; line-height: 30px;"
                  onComplete="jQuery('#summayDaftar').val('');jQuery('#summayDaftar').select();;jQuery('#summayDaftar').focus();"
                  method="post">

        <g:select name="type" from="${['T', 'G']}"
                  id="typeField"
                  style="border-radius: 5px;"
                  tabindex="1"
                  value="T"/>
        &nbsp;
        Priority: <g:select name="priority" from="${(1..5)}"
                        id="priority"
                        tabindex="1"
                        value="${2}"/>
        &nbsp;
        Context: <g:select name="context" id="context" from="${mcs.parameters.Context.list([sort: 'code', order: 'asc'])}"
                       optionKey="id" class="chosen"
                       style="width: 80px !important;"
                       noSelection="${['null': 'Context...']}"
                       optionValue="code"/>
        <br/>
        Goal: <g:select name="goal" id="goal" from="${mcs.Goal.findAllByBookmarked(true, [sort: 'summary', order: 'asc'])}"
                        optionKey="id" class="chosen"
                        style="width: 80px !important;"
                        noSelection="${['null': 'Goal...']}"
                        optionValue="summary"/>
        <br/>
        Course:
        <g:select name="courseNgs" id="courseNgs" from="${mcs.Course.findAll([sort: 'summary', order: 'asc'])}"
                  optionKey="id" class="chosen"
                  noSelection="${['null': 'Course...']}"
                  style="width: 300px !important;" optionValue="summary"/>
        <br/>

    %{--        todo: parametric language list--}%

    %{--<g:select name="language" id="language" class="chosen" from="${['ar', 'en', 'fr', 'fa', 'de']}" value="ar"/>--}%
    %{--<br/>--}%
        <g:textField name="title" value=""
                     tabindex="2" id="summayDaftar"
                     style="background: #f8f9fa; margin: 3px; text-align: right; font-family: Tahoma; font-size: 1em; width: 90% !important;"
                     placeholder="Summary *"
                     class=""/>
    %{--&nbsp;--}%
        <g:submitButton name="save" value="Add"
                        style="text-align: center; padding-left: 8px; padding-right: 8px; display: none;"
                        tabindex="4"
                        id="addXcdFormDaftarSubmit"
                        class="fg-button ui-widget ui-state-default"/>

    %{--        <g:textArea cols="80" rows="12" placeholder="Description / full text ..."--}%
    %{--                    tabindex="3"--}%
    %{--                    name="description" id="descriptionDaftar"--}%
    %{--                    value=""--}%
    %{--                    style="background: #f8f9fa; font-family: tahoma; font-size: small; padding: 3px; width: 95%; height: 80px !important;"/>--}%
    </g:formRemote>

    <div id="underArea" class="common" style="margin: 2px 2px 5px 5px;">
        %{--                <g:render template="/reports/heartbeat" model="[dates: dates]"></g:render>--}%
    </div>

    <h3>Bookmarked tasks without goals</h3>
    <g:render template="/gTemplates/recordListing" model="[list: mcs.Task.findAllByGoalAndBookmarked(null, true)]"></g:render>
    <g:if test="${1 == 2}">
        <g:if test="${notStarted.size() >= 1}">
        %{--<g:render template="/gTemplates/recordListing" model="[list: notStarted ]"></g:render>--}%
            <g:each in="${notStarted.context.unique()}" var="c">
            %{--<h4>@${c}</h4>--}%
                <g:each in="${notStarted.grep{it.context == c}}" var="task" >
                    <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                </g:each>
            </g:each>
        </g:if>
        <g:if test="${inProgress.size() >= 1}">
            <g:each in="${inProgress.context.unique()}" var="c">
                <h4>@${c}</h4>
                <g:each in="${inProgress.grep{it.context == c}}" var="task" >
                    <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                </g:each>
            </g:each>
        </g:if>
        <g:if test="${completed.size() >= 1}">
        %{--<g:render template="/gTemplates/recordListing" model="[list: completed ]"></g:render>--}%
            <g:each in="${completed.context.unique()}" var="c">
                <h4>@${c}</h4>
                <g:each in="${completed.grep{it.context == c}}" var="task" >
                    <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                </g:each>
            </g:each>
        </g:if>
        <g:if test="${overdue.size() >= 1}">
        %{--<h2>Overdue</h2>--}%
        %{--<g:render template="/gTemplates/recordListing" model="[list: overdue ]"></g:render>--}%
            <g:each in="${overdue.context.unique()}" var="c">
            %{--<h4>@${c}</h4>--}%
                <g:each in="${overdue.grep{it.context == c}}" var="task" >
                    <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                </g:each>
            </g:each>
        </g:if>

        <hr/>
        <br/>
    %{--<g:render template="/gTemplates/recordListing" model="[list: pile ]"></g:render>--}%
        <g:each in="${pile.context.unique()}" var="c">
        %{--<h4>@${c}</h4>--}%
            <g:each in="${pile.grep{it.context == c}}" var="task" >
                <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
            </g:each>
        </g:each>

        <hr/>
        <br/>
        <g:render template="/gTemplates/recordListing" model="[list: pile ]"></g:render>
    </g:if>
    <h3>Goals and their tasks</h3>
    <g:each in="${mcs.Goal.findAllByBookmarked(true)}" var="r">
    %{--<h4>@${c}</h4>--}%
    %{--<g:each in="${pile.grep{it.context == c}}" var="task" >--}%
        <g:render template="/gTemplates/recordSummary" model="[record: r]"></g:render>
        <g:render template="/gTemplates/recordListing" model="[list: mcs.Task.findAllByGoalAndBookmarked(r, true)]"></g:render>
    %{--</g:each>--}%
    </g:each>
    %{--<hr/>--}%
    %{--<br/>--}%
    %{--<g:render template="/gTemplates/recordListing" model="[list: pile ]"></g:render>--}%
    %{--<g:each in="${courses}" var="r">--}%
    %{--<h4>@${c}</h4>--}%
    %{--<g:each in="${pile.grep{it.context == c}}" var="task" >--}%
    %{--<g:render template="/gTemplates/recordSummary" model="[record: r]"/>--}%
    %{--</g:each>--}%
    %{--</g:each>--}%

</div>
