<%@ page import="app.Contact; ker.OperationController; app.parameters.Blog;mcs.Department; mcs.parameters.WorkStatus;" %>

<g:if test="${record}">
    <g:render template="/gTemplates/recordSummary" model="[record: record]"/>
</g:if>
<div style="margin: 10px; padding: 5px; border: 0.5px solid darkgray !important;">
<g:formRemote name="genericSearch" id="genericSearch22" url="[controller: 'generics', action: 'saveViaForm']"
              update="${updateRegion}" method="post" style="display: inline; " onComplete="">

    <g:hiddenField name="entityController" value="${entityController}"/>
    <g:hiddenField name="updateRegion" value="${updateRegion}"/>

    <g:hiddenField name="id" value="${record?.id}"/>


    <table>

    <g:if test="${ker.OperationController.getPath('courses.enabled')?.toLowerCase() == 'yes'}">
        <tr>

    <g:if test="${fields.contains('book')}">
        <td>
            <label>Resource</label>
            <g:select name="book.id" style="width: 200px;"
                      from="${record?.book ? [record.book] + mcs.Book.executeQuery('from Book r where r.type.code = ? and r.status.code = ? order by r.title asc', ['prd', 'zbk']) : mcs.Book.executeQuery('from Book r where r.type.code = ? and r.status.code = ? order by r.title asc', ['prd', 'zbk'])}"
                      value="${record?.book?.id}" optionKey="id"
                      optionValue="title"
                      noSelection="${['null': 'No book']}"/>
        </td>
    </g:if>

            <g:if test="${fields.contains('contact')}">
                <td>
                    <label>Contact</label>
                    <g:select name="contact.id" class="ui-corner-all"
                              from="${sources}" optionKey="id"
                              value="${record?.contact?.id}"
                              noSelection="${['null': 'No person']}"/>
                </td>
            </g:if>

    <g:if test="${fields.contains('department')}">
        <td>
            <label>Department</label>
            <g:select name="department.id" style="width: 200px;" from="${departments}"
                      value="${record?.department?.id}" optionKey="id"
                      optionValue="summary"
                      noSelection="${['null': 'No department']}"/>
        </td>
    </g:if>

    <g:if test="${fields.contains('course')}">
        <td>
            <label>Course</label>
            <g:select name="course.id" style="width: 200px;" from="${courses}"
                      id="chosenCourse${record?.id}"
                      value="${record?.course?.id}"
                      optionKey="id"
                      optionValue="summary"
                      noSelection="${['null': 'No course']}"/>



            <script type="text/javascript">
                jQuery("#chosenCourse${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </td>
    </g:if>

    </tr>
        </g:if>
    <tr>

        <g:if test="${fields.contains('queryType')}">
            <td>
                <label>Query type</label>
                <g:select name="queryType" from="${['hql', 'lucene', 'adhoc']}" value="${record?.queryType}"/>
            </td>
        </g:if>

        <g:if test="${fields.contains('code')}">
            <td>
                <label>Code</label>
                <g:textField name="code" placeholder="Code" title="Code" class="ui-corner-all"
                             value="${record?.code}"/>
            </td>
        </g:if>
    %{--<g:if test="${fields.contains('slug')}">--}%
    %{--<td>--}%

    %{--<g:textField name="slug" placeholder="Slug" title="Slug" class="ui-corner-all"--}%
    %{--value="${record?.slug}"/>--}%
    %{--</g:if>--}%
        %{--<g:if test="${fields.contains('publishedNodeId')}">--}%
            %{--<td>--}%
            %{--Pub. Id: <g:textField id="publishedNodeId" name="publishedNodeId"--}%
                              %{--placeholder="Published node Id" title="Published node Id"--}%
                              %{--style="width: 90px;" class="ui-corner-all"--}%
                              %{--value="${record?.publishedNodeId}"/>--}%
        %{--</g:if>--}%
    </td>

        <g:if test="${fields.contains('type')}">
            <td>
                <label>Type</label>
                <g:select name="type.id" style="width: 150px;"
                          from="${types}" optionKey="id" optionValue="name"
                          value="${record?.type?.id}"
                          id="chosenType${record?.id}"
                          noSelection="${['null': 'No type']}"/>
            </td>

            <script type="text/javascript">
                jQuery("#chosenType${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </g:if>

        <g:if test="${fields.contains('category')}">
            <td>
                <label>Category</label>
                <g:select name="category.id" style="width: 150px;"
                          from="${categories}" optionKey="id"
                          value="${record?.category?.id}"
                          id="chosenCategory${record?.id}"
                          noSelection="${['null': 'No category']}"/>
            </td>

            <script type="text/javascript">
                jQuery("#chosenCategory${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </g:if>


        <g:if test="${fields.contains('writing')}">
            <td>
                <label>Writing</label>
                <g:select name="writing.id" from="${writings}" style="width: 150px;"
                          optionKey="id" optionValue="summary"
                          id="chosenWriting${record?.id}"
                          value="${record?.writing?.id ?: (session['writingId'] ?: null)}"
                          noSelection="['null': 'No writing']"/>


                <script type="text/javascript">
                    jQuery("#chosenWriting${record?.id}").chosen({
                        allow_single_deselect: true,
                        no_results_text: "None found"
                    })
                </script>

            </td>
        </g:if>



        <g:if test="${fields.contains('status')}">
            <td>

                <label>Status</label>
                <g:select name="status.id" style="width: 150px;"
                          from="${statuses}" optionKey="id" optionValue="name"
                          id="chosenStatus${record?.id}"
                          data-placeholder="No status"
                          value="${record?.status?.id}"
                          noSelection="${['null': 'No status']}"/>
            </td>

            <script type="text/javascript">
                jQuery("#chosenStatus${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </g:if>

        <g:if test="${fields.contains('goal')}">

            <td>
                <label>Goal</label>

                <g:select name="goal.id" from="${goals}" style="width: 150px;"
                          optionKey="id" optionValue="summary"
                          data-placeholder="No goal"
                          id="chosenGoal${record?.id}"
                          value="${record?.goal?.id ?: (session['goalId'] ?: null)}"
                          noSelection="['null': 'No goal']"/>


                <script type="text/javascript">
                    jQuery("#chosenGoal${record?.id}").chosen({
                        allow_single_deselect: true,
                        no_results_text: "None found"
                    })
                </script>

            </td>
        </g:if>

        %{--<g:if test="${fields.contains('location')}">--}%
            %{--<td>--}%
                %{--<g:select name="location.id" style="width: 150px;"--}%
                          %{--from="${locations}" optionKey="id" optionValue="name"--}%
                          %{--value="${record?.location?.id}"--}%
                          %{--noSelection="${['null': 'No location']}"/>--}%
            %{--</td>--}%
        %{--</g:if>--}%

        <g:if test="${fields.contains('context')}">
            <td>
                <label>Context</label>
                <g:select name="context.id" style="width: 150px;"
                          from="${contexts}" optionKey="id" optionValue="name"
                          value="${record?.context?.id}"
                          noSelection="${['null': 'No context']}"/>
            </td>
        </g:if>

    </tr>
    <tr>

        <g:if test="${fields.contains('numberCode')}">
            <td>
                <label>Code (number)</label>
                <g:textField name="numberCode" placeholder="Number Code" title="Number Code" class="ui-corner-all"
                             value="${record?.numberCode}"/>
            </td>
        </g:if>





    %{--<g:if test="${fields.contains('username')}">--}%
    %{--<td>--}%
    %{--<g:textField name="username" placeholder="Username" title="Username" class="ui-corner-all"--}%
    %{--value="${record?.username}"/>--}%
    %{--</td>--}%
    %{--</g:if>--}%
    %{--<g:if test="${fields.contains('password')}">--}%
    %{--<td>--}%
    %{--<g:textField name="password" placeholder="Password" title="Password" class="ui-corner-all"--}%
    %{--value="${record?.password}"/>--}%
    %{--</td>--}%
    %{--</g:if>--}%




        <g:if test="${fields.contains('name')}">
            <td>
                <label>Name</label>
                <g:textField name="name" placeholder="Name" title="Name" class="ui-corner-all"
                             value="${record?.name}"/>
            </td>

        </g:if>


        <g:if test="${fields.contains('value')}">
            <td>
                <label>Value</label>
                <g:textArea id="value" name="value" placeholder="Value" title="Value" style="width: 250px;"
                            class="ui-corner-all"
                            rows="5" cols="80"
                            value="${record?.value}"/>
            </td>
        </g:if>

    </tr>

    <tr>

        <g:if test="${fields.contains('summary')}">
            <td colspan="3">
                <label>Summary</label>
                <g:textField id="sumamryField" name="summary" title="summary" value="${record?.summary}"
                             style="width: 95%;"/>
            </td>
        </g:if>

    </tr>
    <tr>


        <g:if test="${fields.contains('title')}">
            <td colspan="2">
                <label>Title</label>
                <g:textField placeholder="Title" name="title" title="title" value="${record?.title}"
                             style="width: 95%;"/>

                <g:if test="${fields.contains('authorInfo')}">
                    <label>Author info</label>
                    <g:textField placeholder="Author infor" name="authorInfo" title="Author info"
                                 value="${record?.authorInfo}"
                                 style="width: 95%;"/>
                </g:if>


                <g:if test="${ker.OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <g:if test="${fields.contains('legacyTitle')}">
                        <br/>
                        <label>Legacy title</label>
                        <g:textField placeholder="Legacy title" name="legacyTitle" title="Legacy title"
                                     value="${record?.legacyTitle}" style="width: 95%;"/>

                    </g:if>
                </g:if>

            </td>
        </g:if>



        <g:if test="${fields.contains('link')}">
            <td colspan="3">
                <label>Link</label>
                <g:textField placeholder="link (should start with http and ends with /xmlrpc.php" name="link"
                             title="link"
                             value="${record?.link}" style="width: 150px;"/>
            </td>
        </g:if>


        <g:if test="${fields.contains('style')}">
            <td>
                <label>Style</label>
                <g:textField id="style" name="style" placeholder="CSS Style" title="CSS Style" style="width: 120px;"
                             class="ui-corner-all"
                             value="${record?.style}"/>
            </td>
        </g:if>


        <g:if test="${fields.contains('color')}">
            <td>
                <label>Color</label>
                <g:textField id="color" name="color" placeholder="Color" title="Color" color="width: 60px;"
                             class="ui-corner-all"
                             value="${record?.color}"/>
            </td>
        </g:if>

        %{--</tr>--}%

        %{--<tr>--}%


            <g:if test="${fields.contains('author')}">
                <td>
                    <label>Author</label>
                    <g:textField name="author" placeholder="Author" title="Author" class="ui-corner-all"
                                 value="${record?.author}"/>

                    <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                        <br/>
                        <label>Bib author</label>
                        <g:textField name="authorInBib" placeholder="Author in Bib" title="Author in Bib"
                                     class="ui-corner-all"
                                     value="${record?.authorInBib}"/>
                    </g:if>
                    <br/>
                    <label>Trans.</label>
                    <g:textField name="translator" placeholder="Translator" title="Translator" class="ui-corner-all"
                                 value="${record?.translator}"/>
                    <br/>
                    <label>Editor</label>
                    <g:textField name="editor" placeholder="Editor" title="Editor" class="ui-corner-all"
                                 value="${record?.editor}"/>
                </td>
            </g:if>




        </tr>
        <tr>
            <g:if test="${fields.contains('publisher')}">
                <td>
                    <label>Publisher</label>
                    <g:textField name="publisher"
                                 placeholder="Publisher"
                                 title="Publisher"
                                 style="width: 200px;" value="${fieldValue(bean: record, field: 'publisher')}"/>
                </td>

            </g:if>

            <g:if test="${fields.contains('journal')}">
                <td colspan="2">
                    <label>Journal</label>
                    <g:textField placeholder="Journal" name="journal" value="${record?.journal}"
                                 style="width: 95%;"/>
                </td>
            </g:if>
        </tr>
         <tr>

            <g:if test="${fields.contains('edition')}">
                <td>
                    <label>Ed.</label>  <g:textField name="edition"
                                                     value="${fieldValue(bean: record, field: 'edition')}"
                                                     placeholder="Edition" title="Edition" style="width: 80px;"/>

                    <br/>
                    <label>Vol.</label> <g:textField name="volume" value="${fieldValue(bean: record, field: 'volume')}"
                                                     placeholder="volume" title="volume" style="width: 80px;"/>

                </td>
            </g:if>
            <g:if test="${fields.contains('year')}">
                <td>
                    <label>Year</label>
                    <g:textField name="year" value="${fieldValue(bean: record, field: 'year')}"
                                 placeholder="year" title="year" style="width: 80px;"/>
                    <g:if test="${fields.contains('number')}">
                        <br/>
                        <label>Number</label>
                        <g:textField name="number" value="${fieldValue(bean: record, field: 'number')}"
                                     placeholder="number" title="number" style="width: 80px;"/>
                    </g:if>
                </td>
            </g:if>
            <g:if test="${fields.contains('month')}">
                <td>
                    <label>Month</label>
                    <g:textField name="month" value="${fieldValue(bean: record, field: 'month')}"
                                 placeholder="month" title="month" style="width: 80px;"/>
                    <g:if test="${fields.contains('series')}">
                        <br/>
                        <label>Series</label>
                        <g:textField name="series" value="${fieldValue(bean: record, field: 'series')}"
                                     placeholder="series" title="series" style="width: 80px;"/>
                    </g:if>
                </td>
            </g:if>

        %{--<g:if test="${fields.contains('indicator')}">--}%
        %{--<td>--}%
        %{--<g:select name="indicator.id" class="ui-corner-all"--}%
        %{--from="${indicators}"--}%
        %{--optionKey="id" optionValue="code"--}%
        %{--value="${record?.indicator?.id ?: (session['lastIndicatorId'] ?: null)}"--}%
        %{--noSelection="${['null': '']}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%



        %{--<g:if test="${fields.contains('category') && entityCode == 'Q'}">--}%
        %{--<td>--}%
        %{--<g:select name="category.id" class="ui-corner-all"--}%
        %{--from="${app.PaymentCategory.list()}" optionKey="id"--}%
        %{--value="${record?.category?.id}"--}%
        %{--noSelection="${['null': '']}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%


        </tr>

        <tr>

            <g:if test="${fields.contains('query')}">
                <td colspan="2">
                <label>Query</label>
                <g:textField placeholder="Query" title="Query" rows="5" name="query" value="${record?.query}"
                             style="width: 99%;"/>
            </g:if>


            <g:if test="${fields.contains('countQuery')}">
                <br/>
                <label>Count query</label>
                <g:textField placeholder="Count query" title="Count query" name="countQuery"
                             value="${record?.countQuery}"
                             style="width: 99%;"/>
                </td>
            </g:if>

            <g:if test="${fields.contains('nbPages')}">
                <td>
                    <label>Nb. pages</label>
                    <g:textField placeholder="Nb. pages" title="Nb. pages" id="pages" name="nbPages"
                                 style="width: 150px"
                                 class="ui-corner-all"
                                 value="${record?.nbPages}"/>
                    <br/>
                <g:if test="${fields.contains('isbn')}">
                        <label>ISBN</label>
                        <g:textField placeholder="ISBN" name="isbn" title="isbn" value="${record?.isbn}"
                                     style="width: 150px;"/>
                </g:if>
                </td>
            </g:if>



            <g:if test="${fields.contains('pages')}">
                <td>
                    <label>Pages</label>
                    <g:textField placeholder="Pages" title="Pages" id="pages" name="pages" style="width: 150px"
                                 class="ui-corner-all"
                                 value="${record?.pages}"/>
                </td>
            </g:if>

            <g:if test="${fields.contains('sourceFree')}">
                <td colspan="2">
                    <label>Source</label>
                    <g:textField placeholder="Source"
                                 id="sourceFree" name="sourceFree" style="width: 95%;"
                                 class="ui-corner-all"
                                 value="${record?.sourceFree}"/>
                    <g:if test="${fields.contains('url')}">
                        <label>URL</label>
                        <g:textField placeholder="URL" name="url" value="${record?.url}"
                                     style="width: 95%;"/>

                    </g:if>
                </td>
            </g:if>




        </tr>
        <tr>

            <g:if test="${fields.contains('startDate')}">
                <td>
              <table>
                  <tr>
                      <td>   <label>Start date</label>
                          <pkm:datePicker placeholder="" name="startDate" value="${record?.startDate}"/>
                      </td>
                      <td> <label>time</label>

                          <g:textField name="startTime" style="width:60px;" placeholder="Start time" title="Start time"
                                       value="${record?.startDate ? record?.startDate?.format('HH.mm') : '00.00'}"/></td>
                  </tr>
              </table>


                </td>
            </g:if>

            <g:if test="${fields.contains('endDate')}">
                <td>

                    <table>
                        <tr>
                            <td> <label>End date</label>
                                <pkm:datePicker name="endDate" placeholder="End date" id="asdfasdf"
                                                value="${record?.endDate}"/></td>
                            <td> <label>time</label>
                                <g:textField name="endTime" style="width:60px;" placeholder="Time" title="End time"
                                             value="${record?.endDate ? record?.endDate?.format('HH.mm') : '00.00'}"/></td>
                        </tr>
                    </table>


                </td>
            </g:if>

            <g:if test="${fields.contains('completedOn')}">
                <td>

                    <label>Completed on</label>
                    <pkm:datePicker name="completedOn" placeholder=""
                                    value="${record?.completedOn}"/>
                </td>
            </g:if>
        %{--<g:if test="${fields.contains('actualEndDate')}">--}%
        %{--<td>--}%
        %{--Actual end date<pkm:datePicker name="actualEndDate" placeholder="Actual end date" id="234rsdfsdf"--}%
        %{--value="${record?.actualEndDate}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%


            <g:if test="${fields.contains('publicationCity')}">
                <td>
                    <label>Pub. city</label>
                    <g:textField name="publicationCity"
                                 placeholder="Publication City"
                                 title="Publication City"
                                 style="width: 200px;" value="${fieldValue(bean: record, field: 'publicationCity')}"/>
                </td>

                <td>

                    <label>Pub. date</label>
                    <g:textField name="publicationDate" placeholder="Publication date"
                                 value="${record?.publicationDate}"/>
                </td>

                <td>
                    <label>Pub. on</label>
                    <pkm:datePicker placeholder="Pub. on" name="publishedOn" value="${record?.publishedOn}"/>

                </td>
            </g:if>
        </tr>

        <tr>
            <g:if test="${fields.contains('description')}">
                <td colspan="2">
                    <label>Description</label>
                    <g:textArea cols="80" rows="5" placeholder="Description" title="Description" name="description"
                                value="${record?.description}"
                                style="width: 95%; height: 100px;"/>
                </td>
            </g:if>

        %{--            <g:if test="${fields.contains('recurringInterval')}">--}%
        %{--                <td>--}%
        %{--                    <label>Recurring interval</label>--}%
        %{--                    <g:textField name="recurringInterval"--}%
        %{--                                 value="${fieldValue(bean: record, field: 'recurringInterval')}"--}%
        %{--                                 placeholder="" title="recur #" style="width: 20px;"/>--}%

        %{--                </td>--}%
        %{--            </g:if> --}%

            <g:if test="${fields.contains('recurringCron')}">
                <td>
                    <label>Recurrence cron expression: </label>
                    <br/>
                    <i>min h dom mon dow y*, e.g. <b>0 8 * * 1</b></i>
                    <g:textField name="recurringCron"
                                 value="${fieldValue(bean: record, field: 'recurringCron')}"/>

                </td>
            </g:if>


            <g:if test="${fields.contains('fullText')}">
                <td colspan="2">
                    <label>Full text</label>
                    <g:textArea cols="80" rows="5" placeholder="Full text" title="Full text" name="fullText"
                                value="${record?.fullText}"
                                style="width: 95%;  height: 100px;"/>
                </td>
            </g:if>

        </tr>
        <tr>
            <g:if test="${fields.contains('shortDescription')}">
                <td colspan="2">
                    <label>Short description</label>
                    <g:textArea cols="80" rows="5" placeholder="Short description"
                                title="Short description" name="shortDescription"
                                value="${record?.shortDescription}"
                                style="width: 95%;  height: 80px;"/>
                </td>
            </g:if>
            %{--<g:if test="${fields.contains('descriptionHTML')}">--}%
                %{--<td colspan="2">--}%
                    %{--<g:textArea cols="80" rows="5" placeholder="descriptionHTML"--}%
                                %{--title="Description HTML" name="descriptionHTML"--}%
                                %{--value="${record?.descriptionHTML}"--}%
                                %{--style="width: 95%;  height: 100px;"/>--}%
                %{--</td>--}%
            %{--</g:if>--}%

        </tr>

    %{--<tr>--}%

    %{--<g:if test="${fields.contains('newFilesPath')}">--}%
    %{--<td>--}%
    %{--new    <g:textField placeholder="Path of its location in the new folder"--}%
    %{--id="newFilesPath" name="newFilesPath"--}%
    %{--style="width: 200px"--}%
    %{--class="ui-corner-all"--}%
    %{--value="${record?.newFilesPath ?: null}"/>--}%
    %{--</td>--}%
    %{--</g:if>--}%
    %{--</tr>--}%
        <tr>
        %{--<g:if test="${fields.contains('repositoryPath')}">--}%
        %{--<td>--}%
        %{--rps    <g:textField--}%
        %{--placeholder="Path of its location in the repository"--}%
        %{--id="repositoryPath" name="repositoryPath" style="width: 200px"--}%
        %{--class="ui-corner-all"--}%
        %{--value="${record?.repositoryPath ?: null}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%
            %{--<g:if test="${fields.contains('libraryPath')}">--}%
                %{--<td>--}%
                    %{--lib    <g:textField--}%
                            %{--placeholder="Path of its location in the library"--}%
                            %{--id="libraryPath" name="libraryPath" style="width: 200px"--}%
                            %{--class="ui-corner-all"--}%
                            %{--value="${record?.libraryPath ?: null}"/>--}%
                %{--</td>--}%
            %{--</g:if>--}%


            <g:if test="${fields.contains('metaType')}">
                <td>

                    <g:textField id="metaType" name="metaType"
                                 placeholder="metaType"
                                 title="metaType"
                                 style="width: 150px;" value="${record?.metaType}"/>
                </td>
            </g:if>
            <g:if test="${fields.contains('path')}">
                <td>

                    <g:textField id="path" name="path"
                                 placeholder="Path"
                                 title="path"
                                 style="width: 150px;" value="${record?.path}"/>
                </td>
            </g:if>
            <g:if test="${fields.contains('extensions')}">
                <td>

                    <g:textField id="extensions" name="extensions"
                                 placeholder="Extensions"
                                 title="extensions"
                                 style="width: 150px;" value="${record?.extensions}"/>
                </td>
            </g:if>



        %{--<g:if test="${fields.contains('blog')}">--}%
        %{--<td>--}%
        %{--todo <g:select name="blog.id" style="width: 150px;"--}%
        %{--from="${Blog.list([sort: 'code'])}" optionKey="id" optionValue="summary"--}%
        %{--value="${record?.blog?.id}"--}%
        %{--noSelection="${['null': 'No blog']}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%


            <g:if test="${fields.contains('notes')}">

                <td colspan="1">
                    <label>Notes</label>
                    <g:textArea cols="80" rows="5" id="notes" placeholder="" title="Notes"
                                name="notes" style="width: 95%; max-width: 390px" class="ui-corner-all"
                                value="${record?.notes}"/>
                </td>

            </g:if>
            <g:if test="${fields.contains('bibEntry')}">
                <td colspan="1">
                    <label>Bib entry</label>
                    <g:textArea cols="80" rows="5" id="bibEntry"
                                placeholder="bibEntry"
                                title="bibEntry"
                                name="bibEntry"
                                style="width: 95%; max-width: 400px" class="ui-corner-all"
                                value="${record?.bibEntry}"/>
                </td>
            </g:if>
        </tr>



        <tr>

            <g:if test="${fields.contains('entity')}">
                <td>
                    <label>Entity</label>
                    <g:textField id="entity" name="entity" placeholder="Entity" title="Entity" style="width: 150px;"
                                 value="${record?.entity}"/>
                </td>
            </g:if>

            <g:if test="${fields.contains('module')}">
                <td>
                    <label>Module</label>
                    <g:textField id="module" name="module" placeholder="" title="Module" style="width: 150px;"
                                 value="${record?.module}"/>
                </td>
            </g:if>

            <g:if test="${fields.contains('prefix')}">
                <td>
                    <label>Prefix</label>
                    <g:textField id="prefix" name="prefix" placeholder="" title="Prefix" style="width: 150px;"
                                 value="${record?.prefix}"/>
                </td>
            </g:if>




            <g:if test="${fields.contains('priority')}">
                <td>
                    <label>Priority</label>
                    <g:select name="priority" placeholder="Priority" style="width: 50px;"
                               from="${[1, 2, 3, 4]}"
                               value="${record?.priority ?: 2}"/>
                </td>
            </g:if>

            <g:if test="${fields.contains('language')}">
                <td>
                    <label>Language</label>
                    %{--<g:textField placeholder="Lang. code"--}%
                                 %{--title="Lang. code"--}%
                                 %{--name="language" style="width: 100px" value="${record?.language ?: 'ar'}"/>--}%

                    <g:select name="language" from="${OperationController.getPath('repository.languages').split(',')}"
                              style="overflow: visible; z-index: 200; background: lightgrey" noSelection="${['': '']}"
                    value="${record?.language ?: (OperationController.getPath('default.language') ?: '')}"/>

                </td>
            </g:if>


        <g:if test="${fields.contains('plannedDuration')}">
        <td>
        Planned duration (min)
        <br/><g:textField name="plannedDuration" value="${fieldValue(bean: record, field: 'plannedDuration')}"
        placeholder=""
        title="# planned duration"
        style="width: 80px;"/>
        %{--<br/>--}%
        %{--Completed steps<g:textField name="completedSteps"--}%
        %{--value="${fieldValue(bean: record, field: 'completedSteps')}"--}%
        %{--placeholder="# actual steps"--}%
        %{--title="# actual steps"--}%
        %{--style="width: 20px;"/>--}%

        </td>
        </g:if>
%{--    <g:if test="${fields.contains('totalSteps')}">--}%
%{--        <td>--}%
%{--        Total steps<g:textField name="totalSteps" value="${fieldValue(bean: record, field: 'totalSteps')}"--}%
%{--        placeholder="# total steps"--}%
%{--        title="# total steps"--}%
%{--        style="width: 20px;"/>--}%
%{--        --}%%{--<br/>--}%
%{--        --}%%{--Completed steps<g:textField name="completedSteps"--}%
%{--        --}%%{--value="${fieldValue(bean: record, field: 'completedSteps')}"--}%
%{--        --}%%{--placeholder="# actual steps"--}%
%{--        --}%%{--title="# actual steps"--}%
%{--        --}%%{--style="width: 20px;"/>--}%

%{--        </td>--}%
%{--        </g:if>--}%

        %{--<g:if test="${fields.contains('percentCompleted')}">--}%
        %{--<td>--}%
        %{--%<g:select name="percentCompleted" placeholder="percentCompleted" style="width: 50px;"--}%
        %{--from="${[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]}"--}%
        %{--noSelection="${['null': '0']}"--}%
        %{--value="${record?.percentCompleted ?: 0}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%



            <g:if test="${fields.contains('level')}">
                <td>
                    <label>Level</label>
                    <g:select name="level" value="${record?.level}"
                              from="${['m', 'd', 'W', 'r', 'M', 'A', 'y', 'e', 'l']}"
                              noSelection="${['null': 'No level']}"/>
                </td>
            </g:if>
        %{--<g:if test="${fields.contains('orderInCourse')}">--}%
        %{--<td>--}%
        %{--<g:textField name="orderInCourse" value="${fieldValue(bean: record, field: 'orderInCourse')}"--}%
        %{--placeholder="# crs" title="# crs"--}%
        %{--style="width: 80px;"/>--}%

        %{--</td>--}%
        %{--</g:if>--}%
            <g:if test="${fields.contains('orderNumber')}">
                <td>
                    <label>Order #</label>
                    <g:textField name="orderNumber" value="${fieldValue(bean: record, field: 'orderNumber')}"
                                 placeholder="" title="order #" style="width: 80px;"/>

                </td>
            </g:if>

        </tr>

        <tr>

            %{--<g:if test="${fields.contains('chapters')}">--}%
            %{--<td>--}%
            %{--<g:textField name="chapters"--}%
            %{--placeholder="Chapters"--}%
            %{--title="Chapters"--}%
            %{--value="${fieldValue(bean: record, field: 'chapters')}"/>--}%
            %{--</td>--}%

            %{--</g:if>--}%

        </tr>


        <tr>

            <g:if test="${fields.contains('writtenOn')}">
                <td>
                    Written on
                    <br/>
                    <pkm:datePicker placeholder="Written on" name="writtenOn" value="${record?.writtenOn}"/>
                    <g:checkBox name="approximateDate" id="approximateDate" value="${record?.approximateDate}"/> ~ ?
                </td>
            </g:if>






            <g:if test="${fields.contains('recordId')}">
                <td>
                    <g:textField name="recordId" value="${fieldValue(bean: record, field: 'recordId')}"
                                 placeholder="recordId" title="recordId" style="width: 80px;"/>

                </td>
            </g:if>




            <g:if test="${fields.contains('date')}">
                <td>
                    Date <pkm:datePicker name="date" style="width: 70px;-moz-border-radius: 4px;" extraParams=""
                                         placeholder="Date"
                                         value="${record?.date ?: (session['lastDate'] ?: new Date())}"/>
                </td>
            </g:if>







        <g:if test="${fields.contains('amount')}">
        <td>
        Amount <g:textField id="amount" name="amount" placeholder="Amount" title="Amount"
        style="width: 90px;" class="ui-corner-all"
        value="${record?.amount}"/>
        </td>
        </g:if>

        <g:if test="${fields.contains('publishedNodeId')}">
        <td>
            Published node Id
            <br/>
        <g:textField id="publishedNodeId" name="publishedNodeId"
        placeholder="" title="Published node Id"
        style="width: 90px;" class="ui-corner-all"
        value="${record?.publishedNodeId}"/>
        </td>
        </g:if>

        </tr>
        <tr>

            <g:if test="${fields.contains('calendarEnabled')}">
                <td>
                <g:checkBox name="calendarEnabled" value="${record?.calendarEnabled}"/> Calendar enabled?
                </td>
            </g:if>
            <g:if test="${fields.contains('onHomepage')}">
                <td>
                    <g:checkBox name="onHomepage" value="${record?.onHomepage}"/> On homepage?
                </td>
            </g:if>

 <g:if test="${fields.contains('onMobile')}">
                <td>
                    <g:checkBox name="onMobile" value="${record?.onMobile}"/> On mobile?
                </td>
            </g:if>


        %{--<g:if test="${fields.contains('isDayChallenge')}">--}%
        %{--<td>--}%
        %{--<g:checkBox name="isDayChallenge" value="${record?.isDayChallenge}"/> Is day challenge?--}%
        %{--</td>--}%
        %{--</g:if>--}%

            <g:if test="${fields.contains('isKeyword')}">
                <td>
                    <g:checkBox name="isKeyword" value="${record?.isKeyword}"/> Is keyword?
                </td>
            </g:if>


            <g:if test="${fields.contains('isCategory')}">
                <td>
                    <g:checkBox id="isCategory" name="isCategory" value="${record?.isCategory}"
                                style="width: 15px;"/>  Is category?
                </td>
            </g:if>

        </tr>
        <tr>

        %{--<g:if test="${fields.contains('captureIsbn')}">--}%
        %{--<td><g:checkBox id="captureIsbn" name="captureIsbn" value="${record?.captureIsbn}"--}%
        %{--style="width: 15px;"/> Capture ISBN in file names?--}%
        %{--</td>--}%
        %{--</g:if>--}%
            <g:if test="${fields.contains('multiLine')}">
                <td><g:checkBox id="multiLine" name="multiLine" value="${record?.multiLine}"
                                style="width: 15px;"/> MultiLine
                </td>
            </g:if>

        </tr>

    %{--<tr>--}%
    %{--<g:if test="${fields.contains('reality')}">--}%
    %{--<td colspan="2">--}%
    %{--<g:textArea--}%
    %{--placeholder="Reality"--}%
    %{--title="Reality"--}%
    %{--name="reality" cols="40" rows="5" value="${record?.reality}"/>--}%
    %{--</td>--}%
    %{--</g:if>--}%
    %{--</tr>--}%


    %{--<g:if test="${fields.contains('citationText')}">--}%
    %{--<tr>--}%
    %{--<td colspan="2">--}%
    %{--<g:textField placeholder="Citation text"--}%
    %{--title="Citation text"--}%
    %{--rows="5" name="citationText" value="${record?.citationText}"--}%
    %{--style="width: 95%;"/>--}%
    %{--</td>--}%

    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td colspan="2">--}%
    %{--<g:textField placeholder="Citation Html"--}%
    %{--title="Citation Html"--}%
    %{--rows="5" name="citationHtml" value="${record?.citationHtml}"--}%
    %{--style="width: 95%;"/>--}%
    %{--</td>--}%

    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td colspan="2">--}%
    %{--<g:textField placeholder="Citation Ascii code"--}%
    %{--title="Citation Ascii code"--}%
    %{--rows="5" name="citationAsciicode" value="${record?.citationAsciicode}"--}%
    %{--style="width: 95%;"/>--}%
    %{--</td>--}%

    %{--</tr>--}%
    %{--</g:if>--}%

        </table>

    %{--<hr/>--}%
        <g:submitButton class="fg-button ui-icon-left ui-widget ui-state-default ui-corner-all" name="submit"
                        style="width: 100%; height: 30px;"
                        value="Save"
                        onsubmit=""/>

    </g:formRemote>
    </div>
    <g:if test="${savedRecord && !record}">
        <g:render template="/gTemplates/recordSummary" model="[record: savedRecord]"/>
    </g:if>
