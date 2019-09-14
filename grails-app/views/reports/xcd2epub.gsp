<%@ page import="app.IndexCard; mcs.Course; mcs.Writing" %>


<html >
<head><title>Recent notes</title></head>

<body>

<% int i = ker.OperationController.getPath('epub.days_ago')?.toInteger() %>
<g:each in="${IndexCard.executeQuery('from IndexCard i  where i.dateCreated > ? and i.type.code != ? order by length(i.description) asc', [new Date() - i , 'aya'])}" var="c">

    <br/><br/>
<div style="${c.language == 'ar'  || c.language == 'fa' ? 'direction: rtl; text-align: right;' : ''}">
    <i>${c.course ? "(" + c.course.toString() + ")" : ''}</i>

    <h2>
        %{--<b><u><a>--}%

        ${c.summary }

        %{--</a></u></b>--}%
    </h2>
    <br/>
    ${c.dateCreated.format('dd.MM.yyyy')}
    <br/>
    <br/>

    ${c.description?.replaceAll('\n', '<br/>').encodeAsHTML().decodeHTML()}

    <hr/>
    %{--<br style="page-break-after:always"/>--}%
    
    </div>
</g:each>



</body>
</html>
