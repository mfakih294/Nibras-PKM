<%@ page import="mcs.Journal" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title><g:message code="journal.list" default="Journal List"/></title>

    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-1.3.2.min.js')}"></script>



    <script language="javascript" type="text/javascript">
        jQuery(document).ready(function () {

            jQuery('.searchField').val('');  // should only be in pages without data entry
            jQuery("#tabsTask").tabs({
                cookie:{ expires:30 }
            });


        });
    </script>

</head>

<body>

<g:render template="/journal/toolbar" model="[breadCrumb: breadCrumb, searchEnabled: true]"></g:render>

<div id="searchResults"></div>

<div class="body">

    <g:if test="${flash.message}">
        <script type="text/javascript">
            jQuery.achtung({message:'<g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />', timeout:2});
        </script>
    </g:if>


    <div class="list">
        <div id="instancesDisplayArea">

            <div id="tabsTask">
                <ul>
                    <g:each in="${types}" var="e">
                        <li><a href="#type-${e.id}"><span>${e} - ${Journal.countByType(e)}</span></a></li>

                    </g:each>
                </ul>
                <g:each in="${types}" var="e">
                    <div id="type-${e.id}" style="-moz-column-count:3">
                        <g:findAll in="${Journal.list()}" expr="it.type == e">
                            <h4>${it.level} - ${it.startDate.format('dd.MM.yyyy')}</h4>
                            ${it.body}<br/><br/>
                        %{--<g:render template="/journal/line" model="['journalInstance': it]"/>--}%
                        </g:findAll>
                    </div>
                </g:each>

            </div>

        </div>

    </div>
    <br/><br/>
</div>
</body>
</html>
