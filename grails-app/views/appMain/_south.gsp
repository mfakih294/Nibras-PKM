<%@ page import="ker.OperationController" %>

<% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);
    c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
    %>
    <b>Week</b> ${c.get(Calendar.WEEK_OF_YEAR)}
&nbsp; &nbsp;   |
&nbsp; &nbsp; 
    ${new Date().format("E dd MMM yyyy")}

&nbsp; &nbsp;   |
&nbsp; &nbsp; 

    <b>${java.time.chrono.HijrahDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd MMMM yyyy"))}</b>


&nbsp; &nbsp;   |
&nbsp; &nbsp; 
    <b>Repository 1</b>: ${ker.OperationController.getPath('root.rps1.path')}

&nbsp; &nbsp;   |
&nbsp; &nbsp; 
    <b>Repository 2</b>: ${ker.OperationController.getPath('root.rps2.path')}
&nbsp; &nbsp;  |
&nbsp; &nbsp; 
   2020 &copy; khuta.org

&nbsp; &nbsp; |&nbsp; &nbsp; 


<span id="onlineLog"></span>

 &nbsp;
 / IPs:  &nbsp;
<g:each in="${ips}" var="ip">

   <b title="${ip.title}"> ${ip.ip}</b> (${ip.name})
    &nbsp; &nbsp;
</g:each>

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