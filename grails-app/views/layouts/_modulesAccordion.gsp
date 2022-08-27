<%@ page import="mcs.Operation; ker.OperationController; mcs.parameters.JournalType; mcs.parameters.PlannerType; mcs.Book; mcs.Writing; app.Payment; app.IndicatorData; mcs.Journal; cmn.Setting; mcs.Planner; mcs.Task; mcs.Goal; app.Tag" %>

%{--<div id="accordionModules"--}%
     %{--style="width: 95%; padding-left: 4px;">--}%

<div class="panelCard">
 <h4>
                <span class="T-bkg"
                      style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold; font-size: 12px;"></span>
Main reports<span
        class="moduleCount">${Task.count()}</span></h4>

 <ul>

<g:render template="/layouts/savedSearches" model="[entity: 'M']"/>
</ul>
</div>

    <g:if test="${OperationController.getPath('tasks.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <div class="panelCard">
            <h4>
                <span class="T-bkg"
                      style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold; font-size: 12px;">T</span>
                ${OperationController.getPath('tasks.label') ?: 'Tasks'}<span
                    class="moduleCount">${Task.count()}</span></h4>

            <div>


                %{--<g:link controller="task" action="expotTodotxt" target="_blank">--}%
                %{--Export to Todo.txt format--}%
                %{--</g:link>--}%

                %{--<br/>--}%
                <ul>
                    <g:render template="/layouts/savedSearches" model="[entity: 'T']"/>
                </ul>
            </div>
        </div>
    </g:if>

<g:if test="${OperationController.getPath('goals.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <div class="panelCard">
    <h4>
        <span class="G-bkg"
              style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">G</span>
        ${OperationController.getPath('goals.label') ?: 'Goals'} <span
                class="moduleCount">
            ${Goal.count()}
        </span>

    </h4>

    <div>
        <ul>
            <g:render template="/layouts/savedSearches" model="[entity: 'G']"/>
        </ul>
    </div>
    </div>
</g:if>

<g:if test="${OperationController.getPath('planner.enabled')?.toLowerCase() == 'yes' ? true : false}">

    <div class="panelCard">
    <h4>
        <span class="P-bkg"
              style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">P</span>
        ${OperationController.getPath('planner.label') ?: 'Planner'}<span
                class="moduleCount">${Planner.count()}</span>

    </h4>

    <div>

        <ul>

            <g:render template="/layouts/savedSearches" model="[entity: 'P']"/>

        </ul>

    </div>
    </div>

</g:if>


<g:if test="${OperationController.getPath('journal.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <div class="panelCard">
    <h4>
        <span class="J-bkg"
              style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">J</span>
        ${OperationController.getPath('journal.label') ?: 'Journal'}<span
                class="moduleCount">${Journal.count()}</span>

    </h4>

    <div>

        <ul>
            %{--<li>--}%

                %{--<a href="${createLink(controller: 'export', action: 'exportIcal', id: 'journal.ics')}"--}%
                   %{--target="_blank">--}%
                    %{--Export journal to iCal--}%
                %{----}%

            %{--</li>--}%
            <g:render template="/layouts/savedSearches" model="[entity: 'J']"/>
        </ul>

    </div>
    </div>

</g:if>

    <g:if test="${OperationController.getPath('operations.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <div class="panelCard">
            <h4>
                <span class="O-bkg"
                      style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold; font-size: 12px;">O</span>
                ${OperationController.getPath('operations.label') ?: 'Operations'}<span
                    class="moduleCount">${mcs.Operation.count()}</span></h4>

            <div>
                %{--<g:link controller="task" action="expotTodotxt" target="_blank">--}%
                %{--Export to Todo.txt format--}%
                %{--</g:link>--}%

                %{--<br/>--}%
                <ul>
                    <g:render template="/layouts/savedSearches" model="[entity: 'O']"/>

                    <li>
                        <g:remoteLink controller="generics" action="verifyAllOperations"
                                      update="centralArea"
                                      title="Verify operations">
                            Verify operations
                        %{--دقات--}%
                        %{--</g:remoteLink>--}%
                        %{--style="" target="_blank">--}%
                        %{--<span style="color: white" class="ui-icon ui-icon-signal"></span>--}%
                        %{--<g:message code="ui.menu.RSS"></g:message>--}%
                        </g:remoteLink>
                    </li> <li>
                    <g:remoteLink controller="generics" action="symbolicLinkAllBookmarkedRecords"
                                  update="centralArea"
                                  title="Verify operations">
                        Link bookmarked folders to ${OperationController.getPath('root.out.path')}
                    %{--دقات--}%
                    %{--</g:remoteLink>--}%
                    %{--style="" target="_blank">--}%
                    %{--<span style="color: white" class="ui-icon ui-icon-signal"></span>--}%
                    %{--<g:message code="ui.menu.RSS"></g:message>--}%
                    </g:remoteLink>
                </li>
                </ul>
            </div>
        </div>
    </g:if>

    <g:if test="${OperationController.getPath('notes.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <div class="panelCard">

            <h4>

                <span class="N-bkg"
                      style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">N</span>
                ${OperationController.getPath('notes.label') ?: 'Notes'}
                <span class="moduleCount">${app.IndexCard.count()}</span>

            </h4>

            <div>
                <ul>

                    %{--<li>--}%
                    %{--<g:remoteLink controller="report" action="wordsForReview"--}%
                    %{--update="centralArea"--}%
                    %{--style=""--}%
                    %{--title="Review words">--}%
                    %{--<g:message code="ui.anki"></g:message>--}%

                    %{--</g:remoteLink>--}%

                    %{--</li>--}%


                    <g:render template="/layouts/savedSearches" model="[entity: 'N']"/>
                </ul>

            </div>
        </div>
    </g:if>

    <g:if test="${OperationController.getPath('department.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <div class="panelCard">
            <h4>
                <span class="D-bkg"
                      style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">D</span>
                ${OperationController.getPath('department.label') ?: 'Departments'} <span
                    class="moduleCount">
                ${mcs.Department.count()}
            </span>
            </h4>

            <div>
                <ul>
                    <g:render template="/layouts/savedSearches" model="[entity: 'D']"/>
                </ul>
            </div>
        </div>

    </g:if>

    <g:if test="${OperationController.getPath('course.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <div class="panelCard">
            <h4>
                <span class="C-bkg"
                      style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">C</span>
                ${OperationController.getPath('courses.label') ?: 'Courses'} <span
                    class="moduleCount">
                ${mcs.Course.count()}
            </span>
            </h4>

            <div>
                <ul>
                    <g:render template="/layouts/savedSearches" model="[entity: 'C']"/>
                </ul>
            </div>
        </div>
    </g:if>



    <g:if test="${OperationController.getPath('indicators.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <div class="panelCard">
    <h4>
            <span class="K-bkg"
                  style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">K</span>
            ${OperationController.getPath('indicators.label') ?: 'Indicators'}<span
                class="moduleCount">${IndicatorData.count()}</span>

    </h4>

    <div>
        <ul>
            <li>

                <g:remoteLink controller="report" action="indicators"
                      update="centralArea"
                      title="Indicators">
            Charts
        </g:remoteLink>
            </li>
            <g:render template="/layouts/savedSearches" model="[entity: 'K']"/>
        </ul>
    </div>
    </div>
</g:if>


<g:if test="${OperationController.getPath('payments.enabled')?.toLowerCase() == 'yes' ? true : false}">

    <div class="panelCard">
    <h4><span class="Q-bkg"
                 style="font-family:  'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">Q</span>
        ${OperationController.getPath('payments.label') ?: 'Payments'}
        <span class="moduleCount">${Payment.count()}</span>
    </h4>


    <div>

        <ul>
%{--            <li>--}%
%{--                <a onclick="jQuery('#searchArea').load('report/paymentCategories')">All categories</a>--}%
%{--            </li>--}%

            <g:render template="/layouts/savedSearches" model="[entity: 'Q']"/>

        </ul>

    </div>
    </div>
</g:if>


<g:if test="${OperationController.getPath('writings.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <br/>

    <div class="panelCard">

     <h4>
         <span class="W-bkg"
               style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">W</span>
        ${OperationController.getPath('writings.label') ?: 'Writings'}<span
                class="moduleCount">${Writing.count()}</span>
    </h4>

    <div>

        <ul>

    <g:if test="${OperationController.getPath('xxpkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <li>
                <a onclick="jQuery('#logArea').load('export/generateForKindle')">
                    Generate wrt for kindle (one txt file per course)
                </a>
            </li>

            <li>
                <g:remoteLink controller="export" action="checkoutWritings"
                              update="centralArea"
                              title="Export all writings to text files">
                    Export all writings to text files
                </g:remoteLink>
                %{--todo--}%
            <li>
                <a href="${createLink(controller: 'export', action: 'exportWritingsToOneFile')}"
                   target="_blank">Writings 2 html (new page)</a>
            </li>
</g:if>




                <g:render template="/layouts/savedSearches" model="[entity: 'W']"/>





        </ul>

    </div>
    </div>
</g:if>



<g:if test="${OperationController.getPath('resources.enabled')?.toLowerCase() == 'yes' ? true : false}">
<div class="panelCard">

    <h4>
        <span class="R-bkg"
              style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">R</span>
        ${OperationController.getPath('resources.label') ?: 'Resources'}
        <span class="moduleCount">${mcs.Book.executeQuery("select count (*) from Book")[0]}
        </span>
   </h4>

    <div>

        <ul>

            %{--<li><a onclick="jQuery('#centralArea').load('book/report/notitle')">No title books</a>--}%
            %{--</li>--}%

            %{--<li><a onclick="jQuery('#centralArea').load('book/report/isbnNoTitle')">ISBN  without title</a>--}%
            %{--</li>--}%
            <g:render template="/layouts/savedSearches" model="[entity: 'R']"/>

           </ul>
    </div>
    </div>
</g:if>

<g:if test="${OperationController.getPath('excerpts.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <div class="panelCard">
     <h4>
         <span class="E-bkg"
               style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">E</span>
        ${OperationController.getPath('excerpts.label') ?: 'Excerpts'} <span class="moduleCount">${mcs.Excerpt.countByDeletedOnIsNull()}
        </span>
    </a>
    </h4>

    <div style="font-family: tahoma;">
          <ul>
            <g:render template="/layouts/savedSearches" model="[entity: 'E']"/>
          </ul>
        
    </div>
    </div>

</g:if>

<g:if test="${OperationController.getPath('contacts.enabled')?.toLowerCase() == 'yes' ? true : false}">
    <div class="panelCard">
      <h4>

              <span class="S-bkg"
                    style="font-family: 'Lucida Console'; margin-right: 3px; padding-right: 2px; font-weight: bold;">S</span>
            ${OperationController.getPath('contacts.label') ?: 'Contacts'}<span
                class="moduleCount">${app.Contact.countByDeletedOnIsNull()}</span>

    </h4>

    <div>
        <ul>

            <g:render template="/layouts/savedSearches" model="[entity: 'S']"/>
        </ul>

    </div>
    </div>
    <br/>
</g:if>

%{--</div>--}%
