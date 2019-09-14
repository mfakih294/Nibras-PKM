<%@ page import="mcs.Writing" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title><g:message code="writing.list" default="Writing List"/></title>

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

<g:render template="/writing/toolbar" model="[breadCrumb: breadCrumb, searchEnabled: true]"></g:render>

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

                <g:each in="${list}" var="w">
                    <h4><a class="fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all" tooltip="Edit"
                           href="${createLink(controller: 'writing', action: 'edit', id: w.id)}">
                        <span class="ui-icon ui-icon-pencil" style="display:inline;"/> </span>
                    </a> ${w.title}</h4>
                    ${w.body ? w.body.substring(0, Math.min(w.body.length(), 200)) : ''} <br/><br/>

                </g:each>
            </div>

        </div>

    </div>

</div>
<br/><br/>
</div>
</body>
</html>
