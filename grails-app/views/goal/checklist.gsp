<%@ page import="mcs.Goal" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Goals</title>

    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-1.3.2.min.js')}"></script>



    <script language="javascript" type="text/javascript">
        jQuery(document).ready(function () {

            jQuery('.searchField').val('');  // should only be in pages without data entry


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


    <div id="instancesDisplayArea">
        <g:render template="/goal/line" collection="${list}" var="goalInstance"/>

    </div>
    <br/><br/>
</div>
</body>
</html>
