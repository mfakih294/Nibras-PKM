
Convert to/from week date format
(dd.MM.yyy <-> wwd.yy)
%{--ToDo add to hint list--}%
<g:remoteField style="height: 20px; width: 90px;" controller="operation" action="convertDate"
               update="convertedDate" elementId="dateToConvert" name="dateToConvert" value=""/>
&nbsp;
<div id="convertedDate" style="display: inline;"></div>
