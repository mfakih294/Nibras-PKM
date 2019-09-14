<%@ page import="mcs.parameters.RelationshipType; mcs.Relationship" %>

<g:formRemote name="addRelationship" url="[controller: 'generics', action: 'addRelationship']"
              onComplete="jQuery('#newRelationshipField${entity}${record.id}').val('')"
              update="relationshipRegion${entity}${record.id}"

              style="display: inline;">



    <g:hiddenField name="id" value="${record.id}"/>
    <g:hiddenField name="entityCode" value="${entity}"/>
    <g:select name="type" style="width: 90px; display: inline;"
              from="${mcs.parameters.RelationshipType.list()}" optionKey="id" optionValue="name"/>
<br/>
    <g:textField id="newRelationshipField${entity}${record.id}" name="recordB" class="ui-corner-all"
                 title="[type][id] ([type] [summary] for autocomplete)" placeholder="[type] [summary] to start autocomplete"
                 style="width:150px; display: inline; " value=""/>
    <g:submitButton name="add" value="add" style="display:none;"
                    class="fg-button  ui-widget ui-state-default ui-corner-all"/>
</g:formRemote>

<script type="text/javascript">
    %{--jQuery("#newRelationshipField${entity}${record.id}").find('input').autocomplete("generics/autoCompleteMainEntities", {--}%
        %{--mustMatch: false, minChars: 4, highlight: false, autoFill: false,--}%
        %{--delay: 100, matchSubset: 0, matchContains: 1, selectFirst: false,--}%
%{--//        cacheLength:100,--}%
        %{--multiple: false,--}%
        %{--formatResult: function (data, p, l) {--}%
            %{--return data[1]--}%
        %{--}--}%
    %{--});--}%


    var bestPictures = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: '/nibras/generics/autoCompleteMainEntities?date=${new Date().format('ddMMyyyHHMMss')}',
        remote: '/nibras/generics/autoCompleteMainEntities'
    });

    bestPictures.initialize();

    $('#newRelationshipField${entity}${record.id}').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
    }, {
        name: 'id',
        displayKey: 'value',
        source: bestPictures.ttAdapter()
    });




</script>



%{--<h4>Relationships</h4>--}%

%{--<g:each in="${Relationship.findAll()}" var="t">--}%
%{--dump: ${t.id} ---}%
%{--${t.entityA}  - ${t.recordA} ---}%
%{--${t.entityB}  -${t.recordB}  ---}%


%{--${t.type}  ---}%
%{--</g:each>--}%

<div id="relationshipRegion${entity}${record.id}">

<g:each in="${RelationshipType.findAll()}" var="type">
    <g:if test="${Relationship.executeQuery('select count(*) from Relationship where (entityA = ? or entityA = ? or entityA = ?) and recordA = ? and type = ? ',
            ['mcs.' + record.entityController(), 'app.' + record.entityController(), 'app.parameters.' + record.entityController(), record.id, type])[0] > 0}">
        <b>${type.name}</b>:
        <br/>

        <g:each in="${Relationship.executeQuery('from Relationship where (entityA = ? or entityA = ? or entityA = ?) and recordA = ? and type = ? ',
                ['mcs.' + record.entityController(), 'app.' + record.entityController(), 'app.parameters.' + record.entityController(), record.id, type])}"
                status="c"
                var="t">
            <table border="0">
                <tr>
                    <td>
                        <g:remoteLink controller="relationship" action="delete" id="${t.id}"
                                      update="notificationArea"
                                      before="if(!confirm('Are you sure you want to delete the relationship?')) return false"
                                      title="Logical delete">
                            x
                        </g:remoteLink>
                    </td>
                    <td>
                        %{--todo: works only for mcs package --}%
                        <g:render template="/gTemplates/recordSummary"
                                  model="[record: grailsApplication.classLoader.loadClass(t.entityB).get(t.recordB)]"/>

                    </td>
                </tr>
            </table>

        </g:each>

    </g:if>



    <g:if test="${Relationship.executeQuery('select count(*) from Relationship where (entityB = ? or entityB = ? or entityB = ?) and recordB = ? and type = ? ',
            ['mcs.' + record.entityController(), 'app.' + record.entityController(), 'app.parameters.' + record.entityController(), record.id, type])[0] > 0}">
        <b>${type.inverseName ?: '?'}</b>:

        <g:each in="${Relationship.executeQuery('from Relationship where (entityB = ? or entityB = ? or entityB = ?) and recordB = ? and type = ? ',
                ['mcs.' + record.entityController(), 'app.' + record.entityController(), 'app.parameters.' + record.entityController(), record.id, type])}"
                status="c"
                var="t">

        %{--todo: works only for mcs package --}%
            <g:render template="/gTemplates/recordSummary"
                      model="[record: grailsApplication.classLoader.loadClass(t.entityA).get(t.recordA)]"/>
        </g:each>

    </g:if>
</g:each>

</div>