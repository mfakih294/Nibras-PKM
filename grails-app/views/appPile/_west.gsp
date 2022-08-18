<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
<div id="accordionWest" class="basic">



            <h3><a href="#">
                 Pile (${IndexCard.countByBookmarked(true) + Writing.countByBookmarked(true) +
                         Journal.countByBookmarked(true) + Planner.countByBookmarked(true) + Task.countByBookmarked(true) + Book.countByBookmarked(true)})
            </a></h3>

<g:if test="${OperationController.getPath('operations.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <div style="">

                    <h2>${mcs.Operation.executeQuery('select count(*) from mcs.Operation where deletedOn = null and bookmarked = true order by id desc')[0]} pending operation(s)</h2>
                    <g:render template="/gTemplates/recordListing" model="[list: mcs.Operation.executeQuery('from mcs.Operation where deletedOn = null and bookmarked = true order by id desc'),
                                                                           totalHits: mcs.Operation.executeQuery('select count(*) from mcs.Operation where deletedOn = null and bookmarked = true order by id desc')[0]]"/>

<g:remoteLink controller="generics" action="settleAllOperations"
              update="centralArea" title="Mark all operations as settled">
    <b>Mark all operations as settled</b>
    </g:remoteLink>

</g:if>

                   <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByBookmarked(true),
                                                                           totalHits: Planner.countByBookmarked(true)]"/>
                    <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByBookmarked(true),
                                                                           totalHits: Journal.countByBookmarked(true)]"/>
                    %{--todo: repeat--}%
                    <g:render template="/gTemplates/recordListing" model="[list: Task.findAllByBookmarked(true)]"/>
                    <g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByBookmarked(true),
                                                                           totalHits: IndexCard.countByBookmarked(true)]"/>
                    <g:render template="/gTemplates/recordListing" model="[list: Writing.findAllByBookmarked(true)]"/>
                    <g:render template="/gTemplates/recordListing" model="[list: Book.findAllByBookmarked(true)]"/>
                    <g:render template="/gTemplates/recordListing" model="[list: Goal.findAllByBookmarked(true)]"/>
            </div>

                </div>


%{--  <h3><a href="#">--}%
%{--                Notes  (${IndexCard.countByCourse(record)})--}%
%{--            </a></h3>--}%

%{--            <div style="direction: rtl; text-align: right; ">--}%
%{--                <g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByCourse(record)]"/>--}%
%{--            </div>--}%


