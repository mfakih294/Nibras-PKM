<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<style>

    table th {
        font-weight: bold;
        font-size: large;
    }
    table td {
        padding: 7px;
    }

    h2 {
        color: darkgreen;
        font-size: 1.3em;
    }

    h4 {
        color: #0056b3;
        font-size: 1.2em;
        text-align: center;
    }
</style>

%{--${ker.OperationController.getPath('app.headers.background') ?: '#5b7a59'}--}%
<div class="ui-layout-north southRegion appBkg" style="overflow: hidden;"
     style="">
    %{--<g:render template="/layouts/north" model="[]"/>--}%
    %{--    <g:render template="/appKanban/north"/>--}%
</div>

%{--<div class="ui-layout-west westRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">--}%

%{--<div class="ui-layout-content ui-widget-content">--}%

%{--<g:render template="/appKanban/west"/>--}%
%{--</div>--}%

<div class="ui-layout-south footerRegion"
     style="font-size: 11px; margin-top: 9px; min-height: 0px !important;  padding: 3px; direction: ltr; text-align: left; font-family: tahoma; color: white">
    %{--    <g:render template="/appMain/south"/>--}%
</div>


<div class="ui-layout-east eastRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">
    %{--<div class="ui-layout-content ui-widget-content">--}%
    %{--    <g:render template="/appKanban/east"/>--}%
    <div id="3rdPanel" style="background: white; padding: 7px;">
    </div>
</div>


<div class="ui-layout-center appBkg"
     style="margin-top: 2px !important; background: #f6f9f1; margin-bottom: 2px !important; width: 98% !important; overflow: auto"
     onmouseover="jQuery('#hintArea').html('')">
    %{--ToDo: display none?!--}%
    %{--<div class="ui-layout-content ui-widget-content" onmouseover="jQuery('#hintArea').html('')">--}%


    <div id="logRegion"></div>

    <div id="logArea"></div>


    <div id="searchArea" class="nonPrintable">
    </div>

    <div id="spinner2" style="display:none; z-index: 10000 !important">
        <img src="${resource(dir: '/images', file: 'pmg-grain.gif')}" alt="Spinner2"
             style="z-index: 10000 !important"/>
    </div>
    %{--<sec:ifNotGranted roles="ROLE_ADMIN">--}%
    %{--<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
    %{--<g:render template="/layouts/commandbar" model="[]"/>--}%
    %{--</g:if>--}%
    %{--</sec:ifNotGranted>--}%

    <div id="inner1" class="common" style="">

        <div id="centralArea" class="common">
        %{--<h3>T / context</h3>--}%
            <g:if test="${1 == 1}">
                 <g:formRemote name="addXcdFormDaftar" id="addXcdFormDaftar"
                              url="[controller: 'indexCard', action: 'addXcdFormDaftar']"
                              update="underArea"
                              onComplete="jQuery('#summayDaftar').val('');jQuery('#summayDaftar').select();;jQuery('#summayDaftar').focus();"
                              method="post">

                %{--onkeyup="jQuery('#topDaftarArea').load('${request.contextPath}/indexCard/extractTitle/', {'typing': this.value})"--}%
                %{--<code>Format: title (line 1) <br/> details (from line 2 till the end)--}%
                %{--</code>--}%
&nbsp;
&nbsp;
&nbsp;

                     <b>Add task</b>
                     <br/>
                     &nbsp;
                     &nbsp;
                    <g:select name="type" from="${['T', 'G']}"
                              id="typeField"
                              style="display: none;"
                              tabindex="1"
                              value="T"/>
                    &nbsp;
                    @<g:select name="context" id="context" from="${mcs.parameters.Context.list([sort: 'code', order: 'asc'])}"
                              optionKey="id"
                               style="width: 80px !important;"
                               optionValue="code"/>
                    &nbsp;
   <g:select name="courseNgs" id="courseNgs" from="${mcs.Course.findAll([sort: 'department', order: 'desc'])}"
                              optionKey="id" class="chosen"
             noSelection="${['null': 'Course...']}"
             style="width: 300px !important;" optionValue="summary"/>
                    &nbsp;

                %{--        todo: parametric language list--}%

                    <g:select name="language" id="language" from="${['ar', 'en', 'fr', 'fa', 'de']}" value="ar"
                    />

                    &nbsp;
                    <g:textField name="title" value=""
                                 tabindex="2" id="summayDaftar"
                                 style="background: #f8f9fa; padding: 3px; text-align: right; display: inline;  font-family: tahoma; font-size: 1em; min-width: 50% !important;"
                                 placeholder="Summary * "
                                 class=""/>
                    <g:submitButton name="save" value="Add"
                                    style="text-align: center; padding-left: 8px; padding-right: 8px;"
                                    tabindex="4"
                                    id="addXcdFormDaftarSubmit"
                                    class="fg-button ui-widget ui-state-default"/>

                %{--        <g:textArea cols="80" rows="12" placeholder="Description / full text ..."--}%
                %{--                    tabindex="3"--}%
                %{--                    name="description" id="descriptionDaftar"--}%
                %{--                    value=""--}%
                %{--                    style="background: #f8f9fa; font-family: tahoma; font-size: small; padding: 3px; width: 95%; height: 80px !important;"/>--}%
                </g:formRemote>

                <div id="underArea" class="common" style="margin: 12px 12px 30px 0px;">
                    %{--                <g:render template="/reports/heartbeat" model="[dates: dates]"></g:render>--}%
                </div>

                <g:if test="${1 == 2}">

                    <div style="column-count: ${OperationController.getPath('grouping.column.count') ?: 3}; background: #f9fbf4; padding: 5px;">



                        <h2 style="text-align: left; font-size:larger; color: darkred;">Uncategorized
                        (${mcs.Book.executeQuery('select count(*) from Goal p where p.bookmarked = 1 and p.course is null ',
                        )[0] + mcs.Book.executeQuery('select count(*) from Task p where p.bookmarked = 1 and p.course is null ',
                        )[0]+ mcs.Book.executeQuery('select count(*) from IndexCard p where p.bookmarked = 1 and p.course is null ',
                        )[0]})</h2>

                        <g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.course is null order by p.priority desc')}"
                                var="p">
                            <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>
                        </g:each>

                        <g:each in="${mcs.Book.executeQuery('from Task p where p.bookmarked = 1 and p.course is null  order by p.priority desc')}"
                                var="p">
                            <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>
                        </g:each>
                        <g:each in="${mcs.Book.executeQuery('from IndexCard p where p.bookmarked = 1 and p.course is null  order by p.priority desc')}"
                                var="p">
                            <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>
                        </g:each>
                    %{--                <g:each in="${mcs.Book.executeQuery('from Planner p where p.bookmarked = 1')}"--}%
                    %{--                        var="p">--}%
                    %{--                    <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>--}%
                    %{--                </g:each>--}%
                    %{--                <g:each in="${mcs.Book.executeQuery('from Journal p where p.bookmarked = 1')}"--}%
                    %{--                        var="p">--}%
                    %{--                    <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>--}%
                    %{--                </g:each>--}%



                        <g:each in="${courses}" var="d">
                        %{--                    =${d?.code}--}%
                            <h2 style="text-align: left; font-size:larger; color: darkred">${d.summary} (${mcs.Book.executeQuery('select count(*) from Goal p where p.bookmarked = 1 and p.course = ?',
                                    [d])[0] + mcs.Book.executeQuery('select count(*) from Task p where p.bookmarked = 1 and p.course = ?',
                                    [d])[0]+ mcs.Book.executeQuery('select count(*) from IndexCard p where p.bookmarked = 1 and p.course = ?',
                                    [d])[0]})</h2>

                        %{--                    <g:each in="${mcs.Book.executeQuery('from Course p where p.bookmarked = 1 and p.course = ? order by orderNumber asc',--}%
                        %{--                            [d])}"--}%
                        %{--                            var="p">--}%
                        %{--                        <g:render template="/gTemplates/box" model="[record: p]"></g:render>--}%
                        %{--                    </g:each>--}%

                            <g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.course = ? order by p.priority desc',
                                    [d])}"
                                    var="p">
                                <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>
                            </g:each>

                            <g:each in="${mcs.Book.executeQuery('from Task p where p.bookmarked = 1 and p.course = ? order by p.priority desc',
                                    [d])}"
                                    var="p">
                                <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>
                            </g:each>

                            <g:each in="${mcs.Book.executeQuery('from IndexCard p where p.bookmarked = 1 and p.course = ? order by p.priority desc',
                                    [d])}"
                                    var="p">
                                <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>
                            </g:each>
                        %{--                    <g:each in="${mcs.Book.executeQuery('from Planner p where p.bookmarked = 1 and p.course = ?',--}%
                        %{--                            [d])}"--}%
                        %{--                            var="p">--}%
                        %{--                        <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>--}%
                        %{--                    </g:each>--}%
                        %{--                    <g:each in="${mcs.Book.executeQuery('from Journal p where p.bookmarked = 1 and p.course = ?',--}%
                        %{--                            [d])}"--}%
                        %{--                            var="p">--}%
                        %{--                        <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>--}%
                        %{--                    </g:each>--}%
                        %{--  <g:each in="${mcs.Book.executeQuery('from Book p where p.bookmarked = 1 and p.course = ? and p.priority >= 4',--}%
                        %{--                            [d])}"--}%
                        %{--                            var="p">--}%
                        %{--                        <g:render template="/gTemplates/recordSummary" model="[record: p]"></g:render>--}%
                        %{--                    </g:each>--}%


                        </g:each>

                    </div>
                </g:if>
            </g:if>


            <table border="1" style="margin: 10px; width: 98%; border: #496779; border-collapse: collapse;">
                <thead>
                <th>Todo</th>
                <th colspan="3">Today</th>

                </thead>
            <tr>
                <td></td>
                <td>Not started</td>
                <td>In progress</td>
                <td>Completed</td>
            </tr>
                <tr>
                    <td style="vertical-align: top">
                        <br/>
                        <h2>Overdue</h2>
                        <br/>
                        %{--<g:render template="/gTemplates/recordListing" model="[list: overdue ]"></g:render>--}%
                        <g:each in="${overdue.context.unique()}" var="c">
                            <h4>@${c}</h4>
                            <g:each in="${overdue.grep{it.context == c}}" var="task" >
                                <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                            </g:each>
                        </g:each>
                        <br/>
                    <h2>Pile</h2>
                        <br/>
                        %{--<g:render template="/gTemplates/recordListing" model="[list: pile ]"></g:render>--}%
                        <g:each in="${pile.context.unique()}" var="c">
                            <h4>@${c}</h4>
                            <g:each in="${pile.grep{it.context == c}}" var="task" >
                                <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                            </g:each>
                        </g:each>
                    </td>
                    <td style="vertical-align: top">
                             %{--<g:render template="/gTemplates/recordListing" model="[list: notStarted ]"></g:render>--}%

                        <g:each in="${notStarted.context.unique()}" var="c">
                            <h4>@${c}</h4>
                            <g:each in="${notStarted.grep{it.context == c}}" var="task" >
                                <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                            </g:each>
                        </g:each>

                        </td>
                    <td style="vertical-align: top">


                        <g:each in="${inProgress.context.unique()}" var="c">
                            <h4>@${c}</h4>
                        <g:each in="${inProgress.grep{it.context == c}}" var="task" >
                            <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                        </g:each>
                        </g:each>


                    </td>
                    <td style="vertical-align: top">
                             %{--<g:render template="/gTemplates/recordListing" model="[list: completed ]"></g:render>--}%
                        <g:each in="${completed.context.unique()}" var="c">
                            <h4>@${c}</h4>
                            <g:each in="${completed.grep{it.context == c}}" var="task" >
                                <g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>
                            </g:each>
                        </g:each>

                    </td>
                </tr>
            </table>


            <g:if test="${1 == 2}">
                <table border="1" style="margin: 10px; width: 98%; border: #496779; border-collapse: collapse;">
                    <thead>
                    <th>T*</th>
                    <g:each in="${mcs.Task.executeQuery('select t.context from Task t where t.bookmarked = 1 group by t.context  order by t.context.code')}"
                            var="d">
                        <th>@<b>${d.code}</b></th>
                    </g:each>
                    </thead>
                    <tr>
                        <td style="background: darkgreen"></td>
                        <g:each in="${mcs.Task.executeQuery('select t.context from Task t where t.bookmarked = 1 group by t.context  order by t.context.code')}"
                                var="d">
                            <td id="kanban">
                                <g:each in="${mcs.Book.executeQuery('from Task p where p.bookmarked = 1 and p.context = ? order by orderInCourse asc',
                                        [d])}"
                                        var="p">
                                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                                </g:each>
                            </td>
                        </g:each>
                    </tr>
                </table>

            </g:if>

            <g:if test="${1 == 2}">
                <h2>T* G* C* / D*</h2>
                <table border="1" style="margin: 10px; width: 98%; border: #496779; border-collapse: collapse;">

                    <thead>
                    <th>\ D*</th>
                    <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
                        <th>d<b>${d.code}</b></th>
                    </g:each>
                    <th>d-</th>
                    </thead>

                    %{--     <tr>
                             <td style="background: #d4edda">R*</td>
                             <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
                                 <td>
                                     <g:each in="${mcs.Book.executeQuery('from Book p where p.bookmarked = 1 and p.type.code = ? and p.course.department = ? order by orderInCourse asc',
                                             ["ebk", d])}"
                                             var="p">
                                         <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                                     </g:each>
                                 </td>
                             </g:each>
                         </tr>--}%
                    <tr>
                        <td style="background: #fff3cd">T*</td>
                        <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
                            <td>
                                <g:each in="${mcs.Book.executeQuery('from Task p where p.bookmarked = 1 and p.department = ?',
                                        [d])}"
                                        var="p">
                                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                                </g:each>
                            </td>
                        </g:each>
                        <td>
                            <g:each in="${mcs.Book.executeQuery('from Task p where p.bookmarked = 1 and p.department is null',
                                    [])}"
                                    var="p">
                                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                            </g:each>
                        </td>
                    </tr>

                    <tr>
                        <td style="background: #fff3cd">G*</td>
                        <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
                            <td>
                                <g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.department = ?',
                                        [d])}"
                                        var="p">
                                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                                </g:each>
                            </td>
                        </g:each>
                        <td>
                            <g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.department is null',
                                    [])}"
                                    var="p">
                                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                            </g:each>
                        </td>
                    </tr>
                    <tr>
                        <td style="background: #d3e0d3">C*</td>
                        <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
                            <td>
                                <g:each in="${mcs.Book.executeQuery('from Course p where p.bookmarked = 1 and p.department = ? and p.priority = 4 order by orderNumber asc',
                                        [d])}"
                                        var="p">
                                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                                </g:each>

                            </td>

                        </g:each>
                        <td>-</td>
                    </tr>

                </table>
            </g:if>

        </div>


        %{--<span class="focusPSouth" style="text-align: right !important; direction: rtl !important;"--}%
        %{--title="${Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', ['knb'])[0]?.description}">--}%
        %{--<h5>Last plan</h5>--}%
        %{--<g:render template="/gTemplates/recordSummary" model="[record: Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', [OperationController.getPath('planner.homepage.default-type')],[max: 1])[0]]"></g:render>--}%

        %{--</span>--}%

        %{--<g:if test="${!new File(OperationController.getPath('root.rps1.path')).exists()}">--}%
        %{--<br/>--}%
        %{--<br/>--}%
        %{--Repository folder not found. Please choose an existing folder:--}%
        %{--<br/>--}%
        %{--<g:render template="/forms/updateSetting" model="[settingValue: 'root.rps1.path']"/>--}%
        %{--</g:if>--}%


        %{--<g:if test="${ker.GenericsController.countRecentRecordsStatic() == 0}">--}%
        %{--<g:render template="/layouts/message" model="[messageCode: 'help.recent.records.no']"/>--}%
        %{--</g:if>--}%
    </div>





    %{--<br/>--}%

    %{--first commented one below was in action 14.03.2019 --}%
    %{--<g:formRemote name="batchAdd2"  class="commandBarInPanel"--}%
    %{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
    %{--update="centralArea" style="display: inline"--}%
    %{--before="jQuery('#testTitle4').text('[4]: ' + jQuery('#testField4').val());"--}%
    %{--method="post">--}%
    %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
    %{--<g:submitButton name="batch" value="Execute"--}%
    %{--style="height: 30px; margin: 0px; width: 100px !important; display: none"--}%
    %{--id="quickAddXcdSubmitTop5"--}%
    %{--class="fg-button ui-widget ui-state-default"/>--}%

    %{--<g:textField name="input"  value="" id="testField4"--}%
    %{--autocomplete="off"--}%
    %{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
    %{--placeholder=""--}%
    %{--class="commandBarTexFieldTop"/>--}%
    %{--</g:formRemote>--}%




    %{--<g:formRemote name="batchAdd2"--}%
    %{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
    %{--update="centralArea" style="display: inline"--}%
    %{--method="post">--}%
    %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
    %{--<g:submitButton name="batch" value="Execute"--}%
    %{--style="height: 20px; margin: 0px; width: 100px !important; display: none"--}%
    %{--id="quickAddXcdSubmitTop6"--}%
    %{--class="fg-button ui-widget ui-state-default"/>--}%

    %{--<g:textField name="input"  value=""--}%
    %{--autocomplete="off"--}%
    %{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
    %{--placeholder=""--}%
    %{--class="commandBarTexFieldTop"/>--}%
    %{--</g:formRemote>--}%

    %{--<g:formRemote name="batchAdd2"--}%
    %{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
    %{--update="centralArea" style="display: inline"--}%
    %{--method="post">--}%
    %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
    %{--<g:submitButton name="batch" value="Execute"--}%
    %{--style="height: 20px; margin: 0px; width: 100px !important; display: none"--}%
    %{--id="quickAddXcdSubmitTop7"--}%
    %{--class="fg-button ui-widget ui-state-default"/>--}%

    %{--<g:textField name="input" value=""--}%
    %{--autocomplete="off"--}%
    %{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
    %{--placeholder=""--}%
    %{--class="commandBarTexFieldTop"/>--}%
    %{--</g:formRemote>--}%


    %{--<h6 style="text-aling: center"><a href="#" id="testTitle5">--}%
    %{--5--}%
    %{--</a></h6>--}%

    %{--<div id=5 class="common" style="">--}%
    %{--<div id="inner5" class="common" style="">--}%
    %{--</div>--}%

    %{--<g:formRemote name="batchAdd5"  class="commandBarInPanel"--}%
    %{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
    %{--update="centralArea" style="display: inline"--}%
    %{--before="jQuery('#testTitle5').text('[5]: ' + jQuery('#testField5').val());"--}%
    %{--method="post">--}%
    %{--<g:hiddenField name="sth5" value="${new java.util.Date()}"/>--}%
    %{--<g:submitButton name="batch" value="Execute"--}%
    %{--style="height: 30px; margin: 0px; width: 100px !important; display: none"--}%

    %{--id="quickAddXcdSubmitTop8"--}%
    %{--class="fg-button ui-widget ui-state-default"/>--}%

    %{--<g:textField name="input"  value=""--}%
    %{--autocomplete="off"--}%
    %{--id="testField5"--}%
    %{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
    %{--placeholder=""--}%
    %{--class="commandBarTexFieldTop"/>--}%
    %{--</g:formRemote>--}%

    %{--</div>--}%

</div>
%{--<hr/>--}%
%{--before="jQuery('#testTitle1').text('[1]: ' + jQuery('#quickAddTextFieldBottomTop').val());"--}%
%{--if (jQuery('#quickAddTextFieldBottomTop').val().search('--')== -1){--}%
%{--<div style="-moz-column-count: 3; -webkit-column-count:3">--}%
<div id="hintArea" style="font-size: 12px; padding: 0px; margin: 0px; "></div>
%{--</div>--}%

</div>
<script type="text/javascript">
    jQuery(".chosen").chosen({allow_single_deselect: true, search_contains: true, no_results_text: "None found"});
    jQuery("#chosenTags").chosen({allow_single_deselect: true, no_results_text: "None found"});
    jQuery("#chosenTagsArt").chosen({allow_single_deselect: true, no_results_text: "None found"});

    //    jQuery("#addXcdFormNgs").relatedSelects({
    //        onChangeLoad: '${request.contextPath}/generics/fetchCoursesForDepartment',
    //        defaultOptionText: '',
    //        selects: {
    //            'department.id': {loadingMessage: ''},
    //            'course.id': {loadingMessage: ''}
    //        }
    //    });

    jQuery("#addArticleFormNgs").relatedSelects({
        onChangeLoad: '${request.contextPath}/generics/fetchCoursesForDepartment',
        defaultOptionText: '',
        selects: {
            'department.id': {loadingMessage: ''},
            'course.id': {loadingMessage: ''}
        }
    });
    jQuery("#addXcdFormNgs").relatedSelects({
        onChangeLoad: '${request.contextPath}/generics/fetchWritingsForCourse',
        defaultOptionText: '',
        selects: {
            'course.id': {loadingMessage: ''},
            'writing.id': {loadingMessage: ''}
        }
    });

    jQuery('#chosenTags_chzn').addClass('width95')
    jQuery('#chosenTagsArt_chzn').addClass('width95')


    var clearFormFields = function () {

        jQuery('#title').val('')
        jQuery('#summary').val('')
        jQuery('#description').val('')
        jQuery('#fullText').val('')
        jQuery('#link').val('')
        jQuery('#url').val('')
        jQuery('#approximateDate').clear()
    }


    $(".common").prev('h6').click(function () {
        document.getElementById("centralArea").setAttribute("id", "tmpId");
        //$(this).id//.nextSibling().setAttribute("id", "centralArea");
//        console.log(document.getElementById($(this).next().attr("id")).attr("id"))
        //$(this).next()[0].firstChild.setAttribute("id", "centralArea");
        $(this).next()[0].firstChild.nextSibling.setAttribute("id", "centralArea");
        //console.log($(this).next().attr('id'));


        //alert(currentID);

//        $(this).next().setAttribute("id", "centralArea");

    });

    //    setTimeout(location.reload(), 300000);  // executed once
    //    setTimeout(function() {
    //        window.location.href = window.location;
    //    }, 300000);

</script>