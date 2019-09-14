

<g:if test="${title && !ssId}">
    <h2 style="font-family: Georgia; font-size: 1.3em; color: darkblue; font-weight: bold; line-height: 20px;">
    &sect;    ${title} ${totalHits ? ' (' + totalHits + ')' : ''}
    </h2>
%{--<hr/>--}%
</g:if>

<g:if test="${title && ssId}">
       <g:remoteLink controller="generics" action="executeSavedSearch"
                  id="${ssId}"
                  update="centralArea">
      <h2> &sect;  ${title}
      </h2>
    </g:remoteLink>

%{--<hr/>--}%
</g:if>

<g:if test="${queryKey}">


    <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="findRecords" total="${totalHits}"
                             params="[input: queryKey]" update="centralArea"/>
    </div>


%{--<hr/>--}%
</g:if>


<g:if test="${ssId && searchResultsTotal}">



    <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="executeSavedSearch" total="${searchResultsTotal}"
                             params="[id: ssId]" update="centralArea"/>
    </div>
    <br/>
</g:if>



<g:elseif test="${searchResultsTotal}">



    <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="hqlSearch" total="${searchResultsTotal}"
                             update="centralArea"/>
    </div>
    <br/>
</g:elseif>





%{--<g:if test="${!list}">--}%
%{--<i>No record.</i>--}%
%{--</g:if>--}%
<g:each in="${list}" status="i" var="record">
    <g:render template="/gTemplates/box" model="[record: record, mobileView: mobileView]"/>
</g:each>

<g:if test="${ssId && searchResultsTotal}">

    <br/>
    <br/> <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="executeSavedSearch" total="${searchResultsTotal}"
                             params="[id: ssId]" update="centralArea"/>
    </div>
    <br/>
</g:if>



<g:elseif test="${searchResultsTotal}">
    <br/>
    <br/>  <div class="paginateButtons" style="display:inline !important;">
        <util:remotePaginate controller="generics" action="hqlSearch" total="${searchResultsTotal}"
                             update="centralArea"/>
    </div>
    <br/>
</g:elseif>



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





<script type="text/javascript">
    //   $('#selectAll').click(function() {
    //        if (this.checked) {
    //            $(':checkbox').each(function() {
    //                this.checked = true;
    //            });
    //        } else {
    //            $(':checkbox').each(function() {
    //                this.checked = false;
    //            });
    //        }
    //    });

    /*

    $('#selectAll').click(function (e) {
    $("input[name^='select-']").each(function () {
//        this['value'] = 'on'
        this['checked'] = true
//        console.log(this.attr('value'));
        jQuery('#logRegion').load('/nibras/generics/selectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
    });
    })

    $('#deselectAll').click(function (e) {
    $("input[name^='select-']").each(function () {
        this['checked'] = false
//        console.log(this.attr('value'));
        jQuery('#logRegion').load('/nibras/generics/deselectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
    });
    })

//    });
*/
</script>
