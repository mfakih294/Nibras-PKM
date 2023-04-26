<style>
.hintBox {
    background: #f5f5f5;
    position: absolute;

    opacity: 0.9 !important;
    box-shadow: 0 1px 3px 0px;
    line-height: 27px;
    border-radius: 2px;
    /*border: 1px  darkgray solid;*/
    z-index: 1000000 !important;
    pointer-events: none;
    max-height: 350px;
    /*min-height: 50px;*/
    max-width: 1000px;
    min-width: 300px;
    left: 30px;
    top: 10px;
    padding: 7px;
    /*overflow-y: visible;*/
    overflow: visible;
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