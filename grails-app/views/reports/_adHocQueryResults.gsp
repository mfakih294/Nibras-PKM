<g:if test="${title}">
<h2>
&sect;    ${title}
</h2>
</g:if>
<br/>

<a style="font-size: smaller; color: gray; float: right;" onclick="jQuery('#addHocTable').addClass('arabicText'); jQuery('#addHocTable tr td').addClass('arabicText')">RTL&nbsp; </a>

<g:if test="${list && list.size() > 0}">
    <div style="box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.2); background: #F2F2F2; padding-left: 10px; margin-left: 5px;">
    <table id="addHocTable" style="border-collapse: collapse; width: 95%; ">
    %{--<table>--}%
        <g:each in="${list}" var="r">

            <g:if test="${r && !(r instanceof java.lang.String)}">
                <tr>
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