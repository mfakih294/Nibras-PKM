<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
<div id="accordionWest" class="basic">



            <h3><a href="#">
                 Actions
            </a></h3>

                <div style="">


                    <g:link controller="indexCard" action="generateWritingsBook"
                                  id="${record.id}"
                                  target="_blank"
                                  title="">
                        Generate book on screen
                    </g:link>

                    <br/>
                    <br/>

                    <g:remoteLink controller="generics" action="generateWritingsBookToFile"
                                  id="${record.id}"
                                  update="centralArea"
                                  title="">
                        Generate book to file
                    </g:remoteLink>


                    <br/>
                    <br/>
                    <g:remoteLink controller="indexCard" action="sortNotes"
                                  id="${record.id}"
                                  update="centralArea"
                                  title="">
                        Sort notes
                    </g:remoteLink>


                </div>


  <h3><a href="#">
                 Goals   (${Goal.countByCourse(record)})
            </a></h3>

                <div style="">




                    <g:render template="/gTemplates/recordListing" model="[list: Goal.findAllByCourse(record)]"/>

                </div>

    <h3 style="text-align: right;"><a href="#" >
    Journal (${Journal.countByCourse(record)})
</a></h3>

    <div>

        <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByCourse(record)]"/>

    </div>
  <h3><a href="#">
                 Planner  (${Planner.countByCourse(record)})
            </a></h3>

                <div style="">
                    <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByCourse(record)]"/>

                </div>

            <h3><a href="#">
                Resources (${Book.countByCourse(record)})
            </a></h3>

                <div style="direction: rtl; text-align: right;">
                    %{--<g:render template="/gTemplates/recordListing" model="[list: Book.findAllByCourse(record)]"/>--}%
                </div>

            <h3><a href="#">
                Writing  (${Writing.countByCourse(record)})
            </a></h3>

            <div style="direction: rtl; text-align: right; ">
                <g:render template="/gTemplates/recordListing" model="[list: Writing.findAllByCourse(record)]"/>
            </div>
%{--  <h3><a href="#">--}%
%{--                Notes  (${IndexCard.countByCourse(record)})--}%
%{--            </a></h3>--}%

%{--            <div style="direction: rtl; text-align: right; ">--}%
%{--                <g:render template="/gTemplates/recordListing" model="[list: IndexCard.findAllByCourse(record)]"/>--}%
%{--            </div>--}%


</div>