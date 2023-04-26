<%@ page import="ker.OperationController; cmn.Setting; app.IndexCard; mcs.Writing; mcs.Book" %>


<h2>Changed records (${OperationController.getPath('root.rps1.path') + '/edit/'})</h2>

<style>
    del {
        background: #de9880;
        color: #fff;
    }

    ins {
        background: #406619;
        color: #fff;
    }
</style>

<br/>
%{--Edit folder: .--}%

<g:if test="${!new File(OperationController.getPath('root.rps1.path') + '/edit/').exists()}">
    Folder does not exist (${OperationController.getPath('root.rps1.path') + '/edit/'}).
%{--    Set: <g:render template="/forms/updateSetting" model="[settingValue: 'editBox.path']"/>.--}%
    </g:if>
<g:else>
<g:each in="${new File(OperationController.getPath('root.rps1.path') + '/edit/').listFiles()}" var="f">

    <g:if test="${f.name.endsWith('.md') && 'WNR'.contains(f.name?.substring(0, 1))}">
    %{--<g:set value="${f.name.split(/\./)[0].substring(1)}" var="id"></g:set>--}%
        <g:set value="${f.name.split('-')[1]?.split(' ')[0].replace('.md', '')}" var="id"></g:set>

        <g:if test="${f.name?.startsWith('W')}">
            <g:set value="${Writing.get(id)?.description}" var="description"></g:set>
        </g:if>
        <g:if test="${f.name?.startsWith('N')}">
            <g:set value="${IndexCard.get(id.toLong()).description}" var="description"></g:set>
        </g:if>
 <g:if test="${f.name?.startsWith('R')}">
            <g:set value="${Book.get(id.toLong()).fullText}" var="description"></g:set>
        </g:if>

        <g:if test="${f && f.text?.trim() != description?.trim()}">

            <div id="summary${f.name.substring(0, 1)}${id}">

                <table class="uk-width-expand">

                    <tr >
                        <td colspan="1" style="text-align: left; padding: 5px; width: 50%; border-top: 1px solid darkgray; vertical-align: top;">

                            <b>${f.name}:</b>
                            <br/>
                            <br/>
                            <g:render template="/gTemplates/recordSummary"
                                      model="[record: f.name?.substring(0, 1) == 'W' ? Writing.get(id?.toLong()) : (f.name?.substring(0, 1) == 'R' ? Book.get(id?.toLong()) : IndexCard.get(id.toLong()))]"></g:render>

                        </td>
                    %{--</tr>--}%
                    %{--<tr>--}%
                        <td colspan="1" style="border-top: 1px solid darkgray;">

<g:if test="${1==1}">

<b>Edits:</b>

    <div id="diff${id}"
         style="text-align: right; direction: rtl; line-height: 1.6;vertical-align: top;">
    </div>

    <g:remoteLink controller="generics" action="commitTextChanges" id="${id}"
                  params="[entityCode: f.name?.substring(0, 1), name: f.name]"
                  update="summary${f.name.substring(0, 1)}${id}"
                  style="font-size: 1em; margin: 2px; padding: 2px"
                  title="Commit text changes to database">
        Save edits &crarr;
    </g:remoteLink>

%{--id is ${id}--}%
    %{--=== "${description?.trim().replace(/\n/, '').replace(/\r\n/, '')}"--}%
    <br/>

    %{--<br/>--}%
            <script type="text/javascript">
var a = "${f.text?.trim().replace('\n', '|')}"

//var a = "عند ربط طلب العلم باsadلعمasdfل، يصبح لأصول العمل دور وتأثير على كيفية ومsdواضيع التعلّم. ومن بين الأصول الممة sdfفي العمل هو معرفة الصورة الشاملة لسياقالعمل الحالي، أو الخطوة الحالية. فمن لا يعرف ما سيبهو العمل التالي، وكمتبقّى من العمل لإتمام الهدف، قد يتكاسل في تأدية العمل الحالي، فقد يتعاملمعه على أنّه العمل الوحيدلعظماء في هذا الميدان، بشكل دائم."
//var b = "عند ربط طلب العلم بالعمasdfل، يصبح لأصول العمل دور وتأثير على كيفية ومsdواضيع التعلّم. ومن بين الأصول الممة في العمل هو معرفة الصورة الشاملة لسياقالعمل الحالي، أو الخطوة الحالية. فمن لا يعرف ما هو العمل التالي، وكمتبقّى من العمل لإتمام الهدف، قد يتكاسل في تأدية العمل الحالي، فقد يتعاملمعه على أنّه العمل الوحيدلعظماء في هذا الميدان، بشكل دائم."

        var b = "${description?.trim()?.replace('\r\n', '|')?.replace('\n', '|')}"

//console.log('before diff', a) // .replace('"', '').replace("'", '')
                var diff${id} = JsDiff.diffChars(a, b)
                %{--var diff${id} = JsDiff.diffChars("123", "123321")--}%
                        %{--${f.text?.trim().split('\n')[0]}, "${description.split('\n')[0]}--}%
//console.log('after diff')
                var result${id} = document.getElementById("diff${id}");

                var fragment${id} = document.createDocumentFragment();
                for (var i=0; i < diff${id}.length; i++) {

                    if (diff${id}[i].added && diff${id}[i + 1] && diff${id}[i + 1].removed) {
                        var swap = diff${id}[i];
                        diff${id}[i] = diff${id}[i + 1];
                        diff${id}[i + 1] = swap;
                    }

                    var node;
                    if (diff${id}[i].removed) {
                        node = document.createElement('del');
                        node.appendChild(document.createTextNode(diff${id}[i].value));
                    } else if (diff${id}[i].added) {
                        node = document.createElement('ins');
                        node.appendChild(document.createTextNode(diff${id}[i].value));
                    } else {
                        node = document.createTextNode(diff${id}[i].value.replace('|', '\n'));
                    }
                    fragment${id}.appendChild(node);
                }

                result${id}.textContent = '';
                result${id}.appendChild(fragment${id});


             </script>
</g:if>



                                    <br/>
                                </td>
                            </tr>
<g:if test="${1==2}">
                            <tr>
                                <td style="width: 50%; vertical-align: top; text-align: justify" class="textar">
                                    Database:
                                    <br/>
                            <g:each in="${description?.split('\n')}" var="l">
                                <g:if test="${!f?.text?.contains(l?.trim())}">
                                  +  ${l} <br/> <br/>
                                </g:if>
                            </g:each>

                        </td>
                        <td style="width: 50%;  background: #CAED9E; vertical-align: top; padding: 7px; text-align: justify" class="textar">
File:
                            <br/>
                        %{--${?.encodeAsHTML()?.replace('\n', '<br/>')}--}%

                            <g:each in="${f?.text?.split('\n')}" var="l">
                                <g:if test="${!description?.contains(l?.trim())}">
                                  +  ${l} <br/><br/>
                                </g:if>
                            </g:each>

                            <br/>

                        </td>

                    </tr>
</g:if>
                    <g:set value="" var="description"></g:set>
                </table>
            </div>
        </g:if>
    </g:if>

</g:each>
</g:else>
</table>


<br/>
<br/>
<br/>
<br/>
