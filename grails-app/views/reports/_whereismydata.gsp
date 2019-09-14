<%@ page import="ker.OperationController; cmn.Setting; app.parameters.ResourceType" %>


<table border="1" style="border-collapse: collapse; padding: 6px;" cellpadding=6>
    <thead>
        <th>Type</th>
        <th>Sandbox location</th>
        <th>Count</th>
        <th>Repository location</th>
    <th>Count</th>

    </thead>

    <tr>
        <td style="padding: 3px;">
            Database</td>
        <td colspan="4">${org.codehaus.groovy.grails.commons.ConfigurationHolder.config.dataSource.url}</td>

    </tr>
   <tr>
        <td style="padding: 3px;">
            dbt</td>
        <td colspan="4">${OperationController.getPath('export.recordsToText.path')}</td>


    </tr>

    <g:each in="${[[code: 'G', name: 'Goals'],
    [code: 'T', name: 'Tasks'],
    [code: 'P', name: 'Planner'],
    [code: 'J', name: 'Journal'],
    [code: 'I', name: 'Indicators'],
    [code: 'Q', name: 'Payments'],
    [code: 'W', name: 'Writings'],
    [code: 'N', name: 'Notes'],
    [code: 'R', name: 'Resources'],
    [code: 'E', name: 'Excerpts']
    ]}" var="m">

        <tr>
          <td>Module ${m.code} (${m.name}) </td>
      <td>${OperationController.getPath("module.sandbox.${m.code}.path")}</td>
            <td>
                <pkm:fileCount folder="${OperationController.getPath("module.sandbox.${m.code}.path")}" ext="*"/>
            </td>
      <td>${OperationController.getPath("module.repository.${m.code}.path")}</td>
            <td>
                <pkm:fileCount folder="${OperationController.getPath("module.repository.${m.code}.path")}" ext="*"/>
            </td>

        </tr>
    </g:each>




    <g:each in="${ResourceType.list([sort: 'code'])}" var="t">
     <tr>
        <td><b>${t.code}</b> ${t.name}</td>
        <td>${t.newFilesPath}</td>

         <td>
             <pkm:fileCount folder="${t.newFilesPath}"
                            ext="*"/>
         </td>
        <td>${t.repositoryPath}</td>
         <td>
             <pkm:fileCount folder="${t.repositoryPath}"
                            ext="*"/>
         </td>
    </tr>
    </g:each>


</table>