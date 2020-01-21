<%@ page import="ker.OperationController; cmn.Setting;" %>


<div class="nav nonPrintable"
     style="width: 98%; font-family: tahoma; font-size: 14px; padding: 3px; direction: rtl;">

    &nbsp;
    <img src="${resource(dir: 'images', file: 'favicon-transparent.png')}" width="15px;"/>
&nbsp;
    <g:link controller="page" action="main"
            title="Reload the application">
        <span style="color: #fff;">
            <b style="font-size: 14px; font-family: tahoma, sans-serif;">
                ${OperationController.getPath('app.name') ?: 'Nibras'}</b>
            %{--<i></i><g:meta name="app.version"/>--}%
        </span>
    </g:link>
    %{--<g:if test="${OperationController.getPath('show.textlogo')?.toLowerCase() == 'yes' ? true : false}">--}%
        %{--<sub>--}%
            %{--<a href="http://pomegranate-pkm.org" target="_blank">--}%
                %{--<i style="font-size: 10px; color: #ffffff"></i>--}%
            %{--</a>--}%
        %{--</sub>--}%
    %{--</g:if>--}%

%{--&nbsp;--}%
    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
        %{--<% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);--}%
        %{--c.setFirstDayOfWeek(java.util.Calendar.MONDAY)--}%
        %{--%>--}%
        %{--<b>أ${c.get(Calendar.WEEK_OF_YEAR)}</b>--}%
        %{--&nbsp;--}%
    %{--</sec:ifAnyGranted>--}%


    <g:remoteLink controller="report" action="detailedAdd"
                  update="centralArea"
                  before="jQuery.address.value(jQuery(this).attr('href'));"
                  style="color: white !important"
                  title="Add using forms">
        +
    </g:remoteLink>



    <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <g:remoteLink controller="import" action="importLocalFiles"
                      update="centralArea"
                      before="jQuery.address.value(jQuery(this).attr('href'));"
                      style="color: white !important"
                      title="Import local files">
            <g:message code="ui.import"></g:message>

        </g:remoteLink>
    </g:if>


&nbsp;
    <a href="/nibras/generics/executeSavedSearch/65?reportType=cal" style="color: white !important" target="_blank">
        <g:message code="ui.planner"></g:message>

    </a>
    &nbsp;
    <a href="/nibras/generics/executeSavedSearch/79?reportType=cal" style="color: white !important" target="_blank">
    <g:message code="ui.journal"></g:message>

    </a>
&nbsp;



    <g:remoteLink controller="report" action="reviewPile"
                  update="centralArea"
                  style="color: white !important"
                  title="Review pile">
        <g:message code="ui.review"></g:message>

    </g:remoteLink>

&nbsp;



    <g:remoteLink controller="report" action="wordsForReview"
                  update="centralArea"
                  style="color: white !important"
                  title="Review words">
        <g:message code="ui.anki"></g:message>

    </g:remoteLink>


%{--<sec:ifLoggedIn>--}%
        %{--<g:link controller='logout' style="color: #ffffff !important;">Logout &nbsp;</g:link>--}%
    %{--</sec:ifLoggedIn>--}%

    <sec:ifNotLoggedIn>
        <a href='#' id='loginLink'>Login</a>
    </sec:ifNotLoggedIn>

&nbsp;


    <g:formRemote name="batchAdd2"
                  url="[controller: 'generics', action: 'actionDispatcher']"
                  update="centralArea" style="display: inline"
                  method="post">

        <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
        <g:submitButton name="batch" value="Execute"
                        style="height: 20px; margin: 0px; width: 100px !important; display: none"
                        id="quickAddXcdSubmitTop"
                        class="fg-button ui-widget ui-state-default"/>

        <g:textField name="input" id="quickAddTextFieldBottomTop" value=""
                     autocomplete="off"
                     style="display: inline;  width: 600px !important; background: #E5F6FE; color: white; border: 1px solid #003a69"
                     placeholder="Command bar"
                     onkeyup="if (jQuery('#quickAddTextFieldBottomTop').val().search(';')== -1){jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))}"
                     onfocus="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))"
                     onblur="jQuery('#hintArea').html('')"
                     class="commandBarTexFieldTop"/>

    </g:formRemote>

</div>
