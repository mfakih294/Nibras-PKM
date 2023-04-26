%{--<div style="line-height: 25px; border-right: 2px solid darkgreen; padding: 7px; margin: 40px 40px;" class="text${record.class.declaredFields.name.contains('language') ? record.language : ''}">--}%
    %{--[${entityCode}--}%
    %{--${record.id}]--}%

    <article class="uk-article" style=" border: 1px solid darkgray; margin: 10px; padding; 7px; ">

    <div class="uk-article-title" style="background-color: #edf2eb; padding: 7px; font-size: 1.2em;">


        <a href="./posts/${record.id}.html" target="_blank"
           class="fg-button ui-widget ui-state-default ui-corner-all"
           title="Go to page">

        <g:if test="${record.class.declaredFields.name.contains('summary') && record.summary}">
            ${record.summary}
        </g:if>

        <g:if test="${record.class.declaredFields.name.contains('title') && record.title}">
            ${record.title}
        </g:if>
            </a>

<g:if test="${new Date() - record.dateCreated < 3}">
        <span class="uk-panel-bady uk-badge rtl" style="font-size: 1.2em;">
            جديد${record.dateCreated - new Date()}
        </span>
    </g:if>

    </div>

    <p class="uk-article-meta" style="color: black">

        <g:if test="${record.class.declaredFields.name.contains('author') && record.author}">
            <br/><i>${record.author}</i>
            &nbsp;
        </g:if>

        <g:if test="${record.publisher}">
            <b></b> ${record.publisher}
            &nbsp;
        </g:if>
        <g:if test="${record.journal}">
            <b></b>${record.journal}
            &nbsp;
        </g:if>
        <g:if test="${record.edition}">
            <b></b>${record.edition}
            &nbsp;
        </g:if>
        <g:if test="${record.book}">
            <b></b> ${record.book?.title}
            &nbsp;
        </g:if>
        <g:if test="${record.publicationDate}">
            <b></b>${record.publicationDate}
            &nbsp;
        </g:if>
        <g:if test="${record.year}">
            <b></b> ${record.year}
            &nbsp;
        </g:if>
        <g:if test="${record.month}">
            <b>شهر</b>: ${record.month}
            &nbsp;
        </g:if>
        <g:if test="${record.volume}">
            <b>مجلّد</b> ${record.volume}
            &nbsp;
        </g:if>
        <g:if test="${record.series}">
            <b>سلسلة</b> ${record.series}
            &nbsp;
        </g:if>
        <g:if test="${record.number}">
            <b>عدد</b>: ${record.number}
            &nbsp;
        </g:if>


    </p>

    <p class="uk-article-lead" style="background-color: #f8fdf6; padding: 7px">
%{--g:link controller="page" action="staticPage" target="_blank" id="${record.id}"--}%
<a href="./posts/${record.id}.html" target="_blank"
        class="fg-button ui-widget ui-state-default ui-corner-all"
        title="Go to page">

    <img class="Photo" style="width: 120px; height: 160px; display:inline; text-align: right; margin: 7px;"
            onerror="this.style.display='none'"
         src="https://khuta.org/jabal-amel-4/covers/${record.id}.jpg"/>

    %{--src="${createLink(controller: 'generics', action: 'viewRecordImage', id: (record.id + '.jpg'))}"--}%

    <g:if test="${record.class.declaredFields.name.contains('description') && record.description}">
        ${raw(record.description?.replaceAll('\n', '<br/>'))}
    </g:if>
    <a>
    </p>

    %{--<g:link controller="page" action="staticPage" target="_blank" id="${record.id}"--}%

            %{--class="fg-button ui-widget ui-state-default ui-corner-all"--}%
            %{--title="Go to page">--}%

    %{--params: [entityCode: record.entityCode()]--}%
    %{--, date: new Date()--}%
    %{--</g:link>--}%
<div style="clear: both"></div>
    %{--<hr class="uk-article-divider"/>--}%



</article>
<g:if test="${1==2}">

    <table dir="rtl" style="direction: rtl; background: #f4ffdf; padding: 9px; width: 95%;border: 1px solid lightgoldenrodyellow;">
        <tr>
            <td style="width: 120px; vertical-align: top;">

        %{--<img src="https://localhost:1441/files/R/${record?.type?.code}/${(record.id / 100).toInteger()}/${record.id}/cover.jpg" style="width: 15px;"--}%
            %{--title=""/>--}%
                %{--params="${[id: record.id, entityCode: record.entityCode()]}"--}%
                <g:link controller="page" action="staticPage" target="_blank" id="${record.id}"

                        class="fg-button ui-widget ui-state-default ui-corner-all"
                        title="Go to page">

                    <img class="Photo" style="width: 120px; height: 160px; display:inline" onerror="this.style.display='none'"
                         src="${createLink(controller: 'generics', action: 'viewRecordImage', id: (record.id + '.jpg'))}"/>
                    %{--params: [entityCode: record.entityCode()]--}%
                    %{--, date: new Date()--}%
                </g:link>
            </td>

            <td style="vertical-align: top; padding-left: 15px;">

                %{--params="${[id: record.id, entityCode: record.entityCode()]}"--}%
                <g:link controller="page" action="staticPage" target="_blank" id="${record.id}"
                        class="fg-button ui-widget ui-state-default ui-corner-all"
                        title="Go to page">

                    <g:if test="${record.class.declaredFields.name.contains('summary') && record.summary}">
                        <b>${record.summary}</b>
                        <br/>
                    </g:if>


                    <g:if test="${record.class.declaredFields.name.contains('title') && record.title}">
                        <b style="font-size: 1.3em">${record.title}</b>
                    </g:if>

                    <g:if test="${record.class.declaredFields.name.contains('author') && record.author}">
                        <br/><i>${record.author}</i>
                        <br/>
                    </g:if>

                    <g:if test="${record.publisher}">
                        <b></b> ${record.publisher}
                        <br/>
                    </g:if>
                    <g:if test="${record.journal}">
                        <b></b>${record.journal}
                        <br/>
                    </g:if>
                    <g:if test="${record.edition}">
                        <b></b>${record.edition}
                        <br/>
                    </g:if>
                    <g:if test="${record.book}">
                        <b></b> ${record.book?.title}
                        <br/>
                    </g:if>
                    <g:if test="${record.publicationDate}">
                        <b></b>${record.publicationDate}
                        <br/>
                    </g:if>
                    <g:if test="${record.year}">
                        <b></b> ${record.year}
                        <br/>
                    </g:if>
                    <g:if test="${record.month}">
                        <b>شهر</b>: ${record.month}
                        <br/>
                    </g:if>
                    <g:if test="${record.volume}">
                        <b>مجلّد</b> ${record.volume}
                        <br/>
                    </g:if>
                    <g:if test="${record.series}">
                        <b>سلسلة</b> ${record.series}
                        <br/>
                    </g:if>
                    <g:if test="${record.number}">
                        <b>عدد</b>: ${record.number}
                        <br/>
                    </g:if>



                    <g:if test="${record.class.declaredFields.name.contains('description') && record.description}">
                        <br/>                       ${raw(record.description?.replaceAll('\n', '<br/>'))}
                    </g:if>

                </g:link>



            </td>
        </tr>
    </table>
</g:if>
%{--</div>--}%

