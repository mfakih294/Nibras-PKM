<%@ page import="mcs.Goal" %>


<g:each in="${list}" var="goalInstance">      
      <g:render template="/goal/line" model="[goalInstance: goalInstance]"/>
      </g:each>

<div class="paginateButtons">
         <util:remotePaginate controller="goal" action="revise" total="${total}"
                             update="centralArea"/>
</div>