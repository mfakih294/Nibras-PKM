<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
%{--${ker.OperationController.getPath('app.headers.background') ?: '#5b7a59'}--}%
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
     style="font-size: 12px; margin-top: 10px; min-height: 0px !important;  padding: 3px; direction: ltr; text-align: left; font-family: tahoma; color: white">
    <g:render template="/appMain/south" model="[ips: ips]"/>

</div>


<div class="ui-layout-east eastRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">

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
            </a></h6>

            <div id="inner1" class="common" style="">

                <div id="centralArea" class="common" style="">



%{--                <span class="focusPSouth" style="text-align: right !important; direction: rtl !important;"--}%
%{--                title="${Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', ['knb'])[0]?.description}">--}%
                %{--<h5>Last plan</h5>--}%
                <g:render template="/gTemplates/recordSummary" model="[record: Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', [OperationController.getPath('planner.homepage.default-type')],[max: 1])[0]]"></g:render>
                <g:render template='/reports/homepageSavedSearches'/>
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

            </div>

            <h6 style="text-aling: center"><a href="#" id="testTitle2">
                Panel 2
            </a></h6>

            <div id="2" class="common" style="">
                <div id="inner2" class="common" style="">
                    %{--<g:render template='/reports/homepageSavedSearches'/>--}%

                </div>
                %{--before="jQuery('#testTitle2').text('[2]: ' + jQuery('#testField2').val());"--}%
                <g:formRemote name="batchAdd2" class="commandBarInPanel"
                              url="[controller: 'generics', action: 'actionDispatcher']"
                              update="centralArea" style="display: inline"

                              method="post">
                    <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
                    <g:submitButton name="batch" value="Execute"
                                    style="height: 30px; margin: 0px; width: 100px !important; display: none"
                                    id="quickAddXcdSubmitTop3"
                                    class="fg-button ui-widget ui-state-default"/>

                    <g:textField name="input" value="" id="testField2"
                                 autocomplete="off"
                                 style="display: inline;  font-family: tahoma ; width: 100% !important;"
                                 placeholder=""
                                 class="commandBarTexFieldTop"/>
                </g:formRemote>

            </div>
            <h6><a href="#" id="testTitle3">
                Panel 3
            </a></h6>

            <div id="3" class="common" style="">
                <div id="inner3" class="common" style="">
                </div>
                %{--before="jQuery('#testTitle3').text('[3]: ' + jQuery('#testField3').val());"--}%
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
                                 style="display: inline;  font-family: tahoma ; width: 100% !important;"
                                 placeholder=""
                                 class="commandBarTexFieldTop"/>
                </g:formRemote>

            </div>
        <h6 id="h64"><a href="#" id="testTitle4">
            Script panel
        </a></h6>

            <div id="4d" class="common" style="">
                <div id="inner4" class="common" style="">
                </div>

                %{--<br/>--}%
%{--                <sec:ifAnyGranted roles="ROLE_ADMIN">--}%
                    <g:render template="/layouts/commandbar" model="[]"/>
%{--                </sec:ifAnyGranted>--}%

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
                         style="display: inline; margin-top: 4px; width: 100% !important;"
                         placeholder="Command prompt..."
                         onkeyup="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))"
                         onkeypress="jQuery('#notificationAreaHidden').load('/nibras/generics/verifySmartCommand', { 'line':jQuery('#quickAddTextFieldBottomTop').val() }, function (response, status, xhr) {jQuery('#quickAddTextFieldBottomTop').attr('class', '');jQuery('#quickAddTextFieldBottomTop').attr('class', response); });"
                         onfocus="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()));jQuery('#notificationAreaHidden').load('/nibras/generics/verifySmartCommand', { 'line':jQuery('#quickAddTextFieldBottomTop').val() }, function (response, status, xhr) {jQuery('#quickAddTextFieldBottomTop').attr('class', '');jQuery('#quickAddTextFieldBottomTop').attr('class', response); });"
                         onblur="jQuery('#hintArea').html('')"
                         class=""/>

        </g:formRemote>
        %{--if (jQuery('#quickAddTextFieldBottomTop').val().search('--')== -1){--}%
        %{--<div style="-moz-column-count: 3; -webkit-column-count:3">--}%
        <div id="hintArea" style="font-size: 12px; padding: 0px; margin: 0px; "></div>
        %{--</div>--}%

    </div>

<script type="text/javascript">
    jQuery(".chosen").chosen({allow_single_deselect: true, no_results_text: "None found"});
    jQuery("#chosenTags").chosen({allow_single_deselect: true, no_results_text: "None found"});
    jQuery("#chosenTagsArt").chosen({allow_single_deselect: true, no_results_text: "None found"});

    //    jQuery("#addXcdFormNgs").relatedSelects({
    //        onChangeLoad: '/nibras/generics/fetchCoursesForDepartment',
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


</script>