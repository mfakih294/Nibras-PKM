<%@ page import="ker.OperationController; java.time.temporal.ChronoUnit; mcs.parameters.JournalType; mcs.Journal; mcs.Planner; mcs.parameters.PlannerType" %>


<html lang="ar">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>
        ${OperationController.getPath('app.name') ? OperationController.getPath('app.name') + ' Dashboard': 'Nibras Dashboard'}
        </title>

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'calendar.ico')}" type="image/ico"/>
    <!-- The javascript and css are managed by sprockets. The files can be found in the /assets folder-->

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>

    <script type="application/javascript">

    setInterval(function() {
        jQuery.ajax({
            type: 'GET',
            url: '${request.contextPath}/page/heartbeat',
            dataType: 'html',
            success: function(html, textStatus) {
                if (html == 'ok') {
                    window.location.href = window.location;
                    jQuery('#logArea2').html("<span style='background: darkgray; color: darkgreen'>Online</span>");
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                jQuery('#logArea2').html("<span style='background: darkgray; color: darkred'>Offline</span>");
//                        console.log('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
            }
        });
    }, 60000);

</script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'dashboard/application.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'dashboard/css.css')}"/>

    <link rel="icon" href="favicon.ico">

    <style type="text/css">


        .content {
            padding: 3px;
            direction: rtl !important;
            text-align: right !important;
            vertical-align: top !important;
        }


    [data-col="5"] {
        left: 1245px;
    }

    [data-col="4"] {
        left: 935px;
    }

    [data-col="3"] {
        left: 625px;
    }

    [data-col="2"] {
        left: 315px;
    }

    [data-col="1"] {
        left: 5px;
    }

    [data-row="16"] {
        top: 5555px;
    }

    [data-row="15"] {
        top: 5185px;
    }

    [data-row="14"] {
        top: 4815px;
    }

    [data-row="13"] {
        top: 4445px;
    }

    [data-row="12"] {
        top: 4075px;
    }

    [data-row="11"] {
        top: 3705px;
    }

    [data-row="10"] {
        top: 3335px;
    }

    [data-row="9"] {
        top: 2965px;
    }

    [data-row="8"] {
        top: 2595px;
    }

    [data-row="7"] {
        top: 2225px;
    }

    [data-row="6"] {
        top: 1855px;
    }

    [data-row="5"] {
        top: 1450px;
    }

    [data-row="4"] {
        top: 560px;
    }

    [data-row="3"] {
        top: 310px;
    }

    [data-row="2"] {
        top: 60px;
    }

    [data-row="1"] {
        top: 5px;
    }

    [data-sizey="1"] {
        height: 240px;
    }

    [data-sizey="2"] {
        height: 580px;
    }

    [data-sizey="3"] {
        height: 680px;
    }

    [data-sizey="4"] {
        height: 1470px;
    }

    [data-sizey="5"] {
        height: 1840px;
    }

    [data-sizey="6"] {
        height: 2210px;
    }

    [data-sizey="7"] {
        height: 2580px;
    }

    [data-sizey="8"] {
        height: 2950px;
    }

    [data-sizey="9"] {
        height: 3320px;
    }

    [data-sizey="10"] {
        height: 3690px;
    }

    [data-sizey="11"] {
        height: 4060px;
    }

    [data-sizey="12"] {
        height: 4430px;
    }

    [data-sizey="13"] {
        height: 4800px;
    }

    [data-sizey="14"] {
        height: 5170px;
    }

    [data-sizey="15"] {
        height: 5540px;
    }

    [data-sizex="1"] {
        width: 300px;
    }

    [data-sizex="2"] {
        width: 610px;
    }

    [data-sizex="3"] {
        width: 920px;
    }

    [data-sizex="4"] {
        width: 1230px;
    }
    </style></head>

<body style="direction: rtl; text-align: right;">
<div id="container">
    <div class="gridster ready" style="width: 100%;">
        <ul style="height: 370px; width: 930px; position: relative;">

            <li data-row="1" data-col="1" data-sizex="3" data-sizey="1" class="gs-w  widget-meter"  style="height: 50px !important;">
                <div data-id="welcome" data-title="اليوم" data-text="14 شعبان 1441هـ. " data-moreinfo=""
                     class="widget widget-outboard welcome">

                    <b class="title" data-bind="title">
                    %{--                    مواقيت الصلاة--}%

%{--                        \--}%
%{--                    <% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);--}%
%{--                    c.setFirstDayOfWeek(java.util.Calendar.MONDAY)--}%
%{--                    %>--}%
%{--                    <b>أ</b> ${c.get(Calendar.WEEK_OF_YEAR)}--}%

                </b>

                    <div class="content" style="font-size: 0.7em; text-align: center;">

<g:if test="${ker.OperationController.getPath('hijriDate.enabled')?.toLowerCase() == 'yes' ? true : false}">
                        <b>
                            <b>${((java.time.chrono.HijrahDate.now().plus(ker.OperationController.getPath('hijri.adjustment') ? ker.OperationController.getPath('hijri.adjustment').toInteger(): 0, java.time.temporal.ChronoUnit.DAYS))).format(java.time.format.DateTimeFormatter.ofPattern("dd MMMM").withLocale(Locale.forLanguageTag('ar')))}</b>:
%{--                            &nbsp;&nbsp; ${new Date().format("E dd HH:mm")}: &nbsp;--}%
                        </b>
    &nbsp;

                        <g:set var="aya"
                               value="${app.IndexCard.executeQuery('from IndexCard i where i.priority >= ? and i.type.code = ? and length(i.summary) < 80', [4, 'aya'], [offset: Math.floor(Math.random()*100)])[0]}"/>
                        {
                        ${aya.shortDescription}
                        }
                        (${mcs.Writing.get(aya.recordId)?.summary}
                        ${aya.orderInWriting})
</g:if>
                    </div>
                </div>
            </li>


            <li data-row="2" data-col="1" data-sizex="1" data-sizey="1" class="gs-w">
                <div data-id="welcome" data-title="اليوم" data-text="14 شعبان 1441هـ. " data-moreinfo=""
                     class="widget widget-outboard welcome"><h1 class="title" data-bind="title">
%{--                    مواقيت الصلاة--}%
                  C *
                </h1>

                    <div class="content">

                        <ol style="direction: rtl; text-align: right; margin-right: 30px;">
                            <g:each in="${mcs.Course.findAllByBookmarked(true, [sort: 'department', order: 'desc'])}" var="j">
                                <li>
                                    [${j.code}]
                                    ${j.summary}
                                </li>

                            </g:each>
                        </ol>


                    </div>

                    <p class="more-info" data-bind="moreinfo"></p>

                    <p class="updated-at" data-bind="updatedAtMessage"></p>
                </div>
            </li>

            <li data-row="2" data-col="2" data-sizex="1" data-sizey="1" class="gs-w widget-list">
                <div data-id="outboard-prayers" data-title=" " style="direction: rtl; text-align: right; font-size: .8em;"
                     class="widget widget-outboard outboard-prayers">

                    <h1 class="title"  data-bind="title">
G* p4
                </h1>
                    <div class="content" style="">

                    <ol style="direction: rtl; text-align: right; line-height: 12px;">
                        <g:each in="${mcs.Goal.findAllByBookmarkedAndPriorityGreaterThan(true, 3, [sort: 'department', order: 'desc'])}" var="j">
                            <li>
                                [${j.course?.code}]
                                <b>${j.summary}</b>
%{--                                <pkm:prettyDuration date1="${j.endDate ?: j.startDate}"/>--}%
                            </li>

                        </g:each>
                    </ol>


                    %{--                    <p class="updated-at" data-bind="updatedAtMessage">Last updated at 15:28</p>--}%
                </div>
                </div>
            </li>

            <li data-row="2" data-col="3" data-sizex="1" data-sizey="1" class="gs-w widget-meter">
                <div data-id="outboard-prayers" data-title=" " style="direction: rtl; text-align: right;"
                     class="widget widget-outboard outboard-prayers">
                    <h1 class="title" data-bind="title">
T* p4
                </h1>

                    <div class="content" style="">

%{--                        <ul style="direction: rtl; text-align: right;">--}%
%{--                            <g:each in="${new File('/nbr/goals.txt').text.split('\n')}" var='l'>--}%
%{--                                <li>--}%
%{--                                    <span class="name">--}%
%{--                                        ${l}--}%
%{--                                    </span>--}%
%{----}%
%{--                                </li>--}%
%{--                            </g:each>--}%
%{----}%


                        <ol style="direction: rtl; text-align: right; margin-right: 30px;">
                        <g:each in="${mcs.Task.findAllByBookmarkedAndPriorityGreaterThan(true, 3, [sort: 'summary', order: 'desc'])}" var="j">
                            <li>
%{--                                <u>${j.endDate?.format('dd.MM')}:</u>--}%
                                [${j.course?.code}]
                                ${j.summary}
                            </li>

                        </g:each>
                    </ol>
                </div>
                    %{--                    <p class="updated-at" data-bind="updatedAtMessage">Last updated at 15:28</p>--}%
                </div>
            </li>



            <li data-row="3" data-col="1" data-sizex="1" data-sizey="1" class="gs-w widget-comments">
                <div data-id="outboard-goals" data-title="الأهداف" class="widget widget-outboard outboard-goals" style="direction: rtl; text-align: right;"><h1
                        class="title" data-bind="title">

                    R* p4
                </h1>

                    <div class="content">
                        <ol style="direction: rtl; text-align: right; margin-right: 30px;">
                            <g:each in="${mcs.Book.findAllByBookmarkedAndPriorityGreaterThan(true, 3, [sort: 'department', order: 'desc', max: 5])}" var="j">
                                <li>
                                    [${j.course?.code}]
                                    ${j.title}
                                </li>

                            </g:each>
                        </ol>

                        %{--                        <ul style="direction: rtl; text-align: right;">--}%
                        %{--                            <g:each in="${new File('/nbr/goals.txt').text.split('\n')}" var='l'>--}%
                        %{--                                <li>--}%
                        %{--                                    <span class="name">--}%
                        %{--                                        ${l}--}%
                        %{--                                    </span>--}%
                        %{----}%
                        %{--                                </li>--}%
                        %{--                            </g:each>--}%
                        %{----}%
                    </div>

                    %{--                    <p class="updated-at" data-bind="updatedAtMessage">Last updated at 15:28</p>--}%
                </div>
            </li>

          <li data-row="3" data-col="2" data-sizex="1" data-sizey="1" class="gs-w">
                <div data-id="outboard-goals" data-title="الأهداف" class="widget widget-outboard outboard-goals" style="direction: rtl; text-align: right;">
                    <h1
                        class="title" data-bind="title">mls</h1>

                    <div class="content">

                        %{--Refactor--}%
%{--                        <b>Countdowns</b>--}%
                        <ol style="direction: rtl; text-align: right; margin-right: 30px;">
                            <g:each in="${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('milestone'), true, [sort: 'startDate', order: 'desc'])}" var="j">
                                <li>
                                    <pkm:prettyDuration date1="${j.endDate ?: j.startDate}"/>:
                                    ${j.summary}

                                </li>

                            </g:each>
                        </ol>

%{--                        <b>Countups</b>--}%
%{--                        <ul>--}%
%{--                            <g:each in="${Journal.findAllByType(JournalType.get(52), [sort: 'endDate', order: 'desc'])}" var="j">--}%
%{--                                <li>--}%
%{--                                    ${j.description} - ${(j.startDate..new Date()).size()} days have passed--}%
%{--                                </li>--}%

%{--                            </g:each>--}%
%{--                        </ul>--}%
                    </div>


                </div>
            </li>


  <li data-row="3" data-col="3" data-sizex="1" data-sizey="1" class="gs-w">
                <div data-id="outboard-goals" data-title="الأهداف" class="widget widget-outboard outboard-goals" style="direction: rtl; text-align: right;">
                    <h1
                        class="title" data-bind="title">plc</h1>

                    <div class="content">

                        %{--Refactor--}%
%{--                        <b>Countdowns</b>--}%
                        <ol style="direction: rtl; text-align: right; margin-right: 30px;">
                            <g:each
in="${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('policy'), true, [sort: 'startDate', order: 'desc', max: 1])}" var="j">
                                <li>
                                    <b>${j.summary}</b>:<br/>
                                    <b>${j.description?.replace('\n', '<br/>')}</b>
                                </li>

                            </g:each>
                        </ol>

%{--                        <b>Countups</b>--}%
%{--                        <ul>--}%
%{--                            <g:each in="${Journal.findAllByType(JournalType.get(52), [sort: 'endDate', order: 'desc'])}" var="j">--}%
%{--                                <li>--}%
%{--                                    ${j.description} - ${(j.startDate..new Date()).size()} days have passed--}%
%{--                                </li>--}%

%{--                            </g:each>--}%
%{--                        </ul>--}%
                    </div>

                    <p class="updated-at" data-bind="updatedAtMessage"></p>
                </div>
            </li>



            <li data-row="4" data-col="1" data-sizex="3" data-sizey="1" class="gs-w  widget-meter"  style="height: 30px !important;">
                <div data-id="welcome" data-title="اليوم" data-text="14 شعبان 1441هـ. " data-moreinfo=""
                     class="widget widget-outboard welcome">

                    <b class="title" data-bind="title">
                        %{--                    مواقيت الصلاة--}%

                        %{--                        \--}%
                        %{--                    <% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);--}%
                        %{--                    c.setFirstDayOfWeek(java.util.Calendar.MONDAY)--}%
                        %{--                    %>--}%
                        %{--                    <b>أ</b> ${c.get(Calendar.WEEK_OF_YEAR)}--}%

                    </b>


                        <div class="content" style="font-size: 0.8em !important; text-align: center !important;">

                    ${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('fcs'), true, [sort: 'startDate', order: 'desc', max: 1])[0].summary}
                    ${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('fcs'), true, [sort: 'startDate', order: 'desc', max: 1])[0].description}

                    </div>
                </div>
            </li>




        </ul>
        <center><div style="font-size: 12px; display: none;">Try this: curl -d
        '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "Hey, Look what I can do!"
        }' \http://192.168.0.10:3030/widgets/welcome</div></center>
    </div>

</div>


<div id="saving-instructions">
    <p>Paste the following at the top of <i>sample.erb</i></p>
    <textarea id="gridster-code"></textarea>
</div>
<a href="#saving-instructions" id="save-gridster">Save this layout</a>


<div id="lean_overlay"></div></body></html>
