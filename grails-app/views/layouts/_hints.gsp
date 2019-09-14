<style>
    .hintBox {
        background-color: #e4ecdf;
        position: absolute;
        bottom: 100px;
        opacity: 0.9 !important;
        box-shadow: 0 1px 3px 0px;
        border-radius: 2px;
        border: 1px  darkgray solid;
        z-index: 100;
        pointer-events: none;
        height: 250px;
        width: 290px;
        left: 100px;
        padding: 7px;
        overflow-y: auto;
        font-size: small;
    }
    .hideBox{
        display: none;
    }
</style>
<div class="${hints ? 'hintBox' : 'hideBox'}">
%{--<i>Auto-complete suggestions</i>--}%
    %{--<br/>--}%
    %{--<hr/>--}%
    %{--<br/>--}%
    ${raw(hints)}
</div>