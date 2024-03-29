<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
%{--${ker.OperationController.getPath('app.headers.background') ?: '#5b7a59'}--}%

<style>
.ui-layout-south, .ui-layout-north {
    background: ${OperationController.getPath('app.color') ?: '#6D6D74'} !important;
    /*url(../images/bg-header.gif) no-repeat*/
}

</style>


<div class="ui-layout-north southRegion appBkg" style="overflow: hidden;"
     style="">
    %{--<g:render template="/layouts/north" model="[]"/>--}%
    <g:render template="/appMain/north"/>
</div>

<div class="ui-layout-west westRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">
    %{--<div class="ui-layout-content ui-widget-content">--}%


    <g:render template="/appMain/west"/>
    %{--</div>--}%
</div>

<div class="ui-layout-south footerRegion"
     style="font-size: 14px; margin-top: 10px; margin-left: 20px; min-height: 0px !important;  padding: 6px; direction: ltr; text-align: left; font-family: tahoma; color: white">
    <g:render template="/appMain/south" model="[ips: ips]"/>

</div>


<div class="ui-layout-east eastRegion appBkg" style="margin-top: 0px !important; z-index: 1000000; overflow: auto;">

    %{--<div class="ui-layout-content ui-widget-content">--}%

    <g:render template="/appMain/east"/>

    </div>


    <div class="ui-layout-center appBkg" style="margin-top: 4px !important; margin-bottom: 4px !important;"
         onmouseover="jQuery('#hintArea').html('')">
        %{--ToDo: display none?!--}%
        %{--<div class="ui-layout-content ui-widget-content" onmouseover="jQuery('#hintArea').html('')">--}%


        <div id="logRegion"></div>

        <div id="logArea"></div>


        <div id="searchArea" class="nonPrintable">

        </div>

        <div id="spinner2" style="display:none; z-index: 10000 !important">
            <img src="${resource(dir: '/images', file: 'Eclipse-1.4s-200px.gif')}" alt="Spinner2"
                 style="z-index: 10000 !important"/>
        </div>
        %{--<sec:ifNotGranted roles="ROLE_ADMIN">--}%
        %{--<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
        %{--<g:render template="/layouts/commandbar" model="[]"/>--}%
        %{--</g:if>--}%
        %{--</sec:ifNotGranted>--}%
        <div id="accordionCenter"
             style="margin: 0px !important; width: 100% !important; padding-bottom: 0px !important;">

            <h6 style="text-aling: center"><a href="#" id="testTitle1">
                Main panel
                %{--panel--}%
            </a></h6>

            <div id="1" class="common" style="">

                <div id="centralArea" class="common" style="" tabindex=2>
%{--                <g:render template="/reports/heartbeat" model="[dates: dates]"></g:render>--}%
%{--<g:render template="/gTemplates/recordListing" model="[list: recentRecords, title: 'Last records']"></g:render>--}%

                    <g:render template='/reports/homepageSavedSearches'/>

                    <g:if test="${tasksActiveNotStarted.size() >= 1000}">
                    %{--<tr>--}%
                    %{--<td style="vertical-align: top">--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: notStarted ]"></g:render>--}%
                    %{--<g:each in="${tasksActiveNotStarted?.context?.unique()}" var="c">--}%
                    %{--<h4 style="text-align: center">@${c}</h4>--}%
                        <ul style="direction: rtl;text-align: center; width: 90%; padding: 3px;;">
                        %{--.grep{it.context == c}--}%
                            <g:each in="${tasksActiveNotStarted}" var="task">
                                <li class="text${task.language}" style="border: 1px solid darkgray; border-radius: 5px; padding: 3px; margin: 6px 2px; list-style-type: none;">

                                    <g:remoteLink controller="generics" action="showSummary" id="${task.id}" params="[entityCode: 'T']"
                                                  update="currentTaskArea"
                                                  title="Show task  ">
                                        <b>${task.context?.code}</b>
                                        ${task.summary}
                                    </g:remoteLink>

                                </li>

                            %{--<g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>--}%
                            </g:each>
                        </ul>
                    %{--</g:each>--}%

                    %{--</td>--}%

                    </g:if>


       </div>
                <br/>
                <br/>
                <a class="fg-button ui-widget ui-state-default ui-corner-all" title="Hide"
                   onclick="jQuery('#centralArea').html('');" style="float: right; color: darkgray; margin-right: 4px;">Clear</a>



                <br/>

                <g:if test="${OperationController.getPath('quick-add-form.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <br/>
                %{--<hr/>--}%
                %{--<br/>--}%
                %{--<div class="">--}%
                %{--<h2>Create new record...</h2>--}%
                %{--<h4 style="user-focus-pointer: hand; cursor: hand;"></h4>--}%
                %{--<br/>--}%
                %{--</div>--}%
                    <div id="quickAddForm" style="border: 1px solid darkgreen; padding: 6px;" class="">


                        <div class="headingAdd">
                %{--<h2>Create new record...</h2>--}%
                    <h3 class="addRecordHeading">Add records...</h3>
                %{--<br/>--}%
                    </div>
                    <div class="contentAdd">
                        <g:formRemote name="addXcdFormDaftar" id="addXcdFormDaftar"
                                      url="[controller: 'indexCard', action: 'addXcdFormDaftar']"
                                      update="underAreaForQuickAdd"
                                      onComplete=" jQuery('#descriptionDaftar').val('');jQuery('#summayDaftar').val('');jQuery('#topDaftarArea').html(''); jQuery('#summayDaftar').focus(); jQuery('#underAreaForQuickAdd').scrollIntoView({block: 'center', inline: 'nearest', behavior: 'smooth', });"
                                      method="post">

                        %{--onkeyup="jQuery('#topDaftarArea').load('${request.contextPath}/indexCard/extractTitle/', {'typing': this.value})"--}%
                        %{--<code>Format: title (line 1) <br/> details (from line 2 till the end)--}%
                        %{--</code>--}%



                            <g:select name="type" from="${types}"
                                      id="typeField"
                                      tabindex="1"
                                      optionKey="id"
                                      optionValue="name"
                                      onchange="if (this.value == 'R') {jQuery('#resourceType').prop('disabled',false)} else {jQuery('#resourceType').prop('disabled',true);}"
                                      value="N"/>
                        %{--console.log('now sel: ', this.value);--}%

                        %{--<g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
                            <g:select name="resourceType" id="resourceType" from="${app.parameters.ResourceType.list([sort: 'code', order: 'asc'])}"
                                      optionKey="id" style="" optionValue="code" noSelection="${['': '...']}"/>
                        %{--disabled="true"--}%
                        %{--</g:if>--}%


                            <g:textField name="title" value=""
                                         tabindex="2" id="summayDaftar"
                                         style="background: #f8f9fa; border: 1px solid darkgray; border-radius: 5px;padding: 3px; text-align: right; display: inline;  font-family: tahoma, Lato, serif ; width: 50% !important;"
                                         placeholder="Summary * "/>
                            <a class="fg-button ui-widget ui-state-default ui-corner-all" title="Hide"
                               onclick="jQuery('#detailsOfQuickAdd').removeClass('hidden');" style="padding: 3px; color: black; margin-right: 4px;">more</a>



                            <g:submitButton name="save" value="Save"
                                            style="float: right; background: #82c670; color: black; border: 1px solid darkgray; text-align: center; padding-left: 4px; padding-right: 4px; width: 50px"
                                            tabindex="4"
                                            title="Add record"
                                            id="addXcdFormDaftarSubmit"
                                            class="uk-button-primary"/>
                        %{--(ctrl+enter)--}%

                            <div id="detailsOfQuickAdd" class="hidden">


                                %{--p <g:select name="priority" from="${(1..5)}" style="border-radius: 5px;"--}%
                                            %{--id="priority"--}%
                                            %{--tabindex="1"--}%
                                            %{--value="${2}"/>--}%
                                %{--&nbsp;--}%
                                <a class="" title="Hide"
                                   onclick="jQuery('#detailsOfQuickAdd').addClass('hidden');" style="color: darkgray; float: right;">x</a>



                                %{--<br/>--}%
                                &nbsp;

                                %{--<g:checkBox name="addOperation" id="addOperation" checked="checked"/>Operation--}%
                                %{--<g:checkBox name="addFolder" id="addFolder" checked="checked"/>Make folder--}%
                                %{--<g:checkBox name="grabAllFiles" id="grabAllFiles"/>Move new files--}%



                                %{--<g:select name="language" id="language" from="${OperationController.getPath('repository.languages')?.split(',')}"--}%
                                %{--value="${OperationController.getPath('default.language')}"--}%
                                %{--/>--}%


                                %{--<g:if test="${OperationController.getPath('courses.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
                                %{--<g:select name="courseNgs" id="courseNgs" from="${mcs.Course.findAll([sort: 'department', order: 'desc'])}"--}%
                                %{--optionKey="id" class="chosen" style="width: 450px !important;" optionValue="summary" noSelection="${['': 'No course']}"/>--}%
                                %{--</g:if>--}%

                                <br/>
                                <g:textArea cols="80" rows="12" placeholder="Description / full text ..."
                                            tabindex="3"
                                            name="description" id="descriptionDaftar"
                                            value=""
                                            style="background: #f8f9fa; font-family: tahoma; font-size: small; padding: 9px 3px; width: 99%; height: 90px !important;"/>

                            </div>


                        </g:formRemote>

                        <br/>
                        <div id="underAreaForQuickAdd"></div>
            </div>






                    </div>

                </g:if>


            %{--                <div id="centralArea" class="common" style="">--}%

%{--                </div>--}%


                %{--<div id="subDaftarArea">--}%
%{----}%
                %{--</div>--}%

%{--                <br/>--}%
%{--                <hr style="color: darkgray; background: darkgray"/>--}%
%{--                <br/>--}%






                    %{--                <span class="focusPSouth" style="text-align: right !important; direction: rtl !important;"--}%
%{--                title="${Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', ['knb'])[0]?.description}">--}%
                %{--<h5>Last plan</h5>--}%
                %{--<g:render template="/gTemplates/recordSummary" model="[record: Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', [OperationController.getPath('planner.homepage.default-type')],[max: 1])[0]]"></g:render>--}%


                    %{--                    render(template: '/reports/heartbeat', model: [dates: dates])--}%





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
%{--                </div>--}%

                <g:if test="${1 == 2 && OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
                %{--before="jQuery('#testTitle2').text('[2]: ' + jQuery('#testField2').val());"--}%
                    <br/>
                    <br/>
                    <br/>

                    <br/>
                    <g:formRemote name="batchAdd2" class="commandBarInPanel"
                                  url="[controller: 'generics', action: 'actionDispatcher']"
                                  update="centralArea" style="display: inline"

                                  method="post">
                        <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
                        <g:submitButton name="batch" value="Execute"
                                        style="height: 30px; margin: 0px; width: 120px !important; display: none"
                                        id="quickAddXcdSubmitTop1"
                                        class="fg-button ui-widget ui-state-default"/>

                        <g:textField name="input" value="" id="testField1"
                                     autocomplete="off"
                                     style="display: inline; padding-left: 5px; font-family: tahoma ; width: 100% !important; border: 1px solid darkgray"
                                     placeholder="Command bar"
                                     class="commandBarTexFieldTop"/>
                    </g:formRemote>
                </g:if>



            </div>

<g:if test="${OperationController.getPath('extra-panes.enabled')?.toLowerCase() == '====yes' ? true : false}">
            <h6 style="text-aling: center"><a href="#" id="testTitle2">
                Side panel
            </a></h6>

            <div id="2" class="common" style="">
                <div id="inner2" class="common" style="">




                </div>





            %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
                %{--before="jQuery('#testTitle2').text('[2]: ' + jQuery('#testField2').val());"--}%
    <br/>
    <br/>
    <br/>

    <br/>
    <g:formRemote name="batchAdd2" class="commandBarInPanel"
                              url="[controller: 'generics', action: 'actionDispatcher']"
                              update="centralArea" style="display: inline"

                              method="post">
                    <g:hiddenField name="sth2" value="${new java.util.Date()}"/>

                    <g:submitButton name="batch" value="Execute"
                                    style="height: 30px; margin: 0px; width: 120px !important; display: none;"
                                    id="quickAddXcdSubmitTop3"
                                    class="fg-button ui-widget ui-state-default"/>

                    <g:textField name="input" value="" id="testField2"
                                 autocomplete="off"
                                 style="display: inline; padding-left: 5px; font-family: tahoma ; width: 100% !important; border: 1px solid darkgray"
                                 placeholder="Command bar"
                                 class="commandBarTexFieldTop"/>
                </g:formRemote>
</g:if>
    %{--</sec:ifAnyGranted>--}%
            </div>

    <g:if test="${1 == 2}">
            <h6><a href="#" id="testTitle3">
                Extra panel
            </a></h6>

            <div id="3" class="common" style="">
                <div id="inner3" class="common" style="">

                    %{--<h3>Saved searches</h3>--}%
                    %{--<g:render template='/reports/homepageSavedSearches'/>--}%

                </div>
                %{--before="jQuery('#testTitle3').text('[3]: ' + jQuery('#testField3').val());"--}%
    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <g:formRemote name="batchAdd2" class="commandBarInPanel"
                              url="[controller: 'generics', action: 'actionDispatcher']"

                              update="centralArea" style="display: inline"
                              method="post">
                    <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
                    <g:submitButton name="batch" value="Execute"
                                    style="height: 30px; margin: 0px; width: 100px !important; display: none"
                                    id="quickAddXcdSubmitTop4"
                                    class="fg-button ui-widget ui-state-default"/>

                    <g:textField name="input" value="" id="testField3"
                                 autocomplete="off"
                                 style="display: inline; padding-left: 5px;  font-family: tahoma ; width: 100% !important;  border: 1px solid darkgray"
                                 placeholder=""
                                 class="commandBarTexFieldTop"/>
                </g:formRemote>
    </g:if>
    %{--</sec:ifAnyGranted>--}%

            </div>

    </g:if>
    </g:if>
            %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%

                <g:if test="${1 == 2 && OperationController.getPath('advanced-panel.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <h6 id="h64"><a href="#" id="testTitle4">
            Advanced panel
        </a></h6>

            <div id="4d" class="common" style="">
                <div id="inner4" class="common" style="">
                </div>

                %{--<br/>--}%

                <g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <g:render template="/layouts/commandbar" model="[]"/>
                    </g:if>
                

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

            </div>
                </g:if>
                 %{--</sec:ifAnyGranted>--}%

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

        %{--</div>--}%

        %{--<hr/>--}%
        %{--before="jQuery('#testTitle1').text('[1]: ' + jQuery('#quickAddTextFieldBottomTop').val());"--}%
        
        %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
        
        <g:formRemote name="batchAdd2" class="commandBarInPanel"
                      url="[controller: 'generics', action: 'actionDispatcher']"
                      update="centralArea" style="display: inline"

                      method="post">

            <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
            <g:submitButton name="batch" value="Execute"
                            style="height: 20px; margin: 0px; width: 100px !important; display: none"
                            id="quickAddXcdSubmitTop2"
                            class="fg-button ui-widget ui-state-default"/>

            <g:textField name="input" id="quickAddTextFieldBottomTop" value=""
                         autocomplete="off"
                         style="display: inline; margin-top: 4px; margin-left: 0px !important; padding-left: 5px !important; width: 100% !important;  border: 1px solid darkgray"
                         placeholder="Command bar...(F2)"
                         onkeyup="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))"
                         onkeypress="jQuery('#notificationAreaHidden').load('${request.contextPath}/generics/verifySmartCommand', { 'line':jQuery('#quickAddTextFieldBottomTop').val() }, function (response, status, xhr) {jQuery('#quickAddTextFieldBottomTop').attr('class', '');jQuery('#quickAddTextFieldBottomTop').attr('class', response); });"
                         onfocus="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()));jQuery('#notificationAreaHidden').load('${request.contextPath}/generics/verifySmartCommand', { 'line':jQuery('#quickAddTextFieldBottomTop').val() }, function (response, status, xhr) {jQuery('#quickAddTextFieldBottomTop').attr('class', '');jQuery('#quickAddTextFieldBottomTop').attr('class', response); });"
                         onblur="jQuery('#hintArea').html('')"
                         class=""/>

        </g:formRemote>
        %{--</sec:ifAnyGranted>--}%
        %{--if (jQuery('#quickAddTextFieldBottomTop').val().search('--')== -1){--}%
        %{--<div style="-moz-column-count: 3; -webkit-column-count:3">--}%
        <div id="hintArea" style="font-size: 12px; padding: 0px; margin: 0px; "></div>
        </div>
<br/>
<br/>
    </div>
<div id="notificationAreaHidden"></div>
<script type="text/javascript">


    jQuery(".contentAdd").hide();

    jQuery(".headingAdd").click(function() {
        jQuery(this).next(".contentAdd").slideToggle(200);

        if (!window.isHidden)
            window.isHidden = true;
        else
            window.isHidden = false;
    });


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

//jQuery('#resourceType').prop('disabled',true);
</script>