package pkm

import app.parameters.ResourceType
import ker.OperationController
import mcs.Book
import org.apache.commons.lang.StringUtils

import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.time.Duration
import java.time.Instant

class PkmTagLib {

    static namespace = "pkm"

    def supportService

    def progressBar = { attrs ->

        def background = '#E1E9DB';
        def percent = (attrs?.percent?.toInteger() ? attrs?.percent?.toInteger() : 0)
    /*  switch(percent) {
                case 0..20:  background = 'yellow'
                break
                case 21..40: background = 'lightgreen'
                break
                case 40..70: background = 'darkgreen'
                break
                case 71..90: background = 'darkgray'
                break;
                case 91..100: background = 'lightgray'
                break
              }
              */
        background = 'gray'
        out << """
<div class="ui-progressbar ui-widget ui-widget-content ui-corner-all" style="width: 99%; height: 3px; border: none; display: block; margin-top:4px;">
   <div style="width: ${attrs.percent}%; background: ${background};" class="ui-progressbar-value ui-widget-header ui-corner-left"></div>
</div>
        """
    }

    def highlight = { attrs ->

        def str = attrs.text
        attrs.searchTerms.split(' ').each() {
            (attrs.text =~ /(?i:${it})/).eachWithIndex() { match, i ->
                str = str.replaceAll(match, '<b>' + match + '</b>')
            }
        }
        out << str
    }

    def summarize = { attrs ->

        if (attrs.text && attrs.text != '' && attrs.text != '?' ) {
            def text = attrs.text ? attrs.text.encodeAsHTML() : ''
            def length = attrs.length

            out << StringUtils.abbreviate(text, length ? length.toInteger() : 80)?.replaceAll('>', ' ')?.replaceAll('<', ' ')?.encodeAsHTML()?.decodeHTML()
        } else {
            out << ''
        }
    }


 def listRecordFiles = { attrs ->
        def module = attrs.module
        def fileClass = attrs.fileClass
        def recordId = attrs.recordId
        def type = attrs.type
        def isStatic = attrs.static
        def filesList = []

     def resourceNestedById = false
     def resourceNestedByType = false

     if (OperationController.getPath('resourceNestedById') == 'yes')
         resourceNestedById = true

     if (OperationController.getPath('resourceNestedByType') == 'yes')
         resourceNestedByType = true


     try {
         def folders
         if (module != 'R') {
             folders = [
                     OperationController.getPath('root.rps1.path') + '/' + module,
                     OperationController.getPath('root.rps2.path') + '/' + module,
                     OperationController.getPath('root.rps3.path') + '/' + module
             ]
             folders.each() { folder ->
                 if (folder && new File(folder).exists()) {
                     new File(folder).eachFileMatch(~/${recordId}[a-z][\S\s]*\.[\S\s]*/) {
                         filesList.add(it)
                     }
                 }
             }
             folders = [
                     OperationController.getPath('root.rps1.path') + '/' + module + '/' + recordId,
                     OperationController.getPath('root.rps2.path') + '/' + module + '/' + recordId,
                     OperationController.getPath('root.rps3.path') + '/' + module + '/' + recordId
//                   , OperationController.getPath('pictures.repository.path') + '/' + module + '/' + recordId
             ]
             folders.each() { folder ->
                 if (folder && new File(folder).exists()) {
                     new File(folder).eachFileMatch(~/[\S\s]*\.[\S\s]*/) {
                         filesList.add(it)
                     }
                 }
             }
         }
          else if (module == 'R'){

                def typeSandboxPath = OperationController.getPath('root.rps1.path')+ '/R' +
                        (resourceNestedByType ?  '/' +  type : '') +
                        '/'
                        //def typeLibraryPath = OperationController.getPath('root.rps3.path')+ '/R/' + type
                        //ResourceType.findByCode(type).libraryPath


                        def typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/R' +
                                (resourceNestedByType ?  '/' +  type : '') +
                                '/'
 def typeLibraryPath = OperationController.getPath('root.rps3.path') + '/R' +
                        (resourceNestedByType ?  '/' +  type : '') +
                        '/'


                folders = [
                        typeSandboxPath +
                                (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : ''),
                        typeRepositoryPath + (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : ''),
                        typeLibraryPath + (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : '')
                ]
                folders.each() { folder ->

                    if (new File(folder).exists()) {
                        new File(folder).eachFileMatch(~/${recordId}[a-z][\S\s]*\.[\S\s]*/) {
                            filesList.add(it)
                        }
                    }
                }
                folders = [
          typeSandboxPath + (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : '') + '/' + recordId,
      //    typeLibraryPath + '/' + (recordId / 100).toInteger() + '/' + recordId,
          typeRepositoryPath +(resourceNestedById ?  '/' +   (recordId / 100).toInteger() : '')  + '/' + recordId,
          typeLibraryPath + (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : '') + '/' + recordId
                ]

                def b = Book.get(recordId)
//                if (b.code){
//                    folders.add(typeSandboxPath + '/' + b.code)
//                    folders.add(typeRepositoryPath + '/' + b.code)
//                }

                folders.each() { folder ->
                    if (new File(folder).exists()) {
                        new File(folder).eachFile(){//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                            filesList.add(it)
                        }
                    }
                }
          //      folders = [
//                        OperationController.getPath('excerpts.repository.path')  + '/' + type + '/' + recordId
           //               OperationController.getPath('root.rps2.path') + '/E/' + type + '/' + recordId
//                        OperationController.getPath('video.excerpts.repository.path')  + '/' + type  + '/' + recordId,
//                        OperationController.getPath('video.snapshots.repository.path')   + '/' + type + '/' + recordId
              //  ]
            //    folders.each() { folder ->
            //        if (new File(folder).exists()) {
            //            new File(folder).eachFileMatch(~/[\S\s]*\.[\S\s]*/) {
            //                filesList.add(it)
            //            }
            //        }
            //    }

    


            }
        }
        catch (Exception e) {
            out << ''
            print 'Problem in listing record folder: ' + e.printStackTrace()
        }
        def output = filesList.size() > 0 ? "<ul style='margin: 2px; border-bottom: 1px darkgray solid;list-style: square; font-weight: normal; font-family: tahoma; font-size: 12px; text-decoration: none;'>" : ''
        def c = 1
        for (i in filesList) {
            def fileId = new Date().format('HHmmssSSS') + c //Math.floor(Math.random()*1000)
            c++

            if (isStatic == 'yes') {
                output += """<li>
			<div class="showhim">
<a href="${i.path?.replace('\\' + (OperationController.getPath('rootFolder') ?: 'mhi') + '\\mcd', '.')}" class="${fileClass}"
                          target="_blank"
                          title="${i.path}">
  ${i.name} <span style="font-size: small; color: gray;">
&nbsp;&nbsp;&nbsp;${i.isFile() ? ' ('+ prettySizeMethod(i.size()) + ')' : ''}
</span></a></span></div>
</li>"""
            }
            else {
                session[fileId] = i.path
                def extension = i.name?.split(/\./)?.size() > 0 ? i.name?.split(/\./)?.last()?.toLowerCase() : ''
                output += """<li>
<b>${i.path?.replace(i.name, '')}</b>:<br/>
			<div class="showhim fileCard" id="file${fileId}">

<a title="download" href="${i.isFile() ? createLink(controller: 'operation', action: 'download', id: fileId): '#'}" class="${fileClass}"
                          target="_blank"
                          title="${i.path}">
"""
if (i.isFile()){
                output += """
<img src='${resource(dir: '/file-icons/32px', file: "${extension}.png")}' style="width: 32px;"
                                     title=""/>
"""
}
else {
                output += """
<img src='${resource(dir: '/file-icons/32px', file: "directory.png")}' style="width: 32px;"
                                     title=""/>
"""

}
                output +=  """
                                     <span style="font-size: small; color: gray;" title="${i.path?.replace(i.name, '')}">
${i.isFile() ? '('+ prettySizeMethod(i.size()) + ')' : ''}
</span>${i.name}
            </a>
	    	<span class="testhide">
		<a href="#" title="Extract cover from first page" onclick="jQuery('#logArea').load('${
                    createLink(controller: 'generics', action: 'generateCover', id: recordId, params: [path: i, module: module, type: type])
                }')"    title="${i.path}">
  cvr
            </a>
 &nbsp;<a href="#" title="Generate AblePlayer html file for WebVTT" onclick="jQuery('#logArea').load('${
                    createLink(controller: 'operation', action: 'generateWebVttHtml', id: recordId, params: [path: i, module: module, type: type, fileName: i.name])
                }')"    title="${i.path}">
  vtt
            </a>
 &nbsp;
 <a title="Copy to rps1" onclick="jQuery('#logArea').load('${createLink(controller: 'operation', action: 'checkoutFile', id: recordId, params: [path: i, name: i.name, module: module, type: type])}')">
              &nbsp;    ->
                  </a>
                  <a onclick="if(confirm('Are you sure you want to delete the file?')) return jQuery('#file${fileId}').load('${
                    createLink(controller: 'operation', action: 'deleteFile', path: i.path)}')">
              &nbsp;    x
                 </a>
			</span>
			
			</div>
</li>"""


                // removed 28.11.2019
//                &nbsp;
//                <a onclick="jQuery('#logArea').load('${createLink(controller: 'operation', action: 'checkoutFileOut', id: recordId, params: [path: i, name: i.name, module: module, type: type])}')">
//                        &nbsp;    out
//                </a>


                //${i.path ? i.path?.replaceAll('/mhi', 'Z:')?.replaceAll('/host', 'D:') : ''}
            }

        }

        output += "</ul>"



        out << output.decodeHTML()
//            }
//    out << ''
    }
def listRecordFiles2 = { attrs ->
        def module = attrs.module
        def fileClass = attrs.fileClass
        def recordId = attrs.recordId
        def type = attrs.type
        def isStatic = attrs.static
        def filesList = []
        try {
            def folders = [
                    OperationController.getPath('root.rps1.path') + '/' + module,
                    OperationController.getPath('root.rps2.path') + '/' + module
            ]
            folders.each() { folder ->
                if (folder && new File(folder).exists()) {
                    new File(folder).eachFileMatch(~/${recordId}[a-z][\S\s]*\.[\S\s]*/) {
                        filesList.add(it)
                    }
                }
            }
             folders = [
                    OperationController.getPath('root.rps1.path')+ '/' + module + '/' + recordId,
                    OperationController.getPath('root.rps2.path')+ '/' + module + '/' + recordId
//                   , OperationController.getPath('pictures.repository.path') + '/' + module + '/' + recordId
            ]
            folders.each() { folder ->
                if (folder && new File(folder).exists()) {
                    new File(folder).eachFileMatch(~/[\S\s]*\.[\S\s]*/) {
                        filesList.add(it)
                    }
                }
            }
            if (module == 'R'){

                def typeSandboxPath = OperationController.getPath('root.rps1.path')+ '/R' + (resourceNestedByType ?  '/' +  type : '')
                        //def typeLibraryPath = OperationController.getPath('root.rps3.path')+ '/R/' + type
                        //ResourceType.findByCode(type).libraryPath
                        def typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/R' +  (resourceNestedByType ?  '/' +  type : '')
                folders = [
                        typeSandboxPath  + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : ''),
                        typeRepositoryPath  (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')
                      //  typeLibraryPath + '/' + (recordId / 100).toInteger()
                ]
                folders.each() { folder ->

                    if (new File(folder).exists()) {
                        new File(folder).eachFileMatch(~/${recordId}[a-z][\S\s]*\.[\S\s]*/) {
                            filesList.add(it)
                        }
                    }
                }
                folders = [
          typeSandboxPath +
                  (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : '') + '/' +
                  recordId,
      //    typeLibraryPath + '/' + (recordId / 100).toInteger() + '/' + recordId,
          typeRepositoryPath +
                  (resourceNestedById ?  '/' +   (recordId / 100).toInteger() : '') + '/' +
                  recordId
                ]

                def b = Book.get(recordId)
//                if (b.code){
//                    folders.add(typeSandboxPath + '/' + b.code)
//                    folders.add(typeRepositoryPath + '/' + b.code)
//                }

                folders.each() { folder ->
                    if (new File(folder).exists()) {
                        new File(folder).eachFileRecurse(){//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                        //    if (it.isFile())
                            filesList.add(it)
                        }
                    }
                }
          //      folders = [
//                        OperationController.getPath('excerpts.repository.path')  + '/' + type + '/' + recordId
           //               OperationController.getPath('root.rps2.path') + '/E/' + type + '/' + recordId
//                        OperationController.getPath('video.excerpts.repository.path')  + '/' + type  + '/' + recordId,
//                        OperationController.getPath('video.snapshots.repository.path')   + '/' + type + '/' + recordId
              //  ]
            //    folders.each() { folder ->
            //        if (new File(folder).exists()) {
            //            new File(folder).eachFileMatch(~/[\S\s]*\.[\S\s]*/) {
            //                filesList.add(it)
            //            }
            //        }
            //    }




            }
        }
        catch (Exception e) {
            out << ''
            print 'Problem in listing record folder: ' + e.printStackTrace()
        }
        def output = filesList.size() > 0 ? "" : '' //<ul style='margin: 2px; border-bottom: 1px darkgray solid;list-style: square; font-weight: normal; text-decoration: none;'>" : ''
        def c = 1
        for (i in filesList) {
            def fileId = new Date().format('HHmmssSSS') + c //Math.floor(Math.random()*1000)
            c++

            if (isStatic == 'yes') {
                output += """<li>
			<div class="showhim">
			<a href="${i.path?.replace('\\' + (OperationController.getPath('rootFolder') ?: 'mhi') + '\\mcd', '.')}" class="${fileClass}"
                          target="_blank"
                          title="${i.path}">
  ${i.name} <span style="font-size: small; color: gray;">
&nbsp;&nbsp;&nbsp;${i.isFile() ? ' ('+ prettySizeMethod(i.size()) + ')' : ''}
</span>
            </a>


			</span>
			</div>
</li>"""
            }
            else {
                session[fileId] = i.path
                session[fileId + '.jpg'] = i.path + '.jpg'
              if (i.isFile() && !i.name.endsWith('.jpg')){  output += """
			<div style="font-size: 1em; font-family: ubuntu, Lato; columns-count: 3; margin: 7px; padding: 5px; border: 1px solid darkgray; border-radius: 4px;" id="file${fileId}">
<img src="${i.isFile() ? createLink(controller: 'operation', action: 'download', id: fileId + '.jpg'): '#'}"/>

<a href="${i.isFile() ? createLink(controller: 'operation', action: 'download', id: fileId): '#'}" class="${fileClass}"
                          target="_blank"
                          title="${i.path}">
${i.name}
<span style="font-size: small; color: gray;" title="${i.path?.replace(i.name, '')}">
${i.isFile() ? '('+ prettySizeMethod(i.size()) + ')' : ''}
</span>
            </a>
			</div>
"""  }
                else if (!i.isFile()){
                  output += """

			<div style="font-size: 1.1em; font-family: ubuntu, Lato; margin: 7px; padding: 5px; border: 1px solid darkgray; border-radius: 4px;" id="file${fileId}">
<h3>
${i.name}
</h3>

			</div>
"""
              }
              }


                // removed 28.11.2019
//                &nbsp;
//                <a onclick="jQuery('#logArea').load('${createLink(controller: 'operation', action: 'checkoutFileOut', id: recordId, params: [path: i, name: i.name, module: module, type: type])}')">
//                        &nbsp;    out
//                </a>


                //${i.path ? i.path?.replaceAll('/mhi', 'Z:')?.replaceAll('/host', 'D:') : ''}
            }



        //output += "</ul>"

 

        out << output.decodeHTML()
//            }
//    out << ''
    }

    def listVideos = { attrs ->

        def folder = attrs.folder
        def fileClass = attrs.fileClass
        def initial = attrs.initial
        def recordId = attrs.recordId

//        println 'in list files ' + folder

        def filesList = []
        try {

            if (!initial || initial.toString().trim() == '')
                initial = ''
            if (new File(folder).exists()) {
                new File(folder).eachFileMatch(~/${initial}[\S\s]*/) {
                    filesList.add(it)
                }

                def output = "<ul style='padding: 5px; line-height: 20px;list-style: none; font-weight: bold; font-size: 14px; text-decoration: none;'>"
                def c = 1
                for (i in filesList) {
                    def fileId = new Date().format('HHmmssSSS') + c //Math.floor(Math.random()*1000)
                    c++
                    session[fileId] = i.path
                    output += """<li>


<a href="${createLink(controller: 'operation', action: 'download', id: fileId)}" class="${fileClass}"
                          target="_blank"
                          title="${folder}">
  ${i.name} <span style="font-size: smaller; color: gray;">
${prettySizeMethod(i.size())}
</span>

            </a>
<br/>

   <video width="320" height="240" controls
source src="${createLink(controller: 'operation', action: 'download', id: fileId)}" class="${fileClass}">
                    Your browser does not support the video tag.
                </video>
</li>"""

                }

                output += "</ul>"
                out << output.decodeHTML()
            }
            out << ''
        }
        catch (Exception e) {
            out << 'Problem in folder ' + folder
            print 'Problem ' + e

        }

    }


    def listAudios = { attrs ->

        def folder = attrs.folder
        def fileClass = attrs.fileClass
        def initial = attrs.initial
        def recordId = attrs.recordId

//        println 'in list files ' + folder

        def filesList = []
        try {

            if (!initial || initial.toString().trim() == '')
                initial = ''
            if (new File(folder).exists()) {
                new File(folder).eachFileMatch(~/${initial}[\S\s]*/) {
                    filesList.add(it)
                }

                def output = "<ul style='padding: 5px; line-height: 20px;list-style: none; font-weight: bold; font-size: 14px; text-decoration: none;'>"
                def c = 1
                for (i in filesList) {
                    def fileId = new Date().format('HHmmssSSS') + c //Math.floor(Math.random()*1000)
                    c++
                    session[fileId] = i.path
                    output += """<li>

<a href="${createLink(controller: 'operation', action: 'download', id: fileId)}" class="${fileClass}"
                          target="_blank"
                          title="${folder}">
  ${i.name} <span style="font-size: smaller; color: gray;">
${prettySizeMethod(i.size())}
</span>

            </a>
<br/>

   <audio width="320" height="240" controls
source src="${createLink(controller: 'operation', action: 'download', id: fileId)}" class="${fileClass}">
                    Your browser does not support the video tag.
                </video>
</li>"""

                }

                output += "</ul>"
                out << output.decodeHTML()
            }
            out << ''
        }
        catch (Exception e) {
            out << 'Problem in folder ' + folder
            print 'Problem ' + e

        }

    }
    def listPictures = { attrs ->

        def folder = attrs.folder
        def fileClass = attrs.fileClass
        def initial = attrs.initial
        def recordId = attrs.recordId

//        println 'in list files ' + folder

        def filesList = []
        try {

            if (!initial || initial.toString().trim() == '')
                initial = ''
            if (folder && new File(folder)?.exists()) {
                new File(folder).eachFileMatch(~/${initial}[\S\s]*.jpg/) {
                    filesList.add(it)
                }

                new File(folder).eachFileMatch(~/${initial}[\S\s]*.jpeg/) {
                    filesList.add(it)
                }

                
                new File(folder).eachFileMatch(~/${initial}[\S\s]*.png/) {
                    filesList.add(it)
                }

                
                def output = """ <div id="image-gallery-demoxx" class="content" style="display: block;">
<ul class="galleryxx clearfixxx"> """
                //<ul style='padding: 5px; line-height: 20px;list-style: none; font-weight: bold; font-size: 14px; text-decoration: none;'>"
                def c = 1
                for (i in filesList) {
                    def fileId = new Date().format('HHmmssSSS') + c //Math.floor(Math.random()*1000)
                    c++
                    session[fileId] = i.path

//                    rel="prettyPhotoxx[as]"
                    output += """
  <a href="${createLink(controller: 'operation', action: 'download', id: fileId)}" target="_blank" class="${fileClass}"
                          title="${i.name}">
<img src="${createLink(controller: 'operation', action: 'download', id: fileId)}" width="200" alt="${i.name}" />
            </a>
            <br/>
            <hr style="color: gray"/>
            <br/>
"""

                }

                output += """</div>
</ul>
"""
                out << output.decodeHTML()
            }
            out << ''
        }
        catch (Exception e) {
            out << 'Folder: ' + folder + ' has problem ' + e


        }

    }
    def checkFolder = { attrs ->

        def name = attrs.display ?: attrs.name
        def path = attrs.path

        def color = 'black'
        def output
        if (path) {

            if (!new File(path).exists()) {
                color = 'red'
                output = "<span style='color: ${color}' title='Path: $path'>" + name + "</span>"
                out << output.decodeHTML()
            } else {
                color = 'darkgreen'
                output = "<span style='color: ${color}' title='Path: $path'>" + name + "</span>"
                out << output.decodeHTML()
            }
        } else {
            color = 'darkorange'
            output = "<span style='color: ${color}' title='Path: $path'>" + name + "</span>"
            out << output.decodeHTML()
        }

    }

    public static String labelize(String s) {
        (s =~ /[A-Z]/).eachWithIndex() { it, i ->
            s = s.replaceAll(it, ' ' + it)
        }
        return s
    }


    def datePicker = { attrs ->
        def fieldName = attrs.name
        def fieldId = attrs.id ?: fieldName
        def valueName = attrs.value
        def formattedValue = ''
        if (valueName != null) {
            formattedValue = new SimpleDateFormat("dd.MM.yyyy").format(valueName)
        }
        def cal = resource(dir: 'images', file: 'cal.png')

        out << """
      <input type="text" name="${fieldName}" id="${fieldId}" value="${formattedValue}" style="width:100px;" placeholder="${attrs.placeholder}" />
      <script>
    var pickerOpts = {
//    showOn: "both",
//    buttonImage: '${cal}',
//    buttonImageOnly: true,
    //appendText: " (dd.mm.yyyy)",
    dateFormat: "dd.mm.yy",
    firstDay:1
//    changeFirstDay: false,
//    changeMonth: true,
//    changeYear: true,
//    closeAtTop: true,
//    constrainInput: true,
//    duration: "fast",
    //minDate: "01.01.2003",
    //maxDate: "12.12.2011",
//    navigationAsDateFormat: true,
//    numberOfMonths: 1,
//    showOtherMonths: true,
//    showStatus: true,
//    showWeeks: true,
//    yearRange:"-35+3"

 };
    // onSelect: function(dateText, inst) { console.log('valude entered is: ' + dateText); this.value = dateText}
  jQuery("#${fieldId}").datepicker(pickerOpts);

  </script>
"""

    }

    def weekDate = { attrs ->

//        out << supportService.toWeekDate(attrs.date)

        if (attrs.date) {
            try {
                Calendar c = new GregorianCalendar()
                c.setLenient(false)
                c.setMinimalDaysInFirstWeek(4)
                c.setFirstDayOfWeek(java.util.Calendar.MONDAY)
                c.time = attrs.date
                def tmp = c.get(java.util.Calendar.DAY_OF_WEEK)
                def week = c.get(java.util.Calendar.WEEK_OF_YEAR)
                def year = c.get(java.util.Calendar.YEAR)
                out << '' + (week < 10 ? '0' + week.toString() : week) + '' + (tmp == 1 ? 7 : tmp - 1) + '.' + year.toString().substring(2, 4) + ''
            } catch(Exception e){
                out << 'WD error!'
            }
        } else
            out << ''
    }


    def prettyDuration = { attrs ->

//        out << supportService.toWeekDate(attrs.date)

        if (attrs.date1) {
            try {
                Instant start = attrs.date1.toInstant()
                Instant end = (new Date()).toInstant();//
                Duration dur = Duration.between(end, start);
                long years = dur.toDays() / 365;
                long months = (dur.toDays() % 365 ) / 30;
                long days = ((dur.toDays() % 365 ) % 30) ;
//     long hours = dur.toDays();
//     long minutes = dur.toHours();



                out <<  (days ? days + 'd ' : '') + (months ? months + 'm ' : '') + (years ? years + 'y ' : '')
            } catch(Exception e){
                out << 'WD error!'
            }
        } else
            out << ''
    }



    def fileCount = { attrs ->
        def count = 0
        out << "" //<span style='color: darkorange; padding: 5px; font-weight: bolder;'>" + attrs.folder + '</span>'
        try {
            if (attrs.ext != '*') {
                attrs.ext.split(',').each() { ext ->
                    count = 0
                    new File(attrs.folder).eachFileRecurse { f ->
                        if (f.name.toLowerCase().matches(~/^[\s\S]*.${ext}/))
                            count++
                    }
                    out << "<b>" + count + "</b>  <i>" + ext + "</i> &nbsp;&nbsp;"
                }
            }
            else {
                count = 0
                if (attrs.folder && new File(attrs.folder).exists()){
                new File(attrs.folder).eachFileRecurse { f ->
                    count++
                }
                }
                out << count
            }
        } catch (Exception e) {
            print 'Problem ' + e
            out << '?'
        }
        out << '<br/>'
    }


    static final def BYTE = 1D
    static final def KILO_BYTE = 1024D
    static final def MEGA_BYTE = 1048576D
    static final def GIGA_BYTE = 1073741824D
    static final def TERA_BYTE = 1099511627776D
    static final def PETA_BYTE = 1125899906842624D
    static final def EXA_BYTE = 1152921504606846976D
    static final def ZETTA_BYTE = 1180591620717411303424D
    static final def YOTTA_BYTE = 1208925819614629174706176D

    def prettySize = { attrs ->
        def size = attrs.remove('size') as double
        def abbr = Boolean.valueOf(attrs.remove('abbr'))
        def formatter = attrs.remove('format')
        if (formatter) formatter = new DecimalFormat(formatter)

        if (!size || size < 0) {
            outMsg('prettysize.byte', 0, abbr, formatter)
        } else if (size >= YOTTA_BYTE) {
            outMsg('prettysize.yotta.byte', size.div(YOTTA_BYTE), abbr, formatter)
        } else if (size >= ZETTA_BYTE) {
            outMsg('prettysize.zetta.byte', size.div(ZETTA_BYTE), abbr, formatter)
        } else if (size >= EXA_BYTE) {
            outMsg('prettysize.exa.byte', size.div(EXA_BYTE), abbr, formatter)
        } else if (size >= PETA_BYTE) {
            outMsg('prettysize.peta.byte', size.div(PETA_BYTE), abbr, formatter)
        } else if (size >= TERA_BYTE) {
            outMsg('prettysize.tera.byte', size.div(TERA_BYTE), abbr, formatter)
        } else if (size >= GIGA_BYTE) {
            outMsg('prettysize.giga.byte', size.div(GIGA_BYTE), abbr, formatter)
        } else if (size >= MEGA_BYTE) {
            outMsg('prettysize.mega.byte', size.div(MEGA_BYTE), abbr, formatter)
        } else if (size >= KILO_BYTE) {
            outMsg('prettysize.kilo.byte', size.div(KILO_BYTE), abbr, formatter)
        } else {
            outMsg('prettysize.byte', size, abbr, formatter)
        }
    }

    String prettySizeMethod(size) {
        def abbr = true
        def formatter = new DecimalFormat("#,###.#")

        if (!size || size < 0) {
            outMsgMethod('prettysize.byte', 0, abbr, formatter)
        } else if (size >= YOTTA_BYTE) {
            outMsgMethod('prettysize.yotta.byte', size.div(YOTTA_BYTE), abbr, formatter)
        } else if (size >= ZETTA_BYTE) {
            outMsgMethod('prettysize.zetta.byte', size.div(ZETTA_BYTE), abbr, formatter)
        } else if (size >= EXA_BYTE) {
            outMsgMethod('prettysize.exa.byte', size.div(EXA_BYTE), abbr, formatter)
        } else if (size >= PETA_BYTE) {
            outMsgMethod('prettysize.peta.byte', size.div(PETA_BYTE), abbr, formatter)
        } else if (size >= TERA_BYTE) {
            outMsgMethod('prettysize.tera.byte', size.div(TERA_BYTE), abbr, formatter)
        } else if (size >= GIGA_BYTE) {
            outMsgMethod('prettysize.giga.byte', size.div(GIGA_BYTE), abbr, formatter)
        } else if (size >= MEGA_BYTE) {
            outMsgMethod('prettysize.mega.byte', size.div(MEGA_BYTE), abbr, formatter)
        } else if (size >= KILO_BYTE) {
            outMsgMethod('prettysize.kilo.byte', size.div(KILO_BYTE), abbr, formatter)
        } else {
            outMsgMethod('prettysize.byte', size, abbr, formatter)
        }
    }

    String outMsgMethod(code, units, abbr, formatter) {
        if (units <= 0) {
            return (message(code: 'prettysize.none'))
        } else {
            def sb = new StringBuilder(code)
            if (units > 1) sb << 's'
            if (abbr) sb << '.short'
            if (formatter) units = formatter.format(units)
            return (message(code: sb.toString(), args: [units]))
        }
    }

    def outMsg(code, units, abbr, formatter) {
        if (units <= 0) {
            out << message(code: 'prettysize.none')
        } else {
            def sb = new StringBuilder(code)
            if (units > 1) sb << 's'
            if (abbr) sb << '.short'
            if (formatter) units = formatter.format(units)
            out << message(code: sb.toString(), args: [units])
        }
    }

}
