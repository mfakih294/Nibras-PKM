<g:if test="${title && !ssId}">
<h3>
&sect;    ${title}
</h3>
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
            <br/>
        %{--<hr/>--}%
        </g:if>

    </div>

    </g:if>

<br/>

<a style="font-size: smaller; color: gray; float: right;" onclick="jQuery('#addHocTable').addClass('arabicText'); jQuery('#addHocTable tr td').addClass('arabicText')">RTL&nbsp; </a>

<g:if test="${list && list.size() > 0}">
    <div style="box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.2); padding-left: 10px; margin-left: 5px;">
    <table id="addHocTable" style="border-collapse: collapse; width: 95%; " class="uk-table uk-table-striped">
    %{--<table>--}%
        <g:each in="${list}" var="r" status="s">

            <g:if test="${r && !(r instanceof java.lang.String)}">
                <tr>
                <td style="padding: 5px; border-bottom: solid 1px gray !important; color: #eeeee;">
                    ${s + 1}
                    </td>
                <g:each in="${(0 .. r.size() - 1)}" var="c">
                    <td style="padding: 5px; border-bottom: solid 1px gray !important; color: #eeeee;">
                        ${r[c].encodeAsHTML()}
                    </td>
                </g:each>
            </tr>
             </g:if>
            <g:else>
                <tr>
                    <td style="padding: 5px; border-bottom: solid 1px gray !important; color: #eeeee;">
                        ${r.encodeAsHTML()}
                    </td>
                </tr>
            </g:else>

        </g:each>

    </table>	
    <br/>
    </div>
</g:if>
<g:else>
    Empty result set
</g:else>