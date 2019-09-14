
<g:formRemote name="addContact" url="[controller: 'generics', action: 'addContactToRecord']"
              onComplete="jQuery('#newContactField${entity}${instance.id}').val('')" update="contacts${entity}${instance.id}"
              style="display: inline;">
    <g:hiddenField name="id" value="${instance.id}"/>
    <g:hiddenField name="entityCode" value="${entity}"/>
    <g:textField id="newContactField${entity}${instance.id}" name="contact" placeholder="Add contact..."
                 style="width:100px; display: inline; " value=""/>
    <g:submitButton name="add" value="add" style="display:none;"
                    class="fg-button  ui-widget ui-state-default ui-corner-all"/>
</g:formRemote>

<script type="text/javascript">

    var bestPictures = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace
        ,prefetch: '/nibras/operation/autoCompleteContactsJSON?date=${new Date().format('ddMMyyyHHMMss')}'
       , remote: '/nibras/operation/autoCompleteContactsJSON2'
    });

    bestPictures.initialize();

    $('#newContactField${entity}${instance.id}').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
    }, {
        name: 'value',
        displayKey: 'value',
        source: bestPictures.ttAdapter()
    });


    %{--jQuery("#newContactField${entity}${instance.id}").autocomplete('${request.contextPath}/operation/autoCompleteContacts', {--}%
//        mustMatch:false, minChars:0, highlight:false, autoFill:false,
//        delay:10, matchSubset:0, matchContains:1, selectFirst:false,
//        cacheLength:100, multiple:false
//    });
</script>