%{--
  - Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
  -
  - This program is free software: you can redistribute it and/or modify
  - it under the terms of the GNU General Public License as published by
  - the Free Software Foundation, either version 3 of the License, or
  - (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  - GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License
  - along with this program.  If not, see <http://www.gnu.org/licenses/>
  --}%

<%@ page import="mcs.Planner; cmn.DataChangeAudit; ker.OperationController; app.Indicator; mcs.Goal; mcs.Task; mcs.Journal; mcs.Writing; app.IndexCard; mcs.Excerpt; mcs.Book; mcs.Course;" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <meta name="layout" content="main"/>
    <title>
        %{--${record.entityCode()}--}%
        ${record?.toString()}
    </title>
    %{--${record.id}--}%

    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'record.ico')}" type="image/png"/>

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    %{--<link rel="stylesheet" href="${resource(dir: 'select2/css', file: 'select2.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="./uikit/css/uikit.min.css"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'search.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'autocomplete.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit-rtl.min.css')}"/>--}%


    <link rel="stylesheet" href="../uikit/css/uikit.min.css"/>
    <link rel="stylesheet" href="../uikit/css/uikit-rtl.min.css"/>
    <link rel="stylesheet" href="../uikit/css/dashboard.css"/>


    <script type="text/javascript" src="../uikit/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../uikit/js/uikit.min.js"></script>
    <script type="text/javascript" src="../uikit/js/uikit-icons.min.js"></script>



    <style>
        td a {
            line-height: 25px;
        }


    </style>

</head>

<body class="uk-margin-left uk-margin-right rtl">

%{--<g:if test="${record.entityCode() == 'R'}">--}%
    %{--<h2>Resource page</h2>--}%
%{--</g:if>--}%
%{----}%
%{--<g:if test="${record.entityCode() == 'G'}">--}%
    %{--<h2>Goal page</h2>--}%
%{--</g:if>--}%
%{----}%
%{--<g:if test="${record.entityCode() == 'W'}">--}%
    %{--<h2>Writing page</h2>--}%
%{--</g:if>--}%




%{--<div style="background: lightgray; direction: rtl; text-align: right; margin: 3% 10% 3% 10%; max-width: 700px; line-height: 25px;">--}%

    <g:render template="/gTemplates/staticRecord" model="[record: record]"/>

<g:if test="${record.url}">
    <span style="">
        <b>رابط :</b>

        <a href="${record.url}">
            <pkm:summarize
                    text="${record?.url}"
                    length="60"/>
        </a>

        <span id="linkBloc${record.id}"></span>

    </span>
    <br/>
%{--${record.author},${record.title ?: record.legacyTitle} ${record.edition} ed--}%
%{--(${record.publisher},--}%
%{--${record.publicationDate})--}%
</g:if>



%{--<g:render template="/gTemplates/filesListing" model="[record: record, entityCode: record.entityCode(), isStatic: 'yes']"/>--}%

<g:if test="${record.class.declaredFields.name.contains('fullText') && record.fullText}">
<br/> ${raw(record.fullText?.replaceAll('\n', '<br/>'))}
</g:if>
%{--<g:if test="${record.class.declaredFields.name.contains('notes') && record.notes}">--}%
%{--<br/>       <i>${record.notes?.replaceAll('\n', '<br/>')?.decodeHTML()}</i>--}%
%{--</g:if>--}%
%{--</div>--}%
                %{--<g:render template="/gTemplates/recordSummary" model="[record: record]"/>--}%

</body>


</html>
