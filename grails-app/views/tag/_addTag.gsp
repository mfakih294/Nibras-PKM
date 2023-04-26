

<g:formRemote name="addTag" url="[controller: 'generics', action: 'addTagToRecord']"
              onComplete="jQuery('#newTagField${entity}${instance.id}').val('')"
              update="tags${entity}${instance.id}"
              style="display: inline;">
    <g:hiddenField name="id" value="${instance.id}"/>
    <g:hiddenField name="entityCode" value="${entity}"/>
    <g:textField id="newTagField${entity}${instance.id}" name="tag" placeholder="Add tag..."
                 class="newTagField"
                 style="width:250px; display: inline; " value=""/>
    <g:submitButton name="add" value="add" style="display:none;"
                    class="fg-button  ui-widget ui-state-default ui-corner-all"/>
</g:formRemote>

<span id="tags${entity}${instance.id}"></span>

 %{--<g:if test="${entity == 'N'}">--}%
%{--<g:formRemote name="linkNoteToResource" url="[controller: 'indexCard', action: 'linkNoteToResource']"--}%
              %{--update="tags${entity}${instance.id}"--}%
              %{--style="display: inline;">--}%
    %{--<g:hiddenField name="id" value="${instance.id}"/>--}%
    %{--<g:textField  name="bookId" id="bookId" placeholder="Book id..."--}%
                 %{--style="width:50px; display: inline; " value=""/>--}%

    %{--<g:submitButton name="add" value="-R" style="display:none;"--}%
                    %{--class="fg-button  ui-widget ui-state-default ui-corner-all"/>--}%
%{--</g:formRemote>--}%

 %{--</g:if>--}%

<script type="text/javascript">

    var bestPictures = new Bloodhound({
//        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                datumTokenizer: function(d) {
        var test = Bloodhound.tokenizers.whitespace(d.value);
        $.each(test,function(k,v){
            i = 0;
            while( (i+1) < v.length ){
                test.push(v.substr(i,v.length));
                i++;
            }
        })
        return test;
    },
        queryTokenizer: Bloodhound.tokenizers.whitespace
		, remote: '${request.contextPath}/operation/autoCompleteTagsJSON'
		, limit: 12
        ,prefetch: '${request.contextPath}/operation/autoCompleteTagsJSON?date=${new Date().format('ddMMyyyHHMMss')}'
    });

	//?date={new Date().format('ddMMyyyHHMMss')
//       

    bestPictures.initialize();

    $('#newTagField${entity}${instance.id}').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
    }, {
        name: 'value',
        displayKey: 'value',
        source: bestPictures.ttAdapter()
    });


     jQuery('#newTagField${entity}${instance.id}').focus();
    %{--jQuery("#newTagField${entity}${instance.id}").autocomplete({appendTo: "body", source: 'operation/autoCompleteTags'})--}%
//        mustMatch:false
//        minChars:0, highlight:false, autoFill:false,
//        delay:10, matchSubset:0, matchContains:1, selectFirst:false,
//        cacheLength:100, multiple:false
//    });
</script>