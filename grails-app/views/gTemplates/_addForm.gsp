<%@ page import="app.Contact; ker.OperationController; app.parameters.Blog;mcs.Department; mcs.parameters.WorkStatus;" %>

%{--<g:if test="${record}">--}%
    %{--<g:render template="/gTemplates/recordSummary" model="[record: record]"/>--}%
%{--</g:if>--}%
<h4>Add record</h4>
<g:formRemote name="genericSearch" id="genericSearch22" url="[controller: 'generics', action: 'saveViaForm']"
              class="uk-form-stacked uk-grid-small uk-margin-small-left uk-margin-small-right"
              update="${updateRegion}" method="post" onComplete="">

    <g:hiddenField name="entityController" value="${entityController}"/>
    <g:hiddenField name="updateRegion" value="${updateRegion}"/>

    <g:hiddenField name="id" value="${record?.id}"/>

    %{--<div style="uk-grid" uk-grid>--}%

    <g:if test="${ker.OperationController.getPath('courses.enabled')?.toLowerCase() == 'yes'}">

    <g:if test="${fields.contains('book')}">
        <div>
            <label class="uk-form-label">Resource</label>
        <div class="uk-form-controls">
            <g:select class="uk-width-1-1 uk-select"  name="book.id" style="width: 200px;"
                      from="${record?.book ? [record.book] + mcs.Book.executeQuery('from Book r where r.type.code = ? and r.status.code = ? order by r.title asc', ['prd', 'zbk']) : mcs.Book.executeQuery('from Book r where r.type.code = ? and r.status.code = ? order by r.title asc', ['prd', 'zbk'])}"
                      value="${record?.book?.id}" optionKey="id"
                      optionValue="title"
                      noSelection="${['null': 'No book']}"/>
        </div>
        </div>
    </g:if>

            <g:if test="${fields.contains('contact')}">
                <div>
                    <label class="uk-form-label">Contact</label>
                <div class="uk-form-controls">
                    <g:select class="uk-width-1-1 uk-select"  name="contact.id" class="ui-corner-all"
                              from="${sources}" optionKey="id"
                              value="${record?.contact?.id}"
                              noSelection="${['null': 'No person']}"/>
                </div>
                </div>
            </g:if>

    <g:if test="${fields.contains('department')}">
        <div>
        <label class="uk-form-label">Department</label>

            <g:select class="uk-width-1-1 uk-select"  name="department.id" style="width: 200px;" from="${departments}"
                      value="${record?.department?.id}" optionKey="id"
                      optionValue="summary"
                      noSelection="${['null': 'No department']}"/>
        </div>
    </g:if>

    <g:if test="${fields.contains('course')}">
        <div>
            <label class="uk-form-label">Course</label>
            <g:select class="uk-width-1-1 uk-select"  name="course.id" style="" from="${courses}"
                      id="chosenCourse${record?.id}"
                      value="${record?.course?.id}"
                      optionKey="id"
                      optionValue="summary"
                      noSelection="${['null': 'No course']}"/>
        </div>


            <script type="text/javascript">
                jQuery("#chosenCourse${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

    </g:if>

        </g:if>

        <g:if test="${fields.contains('queryType')}">


                <div>
            <label class="uk-form-label">Query type</label>
                <g:select class="uk-width-1-1 uk-select"  name="queryType" from="${['hql', 'lucene', 'adhoc']}" value="${record?.queryType}"/>
                </div>
        </g:if>

        <g:if test="${fields.contains('code')}">
            <div>
                <label class="uk-form-label">Code</label>
                <g:textField class="uk-width-1-1 uk-input"  name="code" placeholder="Code" title="Code"
                             value="${record?.code}"/>
            </div>
        </g:if>
    %{--<g:if test="${fields.contains('slug')}">--}%
    %{----}%

    %{--<g:textField class="uk-width-1-1 uk-input"  name="slug" placeholder="Slug" title="Slug" --}%
    %{--value="${record?.slug}"/>--}%
    %{--</g:if>--}%
        %{--<g:if test="${fields.contains('publishedNodeId')}">--}%
            %{----}%
            %{--Pub. Id: <g:textField class="uk-width-1-1 uk-input"  id="publishedNodeId" name="publishedNodeId"--}%
                              %{--placeholder="Published node Id" title="Published node Id"--}%
                              %{--style="width: 90px;" --}%
                              %{--value="${record?.publishedNodeId}"/>--}%
        %{--</g:if>--}%
    

        <g:if test="${fields.contains('type')}">
            <div>
                <label class="uk-form-label">Type</label>
                <g:select class="uk-width-1-1 uk-select"  name="type.id" style="width: 150px;"
                          from="${types}" optionKey="id" optionValue="name"
                          value="${record?.type?.id}"
                          id="chosenType${record?.id}"
                          noSelection="${['null': 'No type']}"/>
            </div>
            <script type="text/javascript">
                jQuery("#chosenType${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </g:if>

        <g:if test="${fields.contains('category')}">
            <div>
                <label class="uk-form-label">Category</label>
                <g:select class="uk-width-1-1 uk-select"  name="category.id" style="width: 150px;"
                          from="${categories}" optionKey="id"
                          value="${record?.category?.id}"
                          id="chosenCategory${record?.id}"
                          noSelection="${['null': 'No category']}"/>
            </div>
            <script type="text/javascript">
                jQuery("#chosenCategory${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </g:if>


        <g:if test="${fields.contains('writing')}">
            <div>
                <label class="uk-form-label">Writing</label>
                <g:select class="uk-width-1-1 uk-select"  name="writing.id" from="${writings}" style="width: 150px;"
                          optionKey="id" optionValue="summary"
                          id="chosenWriting${record?.id}"
                          value="${record?.writing?.id ?: (session['writingId'] ?: null)}"
                          noSelection="['null': 'No writing']"/>
            </div>

                <script type="text/javascript">
                    jQuery("#chosenWriting${record?.id}").chosen({
                        allow_single_deselect: true,
                        no_results_text: "None found"
                    })
                </script>

        </g:if>



        <g:if test="${fields.contains('status')}">
            <div>

                <label class="uk-form-label">Status</label>
                <g:select class="uk-width-1-1 uk-select"  name="status.id" style="width: 150px;"
                          from="${statuses}" optionKey="id" optionValue="name"
                          id="chosenStatus${record?.id}"
                          data-placeholder="No status"
                          value="${record?.status?.id}"
                          noSelection="${['null': 'No status']}"/>
            </div>

            <script type="text/javascript">
                jQuery("#chosenStatus${record?.id}").chosen({
                    allow_single_deselect: true,
                    no_results_text: "None found"
                })
            </script>

        </g:if>

        <g:if test="${fields.contains('goal')}">
            <div>
            
                <label class="uk-form-label">Goal</label>

                <g:select class="uk-width-1-1 uk-select"  name="goal.id" from="${goals}" style="width: 150px;"
                          optionKey="id" optionValue="summary"
                          data-placeholder="No goal"
                          id="chosenGoal${record?.id}"
                          value="${record?.goal?.id ?: (session['goalId'] ?: null)}"
                          noSelection="['null': 'No goal']"/>
            </div>

                <script type="text/javascript">
                    jQuery("#chosenGoal${record?.id}").chosen({
                        allow_single_deselect: true,
                        no_results_text: "None found"
                    })
                </script>

            
        </g:if>

        %{--<g:if test="${fields.contains('location')}">--}%
            %{----}%
                %{--<g:select class="uk-width-1-1 uk-select"  name="location.id" style="width: 150px;"--}%
                          %{--from="${locations}" optionKey="id" optionValue="name"--}%
                          %{--value="${record?.location?.id}"--}%
                          %{--noSelection="${['null': 'No location']}"/>--}%
            %{----}%
        %{--</g:if>--}%

        <g:if test="${fields.contains('context')}">
            <div>
                <label class="uk-form-label">Context</label>
                <g:select class="uk-width-1-1 uk-select"  name="context.id" style="width: 150px;"
                          from="${contexts}" optionKey="id" optionValue="name"
                          value="${record?.context?.id}"
                          noSelection="${['null': 'No context']}"/>
            </div>
        </g:if>

    
    

        <g:if test="${fields.contains('numberCode')}">
            <div>
                <label class="uk-form-label">Code (number)</label>
                <g:textField class="uk-width-1-1 uk-input"  name="numberCode" placeholder="Number Code" title="Number Code"
                             value="${record?.numberCode}"/>
            </div>
        </g:if>





    <g:if test="${fields.contains('username')}">
        <div>
    <g:textField class="uk-width-1-1 uk-input"  name="username" placeholder="Username" title="Username"
    value="${record?.username}"/>
        </div>
    </g:if>
    <g:if test="${fields.contains('password')}">
        <div>
    <g:textField class="uk-width-1-1 uk-input"  name="password" placeholder="Password" title="Password"
    value="${record?.password}"/>
        </div>
    </g:if>




        <g:if test="${fields.contains('name')}">
            <div>
                <label class="uk-form-label">Name</label>
                <g:textField class="uk-width-1-1 uk-input"  name="name" placeholder="Name" title="Name"
                             value="${record?.name}"/>

            </div>
        </g:if>


        <g:if test="${fields.contains('value')}">
            <div>
                <label class="uk-form-label">Value</label>
                <g:textField class="uk-width-1-1 uk-input"  id="value" name="value" placeholder="Value" title="Value" style="width: 250px;"
                            value="${record?.value}"/>
                %{--rows="5" cols="80"--}%
            </div>
        </g:if>

    

    

        <g:if test="${fields.contains('summary')}">

            <div>
                <label class="uk-form-label">Summary</label>
                <g:textField class="uk-width-1-1 uk-input"  id="sumamryField" name="summary" title="summary" value="${record?.summary}"
                             />
            </div>
        </g:if>

    
    


        <g:if test="${fields.contains('title')}">
            <div>
                <label class="uk-form-label">Title</label>
                <g:textField class="uk-width-1-1 uk-input"  placeholder="Title" name="title" title="title" value="${record?.title}"
                             />
</div>
                <g:if test="${fields.contains('authorInfo')}">
                    <div>
                    <label class="uk-form-label">Author info</label>
                    <g:textField class="uk-width-1-1 uk-input"  placeholder="Author infor" name="authorInfo" title="Author info"
                                 value="${record?.authorInfo}"/>
                    </div>
                </g:if>


                <g:if test="${ker.OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                    <g:if test="${fields.contains('legacyTitle')}">
<div>
                        <label class="uk-form-label">Legacy title</label>
                        <g:textField class="uk-width-1-1 uk-input"  placeholder="Legacy title" name="legacyTitle" title="Legacy title"
                                     value="${record?.legacyTitle}" />
                        </div>
                    </g:if>
                </g:if>


        </g:if>



        <g:if test="${fields.contains('link')}">
            <div>
                <label class="uk-form-label">Link</label>
                <g:textField class="uk-width-1-1 uk-input"  placeholder="link (should start with http and ends with /xmlrpc.php" name="link"
                             title="link"
                             value="${record?.link}" style="width: 350px;"/>
            </div>
        </g:if>


        <g:if test="${fields.contains('style')}">
            <div>
                <label class="uk-form-label">Style</label>
                <g:textField class="uk-width-1-1 uk-input"  id="style" name="style" placeholder="CSS Style" title="CSS Style" style="width: 120px;"

                             value="${record?.style}"/>
            </div>
        </g:if>


        <g:if test="${fields.contains('color')}">
            <div>
                <label class="uk-form-label">Color</label>
                <g:textField class="uk-width-1-1 uk-input"  id="color" name="color" placeholder="Color" title="Color" color="width: 60px;"

                             value="${record?.color}"/>
            </div>
        </g:if>

        %{----}%

        %{----}%


            <g:if test="${fields.contains('author')}">
                <div>
                    <label class="uk-form-label">Author</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="author" placeholder="Author" title="Author"
                                 value="${record?.author}"/>
                </div>


                    <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                        <div>
                        <label class="uk-form-label">Bib author</label>
                        <g:textField class="uk-width-1-1 uk-input"  name="authorInBib" placeholder="Author in Bib" title="Author in Bib"
                                     value="${record?.authorInBib}"/>
                        </div>
                    </g:if>

                <div>
                    <label class="uk-form-label">Trans.</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="translator" placeholder="Translator" title="Translator"
                                 value="${record?.translator}"/>

                </div>
                <div>
                    <label class="uk-form-label">Editor</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="editor" placeholder="Editor" title="Editor"
                                 value="${record?.editor}"/>
                </div>
            </g:if>




        
        
            <g:if test="${fields.contains('publisher')}">
                <div>
                    <label class="uk-form-label">Publisher</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="publisher"
                                 placeholder="Publisher"
                                 title="Publisher"
                                 style="width: 200px;" value="${fieldValue(bean: record, field: 'publisher')}"/>
                </div>

            </g:if>

            <g:if test="${fields.contains('journal')}">
                <div>
                    <label class="uk-form-label">Journal</label>
                    <g:textField class="uk-width-1-1 uk-input"  placeholder="Journal" name="journal" value="${record?.journal}"
                                 />
                </div>
            </g:if>
        
         

            <g:if test="${fields.contains('edition')}">
                <div>
                    <label class="uk-form-label">Ed.</label>
                <g:textField class="uk-width-1-1 uk-input"  name="edition"
                                                     value="${fieldValue(bean: record, field: 'edition')}"
                                                     placeholder="Edition" title="Edition" style="width: 80px;"/>

                </div>

                <div>

                    <label class="uk-form-label">Vol.</label>
                <g:textField class="uk-width-1-1 uk-input"  name="volume" value="${fieldValue(bean: record, field: 'volume')}"
                                                     placeholder="volume" title="volume" style="width: 80px;"/>
                </div>
                
            </g:if>
            <g:if test="${fields.contains('resourceYear')}">
                <div>
                    <label class="uk-form-label">Year</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="resourceYear" value="${fieldValue(bean: record, field: 'resourceYear')}"
                                 placeholder="Year" title="resourceYear" style="width: 80px;"/>
                </div>

                    <g:if test="${fields.contains('number')}">
                        <div>
                        <label class="uk-form-label">Number</label>
                        <g:textField class="uk-width-1-1 uk-input"  name="number" value="${fieldValue(bean: record, field: 'number')}"
                                     placeholder="number" title="number" style="width: 80px;"/>
                        </div>
                    </g:if>
                
            </g:if>
            <g:if test="${fields.contains('month')}">
                <div>
                    <label class="uk-form-label">Month</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="month" value="${fieldValue(bean: record, field: 'month')}"
                                 placeholder="month" title="month" style="width: 80px;"/>
                </div>
                    <g:if test="${fields.contains('series')}">
                        <div>
                        <label class="uk-form-label">Series</label>
                        <g:textField class="uk-width-1-1 uk-input"  name="series" value="${fieldValue(bean: record, field: 'series')}"
                                     placeholder="series" title="series" style="width: 80px;"/>
                        </div>
                    </g:if>
                
            </g:if>

        %{--<g:if test="${fields.contains('indicator')}">--}%
        %{----}%
        %{--<g:select class="uk-width-1-1 uk-select"  name="indicator.id" --}%
        %{--from="${indicators}"--}%
        %{--optionKey="id" optionValue="code"--}%
        %{--value="${record?.indicator?.id ?: (session['lastIndicatorId'] ?: null)}"--}%
        %{--noSelection="${['null': '']}"/>--}%
        %{----}%
        %{--</g:if>--}%



        %{--<g:if test="${fields.contains('category') && entityCode == 'Q'}">--}%
        %{----}%
        %{--<g:select class="uk-width-1-1 uk-select"  name="category.id" --}%
        %{--from="${app.PaymentCategory.list()}" optionKey="id"--}%
        %{--value="${record?.category?.id}"--}%
        %{--noSelection="${['null': '']}"/>--}%
        %{----}%
        %{--</g:if>--}%


        

        

            <g:if test="${fields.contains('query')}">
                <div>
                <label class="uk-form-label">Query</label>
                <g:textArea class="uk-width-1-1 uk-textarea"  placeholder="Query" title="Query" rows="5" name="query" value="${record?.query}"
                             />
                </div>
            </g:if>


            <g:if test="${fields.contains('countQuery')}">
                <div>
                <label class="uk-form-label">Count query</label>
                <g:textArea class="uk-width-1-1 uk-textarea"  placeholder="Count query" title="Count query" name="countQuery"
                             value="${record?.countQuery}"
                             />
                </div>
            </g:if>

            <g:if test="${fields.contains('nbPages')}">
                <div>
                    <label class="uk-form-label">Nb. pages</label>
                    <g:textField class="uk-width-1-1 uk-input"  placeholder="Nb. pages" title="Nb. pages" id="pages" name="nbPages"
                                 value="${record?.nbPages}"/>
                </div>


                <g:if test="${fields.contains('isbn')}">
                    <div>
                    <label class="uk-form-label">ISBN</label>
                        <g:textField class="uk-width-1-1 uk-input"  placeholder="ISBN" name="isbn" title="isbn" value="${record?.isbn}"
                                     style="width: 150px;"/>
                    </div>
                </g:if>
                
            </g:if>



            <g:if test="${fields.contains('pages')}">
                <div>
                    <label class="uk-form-label">Pages</label>
                    <g:textField class="uk-width-1-1 uk-input"  placeholder="Pages" title="Pages" id="pages" name="pages" style="width: 150px"

                                 value="${record?.pages}"/>
                </div>
            </g:if>

            <g:if test="${fields.contains('sourceFree')}">
                <div>
                    <label class="uk-form-label">Source</label>
                    <g:textField class="uk-width-1-1 uk-input"  placeholder="Source"
                                 id="sourceFree" name="sourceFree"
                                 value="${record?.sourceFree}"/>
                </div>
                    <g:if test="${fields.contains('url')}">
                        <div>
                        <label class="uk-form-label">URL</label>
                        <g:textField class="uk-width-1-1 uk-input"  placeholder="URL" name="url" value="${record?.url}"
                                     />
                        </div>
                    </g:if>
                
            </g:if>




        
        

            <g:if test="${fields.contains('startDate')}">

                <div>
                  
                         <label class="uk-form-label">Start date</label>
                          <pkm:datePicker placeholder="" name="startDate" value="${record?.startDate}"/>
                </div>
                <div>
                       <label class="uk-form-label">time</label>

                          <g:textField class="uk-width-1-1 uk-input"  name="startTime" style="width:60px;" placeholder="Start time" title="Start time"
                                       value="${record?.startDate ? record?.startDate?.format('HH.mm') : '00.00'}"/>
                </div>



                
            </g:if>

            <g:if test="${fields.contains('endDate')}">


                <div>
                        
                             <label class="uk-form-label">End date</label>
                                <pkm:datePicker name="endDate" placeholder="End date" id="asdfasdf"
                                                value="${record?.endDate}"/>
                </div>
                <div>
                             <label class="uk-form-label">time</label>
                                <g:textField class="uk-width-1-1 uk-input"  name="endTime" style="width:60px;" placeholder="Time" title="End time"
                                             value="${record?.endDate ? record?.endDate?.format('HH.mm') : '00.00'}"/>

                </div>


                
            </g:if>

            <g:if test="${fields.contains('completedOn')}">

                <div>
                    <label class="uk-form-label">Completed on</label>
                    <pkm:datePicker name="completedOn" placeholder=""
                                    value="${record?.completedOn}"/>
                </div>
            </g:if>
        %{--<g:if test="${fields.contains('actualEndDate')}">--}%
        %{----}%
        %{--Actual end date<pkm:datePicker name="actualEndDate" placeholder="Actual end date" id="234rsdfsdf"--}%
        %{--value="${record?.actualEndDate}"/>--}%
        %{----}%
        %{--</g:if>--}%


            <g:if test="${fields.contains('publicationCity')}">
                <div>
                    <label class="uk-form-label">Publication city</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="publicationCity"
                                 placeholder="Publication City"
                                 title="Publication City"
                                 style="width: 200px;" value="${fieldValue(bean: record, field: 'publicationCity')}"/>
                </div>

                
<div>
                    <label class="uk-form-label">Publication date</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="publicationDate" placeholder="Publication date"
                                 value="${record?.publicationDate}"/>
                </div>

                <div>
                    <label class="uk-form-label">Published on</label>
                    <pkm:datePicker placeholder="Pub. on" name="publishedOn" value="${record?.publishedOn}"/>
                </div>
                
            </g:if>
        

        
            <g:if test="${fields.contains('description')}">
                <div>
                    <label class="uk-form-label">Description</label>
                    <g:textArea class="uk-width-1-1 uk-textarea"  cols="80" rows="5" placeholder="Description" title="Description" name="description"
                                value="${record?.description}"
                                style="height: 100px;"/>
                </div>
            </g:if>

        %{--            <g:if test="${fields.contains('recurringInterval')}">--}%
        %{--                --}%
        %{--                    <label class="uk-form-label">Recurring interval</label>--}%
        %{--                    <g:textField class="uk-width-1-1 uk-input"  name="recurringInterval"--}%
        %{--                                 value="${fieldValue(bean: record, field: 'recurringInterval')}"--}%
        %{--                                 placeholder="" title="recur #" style="width: 20px;"/>--}%

        %{--                --}%
        %{--            </g:if> --}%

            <g:if test="${fields.contains('recurringCron')}">
                <div>
                    <label class="uk-form-label">Recurrence cron expression: </label>
                    <br/>
                    <i>min h dom mon dow y*, e.g. <b>0 8 * * 1</b></i>
                    <g:textField class="uk-width-1-1 uk-input"  name="recurringCron"
                                 value="${fieldValue(bean: record, field: 'recurringCron')}"/>
                </div>
                
            </g:if>


            <g:if test="${fields.contains('fullText')}">
                <div>
                    <label class="uk-form-label">Full text</label>
                    <g:textArea class="uk-width-1-1 uk-textarea"  cols="80" rows="5" placeholder="Full text" title="Full text" name="fullText"
                                value="${record?.fullText}"
                                style="height: 100px;"/>
                </div>
            </g:if>

        
        
            <g:if test="${fields.contains('shortDescription')}">
                <div>
                    <label class="uk-form-label">Short description</label>
                    <g:textArea class="uk-width-1-1 uk-textarea"  cols="80" rows="5" placeholder="Short description"
                                title="Short description" name="shortDescription"
                                value="${record?.shortDescription}"
                                style="height: 80px;"/>
                </div>
            </g:if>
            %{--<g:if test="${fields.contains('descriptionHTML')}">--}%
                %{--<td colspan="2">--}%
                    %{--<g:textArea class="uk-width-1-1 uk-textarea"  cols="80" rows="5" placeholder="descriptionHTML"--}%
                                %{--title="Description HTML" name="descriptionHTML"--}%
                                %{--value="${record?.descriptionHTML}"--}%
                                %{--style="width: 95%;  height: 100px;"/>--}%
                %{----}%
            %{--</g:if>--}%

        

    %{----}%

    %{--<g:if test="${fields.contains('newFilesPath')}">--}%
    %{----}%
    %{--new    <g:textField class="uk-width-1-1 uk-input"  placeholder="Path of its location in the new folder"--}%
    %{--id="newFilesPath" name="newFilesPath"--}%
    %{--style="width: 200px"--}%
    %{----}%
    %{--value="${record?.newFilesPath ?: null}"/>--}%
    %{----}%
    %{--</g:if>--}%
    %{----}%
        
        %{--<g:if test="${fields.contains('repositoryPath')}">--}%
        %{----}%
        %{--rps    <g:textField class="uk-width-1-1 uk-input" --}%
        %{--placeholder="Path of its location in the repository"--}%
        %{--id="repositoryPath" name="repositoryPath" style="width: 200px"--}%
        %{----}%
        %{--value="${record?.repositoryPath ?: null}"/>--}%
        %{----}%
        %{--</g:if>--}%
            %{--<g:if test="${fields.contains('libraryPath')}">--}%
                %{----}%
                    %{--lib    <g:textField class="uk-width-1-1 uk-input" --}%
                            %{--placeholder="Path of its location in the library"--}%
                            %{--id="libraryPath" name="libraryPath" style="width: 200px"--}%
                            %{----}%
                            %{--value="${record?.libraryPath ?: null}"/>--}%
                %{----}%
            %{--</g:if>--}%


            <g:if test="${fields.contains('metaType')}">

                <div>
                    <g:textField class="uk-width-1-1 uk-input"  id="metaType" name="metaType"
                                 placeholder="metaType"
                                 title="metaType"
                                 style="width: 150px;" value="${record?.metaType}"/>
                </div>
            </g:if>
            <g:if test="${fields.contains('path')}">
                <div>

                    <g:textField class="uk-width-1-1 uk-input"  id="path" name="path"
                                 placeholder="Path"
                                 title="path"
                                 style="width: 150px;" value="${record?.path}"/>
                </div>
            </g:if>
            <g:if test="${fields.contains('extensions')}">

                <div>
                    <g:textField class="uk-width-1-1 uk-input"  id="extensions" name="extensions"
                                 placeholder="Extensions"
                                 title="extensions"
                                 style="width: 150px;" value="${record?.extensions}"/>
                </div>
            </g:if>



        %{--<g:if test="${fields.contains('blog')}">--}%
        %{----}%
        %{--todo <g:select class="uk-width-1-1 uk-select"  name="blog.id" style="width: 150px;"--}%
        %{--from="${Blog.list([sort: 'code'])}" optionKey="id" optionValue="summary"--}%
        %{--value="${record?.blog?.id}"--}%
        %{--noSelection="${['null': 'No blog']}"/>--}%
        %{----}%
        %{--</g:if>--}%


            <g:if test="${fields.contains('notes')}">

                <div>
                    <label class="uk-form-label">Notes</label>
                    <g:textArea class="uk-width-1-1 uk-textarea"  cols="80" rows="5" id="notes" placeholder="" title="Notes"
                                name="notes" style=""
                                value="${record?.notes}"/>
                </div>

            </g:if>
            <g:if test="${fields.contains('bibEntry')}">
                <div>
                    <label class="uk-form-label">Bib entry</label>
                    <g:textArea class="uk-width-1-1 uk-textarea"  cols="80" rows="5" id="bibEntry"
                                placeholder="bibEntry"
                                title="bibEntry"
                                name="bibEntry"
                                style="width: 95%; max-width: 400px"
                                value="${record?.bibEntry}"/>
                </div>
            </g:if>
        



        

            <g:if test="${fields.contains('entity')}">
                <div>
                    <label class="uk-form-label">Entity</label>
                    <g:textField class="uk-width-1-1 uk-input"  id="entity" name="entity" placeholder="Entity" title="Entity" style="width: 150px;"
                                 value="${record?.entity}"/>
                </div>
            </g:if>

            <g:if test="${fields.contains('module')}">
                <div>
                    <label class="uk-form-label">Module</label>
                    <g:textField class="uk-width-1-1 uk-input"  id="module" name="module" placeholder="" title="Module" style="width: 150px;"
                                 value="${record?.module}"/>
                </div>
            </g:if>

            <g:if test="${fields.contains('prefix')}">
                <div>
                    <label class="uk-form-label">Prefix</label>
                    <g:textField class="uk-width-1-1 uk-input"  id="prefix" name="prefix" placeholder="" title="Prefix"
                                 value="${record?.prefix}"/>
                </div>
            </g:if>




            <g:if test="${fields.contains('priority')}">
                <div>
                    <label class="uk-form-label">Priority</label>
                    <g:select class="uk-width-1-1 uk-select"  name="priority" placeholder="Priority"
                               from="${[1, 2, 3, 4]}"
                               value="${record?.priority ?: 2}"/>
                </div>
            </g:if>

            <g:if test="${fields.contains('language')}">
                <div>
                    <label class="uk-form-label">
                        Language</label>
                    %{--<g:textField class="uk-width-1-1 uk-input"  placeholder="Lang. code"--}%
                                 %{--title="Lang. code"--}%
                                 %{--name="language" style="width: 100px" value="${record?.language ?: 'ar'}"/>--}%

                    <g:select class="uk-width-1-1 uk-select" name="language" from="${OperationController.getPath('repository.languages').split(',')}"
                              style="overflow: visible; z-index: 200;" noSelection="${['': '']}"
                    value="${record?.language ?: (OperationController.getPath('default.language') ?: '')}"/>
                </div>
                
            </g:if>


        <g:if test="${fields.contains('plannedDuration')}">
            <div>
            <label class="uk-form-label">
            Planned duration (min)
            </label>
            <g:textField class="uk-width-1-1 uk-input"  name="plannedDuration" value="${fieldValue(bean: record, field: 'plannedDuration')}"
        placeholder=""
        title="# planned duration"/>
            </div>
        %{--<br/>--}%
        %{--Completed steps<g:textField class="uk-width-1-1 uk-input"  name="completedSteps"--}%
        %{--value="${fieldValue(bean: record, field: 'completedSteps')}"--}%
        %{--placeholder="# actual steps"--}%
        %{--title="# actual steps"--}%
        %{--style="width: 20px;"/>--}%

        
        </g:if>
%{--    <g:if test="${fields.contains('totalSteps')}">--}%
%{--        --}%
%{--        Total steps<g:textField class="uk-width-1-1 uk-input"  name="totalSteps" value="${fieldValue(bean: record, field: 'totalSteps')}"--}%
%{--        placeholder="# total steps"--}%
%{--        title="# total steps"--}%
%{--        style="width: 20px;"/>--}%
%{--        --}%%{--<br/>--}%
%{--        --}%%{--Completed steps<g:textField class="uk-width-1-1 uk-input"  name="completedSteps"--}%
%{--        --}%%{--value="${fieldValue(bean: record, field: 'completedSteps')}"--}%
%{--        --}%%{--placeholder="# actual steps"--}%
%{--        --}%%{--title="# actual steps"--}%
%{--        --}%%{--style="width: 20px;"/>--}%

%{--        --}%
%{--        </g:if>--}%

        %{--<g:if test="${fields.contains('percentCompleted')}">--}%
        %{----}%
        %{--%<g:select class="uk-width-1-1 uk-select"  name="percentCompleted" placeholder="percentCompleted" style="width: 50px;"--}%
        %{--from="${[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]}"--}%
        %{--noSelection="${['null': '0']}"--}%
        %{--value="${record?.percentCompleted ?: 0}"/>--}%
        %{----}%
        %{--</g:if>--}%



            <g:if test="${fields.contains('level')}">
                <div>
                    <label class="uk-form-label">Level</label>
                    <g:select class="uk-width-1-1 uk-select"  name="level" value="${record?.level}"
                              from="${['m', 'd', 'W', 'r', 'M', 'A', 'y', 'e', 'l']}"
                              noSelection="${['null': 'No level']}"/>
                </div>
            </g:if>
        %{--<g:if test="${fields.contains('orderInCourse')}">--}%
        %{----}%
        %{--<g:textField class="uk-width-1-1 uk-input"  name="orderInCourse" value="${fieldValue(bean: record, field: 'orderInCourse')}"--}%
        %{--placeholder="# crs" title="# crs"--}%
        %{--style="width: 80px;"/>--}%

        %{----}%
        %{--</g:if>--}%
            <g:if test="${fields.contains('orderNumber')}">
                <div>
                    <label class="uk-form-label">Order #</label>
                    <g:textField class="uk-width-1-1 uk-input"  name="orderNumber" value="${fieldValue(bean: record, field: 'orderNumber')}"
                                 placeholder="" title="order #" style="width: 80px;"/>
                </div>
                
            </g:if>

        

        

            %{--<g:if test="${fields.contains('chapters')}">--}%
            %{----}%
            %{--<g:textField class="uk-width-1-1 uk-input"  name="chapters"--}%
            %{--placeholder="Chapters"--}%
            %{--title="Chapters"--}%
            %{--value="${fieldValue(bean: record, field: 'chapters')}"/>--}%
            %{----}%

            %{--</g:if>--}%

        


        

            <g:if test="${fields.contains('writtenOn')}">
                <div>

                    <label class="uk-form-label">
                    Written on
                    </label>

                    <pkm:datePicker placeholder="Written on" name="writtenOn" value="${record?.writtenOn}"/>
                    <g:checkBox name="approximateDate" id="approximateDate" value="${record?.approximateDate}"/> ~ ?
                </div>
            </g:if>






            <g:if test="${fields.contains('recordId')}">
                <div>
                    <label class="uk-form-label">
Record ID
                    </label>


                    <g:textField class="uk-width-1-1 uk-input"  name="recordId" value="${fieldValue(bean: record, field: 'recordId')}"
                                 placeholder="recordId" title="recordId" style="width: 80px;"/>

                </div>
            </g:if>




            <g:if test="${fields.contains('date')}">
                <div>

                    <label class="uk-form-label">
                        Date
                    </label>


                     <pkm:datePicker name="date" style="width: 70px;-moz-border-radius: 4px;" extraParams=""
                                         placeholder="Date"
                                         value="${record?.date ?: (session['lastDate'] ?: new Date())}"/>
                </div>
            </g:if>



        <g:if test="${fields.contains('amount')}">
            <div>


               <label class="uk-form-label">
                Amount
            </label>


            <g:textField class="uk-width-1-1 uk-input"  id="amount" name="amount" placeholder="Amount" title="Amount"
        style="width: 90px;"
        value="${record?.amount}"/>
        
        </g:if>

        %{--<g:if test="${fields.contains('publishedNodeId')}">--}%
                    %{--Published node Id--}%
            %{--<br/>--}%
        %{--<g:textField class="uk-width-1-1 uk-input"  id="publishedNodeId" name="publishedNodeId"--}%
        %{--placeholder="" title="Published node Id"--}%
        %{--style="width: 90px;"--}%
        %{--value="${record?.publishedNodeId}"/>--}%
        %{----}%
        %{--</g:if>--}%

        
        

            <g:if test="${fields.contains('calendarEnabled')}">
                <div>

                    <label class="uk-form-label">
                        Calendar enabled?
                    </label>


                    <g:checkBox name="calendarEnabled" value="${record?.calendarEnabled}"/>

                </div>
            </g:if>
            <g:if test="${fields.contains('onHomepage')}">
                <div>

                    <label class="uk-form-label">
                        On homepage?
                    </label>


                    <g:checkBox name="onHomepage" value="${record?.onHomepage}"/>

                </div>
            </g:if>

 <g:if test="${fields.contains('onMobile')}">
     <div>
         <label class="uk-form-label">
             On mobile?
         </label>

         <g:checkBox name="onMobile" value="${record?.onMobile}"/>
           </div>

            </g:if>


    <g:if test="${fields.contains('markedAsActive')}">
        <div>
            <label class="uk-form-label">
                Status marked as active?
            </label>


            <g:checkBox name="markedAsActive" value="${record?.markedAsActive}"/>
              </div>
            </g:if>


        %{--<g:if test="${fields.contains('isDayChallenge')}">--}%
        %{----}%
        %{--<g:checkBox name="isDayChallenge" value="${record?.isDayChallenge}"/> Is day challenge?--}%
        %{----}%
        %{--</g:if>--}%

            <g:if test="${fields.contains('isKeyword')}">
                <div>
                    <label class="uk-form-label">
                        Is keyword?
                    </label>

                    <g:checkBox name="isKeyword" value="${record?.isKeyword}"/>
                </div>
            </g:if>


            <g:if test="${fields.contains('isCategory')}">
                <div>
                    <label class="uk-form-label">
                        Is category?
                    </label>

                    <g:checkBox id="isCategory" name="isCategory" value="${record?.isCategory}"
                                style="width: 15px;"/>
                </div>
            </g:if>

        
        

        %{--<g:if test="${fields.contains('captureIsbn')}">--}%
        %{--<g:checkBox id="captureIsbn" name="captureIsbn" value="${record?.captureIsbn}"--}%
        %{--style="width: 15px;"/> Capture ISBN in file names?--}%
        %{----}%
        %{--</g:if>--}%
            <g:if test="${fields.contains('multiLine')}">
                <div>
                    <label class="uk-form-label">
                        MultiLine
                    </label>
                <g:checkBox id="multiLine" name="multiLine" value="${record?.multiLine}"
                                style="width: 15px;"/>



                </div>
            </g:if>

        

    %{----}%
    %{--<g:if test="${fields.contains('reality')}">--}%
    %{--<td colspan="2">--}%
    %{--<g:textArea class="uk-width-1-1 uk-textarea" --}%
    %{--placeholder="Reality"--}%
    %{--title="Reality"--}%
    %{--name="reality" cols="40" rows="5" value="${record?.reality}"/>--}%
    %{----}%
    %{--</g:if>--}%
    %{----}%


    %{--<g:if test="${fields.contains('citationText')}">--}%
    %{----}%
    %{--<td colspan="2">--}%
    %{--<g:textField class="uk-width-1-1 uk-input"  placeholder="Citation text"--}%
    %{--title="Citation text"--}%
    %{--rows="5" name="citationText" value="${record?.citationText}"--}%
    %{--/>--}%
    %{----}%

    %{----}%
    %{----}%
    %{--<td colspan="2">--}%
    %{--<g:textField class="uk-width-1-1 uk-input"  placeholder="Citation Html"--}%
    %{--title="Citation Html"--}%
    %{--rows="5" name="citationHtml" value="${record?.citationHtml}"--}%
    %{--/>--}%
    %{----}%

    %{----}%
    %{----}%
    %{--<td colspan="2">--}%
    %{--<g:textField class="uk-width-1-1 uk-input"  placeholder="Citation Ascii code"--}%
    %{--title="Citation Ascii code"--}%
    %{--rows="5" name="citationAsciicode" value="${record?.citationAsciicode}"--}%
    %{--/>--}%
    %{----}%

    %{----}%
    %{--</g:if>--}%


    %{--<hr/>--}%
        <g:submitButton class="uk-button uk-button-primary uk-width-expand" name="submit"
                        style="height: 40px;"
                        value="Save"
                        onsubmit=""/>
    %{--</div>--}%
    </g:formRemote>

    <g:if test="${savedRecord && !record}">

        <br/>

        <g:render template="/gTemplates/recordSummary" model="[record: savedRecord]"/>

    </g:if>

