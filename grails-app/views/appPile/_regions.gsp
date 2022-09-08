<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
%{--${ker.OperationController.getPath('app.headers.background') ?: '#5b7a59'}--}%
<div class="ui-layout-north southRegion appBkg" style="overflow: hidden;"
     style="">
    %{--<g:render template="/layouts/north" model="[]"/>--}%
    <g:render template="/appPile/north"/>
</div>

<div class="ui-layout-west westRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">
    %{--<div class="ui-layout-content ui-widget-content">--}%

    <g:render template="/appPile/west"/>

</div>

<div class="ui-layout-south footerRegion"
     style="font-size: 11px; margin-top: 9px; min-height: 0px !important;  padding: 3px; direction: ltr; text-align: left; font-family: tahoma; color: white">

    <% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);
    c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
    %>
    <b>Week</b> ${c.get(Calendar.WEEK_OF_YEAR)} /
%{--    / ${new Date().format("E")}--}%



&nbsp;
&nbsp;
&nbsp;&nbsp;&nbsp;
    <i>${java.time.chrono.HijrahDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd MMMM yyyy"))}</i>
    &nbsp;&nbsp;&nbsp;
    <b>Repository 1</b>: ${OperationController.getPath('root.rps1.path')}

&nbsp;&nbsp;&nbsp;
&copy; khuta.org/nibras


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
</div>


%{--<div class="ui-layout-east eastRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">--}%

    %{--<div class="ui-layout-content ui-widget-content">--}%

    %{--<g:render template="/appCourse/east"/>--}%
%{--</div>--}%


<div class="ui-layout-center appBkg" style="margin-top: 2px !important; margin-bottom: 2px !important;"
     onmouseover="jQuery('#hintArea').html('')">
    %{--ToDo: display none?!--}%
    %{--<div class="ui-layout-content ui-widget-content" onmouseover="jQuery('#hintArea').html('')">--}%


    <div id="logRegion"></div>

    <div id="logArea"></div>


    <div id="searchArea" class="nonPrintable">

    </div>

    <div id="spinner2" style="display:none; z-index: 10000 !important">
        <img src="${resource(dir: '/images', file: 'pmg-grain.gif')}" alt="Spinner2"
             style="z-index: 10000 !important; display: none;"/>
    </div>
    %{--<sec:ifNotGranted roles="ROLE_ADMIN">--}%
    %{--<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
    %{--<g:render template="/layouts/commandbar" model="[]"/>--}%
    %{--</g:if>--}%
    %{--</sec:ifNotGranted>--}%
    <div id="accordionCenter"
         style="margin: 0px !important; width: 100% !important; padding-bottom: 0px !important;">

        <h6 style="text-aling: center"><a href="#" id="testTitle1">
            Main panel
        </a></h6>

        <div id="inner1" class="common" style="">

            <div id="centralArea" class="common" style="">

                <div id="3rdPanel">

                </div>



                %{--<g:render template="/gTemplates/recordSummary" model="[record: record]"/>--}%


        </div>

    </div>
    %{--<hr/>--}%
    %{--before="jQuery('#testTitle1').text('[1]: ' + jQuery('#quickAddTextFieldBottomTop').val());"--}%
    %{--if (jQuery('#quickAddTextFieldBottomTop').val().search('--')== -1){--}%
    %{--<div style="-moz-column-count: 3; -webkit-column-count:3">--}%
    <div id="hintArea" style="font-size: 12px; padding: 0px; margin: 0px; "></div>
    %{--</div>--}%

</div>
</div>
<script type="text/javascript">
    jQuery(".chosen").chosen({allow_single_deselect: true, no_results_text: "None found"});
    jQuery("#chosenTags").chosen({allow_single_deselect: true, no_results_text: "None found"});
    jQuery("#chosenTagsArt").chosen({allow_single_deselect: true, no_results_text: "None found"});

    //    jQuery("#addXcdFormNgs").relatedSelects({
    //        onChangeLoad: '${request.contextPath}/generics/fetchCoursesForDepartment',
    //        defaultOptionText: '',
    //        selects: {
    //            'department.id': {loadingMessage: ''},
    //            'course.id': {loadingMessage: ''}
    //        }
    //    });

    jQuery("#addArticleFormNgs").relatedSelects({
        onChangeLoad: '${request.contextPath}/generics/fetchCoursesForDepartment',
        defaultOptionText: '',
        selects: {
            'department.id': {loadingMessage: ''},
            'course.id': {loadingMessage: ''}
        }
    });
    jQuery("#addXcdFormNgs").relatedSelects({
        onChangeLoad: '${request.contextPath}/generics/fetchWritingsForCourse',
        defaultOptionText: '',
        selects: {
            'course.id': {loadingMessage: ''},
            'writing.id': {loadingMessage: ''}
        }
    });

    jQuery('#chosenTags_chzn').addClass('width95')
    jQuery('#chosenTagsArt_chzn').addClass('width95')


    var clearFormFields = function () {

        jQuery('#title').val('')
        jQuery('#summary').val('')
        jQuery('#description').val('')
        jQuery('#fullText').val('')
        jQuery('#link').val('')
        jQuery('#url').val('')
        jQuery('#approximateDate').clear()
    }


    $(".common").prev('h6').click(function () {
        document.getElementById("centralArea").setAttribute("id", "tmpId");
        //$(this).id//.nextSibling().setAttribute("id", "centralArea");
//        console.log(document.getElementById($(this).next().attr("id")).attr("id"))
        //$(this).next()[0].firstChild.setAttribute("id", "centralArea");
        $(this).next()[0].firstChild.nextSibling.setAttribute("id", "centralArea");
        //console.log($(this).next().attr('id'));


        //alert(currentID);

//        $(this).next().setAttribute("id", "centralArea");

    });


</script>