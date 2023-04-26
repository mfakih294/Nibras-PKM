<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>


<div id="accordionWest"
     style="width: 90%; padding: 0 30px;">

    <g:if  test="${mcs.Department.count() == 0}">
        <h1>There are no departments yet.</h1>
    </g:if>

<g:if test="${1==2}">

    <h2>Active courses</h2>

    <g:each in="${mcs.Department.list([sort: 'code'])}" var="d">
        <g:if test="${Course.countByDepartmentAndBookmarked(Department.get(d.id), true, [sort: 'code', order: 'asc']) > 0}">
            <br/>
            <h3 class="bowseTab">
                %{--<g:remoteLink controller="report" action="departmentCourses"--}%
                %{--update="centralArea" params="[id: d.id]"--}%
                %{--title="Actions">--}%
                %{--<span style="padding: 1px;">--}%



                <a>

                    <g:remoteLink controller="generics" action="recordsByDepartment" id="${d.id}"
                                  before="jQuery.address.value(jQuery(this).attr('href'));"
                                  update="centralArea">
                        ${d.summary}
                        <b> ${d.code}  </b> (${d.courses.size()})
                    </g:remoteLink>
                    %{--<span class="moduleCount">--}%


                    %{--</span>--}%
                    %{--<span class="I-bkg" style=" float: right;"--}%
                    %{--style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">--}%
                    %{--</span>--}%

                </a>

            </h3>


            <div>
                <ul style="padding-left: 0">
                    <g:each in="${Course.findAllByDepartmentAndBookmarked(Department.get(d.id), true, [sort: 'code', order: 'asc'])}"
                            var="t">
                        <li style="list-style-type: none">
                            <g:remoteLink controller="generics" action="recordsByCourse" id="${t.id}"
                                          before="jQuery.address.value(jQuery(this).attr('href'));"
                                          update="centralArea">
                                <b>${t.numberCode}</b>
                                ${StringUtils.abbreviate(t.summary ?: '', 26)}
                                <sup>
                                    <b>${t.code != t.numberCode.toString() ? t.code : ''}</b>

                                </sup>
                            </g:remoteLink>
                        </li>
                    </g:each>
                </ul>
            </div>
        </g:if>
    </g:each>


   </g:if>

%{--<h2>All courses</h2>--}%

    <h3 class="bowseTab">
        <a>
            Active records
        </a>
    </h3>

<g:if test="${1==1}">
    <div>

        <g:remoteLink controller="operation" action="dumpAllWritings" update="centralArea">
            Export all writings
        </g:remoteLink>

        <br/>
        <br/>

        <g:each in="${Course.findAll([sort: 'code', order: 'asc'])}"
                var="t">
            <g:if test="${Writing.countByCourseAndBookmarked(t, true)> 0}">


                <div style="text-align: center; background: #ececc8; border-right: 1px solid darkgray; padding: 5px; margin: 8px 3px;">
                    <b>${t.numberCode}</b>
                    ${StringUtils.abbreviate(t.summary ?: '', 26)} (${Writing.countByCourse(t)})
                </div>


                <ul style="padding-left: 30px">
                    <g:each in="${Writing.findAllByCourseAndBookmarked(t, true, [sort: 'orderNumber', order: 'asc'])}"
                            var="w">
                        <li style="list-style-type: none">
                            <g:remoteLink controller="page" action="panel"
                                          params="${[id: w.id, entityCode: 'W']}"
                                          update="3rdPanel"
                                          title="Go to page">
                                ${w.toString()}
                                <g:if test="${w?.description?.length() > 0}">
                                    %{--<div style="float: left">--}%
                                    <g:each in="${0..Math.min((w?.description?.length() / 100).toInteger(), 15)}" var='c'>
                                        -
                                    </g:each>
                                    %{--</div>--}%
                                </g:if>
                            </g:remoteLink>
                        </li>
                    </g:each>
                </ul>
            </g:if>
        </g:each>


     <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByBookmarked(true),
                                                                           totalHits: Planner.countByBookmarked(true)]"/>
                    <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByBookmarked(true),
                                                                           totalHits: Journal.countByBookmarked(true)]"/>
                    %{--todo: repeat--}%
                    <g:render template="/gTemplates/recordListing" model="[list: Task.findAllByBookmarked(true)]"/>
                    %{--<g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByBookmarked(true),--}%
                                                                           %{--totalHits: IndexCard.countByBookmarked(true)]"/>--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Writing.findAllByBookmarked(true)]"/>--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Book.findAllByBookmarked(true)]"/>--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Goal.findAllByBookmarked(true)]"/>--}%



    </div>
</g:if>

<g:if test="${1==2}">

        <h3 class="bowseTab">
            <a>
        All Writings
            </a>
    </h3>
    <div>
        <g:each in="${mcs.Department.list([sort: 'code'])}" var="d">

            %{--<g:remoteLink controller="report" action="departmentCourses"--}%
            %{--update="centralArea" params="[id: d.id]"--}%
            %{--title="Actions">--}%
            %{--<span style="padding: 1px;">--}%

                %{--<g:remoteLink controller="generics" action="recordsByDepartment" id="${d.id}"--}%
                              %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
                              %{--update="centralArea">--}%
            <div
                    style="text-align: left; font-weight: bold; background: #a1ac97; border-right: 1px solid darkgray; padding: 7px; margin: 14px 3px;">

                <a style=" color: white;">
            ${d.summary}
                     (${d.courses.size()} courses)
        </a>
            </div>
                %{--</span>--}%
                %{--</g:remoteLink>--}%



                %{--<span class="I-bkg" style=" float: right;"--}%
                %{--style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">--}%
                %{--</span>--}%




        <div>

                <g:each in="${Course.findAllByDepartment(Department.get(d.id), [sort: 'code', order: 'asc'])}"
                        var="t">

                    <g:if test="${Writing.countByCourse(t) > 0}">
                    <div style="background: #ececc8; border-right: 1px solid darkgray; padding: 5px; margin: 8px 3px;"
                         class="${t.language}" title="${t.code}"
                         onclick="jQuery('#courseWritings${t.id}').removeClass('hidden');">
                            <b>${t.numberCode}</b>
                    ${StringUtils.abbreviate(t.summary ?: '', 26)} (${Writing.countByCourse(t)}w)
                    </div>

                    <ul id="courseWritings${t.id}" style="padding-left: 30px" class="--hidden">
                        <g:each in="${Writing.findAllByCourse(t, [sort: 'orderNumber', order: 'asc'])}"
                                var="w">
                            %{--<a onclick="jQuery('#quickAddForm').addClass('hidden');">--</a>--}%
                    %{--<li style="list-style-type: bullet; text-align: right; direction: rtl;">--}%
                            <li class="${w.language}">
                        <g:remoteLink controller="page" action="panel"
                        params="${[id: w.id, entityCode: 'W']}"
                        update="3rdPanel"
                        title="Go to page">
                        ${w.toString()}
                            <g:if test="${w?.description?.length() > 0}">
                                <div style="float: ${w.language == 'ar' ? 'left' : 'right'}">
                            <g:each in="${0..Math.min(Math.floor(w?.description?.length() / 100).toInteger(), 15)}" var='c'>
                            -
                                </g:each>
                            &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                </div>
                                </g:if>

                        </g:remoteLink>
                    </li>
                </g:each>
            </ul>
                    </g:if>
                </g:each>
        </div>
</g:each>
</div>
</g:if>



</div>



<g:if test="${1==2}">
<div id="accordionWest" class="basic">



            <h3><a href="#">
                 Pile (${IndexCard.countByBookmarked(true) + Writing.countByBookmarked(true) +
                         Journal.countByBookmarked(true) + Planner.countByBookmarked(true) + Task.countByBookmarked(true) + Book.countByBookmarked(true)})
            </a></h3>
<div style="">
<g:if test="${OperationController.getPath('operations.enabled')?.toLowerCase() == 'yes' ? true : false}">


                    <h2>${mcs.Operation.executeQuery('select count(*) from mcs.Operation where deletedOn = null and bookmarked = true order by id desc')[0]} pending operation(s)</h2>
                    <g:render template="/gTemplates/recordListing" model="[list: mcs.Operation.executeQuery('from mcs.Operation where deletedOn = null and bookmarked = true order by id desc'),
                                                                           totalHits: mcs.Operation.executeQuery('select count(*) from mcs.Operation where deletedOn = null and bookmarked = true order by id desc')[0]]"/>

<g:remoteLink controller="generics" action="settleAllOperations"
              update="centralArea" title="Mark all operations as settled">
    <b>Mark all operations as settled</b>
    </g:remoteLink>

</g:if>

                   %{--<g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByBookmarked(true),--}%
                                                                           totalHits: Planner.countByBookmarked(true)]"/>
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByBookmarked(true),--}%
                                                                           totalHits: Journal.countByBookmarked(true)]"/>
                    %{--todo: repeat--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Task.findAllByBookmarked(true)]"/>--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByBookmarked(true),--}%
                                                                           totalHits: IndexCard.countByBookmarked(true)]"/>
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Writing.findAllByBookmarked(true)]"/>--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Book.findAllByBookmarked(true)]"/>--}%
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Goal.findAllByBookmarked(true)]"/>--}%
            </div>

                </div>
</g:if>

%{--  <h3><a href="#">--}%
%{--                Notes  (${IndexCard.countByCourse(record)})--}%
%{--            </a></h3>--}%

%{--            <div style="direction: rtl; text-align: right; ">--}%
%{--                <g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByCourse(record)]"/>--}%
%{--            </div>--}%


