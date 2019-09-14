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
&sect;    ${title}
</h2>

<div style="direction: rtl; text-align: justify; ">
    %{--line-height: 200%--}%

    <div style="direction: rtl; text-align: right;  -webkit-column-count: 4; -moz-column-count: 4; column-count: 4;  ">
        <g:each in="${mcs.Writing.executeQuery('from Writing i where i.type.code = ? order by i.orderInBook', ['surah'])}"
                status="s"
                var="w">

            <a id="back-${w.id}">${s + 1}</a>
            &nbsp; <a href="#${w.id}">${w}</a>
            <br/>
        </g:each>
    </div>




    <g:each in="${mcs.Writing.executeQuery('from Writing i where i.type.code = ? order by i.orderInBook', ['surah'])}"
            var="s">

        <h3><a id="${s.id}">${s.orderInBook} ${s}</a></h3>

        <g:each in="${4..2}" var="j">
            <h4>مستوى  ${j}</h4>
            <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ?   order by i.orderInWriting', [s.id.toString(), 'aya'])}"
                    var="r">

                <g:if test="${r.isNewSection}">
                    <br/>
                </g:if>
                <g:if test="${r.orderInWriting == 1}">
                    <span style="" class="aya">

                        <g:each in="${(0..7)}" var="i">
                            <g:if test="${i < r.shortDescription.split(' ')?.size()}">
                                ${r.shortDescription.split(' ')[i]}
                            </g:if>
                        </g:each>...  ${r.orderInWriting}

                    </span>
                </g:if>
                <g:else>
                    <span style="" class="aya">

                        %{--<g:each in="${(0..ker.OperationController.getPath('aya.first.words.count').toInteger() - 1)}" var="i">--}%
                        <g:each in="${(0..j - 1)}" var="i">
                            <g:if test="${i < r.shortDescription.split(' ')?.size()}">
                                ${r.shortDescription.split(' ')[i]}
                            </g:if>
                        </g:each>... ${r.orderInWriting}

                    </span>
                </g:else>

            </g:each>
        </g:each>

    </g:each>
</div>

<script type="application/javascript">
    jQuery('#123').focus();
</script>