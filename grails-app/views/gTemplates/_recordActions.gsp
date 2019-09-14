<a class="fg-button fg-button-icon-left ui-widget ui-state-default ui-corner-all"
   id="actions${record.entityCode()}${record.id}">
    <span class="ui-icon ui-icon-triangle-1-s"></span> Actions
</a>

<div class="hidden">
    <ul>

        <li class=" fg-button fg-button-icon-left ui-widget ui-state-default ui-corner-all">
        %{--<span class="ui-icon ui-icon-info">--}%


        %{--</span>--}%

            <g:remoteLink controller="generics" action="bookmark"
                          params="${[id: record.id, entityCode: record.entityCode()]}"
                          update="${record.entityCode()}Record${record.id}"
                          title="Toogle bookmark">
                <g:if test="${record.bookmarked}">
                    <i><b style="font-size: 10px;">Unbookmark</b></i>
                </g:if>
                <g:else>
                    Bookmark
                </g:else>
            </g:remoteLink>

        </li>

        <li class=" fg-button fg-button-icon-left ui-widget ui-state-default ui-corner-all">
            %{--<span class="ui-icon ui-icon-info">--}%


            %{--</span>--}%

            <g:remoteLink controller="generics" action="logicalDelete"
                          params="${[id: record.id, entityCode: record.entityCode()]}"
                          update="${record.entityCode()}Record${record.id}"
                          before="if(!confirm('Are you sure you want to delete the record?')) return false"
                          title="Logical delete">
                Delete
            </g:remoteLink>
        </li>

        %{--<li class=" fg-button fg-button-icon-left ui-widget ui-state-default ui-corner-all">--}%
        %{--<span class="ui-icon ui-icon-info"></span>--}%
        %{--Mark as top priority--}%
        %{--</li>--}%

        <g:render template="/${record.entityController()}/actions" model="[recordId: record.id]"/>

    </ul>

</div>



<script>
    jQuery("#actions${record.entityCode()}${record.id}").menu({
        content: jQuery("#actions${record.entityCode()}${record.id}").next().html(),
        showSpeed: 300, positionOpts: {
            posX: 'left',
            posY: 'bottom',
            offsetX: 0,
            offsetY: 0,
            directionH: 'right',
            directionV: 'down',
            //   detectH: true, // do horizontal collision detection
            //   detectV: true, // do vertical collision detection
            linkToFront: false
        }
    });
</script>

