<style>
.hintBox {
    background: #FBFBFB;
    position: absolute;
    bottom: 50px;
    opacity: 0.9 !important;
    box-shadow: 0 1px 3px 0px;
    line-height: 27px;
    border-radius: 2px;
    /*border: 1px  darkgray solid;*/
    z-index: 100;
    pointer-events: none;
    max-height: 350px;
    min-height: 150px;
    max-width: 900px;
    min-width: 300px;
    left: 100px;
    padding: 7px;
    overflow-y: visible;
    /*font-size: small;*/
    column-count: 4;
}
.hideBox{
    display: none;
}
</style>
<div class="${hints ? 'hintBox' : 'hideBox'}" style="">
    %{--<i>Auto-complete suggestions</i>--}%
    %{--<br/>--}%
    %{--<hr/>--}%
    %{--<br/>--}%
    ${raw(hints)}
</div>