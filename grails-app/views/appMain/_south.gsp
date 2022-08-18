<%@ page import="ker.OperationController" %>

<% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);
    c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
    %>
    <b>Week</b> ${c.get(Calendar.WEEK_OF_YEAR)}
&nbsp; &nbsp;   |
&nbsp; &nbsp; 
    ${new Date().format("E dd MMM")}

&nbsp; &nbsp;   |
&nbsp; &nbsp;

<g:if test="${OperationController.getPath('hijriDate.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <b>${java.time.chrono.HijrahDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd MMMM"))}</b>


&nbsp; &nbsp;   |
&nbsp; &nbsp;
    </g:if>

<g:remoteLink controller="report" action="whereIsMyData"
              update="centralArea"
              title="Location of data">
    My Data
%{--دقات--}%
%{--</g:remoteLink>--}%
%{--style="" target="_blank">--}%
%{--<span style="color: white" class="ui-icon ui-icon-signal"></span>--}%
%{--<g:message code="ui.menu.RSS"></g:message>--}%
</g:remoteLink>



&nbsp; &nbsp;   |
&nbsp; &nbsp;

<g:if test="${OperationController.getPath('rss.enabled')?.toLowerCase() == 'yes' ? true : false}">
<g:link controller="sync" action="rssPile"
        target="_blank"
        title="RSS feed">
%{--    <span class="ui-icon ui-icon-signal"></span> --}%
    RSS
</g:link>


&nbsp; &nbsp;   |
&nbsp; &nbsp;
</g:if>

<g:if test="${OperationController.getPath('selection-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <span style="padding-right: 1px !important;">

        <a onclick="selectAll()" href="#">Select all</a>
    &nbsp;
        <g:remoteLink controller="generics" action="showSelectedRecords"
                      update="centralArea"
                      style="padding-right: 0px !important"
                      before="jQuery.address.value(jQuery(this).attr('href'));"
                      title="Selected records">
            <g:message code="ui.selected"></g:message>
            (<span id="selectBasketRegion" style="color: white">${selectBasketCount ?: 0}</span>)
        </g:remoteLink>
    &nbsp;
    &nbsp;
        <g:remoteLink controller="generics" action="deselectAll"
                      update="selectBasketRegion"
                      style="padding-left: 0px !important; padding-right: 2px !important"
                      before="if(!confirm('Are you sure you want to deselect all selected records?')) return false"
                      title="Clear selection">
        %{--<g:message code="ui.clearAllSelection"></g:message> |--}%
            Clear
        </g:remoteLink>

    </span>
    &nbsp; &nbsp;  |
</g:if>





<g:if test="${OperationController.getPath('copyright.show')?.toLowerCase() == 'yes' ? true : false}">
                    
&nbsp; &nbsp; 
   ${new Date().format('yyyy')} &copy; khuta.org
    &nbsp; &nbsp; |&nbsp; &nbsp;
    </g:if>


<pkm:checkFolder name='rps1' path="${OperationController.getPath('root.rps1.path')}"/>
&nbsp;

    <pkm:checkFolder name='rps2' path="${OperationController.getPath('root.rps2.path')}"/>
&nbsp;

    <pkm:checkFolder name='edit' display='Edit'
                     path="${OperationController.getPath('editBox.path')}"/>
&nbsp;

    <span id="onlineLog"></span>
<g:if test="${OperationController.getPath('IPs.show')?.toLowerCase() == 'yes' ? true : false}">
 &nbsp;
  IPs:  &nbsp;
<g:each in="${ips}" var="ip">

   <b title="${ip.name}"> ${ip.ip}</b>
%{--    vs .title ?--}%
%{--    (${ip.name})--}%
    &nbsp; &nbsp;
</g:each>
</g:if>

<span style="border: 0px dashed darkgray; padding-left: 15px !important; background: #8e8e97">
    %{--${rpsSize}--}%
    ${new File('/nibras/rps1/new').listFiles().size()} new /
    %{--<% def fc = 0; new File('/nibras/rps1').traverse(){fc++} %> ${fc} total ---}%
    %{--<% def fc = 0; new File('/nibras/rps1').traverse(){fc++} %> ${fc} total ---}%
    <pkm:prettySize size="${new File('/nibras/rps1/new').directorySize()}" abbr="${true}"/>
</span>


<g:if test="${1==2}">

<span style="border: 0px dashed darkgray; padding-left: 15px !important; background: #8e8e97">

${mcs.Course.countByBookmarked(true)} C * / p4:

:&nbsp; &nbsp;  <g:each in="${mcs.Department.findAll([sort: 'orderNumber', order: 'asc'])}" var="d">
    <g:if test="${mcs.Course.countByDepartmentAndBookmarked(d, true, [sort: 'code', order: 'asc']) > 0}">
        %{--<b style="font-size: 14px;">${d.code}</b>:--}%
        <g:each in="${mcs.Course.findAllByDepartmentAndBookmarked(d,true, [sort: 'department', order: 'asc'])}" var="crs">
            <g:if test="${crs.priority == 4}">
            <span style="font-size: 13px; text-decoration: underline; border-radius: 2px; padding: 1px; margin-right: 4px;">${crs.code}</span>
            </g:if>
        </g:each>

    </g:if>
</g:each>
</span>

</g:if>


%{--    ${java.time.chrono.HijrahDate.now().get(java.time.temporal.ChronoField.DAY_OF_MONTH)}/--}%
%{--    ${java.time.chrono.HijrahDate.now().get(java.time.temporal.ChronoField.MONTH_OF_YEAR)}/--}%
%{--    ${java.time.chrono.HijrahDate.now().get(java.time.temporal.ChronoField.YEAR)}--}%


%{--    HijrahDate date = HijrahChronology.INSTANCE.date(1404,11,10);--}%
%{--    System.out.println(date.format(DateTimeFormatter.ofPattern("dd-MMMM-yyyy")));--}%
%{--    System.out.println(DateTimeFormatter.ofPattern("MMMM").format(hd,new Locale("ar")));--}%
%{--    which will show the output:--}%
%{--    10-Dhuʻl-Qiʻdah-1404--}%



    %{--<div class="ui-layout-content ui-widget-content">--}line-height: 1px;%

    %{--</div>--}%



<script type="text/javascript">
    function selectAll() {


            jQuery(':checkbox').each(function () {
                this.click()
            });

    };



        jQuery('#selectAll').click(function() {
            if (this.checked) {
                jQuery(':checkbox').each(function() {this.checked = true;});
            } else {
                jQuery(':checkbox').each(function() {
                    this.checked = false;
                });
            }
        });


</script>