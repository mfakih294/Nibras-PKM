<%@ page import="app.Tag" %>

<div id="actionsBox" style="padding-top:2px; margin:0px;">

    <a tabindex="0" href="#actions" class="fg-button fg-button-icon-right ui-widget ui-state-default ui-corner-all"
       id="actions${recordId}">actions <span class="ui-icon ui-icon-triangle-1-s"></span></a>

    <div id="#actions${recordId}" class="hidden">
        <ul>

            <li>

                <g:remoteLink controller="tag" action="edit" id="${recordId}" update="${recordId}TagCard"
                              title="Refresh data">
                    Edit
                </g:remoteLink>

            </li>

            <li>

                <g:remoteLink controller="tag" action="refresh" id="${recordId}" update="${recordId}TagCard"
                              title="Refresh data">
                    refresh data
                </g:remoteLink>
            </li>

            <li>

                <a title="Changes" href="${createLink(controller: 'tag', action: 'show', id: recordId)}">
                    changes
                </a>

            </li>

            <li>
                <g:remoteLink controller="tag" action="delete" id="${recordId}"
                              update="[success: 'notificationArea', failure: 'notificationArea']"
                              on404="alert('not found');" onComplete="clearNotification()">delete</g:remoteLink>

            </li>

        </ul>
    </div>

    <script>
        jQuery("#actions${recordId}").menu({content:jQuery("#actions${recordId}").next().html(), showSpeed:200});
    </script>

</div><!-- actions box end -->