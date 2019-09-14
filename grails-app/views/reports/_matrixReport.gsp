<%@ page import="app.IndexCard" %>
<style type="text/css">

.aya {
    color: black;
}

.aya0 {
    font-size: 24px;
    font-family: "traditional arabic";
    color: black;
    background: #ffdcd4;
}

.aya1 {
    font-size: 24px;
    font-family: "traditional arabic";
    color: white;
    background: #f7b6b3;
}

.aya2 {
    font-size: 22px;
    font-family: "traditional arabic";
    color: white;
    /*background: #f3f1cf;*/
}

.aya3 {
    font-size: 24px;
    font-family: "traditional arabic";
    font-weight: bold;
    color: black;
    background: #e8f6d4;
}

.aya4 {
    font-size: 24px;
    font-family: "traditional arabic";
    color: black;
    font-weight: bold;
    background: #dbe6fa;
}

</style>

<input type="text" style="width: 5px;" value="" id="123"></input>

<h2 class="arabicText">
&sect; آداب   معراج المؤمن
</h2>

<div style="direction: rtl; text-align: justify; ">
    %{--line-height: 200%--}%
    <table border="1" style="border: 1px solid darkgray; direction: rtl; text-align: right;">
        <tr>
            <td></td>
            <g:each in="${mcs.Writing.executeQuery('from Writing i where i.course.code = ? ', ['adab2'])}"
                    var="s">

                <td style=" direction: rtl; text-align: right;">
                    ${s}</td>

            </g:each>
        </tr>
        <g:each in="${app.Contact.executeQuery('select i.contact from IndexCard i where i.course.code = ? group by i.contact', ['adab2'])}"
                var="c">
            <tr>
                <td style="vertical-align: top"><b>${c}</b></td>

                <g:each in="${mcs.Writing.executeQuery('from Writing i where i.course.code = ? order by i.id asc ', ['adab2'])}"
                        var="s2">
                    <g:if test="${app.IndexCard.executeQuery('select count(*) from IndexCard i where i.recordId = ? and i.contact = ? ', [s2.id.toString(), c])[0] > 0}">
                        <td style="vertical-align: top; direction: rtl; text-align: right;">

                            <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.contact = ? ', [s2.id.toString(), c])}"
                                    var="n">
                                <span title="${n.description?.replace('\n', '<br/>')}">
                                    <pkm:summarize text="${n.description}"
                                                   length="${180}"/>
                                </span>
                            </g:each>
                        </td>
                    </g:if>
                    <g:else>
                        <td></td>
                    </g:else>
                </g:each>
            </tr>
        </g:each>

    </table>
</div>
<script type="application/javascript">
    jQuery('#123').focus();
</script>