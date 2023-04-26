<%@ page import="mcs.parameters.SavedSearch" %>
%{--<head>--}%
%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.min.css')}"/>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.modal.min.js')}"></script>--}%
%{--</head>--}%
%{--123--}%
%{--<a id="123" href="${createLink(controller: 'page', action: 'colors')}"  class="modal">colors</a>--}%
%{--456--}%

%{--<script type="javascript">--}%
%{--    jQuery('#123').modal();--}%
%{--</script>--}%
%{--Todo--}%


<g:if test="${title && !ssId}">
    <h2 style="line-height: 20px;">
       ${title} ${totalHits != null ? ' (' + totalHits + ')' : ''}
    </h2>
%{--<hr/>--}%
</g:if>

<g:if test="${title && ssId}">
    <div id="savedSearch${ssId}">
      <h4>
          <g:remoteLink controller="generics" action="executeSavedSearch"
                        id="${ssId}"
                        before="jQuery.address.value(jQuery(this).attr('href'));"
                        update="centralArea">

              &sect;  ${title}
       </g:remoteLink>
          <g:remoteLink controller="generics" action="fetchAddForm" id="${ssId}"
                        params="[entityController: 'mcs.parameters.SavedSearch',
                                 updateRegion: '3rdPanel',
                                 finalRegion: '3rdPanel']"
                        update="3rdPanel"
                        title="Edit">
              (Edit)
          </g:remoteLink>
    </h4>

        <g:if test="${query}">
            <i style="line-height: 20px;">
                (${query})
            </i>
        %{--<hr/>--}%
            <br/>
        </g:if>



    </div>

    %{--<g:if test="${totalHits != 0}">--}%


    <g:if test="${1 == 1}">
    <g:if test="${SavedSearch.get(ssId).queryType == 'hql'}">
        <sup>
            <g:remoteLink controller="generics" action="executeSavedSearch"
                          style=" color: gray"
                          before="jQuery.address.value(jQuery(this).attr('href'));"
                          id="${ssId}" params="[reportType: 'random']"
                          update="centralArea">
                random

            </g:remoteLink>
        </sup>
        <sup>
            <g:link controller="generics" action="executeSavedSearch"
                    style=" color: gray"
                    id="${ssId}" params="[reportType: 'tab']"
                    target="_blank">
                tab
            </g:link>
        </sup>

        <g:if test="${mcs.parameters.SavedSearch.get(ssId).calendarEnabled}">
            <sub>
                <g:link controller="generics" action="executeSavedSearch"
                        style=" color: gray"
                        id="${i.id}" params="[reportType: 'cal']"
                        target="_blank">
                    cal
                </g:link>

            </sub>
        </g:if>
        </g:if>

    </g:if>


%{--<hr/>--}%
</g:if>


<g:if test="${ssId && searchResultsTotal && params.max}">

    %{--th: ${searchResultsTotal}--}%
    %{--th class: ${searchResultsTotal.class}--}%
   <div class="paginateButtons" style="display:inline !important;">
    <util:remotePaginate controller="generics" action="executeSavedSearch" total="${searchResultsTotal}"
                         maxsteps="10"
                         params="[id: ssId]" update="centralArea"/>
       <br/>
</div>
</g:if>



<g:elseif test="${searchResultsTotal  && params.max}">
   
  <div class="paginateButtons" style="display:inline !important;">
    <util:remotePaginate controller="generics" action="hqlSearch" total="${searchResultsTotal}"
                         maxsteps="10"
                         update="centralArea"/>
      <br/>
</div>
</g:elseif>


<g:if test="${queryKey}">

    %{--th: ${totalHits}--}%
    %{--th: ${totalHits.class}--}%
    %{--th: ${queryKey}--}%
    <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="findRecords" total="${totalHits}"
                             maxsteps="10"
                             params="[input: queryKey]" update="centralArea"/>
        <br/>
    </div>

</g:if>


<g:if test="${queryKey2}">
    <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="queryRecords" total="${totalHits}"
                             maxsteps="10"
                             params="[input: queryKey2]" update="centralArea"/>
        <br/>
    </div>

</g:if>


%{--<g:if test="${request.action != 'main' && list.size() > 4}">--}%
%{--<a id="selectAll" class="fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
   %{--title="Edit box">--}%
    %{--<span class="ui-icon ui-icon-check"></span>--}%
%{--</a>--}%


%{--&nbsp;--}%
%{--&nbsp;--}%
%{--<a id="deselectAll"--}%
   %{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
   %{--title="Edit box">--}%
    %{--<span class="ui-icon ui-icon-cancel"></span>--}%
%{--</a>--}%

%{--&nbsp;--}%
%{--&nbsp;--}%
%{--<g:remoteLink controller="generics" action="deselectAll"--}%
              %{--update="centralArea"--}%
              %{--class=" fg-button fg-button-icon-left ui-widget ui-state-default ui-corner-all"--}%
              %{--before="if(!confirm('Are you sure you want to deselect all selected records from all current and previous listings? Click on Selected records to see your selections')) return false"--}%
              %{--title="Selected records">--}%
    %{--<span class="ui-icon ui-icon-arrow-1-n"></span> x--}%
%{--</g:remoteLink>--}%
%{--<br/>--}%
   %{--</g:if>--}%

%{--ToDo fix select all<input type="checkbox" id="selectAll" value="selectAll"> Select / Deselect All<br/><br/>--}%

%{--<g:if test="${ssId && searchResultsTotal}">--}%



    %{--<div class="paginateButtons" style="display:inline !important;">--}%
        %{--<util:remotePaginate controller="generics" action="executeSavedSearch" total="${searchResultsTotal}"--}%
                             %{--maxsteps="5"--}%
                             %{--params="[id: ssId]" update="centralArea"/>--}%
    %{--</div>--}%
    %{--<br/>--}%
%{--</g:if>--}%



%{--<g:elseif test="${searchResultsTotal}">--}%



    %{--<div class="paginateButtons" style="display:inline !important;">--}%
        %{--<util:remotePaginate controller="generics" action="hqlSearch" total="${searchResultsTotal}"--}%
                             %{--maxsteps="5"--}%
                             %{--update="centralArea"/>--}%
    %{--</div>--}%
    %{--<br/>--}%
%{--</g:elseif>--}%





<g:if test="${!list}">
<i>No records found.</i>
</g:if>


<g:if test="${session['showLine1Only'] == 'on'}">
<g:each in="${list}" status="i" var="record">

%{--<div class="uk-margin-medium-right uk-margin-medium-left">--}%
    <g:render template="/gTemplates/recordSummary" model="[record: record, tabIndex: i, expanded: expanded]"/>
    <br/>
%{--</div>--}%


</g:each>
</g:if>
<g:else>
    <g:each in="${list}" status="i" var="record">
        %{--<div class="uk-margin-medium-right uk-margin-medium-left">--}%
        <g:render template="/gTemplates/recordSummary" model="[
                expanded: expanded,
                record: (record.entityCode() == 'R' ? mcs.Book.findById(record.id): record),
                tabIndex: i,
                context: (highlights && highlights[i] ? highlights[i] : null)]"/>
        <br/>
        %{--</div>--}%
    </g:each>

</g:else>


    %{--</g:if>--}%
%{--<g:else>--}%
    %{--<br/>--}%
    %{--<i style="color: darkgray">No matching--}%
    %{--todo fix ${entity?.toLowerCase()?.split(/\./)[1]}--}%
    %{--records found.</i>--}%
%{--</g:else>--}%

<sec:ifLoggedIn>
    <sec:ifAnyGranted roles="ROLE_ADMIN">
        <g:if test="${params.action == 'logicallyDeletedRecords'}">
            <g:remoteLink controller="generics" action="physicallyDeleteRecords"
                          update="centralArea"
                          before="if(!confirm('Are you sure you want to delete all records?')) return false"
                          title="Delete all logically deleted records">
                <b style="color: red">Empty trash</b>
            </g:remoteLink>
        </g:if>
    </sec:ifAnyGranted>
</sec:ifLoggedIn>

<g:set var="customId"
       value="${new Date().format('hhmmss')}"/>

<script type="text/javascript">
jQuery('#selectBasketRegion').load('${request.contextPath}/generics/countSelection');
%{--jQuery('#importFileCount').load('${request.contextPath}/page/importbeat');--}%
%{--jQuery('#editFileCount').load('${request.contextPath}/page/editHeartbeat');--}%
%{--jQuery('#recentRecordsCount').load('${request.contextPath}/generics/countRecentRecords');--}%

//jQuery(document).ready(function () {
    %{--document.getElementsByClassName("prevLink")[0].className = "prevLink${customId}";--}%
if (jQuery(".prevLink").size() > 0) {
    document.getElementsByClassName("prevLink")[0].className = "prevLink${customId}";
//todo change p
    Mousetrap.bind(['b','لا', 'left'], function (e) {
        jQuery(".prevLink${customId}").click();
    });
}

if (jQuery(".nextLink").size() > 0) {
    document.getElementsByClassName("nextLink")[0].className = "nextLink${customId}";

    Mousetrap.bind(['n','ى', 'right'], function (e) {
        jQuery(".nextLink${customId}").click();
    });

    Mousetrap.bind(['shift+a', 'shift+ش'], function (e) {
        jQuery(".recordSelected .quickBookmarkButton").click();
        jQuery(".nextLink${customId}").click();
    });
}


//});
</script>