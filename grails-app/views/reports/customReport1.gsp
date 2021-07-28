<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
        BDL Paintings Report
    </title>
    <style>
    td {
        padding: 4px;
    }

    th {
        background: lightgreen
    }

    tr.even  td {
        background: #f2f1f1;
    }
    </style>
</head>

<body style="margin-left: 5%; margin-right: 5%">

<h3>BDL Paintings Report</h3>
Date: ${new Date()?.format('dd MMMM yyyy')}.
<br/>
<br/>
<table border=1 style="border: 1px darkgray; border-collapse: collapse;">
    <tr>
        <th style="">#</th>

        <th style="width: 58%">Title and description</th>
        <th style="">Location</th>
        <th style="">Asset #</th>
        <th>Image</th>
    </tr>
  <g:each in="${list}">
    <tr class="${i % 2 == 0 ? 'even': ''}">
        <td style="cell-collapse: collapse">
            ${i++}
        </td>

        <td style="line-height: 15px;padding: 4px; border-collapse: collapse">
            <b>${it.title ?: ''}</b>
            <br/>
            ${raw(it.description?.replace('\n', '<br/>'))}
        </td>
        <td style="vertical-align: top">
            ${it.status}
        </td>
        <td style="vertical-align: top">
            ${it.code}
        </td>
        <td>
            <img class="Photo" style="width: 90px; height: 120px; display:inline"
                 src="${createLink(controller: 'book', action: 'viewImage', id: it.id, params: [date: new Date()])}"/>
        </td>
    </tr/>
  </g:each>
    </table>

</body>

</html>





