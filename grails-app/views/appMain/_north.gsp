<%@ page import="ker.OperationController; java.text.DecimalFormat; cmn.Setting; grails.util.Metadata" %>


<header>
    <nav class="uk-navbar-container" uk-navbar style="background-color: #4A5C69;">
        <div class="uk-navbar-left">

            <ul class="uk-navbar-nav">


                <li>
                    <a href="${createLink(controller: 'page', action:'appMain')}" target="_blank">
                    <img src="${resource(dir: 'images', file: 'calendar.ico')}" style="padding-left:20px; width: 50px" alt="Nibras"/>
                    </a>
                </li>

                <li class="" style="">

                    <a class="uk-link" href="${createLink(controller: 'page', action:'appMain')}" target="_blank">

                        %{--<span style="margin-right: 1px;">--}%
                            <b style="font-family: Lato, sans-serif;">
                                ${OperationController.getPath('app.name') ?: 'Nibras'}</b>
                            <i>
                                &nbsp;
                                v${grailsApplication.metadata.getApplicationVersion()}
                                %{--<g:meta name="app.version"/>--}%
                            </i>
                        %{--</span>--}%
                    </a>



                <li>
                    <a href="#">Apps</a>

                    <div class="uk-navbar-dropdown">
                        <ul class="uk-nav uk-navbar-dropdown-nav">


                            <g:if test="${OperationController.getPath('mihrab.enabled')?.toLowerCase() == 'yes' ? true : false}">
                                <li>
                                    <a href="${createLink(controller: 'page', action:'appMihrab')}" target="_blank">
                                        Mihrab
                                        %{--            &nearr;--}%
                                    </a>
                                </li>
                            </g:if>
            </li>



                <li>

                    <a class="uk-link"  href="${createLink(controller: 'page', action:'appPile')}" target="_blank">
                        Reader
                    </a>

                </li>

                <li>
                    <a href="${createLink(controller: 'page', action:'appNotes')}" target="_blank">
                        Notes
                    </a>
                </li>


            </ul>
                    </div>
                </li>





                <g:if test="${OperationController.getPath('calendar.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <li>
                        <a class="uk-link"  href="${createLink(controller: 'page', action:'appCalendar')}" target="_blank">
                            Calendar
                        </a>
                    </li>
                </g:if>

                <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <li>
                    %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
                        <g:remoteLink controller="import" action="importLocalFiles"
                                      update="centralArea"
                                      style="padding-right: 2px !important;"
                                      title="Import local files (Path: root.rps1.path)">

                        %{--<span class="ui-icon ui-icon-arrow-2-e-w"></span>--}%
                        %{--<g:message code="ui.importFiles"></g:message>--}%
                            Import <span id="importFileCount"></span>
                        %{--<pkm:checkFolder name='rps1' display='Import (<span id="importFileCount"></span>)'--}%
                        %{--path="${ker.OperationController.getPath('root.rps1.path')}"/>--}%
                        </g:remoteLink>
                        </li>

                        <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
                        %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
                            <li>
                            <g:remoteLink controller="import" action="advancedRecordImport"
                                          update="centralArea"
                                          style="padding-right: 2px !important;"
                                          title="Import records in batch">
                            %{--<span class="ui-icon ui-icon-arrow-2-e-w"></span>--}%
                            %{--<g:message code="ui.importFiles"></g:message>--}%
                                Batches
                            %{--<pkm:checkFolder name='rps1' display='Import (<span id="importFileCount"></span>)'--}%
                            %{--path="${ker.OperationController.getPath('root.rps1.path')}"/>--}%
                            </g:remoteLink>
                            </li>
                        </g:if>
                </g:if>

                   <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    %{--<td  style="padding: 1px !important;">--}%
                        <li>

                            <g:remoteLink controller="import" action="editBox"
                                          update="centralArea"
                                          style="padding-right: 2px !important;"
                                          title="Edit box">
                            %{--<g:message code="ui.writings"></g:message>--}%
                                Edit (${editFileCount ?: 0})
                                %{--<span id="editFileCount"></span>--}%
                            </g:remoteLink>

                        </li>

                    </g:if>




            </ul>
        </div>

        <div class="uk-navbar-right">

            <ul class="uk-navbar-nav">

                <li>
                    %{--<span id="notificationArea" style=""></span>--}%
                    %{--<span style="display: none" id="notificationAreaHidden"></span>--}%

                    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
                    <g:formRemote name="batchAdd3"
                                  url="[controller: 'generics', action: 'quickTextSearch']"
                                  update="centralArea" style="padding: 5px;"
                                  before="jQuery('#testTitle5').text('[3]: ' + jQuery('#testField5').val());"
                                  method="post">

                    %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
                        <g:submitButton name="batch" value="Execute"
                                        style="margin: 0px; display: none"
                                        id=" "
                                        class="ui-widget ui-state-default"/>

                        <g:select name="resultType"
                                  from="${[[id: '*']] + types}"
                                  optionKey="id"
                                  optionValue="id" class="uk-select"
                                  style="width: 50px; direction: ltr; text-align: left; padding: 5px; margin: 0;"
                                  value="N"/>

                        <g:textField name="input" value="" id="speedsearch"
                                     autocomplete="off" class="uk-input"
                                     style="float: right; display: inline;  width: 250px !important; padding: 5px; margin: 1px;"
                                     placeholder="Search (Esc)..."/>

                    </g:formRemote>

                </li>


                %{--<li>--}%
                    %{----}%
                %{--</li>--}%
                <li>



                        <sec:ifLoggedIn>
                            <g:remoteLink controller="page" action="manageUser"
                                          update="centralArea"
                                          title="Manager user account">
                                <u>${username}</u>
                            </g:remoteLink>

                        </sec:ifLoggedIn>

                        <sec:ifNotLoggedIn>
                            You are not logged in
                        </sec:ifNotLoggedIn>


                    <div class="uk-navbar-dropdown">
                        <ul class="uk-nav uk-navbar-dropdown-nav">



                                <li>
                                    <a href="${request.contextPath}/logoff"
                                       style="">
                                        Logout
                                        %{--<g:message code="ui.menu.help"></g:message>--}%
                                    </a>
                                </li>

                </ul>
                        </div>
                </li>


                <li><a href="#" style="color: white">
                    &nbsp;


                </a></li>
            </ul>

        </div>
    </nav>
</header>







%{--<div id="dialog" title="Basic dialog">--}%
%{--<p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>--}%
%{--</div>--}%

<script>
    //    $("#dialog").dialog();

    function dualDisplay() {
        document.getElementById("centralArea").id = "temp1q";
        document.getElementById("sandboxPanel").id = "centralArea";
        console.log('dual')
        jQuery('#accordionEast').accordion({active: 3});

    }

    function singleDisplay() {
        document.getElementById("temp1q").id = "centralArea";
        document.getElementById("centralArea").id = "sandboxPanel";
        console.log('single')
    }


    $('#selectAll').click(function (e) {
        $("input[name^='select-']").each(function () {
//        this['value'] = 'on'
            this['checked'] = true
//        console.log(this.attr('value'));
            jQuery('#logRegion').load('${request.contextPath}/generics/selectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
        });
    })

    $('#deselectAll').click(function (e) {
        $("input[name^='select-']").each(function () {
            this['checked'] = false
//        console.log(this.attr('value'));
            jQuery('#logRegion').load('${request.contextPath}/generics/deselectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
        });
    })
</script>
