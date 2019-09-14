<%@ page import="app.IndexCard; mcs.Writing" %>
<html lang="ar" dir="rtl">

<head>
    <title>Qur'ani</title>

    %{--<link rel="stylesheet" href="./site/css/main.css"/>--}%

    %{--<link rel="stylesheet" href="./site/css/personalization.css"/>--}%

    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout-mine.css')}"/>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'personalization.css')}"/>

</head>


<body style="margin: auto; width: 70%; font-family: tahoma; text-align: right;">

<h2 class="arabicText">
    ${app.IndexCard.executeQuery('select count(*) from IndexCard i where i.type.code = ? and (i.priority >= 3 or i.priority < 2)', ['aya'])[0]}
    إشارة
    /
    ${app.IndexCard.executeQuery('select count(*) from IndexCard i where i.type.code = ? and i.notes is not null', ['aya'])[0]}
    حاشية
</h2>


<h3>السور</h3>

<div style="direction: rtl; text-align: right;  -webkit-column-count: 6; -moz-column-count: 6; column-count: 6;  column-gap: 4px;">
    <g:each in="${mcs.Writing.executeQuery('from Writing i where i.type.code = ? order by i.orderInBook', ['surah'])}"
            status="s"
            var="w">

        <a id="back-${w.id}">${s + 1}</a>
        &nbsp; <a href="#${w.id}">${w}</a>


        <br/>
    </g:each>
</div>



<g:each in="${mcs.Writing.executeQuery('from Writing i where i.type.code = ? order by i.orderInBook', ['surah'])}"
        var="w">

    <h1><a id="${w.id}">${w}</a></h1>
%{--<a href="back-${w.id}">b</a>--}%


    <div style="padding-left: 10px; margin-left: 5px;">
        <table class="arabicText" style=" direction: rtl; border-collapse: collapse; width: 90%; ">
        %{--<table>--}%
        %{--<g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ? and (i.notes is not null or i.priority >= 3 or i.priority < 2) order by i.orderInWriting',[w.id.toString(), 'aya'])}"--}%
            <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ? and (i.notes is not null and i.reviewCount = 0) order by i.orderInWriting', [w.id.toString(), 'aya'])}"
                    var="r">

                <tr>

                    <td class="arabicText"
                        style="${r.bookmarked ? 'font-weight: bold' : ''}; font-family: 'traditional arabic'; font-size: 21px; width: 30%; line-height: 40px; padding: 5px; border-bottom: solid 1px gray !important; color: #eeeee;">

                        <div style="direction: rtl; text-align: right;">

                            %{--<g:if test="${r.isNewSection}"><br/></g:if>--}%
                            م${r.priority}  (آ${r.orderInWriting})     <div style="font-weight: bold; display: inline;"
                                                                            title="${r.description != '?' ? r.description : ''}"
                                                                            class="aya aya${r.priority}">
                            ${r.shortDescription}</div>

                            <span style="color: #4A5C69">
                                ${r.description != '?' ? 'آ' + r.description : ''}
                            </span>
                            <span style="color: #123456">
                                <g:if test="${r.notes}">
                                    :: ${r.notes?.replaceAll('\n', '<br/>')}

                                    <g:remoteLink controller="generics" action="markCompleted"
                                                  id="${r.id}"
                                                  params="[entityCode: 'N']"
                                                  update="Aya${r.id}"
                                                  title="Mark completed">
                                        <b>done</b>
                                    </g:remoteLink>
                                    <g:remoteLink controller="generics" action="markReviewed"
                                                  id="${r.id}"
                                                  params="[entityCode: 'N']"
                                                  update="Aya${r.id}"
                                                  title="Mark review">
                                        <b style="color: darkgreen">rev</b>
                                    </g:remoteLink>



                                <div id="Aya${r.id}"></div>
                                </g:if>

                            </span>
                            <i style="font-size: 10px">${r.id}</i>
                        </div>
                    </td>

                </tr>

            </g:each>

        </table>
    </div>
</g:each>

<br/>

</body>
</html>