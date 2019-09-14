<%@ page import="cmn.Setting; mcs.Course; mcs.parameters.WritingType; mcs.parameters.ResourceStatus; mcs.Book; app.IndexCard" %>


%{--<g:hiddenField name="entityCode" value="${recordEntityCode}"></g:hiddenField>--}%
%{--<g:hiddenField name="recordId" value="${recordId}"></g:hiddenField>--}%

<table style="width: 100%">
    <tbody>

    <tr>
        <td style="width: 50%">

            %{--<label for="description">Description--}%
            %{--</label>--}%

            <g:select name="type.id" class="ui-corner-all" style="width: 60px"
                      from="${WritingType.list([sort: 'name'])}" optionKey="id" optionValue="code"
                      value="${indexCardInstance?.type?.id ?: (session['lastIcdTypeId'] ?: WritingType.findByCode('quote').id)}"
                      noSelection="${['null': 'No type']}"/>

            %{--<g:select name="writingId"--}%
                      %{--from="${mcs.Writing.executeQuery('from Writing w where w.course.bookmarked = ? order by w.course.department.orderNumber asc, w.course.orderNumber asc', [true])}"--}%
                      %{--style="width: 100px;"--}%
                      %{--optionKey="id" value="${indexCardInstance?.writing?.id ?: (writingId ?: null)}"--}%
                      %{--noSelection="['null': 'No writing']"/>--}%

            %{--<g:if test="${Setting.findByName('course.enabled')?.value == 'yes'}">--}%
                %{--<g:select name="course.id" style="direction: rtl; text-align: right; width: 100px;"--}%
                          %{--from="${Course.executeQuery('from Course c where c.bookmarked = ? order by c.department.orderNumber asc, c.orderNumber asc', true)}"--}%
                          %{--value="${indexCardInstance?.course?.id}" optionKey="id"--}%
                          %{--noSelection="${['null': 'No course']}"/>--}%
            %{--</g:if>--}%

            <g:select name="language" from="${['ar', 'fa', 'en', 'fr']}"
                      style="width: 40px" value="${language ?: indexCardInstance?.language}"/>

            <g:textField placeholder="Book ID" id="book.id" name="book.id" style="width: 60px" class="ui-corner-all"
                         value="${indexCardInstance?.book?.id ?: (bookId ?: null)}"/>
&nbsp;
&nbsp;
&nbsp;
            <g:textField placeholder="Pages" id="pages" name="pages" style="width: 70px" class="ui-corner-all"
                         value="${indexCardInstance?.pages}"/>

            <g:textField placeholder="Summary"  id="summary" name="summary" style="width: 90%" class="ui-corner-all"
                         value="${indexCardInstance?.summary}"/>


        </td>
        <td  style="width: 50%;">

            <g:textArea placeholder="" id="descriptionOfNote" name="description"
                        style="width: 99%; height: 60px;"
                        class="ui-corner-all"
                        cols="40" rows="5" value="${indexCardInstance?.description}"/>

            %{--<g:textField placeholder="source / url"  id="sourceFree" name="sourceFree" style="width: 99%;" class="ui-corner-all"--}%
            %{--value="${indexCardInstance?.sourceFree}"/>--}%

            %{--<br/>--}%
            %{--<pkm:datePicker name="writtenOn" placeholder="Written on" value="${indexCardInstance?.writtenOn}"/>--}%

            %{--<g:textField name="orderNumber"  value="${indexCardInstance?.orderNumber}" style="width: 50px;"/>--}%


            %{--<br/>--}%
            %{--<g:textField placeholder="Source"  id="sourceFree" name="sourceFree" style="width: 99%;" class="ui-corner-all"--}%
            %{--value="${indexCardInstance?.sourceFree}"/>--}%
            %{--<g:textArea placeholder="ملاحظاتك..." id="notes" name="notes"--}%
                        %{--style="width: 99%; height: 30px !important;"--}%
                        %{--class="ui-corner-all"--}%
                        %{--cols="40" rows="5" value="${indexCardInstance?.notes}"/>--}%
        </td>
    </tr>
    %{--<tr>--}%
    %{--<td valign="top" class="value ${hasErrors(bean: indexCardInstance, field: 'source', 'errors')}">--}%


    %{--<g:select name="source.id" class="ui-corner-all"--}%
    %{--from="${app.parameters.WordSource.list([sort: 'name'])}" optionKey="id"--}%
    %{--value="${indexCardInstance?.source?.id}"--}%
    %{--noSelection="${['null': 'No source']}"/>--}%
    %{--</td>  <td valign="top" class="value ${hasErrors(bean: indexCardInstance, field: 'writing', 'errors')}">--}%

    %{--<br/>--}%

    %{--B---}%



    %{--</td>--}%
    %{--</tr>--}%

    </tbody>
</table>

<script>
    jQuery("#descriptionOfNote").focus();

    //    jQuery("#book").autocomplete(
    //            "${contextPath}/book/autoCompleteBooks", {
    //                mustMatch:false, minChars:4, selectFirst:false, highlight:false, autoFill:false, multipleSeparator:' ', multiple:false, delay:200,
    //                formatResult:function (data, p, l) {
    //                    return data[1]
    //                }
    //            });
</script>

