<%@ page import="ker.OperationController" %>

<% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);
    c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
    %>
    <b>Week</b> ${c.get(Calendar.WEEK_OF_YEAR)}

    ${new Date().format("dd MMM yyyy")}

&nbsp;  |
&nbsp;

    <b>${java.time.chrono.HijrahDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd MMMM yyyy"))}</b>


&nbsp;  |
&nbsp;
    <b>Repository 1</b>: ${ker.OperationController.getPath('root.rps1.path')}
&nbsp; |
&nbsp;
    &copy; khuta.org

&nbsp;|&nbsp;

C*:&nbsp; <g:each in="${mcs.Department.findAll([sort: 'orderNumber', order: 'asc'])}" var="d">
    <g:if test="${mcs.Course.countByDepartmentAndBookmarked(d, true, [sort: 'code', order: 'asc']) > 0}">
        <b style="font-size: 14px;">${d.code}</b>:
        <g:each in="${mcs.Course.findAllByDepartmentAndBookmarked(d,true, [sort: 'department', order: 'asc'])}" var="crs">
            <span style="font-size: 13px; border-radius: 2px; border: 1px lightgrey solid; padding: 1px; margin-right: 2px;">${crs.code}</span>
        </g:each>

    </g:if>
</g:each>


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