<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<div id="accordionEast" class="basic">

    <h3><a href="#">
        <g:message code="ui.details"></g:message>
    </a></h3>

    <div id="3rdPanel">


        %{--<uploadr:add id="addToRecordFolder"--}%
                           %{--url="${[controller: 'import', action: 'addToRecordFolder2']}"--}%
                           %{--params="${[recordId: '12']}">--}%
            %{--Add to record folder   ============--}%
        %{--</uploadr:add>--}%


        %{--<div >--}%

        %{--</div>--}%

        <br/>
        <hr/>

        %{--Todo--}%
        <br/>






        %{--params="[variableTwo: 'foo', variableThree: 'bar', variableFour: 4, myObject: someObject]"--}%
        %{--             model="[booleanOne:true, variableTwo: 'foo', variableThree: 'bar', variableFour: 4, myObject: someObject]"--}%

    </div>



    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<h3><a href="#">--}%
    %{--<g:message code="ui.sandbox"></g:message>--}%

    %{--</a></h3>--}%

    %{--<div id='sandboxPanel'>--}%

    %{--</div>--}%
    %{--</sec:ifAnyGranted>--}%

    %{--<h4>Add records</h4>--}%
    %{--<hr/>--}%

    <h3 class="accordionPanelAdd" style="margin-top: 5px;"><a href="#">
        <g:message code="ui.add"></g:message>
    </a></h3>

    <div id=''>
        <div class="panelCard">
        <h4>Using sheet:</h4>

        <ul style="list-style: square; column-count: 2">
            <g:if test="${ker.OperationController.getPath('indicators.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <li><g:remoteLink controller="report" action="indicatorPanorama"
                                  update="centralArea"
                                  title="Update indicators">
                    <g:message code="ui.indicators"></g:message>
                </g:remoteLink></li>

            </g:if>

            <g:if test="${OperationController.getPath('payments.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <li><g:remoteLink controller="report" action="paymentPanorama"
                                  update="centralArea"
                                  title="Enter recent payments">
                    Payments
                </g:remoteLink></li>
            </g:if>
            <li>
                <g:remoteLink controller="report" action="enterTasksWithContext"
                              update="centralArea"
                              title="Enter new tasks">
                    Tasks
                </g:remoteLink>

            </li>
            <li>
                <g:remoteLink controller="report" action="enterJournalWithType"
                              update="centralArea"
                              title="Enter new journal entries">
                    Journal
                </g:remoteLink>

            </li>

        </ul>

          </div>


        <div class="panelCard">

        <h4>Using forms:</h4>


        <span style="column-count: 2">
            <ul style="list-style: square; column-count: 2">

                <g:each in="${
                    [
                            [enabled: OperationController.getPath('goals.enabled')?.toLowerCase() == 'yes', code: 'G', name: 'Goals', controller: 'mcs.Goal'],
                            [enabled: OperationController.getPath('tasks.enabled')?.toLowerCase() == 'yes', code: 'T', name: 'Tasks', controller: 'mcs.Task'],
                            [enabled: OperationController.getPath('planner.enabled')?.toLowerCase() == 'yes', code: 'P', name: 'Planner', controller: 'mcs.Planner'],
                            [enabled: OperationController.getPath('journal.enabled')?.toLowerCase() == 'yes', code: 'J', name: 'Journal', controller: 'mcs.Journal'],
                            [enabled: OperationController.getPath('indicators.enabled')?.toLowerCase() == 'yes', code: 'I', name: 'Indicator', controller: 'app.IndicatorData'],
                            [enabled: OperationController.getPath('Payment.enabled')?.toLowerCase() == 'yes', code: 'Q', name: 'Payment', controller: 'app.Payment'],
                            [enabled: OperationController.getPath('writings.enabled')?.toLowerCase() == 'yes', code: 'W', name: 'Writing', controller: 'mcs.Writing'],
                            [enabled: OperationController.getPath('notes.enabled')?.toLowerCase() == 'yes', code: 'N', name: 'Notes', controller: 'app.IndexCard',],
                            [enabled: OperationController.getPath('resources.enabled')?.toLowerCase() == 'yes', code: 'R', name: 'Resources', controller: 'mcs.Book'],
                            [enabled: OperationController.getPath('contacts.enabled')?.toLowerCase() == 'yes', code: 'S', name: 'Contact', controller: 'app.Contact']
                    ].grep { it.enabled == true }
                }"
                        var="i">
                %{--todo--}%

                    <g:remoteLink controller="generics" action="fetchAddForm"
                                  params="[entityController: i.controller, updateRegion: 'centralArea']"
                                  update="centralArea">
                        <li>
                            <span style="font-size: 12px; padding: 2px;">
                                ${i.name} (${i.code})
                            </span>
                        </li>
                    </g:remoteLink>

                </g:each>
            </ul>

        </span>

            </div>

        <div class="panelCard">

        <h4>By importing files named in Nibras format:</h4>

        <ul>

            <li>

                <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <g:remoteLink controller="import" action="importLocalFiles"
                                  update="centralArea"
                                  before="jQuery.address.value(jQuery(this).attr('href'));"
                                  title="Import local files">
                        Import files (in <b>${OperationController.getPath('root.rps1.path')}</b>)
                    </g:remoteLink>
                </g:if>
            </li>
        </ul>
</div>
    </div>

    <h3 class="accordionPanelAdd"><a href="#">
        <g:message code="ui.add.full.art"></g:message>

    </a></h3>

    <div id='addArticle'>

        <g:formRemote name="addArticleFormNgs" id="addArticleFormNgs"
                      url="[controller: 'indexCard', action: 'addArticleFormNgs']"
                      update="centralArea"
                      method="post">

            <g:select name="language" from="${['ar', 'fr', 'en', 'de', 'fa']}"
                      id="language"
                      value="ar"
                      noSelection="${['null': '']}"/>
            <g:select name="priority" from="${(1..4)}"
                      id="priorityArticle"
                      value="${2}"/>

            <g:select name="department.id" from="${Department.list([sort: 'code'])}"
                      optionKey="id" id="department"
                      optionValue="code"
                      noSelection="${['null': '']}"/>

            <g:select name="course.id" from="${Course.list()}"
                      optionKey="id" class="chosen" id="course"
                      optionValue="summary"
                      noSelection="${['null': '']}"/>
            <br/>
            <pkm:datePicker name="publishedOn" placeholder="Date" id="34563453" value="${new Date()}"/>
        %{--~<g:checkBox name="approximateDate" id="approximateDate" value=""/>--}%


            <g:select name="type.id" from="${app.parameters.ResourceType.list([sort: 'code'])}"
                      optionKey="id" class="chosen chosen-rtl" id="type"
                      optionValue="name"
                      value="${ResourceType.findByCode('art')?.id}"
                      noSelection="${['null': '']}"/>



            <a onclick="clearFormFields()">Clear</a>
            <br/>
            <g:textField placeholder="Title" name="title" id="title" value=""
                         style="background: #e8efe7; width: 100%;" dir="auto"/>

            <g:textArea cols="80" rows="12" placeholder="Full text" name="fullText" id="fullText"
                        value="" dir="auto"
                        style="font-family: tahoma; font-size: small; background: #f7fff6; width: 100%; height: 200px !important;"/>
            <br/>

            <g:textField placeholder="url" name="url" id="url" value="" style="width: 100%;"/>
        %{--NR: <g:textField placeholder="sourceFree" name="sourceFree" id="sourceFree" value="" style="width: 100%;"/>--}%

            <br/>
            <br/>
        %{--<g:select name="chosenTagsArt" from="${Tag.list()}" multiple=""--}%
        %{--size="80" style="min-width: 200px; min-height: 40px;"--}%
        %{--value="" optionKey="id"--}%
        %{--class="chosen chosen-rtl" id="chosenTagsArt"--}%
        %{--optionValue="name"--}%
        %{--noSelection="${['null': '']}"/>--}%
        %{----}%
        %{--<br/>--}%
        %{--<br/>--}%

            <g:submitButton name="save" value="Save"
                            style="height: 25px; margin: 0px; width: 100% !important; background: #efece0"
                            id="4568734523"
                            class="fg-button ui-widget ui-state-default"/>
        </g:formRemote>

    </div>


    <h3 class="accordionPanelAdd"><a href="#">
        <g:message code="ui.add.full.note"></g:message>

    </a></h3>

    <div id='addXcd'>

        <g:formRemote name="addXcdFormNgs" id="addXcdFormNgs"
                      url="[controller: 'indexCard', action: 'addXcdFormNgs']"
                      update="centralArea"
                      onComplete="clearFormFields()"
                      method="post">

            <g:select name="language" from="${['ar', 'fr', 'en', 'de', 'fa']}"
                      id="language"
                      value="ar"
                      noSelection="${['null': '']}"/>

            <g:select name="priority" from="${(1..4)}"
                      id="priorityNote"
                      value="${2}"/>


            <g:select name="department.id" from="${Department.list([sort: 'code'])}"
                      optionKey="id" id="department"
                      optionValue="code"
                      noSelection="${['null': 'd-']}"/>

            <g:select name="course.id"
                      from="${Course.executeQuery('from Course c where c.bookmarked = true order by c.department.orderNumber asc, c.orderNumber asc')}"
                      optionKey="id"
                      id="courseNote"
                      class="chosen chosen-rtl"
                      optionValue="summary"
                      noSelection="${['null': 'No course']}"/>
            <br/>
            <pkm:datePicker name="writtenOn" placeholder="Date" id="34563453" value="${new Date()}"/>
        %{--~<g:checkBox name="approximateDate" id="approximateDate" value=""/>--}%

            <g:select name="type.id" from="${WritingType.list([sort: 'code'])}"
                      optionKey="id"
                      id="typeNote"
                      class="chosen chosen-rtl"
                      optionValue="code"
                      value="${WritingType.findByCode('usr')?.id}"
                      noSelection="${['null': 'No type']}"/>

            <a onclick="clearFormFields()">Clear</a>

            <br/>

        %{--<g:select name="writing.id"--}%
        %{--from="${Writing.executeQuery('from Writing w where w.course.bookmarked = ? order by w.course.department.orderNumber asc, w.course.orderNumber asc, w.orderNumber asc', [true])}"--}%
        %{--optionKey="id"--}%
        %{--id="writingNote"--}%
        %{--optionValue="summary"--}%
        %{--class="chosen chosen-rtl"--}%
        %{--style="width: 48%; text-align: right; direction:rtl"--}%
        %{--value="${null}"--}%
        %{--noSelection="${['null': 'No writing']}"/>--}%
        %{----}%



        %{--<g:select name="contact.id"--}%
        %{--from="${app.Contact.executeQuery('from Contact c order by c.summary asc')}"--}%
        %{--optionKey="id"--}%
        %{--id="contactNote"--}%
        %{--optionValue="summary"--}%
        %{--class="chosen chosen-rtl"--}%
        %{--style="width: 48%; text-align: right; direction:rtl"--}%
        %{--value="${null}"--}%
        %{--noSelection="${['null': '']}"/>--}%


        %{----}%
        %{--<br/>--}%
        %{--<g:select name="book.id"--}%
        %{--from="${Book.executeQuery('from Book r where r.status.code = ? order by r.course.department.orderNumber asc, r.course.orderNumber asc, r.orderNumber asc', ['mkt'])}"--}%
        %{--id="bookId"--}%
        %{--optionKey="id"--}%
        %{--optionValue="title"--}%
        %{--class="chosen chosen-rtl"--}%
        %{--style="width: 99%; text-align: right; direction:rtl"--}%
        %{--value="${null}"--}%
        %{--noSelection="${['null': '']}"/>--}%

        %{----}%

            <g:textField placeholder="Summary" name="summary" id="summary" value=""
                         style="background: #e8efe7; width: 100%; ;" dir="auto"/>

            <g:textArea cols="80" rows="12" placeholder="Description" name="description" id="description"
                        value="" dir="auto"
                        style="font-family: tahoma; font-size: small; background: #f7fff6; width: 100%; height: 150px !important;"/>
            <br/>

            R ID: <g:textField placeholder="book.id" name="book.id" id="book.id" value="" style="width: 70%;"/>

            Pg. <g:textField placeholder="pages" name="pages" id="pages" value="" style="width: 30%;"/>
            <br/>
            <g:textField placeholder="url" name="url" id="url" value="" placehoder="url" style="width: 100%;"/>
        %{--<br/>--}%
        %{--<br/>--}%
        %{--<g:select name="chosenTags" from="${Tag.list()}" multiple=""--}%
        %{--size="80" style="min-width: 200px; min-height: 50px;"--}%
        %{--value="" optionKey="id"--}%
        %{--class="chosen chosen-rtl" id="chosenTags"--}%
        %{--optionValue="name"--}%
        %{--noSelection="${['null': '']}"/>--}%

            <br/>

            <g:submitButton name="save" value="Save"

                            style="height: 35px; margin: 0px; width: 100% !important; background: #efece0"
                            id="45634523"
                            class="fg-button ui-widget ui-state-default"/>
        </g:formRemote>

    </div>


    %{--<h3 class="accordionPanelAdd"><a href="#">--}%
        %{--<g:message code="ar.daftar"></g:message>--}%
    %{--</a></h3>--}%

    %{--<div id='daftarDiv'>--}%

        %{--<span id="topDaftarArea"--}%
              %{--style="font-style: italic; padding-right: 15px; text-align: right; font-size: small; color: darkgreen">--}%

        %{--</span>--}%


        %{--<br/>--}%

        %{--<a onclick="openNoteTaker()" href="javascript:void(0);" target="_self">--}%
        %{--&nearr;--}%
        %{--&nearr;--}%
            %{--Open in a dedicated window.--}%
        %{--</a>--}%

    %{--</div>--}%


    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<h4>Configuration</h4>--}%
    %{--<hr/>--}%
    <h3 class="accordionPanelSettings" style="margin-top: 5px;"><a href="#">
        <g:message code="ui.settings"></g:message>

    </a></h3>


    <div>

        <ul class="settingsUL">
            <li>
                Configuration
                <ul>
                    <li>
                        <g:remoteLink controller="page" action="settingsMain" update="centralArea">
                            Main settings list (${Setting.countByBookmarked(true)})
                        </g:remoteLink>

                    </li>
                    <li>
                        <g:remoteLink controller="page" action="settingsFull" update="centralArea">
                            Full settings list (${Setting.count()})
                        </g:remoteLink></li>

                    <li>

                        <g:render template="/layouts/manageParametersLink"
                                  model="[controller: 'app.parameters.CommandPrefix', name: 'Command prefix']"/>
                    </li>
                    <li>
                        <g:render template="/layouts/manageParametersLink"
                                  model="[controller: 'mcs.parameters.SavedSearch', name: 'Saved search']"/>
                    </li>
                    <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                        <li>
                            <g:render template="/layouts/manageParametersLink"
                                      model="[controller: 'cmn.Setting', name: 'Setting']"/>
                        </li>
                    </g:if>
                </ul>

            </li>



            %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
            %{--<td>--}%
            %{--<input type="radio" name="myRadios" onchange="singleDisplay();" value="Single" />--}%
            %{--<input type="radio" name="myRadios" onchange="dualDisplay();" value="dual display" />--}%
            %{--<a id="singleDisplay"--}%
            %{--title="Single display">--}%
            %{--Single--}%
            %{--&nbsp;--}%
            %{--&nbsp;--}%
            %{--<a id="dualDisplay"--}%
            %{--title="Dual display">--}%
            %{--dual display--}%
            %{--</a>--}%
            %{--</td>--}%



            <li>
                Execute code
                <ul>
                    <li>

                        <a href="${createLink(controller: 'console')}" target="_blank">

                            <g:message code="ui.console"></g:message>
                        </a>
                    </li>
                </ul>
                %{--</sec:ifAnyGranted>--}%


            <li>
                Record presentation
                <ul>
                    <li>
                        <g:remoteLink controller="report" action="showLine1Only"
                                      update="logArea"
                                      title="Selected records">
                            <g:if test="${session['showLine1Only'] == 'on'}">
                                <b>summarized</b>
                            </g:if>
                            <g:else>
                                summarized
                            </g:else>
                        </g:remoteLink>
                    </li>
                    <li><g:remoteLink controller="report" action="showFullCard"
                                      update="logArea"
                                      title="Selected records">
                        <g:if test="${session['showFullCard'] == 'on'}">
                            <b>full</b>
                        </g:if>
                        <g:else>
                            full
                        </g:else>
                    </g:remoteLink>
                    </li>
                </ul>

            </li>



            <li>
                Folders availability
                <ul>
                    <li>
                        <pkm:checkFolder name='rps2' path="${OperationController.getPath('root.rps2.path')}"/>

                    </li>
                    <li>
                        <pkm:checkFolder name='rps3' path="${OperationController.getPath('root.rps3.path')}"/>

                    </li>
                    <li>
                        <pkm:checkFolder name='edit' display='Edit'
                                         path="${OperationController.getPath('editBox.path')}"/>
                    </li>
                </ul>

            </li>



            <li>
                Records per page
                <ul>
                    <li>
                        <g:select name="resultType"
                                  from="${[1, 2, 3, 4, 5, 7, 10, 15, 20, 30, 40, 50, 100, 250]}"
                                  style="direction: ltr; text-align: left; padding: 0; margin: 0;  height: 24px;"
                                  noSelection="${['null': '']}"
                                  onchange="jQuery('#notificationArea').load('${request.contextPath}/generics/setPageMax/' + this.value);"
                                  value="${Setting.findByNameLike('savedSearch.pagination.max.link')?.value ?: 4}"/>
                        <span id="notificationArea" style=""></span>
                        <span style="display: none" id="notificationAreaHidden"></span>

                    </li>
                </ul>

            </li>

        </ul>
        <br/>
        %{--<li>--}%
        <b>Change repositories paths:</b>
        <br/>
        %{--<ul>--}%
        %{--<li>--}%
        rps1.path: <g:render template="/forms/updateSetting" model="[settingValue: 'root.rps1.path']"/>
        <br/>
        %{--</li>--}%

        %{--<li>--}%
        rps2.path: <g:render template="/forms/updateSetting" model="[settingValue: 'root.rps2.path']"/>
        %{--</li>--}%
        %{--</ul>--}%

        %{--</li>--}%
        <br/>
 rps3.path: <g:render template="/forms/updateSetting" model="[settingValue: 'root.rps3.path']"/>
        %{--</li>--}%
        %{--</ul>--}%

        %{--</li>--}%
        <br/>

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

    </div>


    <h3 class="accordionPanelSettings"><a href="#">
        <g:message code="ui.parameters"></g:message>

    </a></h3>


    <div>
        <g:if test="${1 == 2}">
            <g:each in="${[
                    //                            ['app.parameters.Markup', 'Markup'],
//                            ['app.parameters.Pomegranate', 'Pomegranate'],

                    ['mcs.Department', 'Department'],
                    ['mcs.Course', 'Course'], 'l',


                    ['mcs.parameters.GoalType', 'Goal type'],
                    ['mcs.parameters.Context', 'Context'],
                    ['mcs.parameters.WorkStatus', 'Work status'], 'l',
                    ['mcs.parameters.PlannerType', 'Planner type'],
                    ['mcs.parameters.JournalType', 'Journal type'], 'l',
//
                    ['mcs.parameters.ResourceStatus', 'Resource status'],
                    ['app.parameters.ResourceType', 'Resource type'],
                    'l',
                    ['mcs.parameters.WritingStatus', 'Writing status'],
                    ['mcs.parameters.WritingType', 'Writing type'],
                    ['app.parameters.Blog', 'Blog'],
                    'l',
                    ['app.Indicator', 'Indicator'],
//                              ['mcs.parameters.Location', 'Location'],
                    ['app.PaymentCategory', 'Payment category'],
                    'l',
                    ['mcs.parameters.RelationshipType', 'Relationship type']
            ]}"
                    var="i">
                <g:if test="${i != 'l'}">
                    <g:render template="/layouts/manageParametersLink" model="[controller: i[0], name: i[1]]"/>
                </g:if>
                <g:else>
                    <hr/>
                    <br/>
                </g:else>

            </g:each>

            <br/>
            <hr/>
            <br/>

            <g:each in="${[
                    ['app.parameters.CommandPrefix', 'Command prefix'],
                    ['mcs.parameters.SavedSearch', 'Saved search'],
                    ['cmn.Setting', 'Setting'],
                    ['app.Tag', 'Tag']
            ]}" var="i">

                <g:remoteLink controller="generics" action="fetchAddForm"
                              params="[entityController: i[0], isParameter: true,
                                       updateRegion    : 'centralArea']"
                              before="jQuery.address.value(jQuery(this).attr('href'));"
                              update="centralArea">

                    <span style="font-size: 12px; padding: 2px;">
                        ${i[1]} (${grailsApplication.classLoader.loadClass(i[0]).count()})
                    </span>

                </g:remoteLink>
                <br/>
            </g:each>

        </g:if>

        <span style="-moz-column-count: 1; -webkit-column-count:1">

            <h4>Top level</h4>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'mcs.Department', name: 'Department']"/>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'mcs.Course', name: 'Course']"/>
            <h4>For resources</h4>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'mcs.parameters.ResourceStatus', name: 'Resource status']"/>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'app.parameters.ResourceType', name: 'Resource type']"/>

            <g:if test="${OperationController.getPath('goals.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <h4>For goals</h4>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'mcs.parameters.GoalType', name: 'Goal type']"/>
            </g:if>

            <h4>For goals and tasks</h4>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'mcs.parameters.Context', name: 'Context']"/>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'mcs.parameters.WorkStatus', name: 'Work status']"/>
            <g:if test="${OperationController.getPath('planner.enabled')?.toLowerCase() == 'yes' || OperationController.getPath('journal.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <h4>For planner and journal</h4>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'mcs.parameters.PlannerType', name: 'Planner type']"/>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'mcs.parameters.JournalType', name: 'Journal type']"/>
            </g:if>
            <g:if test="${OperationController.getPath('writings.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <h4>For writing</h4>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'mcs.parameters.WritingType', name: 'Type']"/>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'mcs.parameters.WritingStatus', name: 'Status']"/>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'app.parameters.Blog', name: 'Blog']"/>
            </g:if>
        %{--<g:render template="/layouts/manageParametersLink"--}%
        %{--model="[controller: 'app.parameters.Blog', name: 'Blog']"/>--}%
            <g:if test="${OperationController.getPath('indicators.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <h4>For indicators</h4>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'app.Indicator', name: 'Indicator']"/>
            </g:if>
            <g:if test="${OperationController.getPath('payments.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <h4>For payments</h4>
                <g:render template="/layouts/manageParametersLink"
                          model="[controller: 'app.PaymentCategory', name: 'Payment category']"/>
            %{--<g:render template="/layouts/manageParametersLink"--}%
            %{--model="[controller: 'mcs.parameters.RelationshipType', name: 'Relationship type']"/>--}%
            </g:if>
            <h4>For any record</h4>
            <g:render template="/layouts/manageParametersLink"
                      model="[controller: 'app.Tag', name: 'Tag']"/>

        </span>
        <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <g:remoteLink controller="page" action="colors"
                          update="centralArea"
                          title="List of colors to choose from">
                Colors
            </g:remoteLink>


            <br/>

            <h4 class="">
                <a>Exports</a>
            </h4>

        %{--<div>--}%

            <g:remoteLink controller="operation" action="generateStaticBlogMenu" update="centralArea">
                Static blog menu
            </g:remoteLink>
            <br/>

            <g:remoteLink controller="export" action="textbooks2Bib" update="notificationArea">
                Textbooks 2 bib
            </g:remoteLink>
            <br/>


            <g:remoteLink controller="export" action="generateAuthors" update="notificationArea">
                Generate authors db
            </g:remoteLink>
            <br/>


            <g:remoteLink controller="export" action="staticWebsite" update="centralArea">
                Generate static site



            </g:remoteLink>
            <br/>
            <g:remoteLink controller="report" action="quranReportToString" update="centralArea">
                Qurani inline
            </g:remoteLink>
            <br/>      <g:remoteLink controller="report" action="staticQuranReport" update="centralArea">
            Qurani inline to file
        </g:remoteLink>
            <br/>       <g:remoteLink controller="report" action="staticQuranReportTex" update="centralArea">
            Qurani inline to Tex file
        </g:remoteLink>
            <br/>
            <g:remoteLink controller="report" action="memorizationReport" update="centralArea">
                Memorization aid
            </g:remoteLink>
            <br/>  <g:remoteLink controller="report" action="memorizationReport" update="centralArea">
            Memorization aid
        </g:remoteLink>
            <br/>
            <g:remoteLink controller="report" action="staticMemorizationReport" update="centralArea">
                Memorization aid to file
            </g:remoteLink>
            <br/>

            <g:remoteLink controller="report" action="matrixReport" update="centralArea">
                Salat matrix report
            </g:remoteLink>
            <br/>

            <g:remoteLink controller="export" action="generateAllBibs" update="notificationArea">
                Generate all bibs
            </g:remoteLink>
            <br/>

        %{--<g:link controller="report" action="staticQuranReport"--}%
        %{--target="_blank"--}%
        %{--title="Qurani new tab">--}%
        %{--Qurani new tab--}%
        %{--</g:link>--}%
        %{--<br/>--}%
            <g:link controller="report" action="xcd2epub"
                    target="_blank"
                    title="xcd2epub">
                xcd 2epub
            </g:link>
            <br/>

            <g:remoteLink controller="generics" action="dotTextDump" update="notificationArea">
                Export records to text files
            </g:remoteLink>

            <br/>

            <g:remoteLink controller="export" action="exportTxtToBeamer" update="notificationArea">
                Convert text to beamer
            </g:remoteLink>

            <br/>

            <a onclick="jQuery('#centralArea').load('report/duplicateIsbnBooks')">Books with duplication ISBN</a>
            <br/>

            <h5 class="">

                <a>Admin saved searches</a>
            </h5>
            <g:render template="/layouts/savedSearches" model="[entity: 'A']"/>
        %{--</div>--}%
        </g:if>
    </div>
    %{--</sec:ifAnyGranted>--}%
    <br/>
    <br/>
    <br/>
    <br/>
</div>

<script type="text/javascript">



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

    function openNoteTaker()  {
        window.open('${request.contextPath}/page/appDaftar', '',
                'height=200,width=400,chrome=yes,scrollbars=yes, titlebar=no, toolbar=no, menubar=no, location=no, status=no, directories=no, resizable=yes');

    }

</script>