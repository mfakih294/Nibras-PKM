<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
<div id="accordionWest" class="basic">



            <h3><a href="#">
                 Pile (${IndexCard.countByBookmarked(true) + Writing.countByBookmarked(true) + Journal.countByBookmarked(true) + Planner.countByBookmarked(true) +Task.countByBookmarked(true)})
            </a></h3>

                <div style="">
     <g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByBookmarked(true)]"/>
     <g:render template="/gTemplates/recordListing" model="[list: Writing.findAllByBookmarked(true)]"/>
     <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByBookmarked(true)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByBookmarked(true)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Task.findAllByBookmarked(true)]"/>
                %{--<g:render template="/gTemplates/recordListing" model="[list: Goal.findAllByBookmarked(true)]"/>--}%

            </div>

                </div>


%{--  <h3><a href="#">--}%
%{--                Notes  (${IndexCard.countByCourse(record)})--}%
%{--            </a></h3>--}%

%{--            <div style="direction: rtl; text-align: right; ">--}%
%{--                <g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByCourse(record)]"/>--}%
%{--            </div>--}%


