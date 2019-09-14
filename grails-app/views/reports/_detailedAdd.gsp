<%@ page import="ker.OperationController" %>

<div style="-moz-column-count: 2">
<ul style="list-style: square">

    <g:each in="${
        [
                [enabled: OperationController.getPath('goals.enabled')?.toLowerCase() == 'yes', code: 'G', name: 'Goals', controller: 'mcs.Goal'],
                [enabled: OperationController.getPath('tasks.enabled')?.toLowerCase() == 'yes', code: 'T', name: 'Tasks', controller: 'mcs.Task'],
                [enabled: OperationController.getPath('planner.enabled')?.toLowerCase() == 'yes', code: 'P', name: 'Planner', controller: 'mcs.Planner'],
                [enabled: OperationController.getPath('journal.enabled')?.toLowerCase() == 'yes', code: 'J', name: 'Journal', controller: 'mcs.Journal'],
                [enabled: OperationController.getPath('indicators.enabled')?.toLowerCase() == 'yes', code: 'I', name: 'Indicator', controller: 'app.IndicatorData'],
                [enabled: OperationController.getPath('Payment.enabled')?.toLowerCase() == 'yes', code: 'Q', name: 'Payment', controller: 'app.Payment'],
                [enabled: OperationController.getPath('writings.enabled')?.toLowerCase() == 'yes', code: 'W', name: 'Writing', controller: 'mcs.Writing'],
                [enabled: OperationController.getPath('notes.enabled')?.toLowerCase() == 'yes', code: 'N', name: 'Notes', controller: 'app.IndexCard',],
                [enabled: OperationController.getPath('resources.enabled')?.toLowerCase() == 'yes', code: 'R', name: 'Resources', controller: 'mcs.Book'],
                [enabled: OperationController.getPath('contacts.enabled')?.toLowerCase() == 'yes', code: 'S', name: 'Contact', controller: 'app.Contact']
        ].grep { it.enabled == true }
    }"
            var="i">
    %{--todo--}%

        <g:remoteLink controller="generics" action="fetchAddForm"
                      params="[entityController: i.controller, updateRegion: 'centralArea']"
                      update="centralArea">
            <li>
                <span style="font-size: 12px; padding: 2px;">
                    <b>${i.code}</b> ${i.name}
                </span>
            </li>
        </g:remoteLink>

    </g:each>
</ul>

</div>