<%@ page import="mcs.Goal" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title><g:message code="goal.list" default="Goal List"/></title>

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

<g:render template="/goal/toolbar" model="[breadCrumb: breadCrumb, searchEnabled: true]"></g:render>

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
                        <li><a href="#type-${e.id}"><span>${e} - ${Goal.countByGoalType(e)}</span></a></li>

                    </g:each>
                </ul>
                <g:each in="${types}" var="e">
                    <div id="type-${e.id}" style="-moz-column-count:2; ">
                        <g:findAll in="${Goal.list()}" expr="it.goalType == e">
                            <h4><a class="fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"
                                   tooltip="Edit"
                                   href="${createLink(controller: 'goal', action: 'edit', id: it.id)}">
                                <span class="ui-icon ui-icon-pencil" style="display:inline;"/> </span></a>${it.title}
                            </h4>
                            ${it.description}

                            <a class="fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all" tooltip="to writing"
                            href="${createLink(controller: 'goal', action: 'convertToWriting', id: it.id)}" target="_blank">
                            <span class="ui-icon ui-icon-arrow-1-w" style="display:inline;"/> </span>

      </a>
                            <br/><br/>
                        %{--<g:render template="/goal/line" model="['goalInstance': it]"/>--}%
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
