/*
 * Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */


package ker

import app.Contact
import app.IndexCard
import app.Indicator
import app.PaymentCategory
import app.Tag
import app.parameters.CommandPrefix
import app.parameters.ResourceType
import app.parameters.Blog
import cmn.Setting
import mcs.*
import mcs.parameters.*
import mcs.parameters.Context
import org.apache.commons.lang.StringUtils
import grails.converters.JSON

//import org.eclipse.mylyn.wikitext.core.parser.MarkupParser
//import org.eclipse.mylyn.wikitext.core.parser.builder.HtmlDocumentBuilder
//import org.eclipse.mylyn.wikitext.core.parser.markup.MarkupLanguage
//import org.eclipse.mylyn.wikitext.core.util.ServiceLocator
//import org.eclipse.mylyn.wikitext.markdown.core.MarkdownLanguage


import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_ADMIN','ROLE_READER'])
class GenericsController {

    static entityMapping = [
            'G'            : 'mcs.Goal',
            'ه'            : 'mcs.Goal',
            'T'            : 'mcs.Task',
            'ع'            : 'mcs.Task',
            'P'            : 'mcs.Planner',
            'خ'            : 'mcs.Planner',

            'W'            : 'mcs.Writing',
            'ك'            : 'mcs.Writing',
            'N'            : 'app.IndexCard',
            'ن'            : 'app.IndexCard',

            'J'            : 'mcs.Journal',
            'ذ'            : 'mcs.Journal',
            'I'            : 'app.IndicatorData',
            'K'            : 'app.Indicator',

            'Q'            : 'app.Payment',
            'د'            : 'app.Payment',
            'L'            : 'app.PaymentCategory',

            'R'            : 'mcs.Book',
            'م'            : 'mcs.Book',
            'C'            : 'mcs.Course',
            'و'            : 'mcs.Course',
            'D'            : 'mcs.Department',
            'ج'            : 'mcs.Department',
            'E'            : 'mcs.Excerpt',
            'ف'            : 'mcs.Excerpt',
            'S'            : 'app.Contact',
            'Tag'          : 'app.Tag',

            'Y'            : 'cmn.Setting',
            'X'            : 'mcs.parameters.SavedSearch',
            'A'            : 'app.parameters.CommandPrefix',
//todo for all params
            'ResourceType' : 'app.parameters.ResourceType',
            'WorkStatus'   : 'mcs.parameters.WorkStatus',
            'WritingStatus': 'mcs.parameters.WritingStatus',
            'GoalType'     : 'mcs.parameters.GoalType',
            'JournalType'  : 'mcs.parameters.JournalType',
            'PlannerType'  : 'mcs.parameters.PlannerType',
            'WritingType'  : 'mcs.parameters.WritingType',
            'Context'      : 'mcs.parameters.Context',
            'Blog'         : 'app.parameters.Blog'

    ]

    static allClasses = [
            mcs.Goal,
            mcs.Task,
            mcs.Planner,

            mcs.Journal,
            app.IndicatorData,
            app.Payment,

            mcs.Writing,
            app.IndexCard,
            mcs.Course,

            mcs.Book,
            mcs.Excerpt,

//            app.parameters.WordSource,
            app.Indicator,
            app.PaymentCategory,
            app.Contact,
            mcs.parameters.SavedSearch
    ]

    static allClassesWithCourses = allClasses -
            [mcs.Excerpt, mcs.Course,
             app.IndicatorData, app.Payment, app.PaymentCategory, app.Indicator, mcs.parameters.SavedSearch]

    static allClassesWithCoursesMinusBW = allClasses -
            [mcs.Excerpt, mcs.Course, mcs.Book, mcs.Writing,
             app.IndicatorData, app.Payment, app.PaymentCategory, app.Indicator, mcs.parameters.SavedSearch]

    // Todo for what?
    static mainClasses = allClasses - [mcs.Course]
    static nonResourceClasses = [
            mcs.Goal,
            mcs.Task,
            mcs.Planner,

            mcs.Journal,
            app.IndicatorData,
            app.Payment,


            mcs.Writing,
            app.IndexCard,
            app.Contact,

            mcs.Excerpt
    ]

    static taggedClasses = [
            mcs.Book,
            mcs.Goal,
            mcs.Task,
            mcs.Planner,

            mcs.Journal,
            app.IndicatorData,
            app.Payment,

            mcs.Writing,
            app.IndexCard,

            mcs.Excerpt
    ]


    static selectedRecords = [:]

    def supportService
    def searchableService

    def quickQuranSearch(String input) {
        if (!input.startsWith(' ')) {
            findRecords('n #aya -- ' + params.input)
        } else if (input.startsWith(' ')) {
            findRecords('n #aya :: ' + params.input)
        }
    }


    def quickTextSearch(String input) {
//        println params.dump()
//        if (!input.startsWith(' ')) {

/**
 def fullquery = queryHead + (queryCriteria ? ' where ' + queryCriteria : '')

 queryKey = '_' + new Date().format('ddMMyyHHmmss')
 session[queryKey] = fullquery


 params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5



 input = '%' + input + '%'
 "TGWNC".each() { entityCode ->
 def count = Task.executeQuery('select count(*) from ' + entityMapping[entityCode] + ' where summary like ?', [input])[0]
 def list = Task.executeQuery('from ' + entityMapping[entityCode] + ' where summary  like ? order by lastUpdated desc', [input], params)

 render(template: '/gTemplates/recordListing', model: [
 totalHits: count,
 list     : list,
 totalHits: count,
 queryKey : queryKey,
 title    : entityCode + ': ' + count + ' results.'
 ])}*/
        render '<h2>Search results...</h2><i>Add a space before the term(s) to search inside the contents of the records</i>.<br/>'

            [
                    [id: 'j', name: 'Journal', code: 'journal'],
                    [id: 'n', name: 'Note', code: 'notes'],
                    [id: 'w', name: 'Writing', code: 'writings'],
                    [id: 'g', name: 'Goal', code: 'goals'],
                    [id: 't', name: 'Task', code: 'tasks'],
                    [id: 'r', name: 'Resource', code: 'resources'],
                    [id: 'p', name: 'Planner', code: 'planner'],
                    [id: 's', name: 'Contact', code: 'contacts'],
                    [id: 'c', name: 'Course', code: 'courses']
            ].each(){
                if (OperationController.getPath(it.code + '.enabled') == 'yes')
                    if (input.startsWith(' '))
                        findRecords(it.id + ' :: ' + params.input)
                        else
                    findRecords(it.id + ' -- ' + params.input)
            }
//             render '<h2>Searching contents...</h2>'
/*
            [
                    [id: 'j', name: 'Journal', code: 'journal'],
                    [id: 'n', name: 'Note', code: 'notes'],
                    [id: 'w', name: 'Writing', code: 'writings'],
                    [id: 'g', name: 'Goal', code: 'goals'],
                    [id: 't', name: 'Task', code: 'tasks'],
                    [id: 'r', name: 'Resource', code: 'resources'],
                    [id: 'p', name: 'Planner', code: 'planner'],
                    [id: 's', name: 'Contact', code: 'contacts'],
                    [id: 'c', name: 'Course', code: 'courses']
            ].each(){
                if (OperationController.getPath(it.code + '.enabled') == 'yes')
                    findRecords(it.id + ' :: ' + params.input)
            }
*/
//        } else if (input.startsWith('  ')) {
//            luceneSearch('m ' + params.input)
//        } else if (input.startsWith(' ')) {
//            findRecords('r :: ' + params.input)
//            findRecords('c :: ' + params.input)
//            findRecords('g :: ' + params.input)
//            findRecords('t :: ' + params.input)
//            findRecords('j :: ' + params.input)
//            findRecords('p :: ' + params.input)
//
//            findRecords('w :: ' + params.input)
//            findRecords('n :: ' + params.input)
//        }
    }


    def actionDispatcher(String input) {
        try {
            if (input && input.trim() != '') {

                if (input == '?')
                    render(template: '/page/help')
                else if (input == 'col') {
                    def colors = """AliceBlue;#F0F8FF
AntiqueWhite;#FAEBD7
Aqua;#00FFFF
Aquamarine;#7FFFD4
Azure;#F0FFFF
Beige;#F5F5DC
Bisque;#FFE4C4
Black;#000000
BlanchedAlmond;#FFEBCD
Blue;#0000FF
BlueViolet;#8A2BE2
Brown;#A52A2A
BurlyWood;#DEB887
CadetBlue;#5F9EA0
Chartreuse;#7FFF00
Chocolate;#D2691E
Coral;#FF7F50
CornflowerBlue;#6495ED
Cornsilk;#FFF8DC
Crimson;#DC143C
Cyan;#00FFFF
DarkBlue;#00008B
DarkCyan;#008B8B
DarkGoldenRod;#B8860B
DarkGray;#A9A9A9
DarkGreen;#006400
DarkKhaki;#BDB76B
DarkMagenta;#8B008B
DarkOliveGreen;#556B2F
DarkOrange;#FF8C00
DarkOrchid;#9932CC
DarkRed;#8B0000
DarkSalmon;#E9967A
DarkSeaGreen;#8FBC8F
DarkSlateBlue;#483D8B
DarkSlateGray;#2F4F4F
DarkTurquoise;#00CED1
DarkViolet;#9400D3
DeepPink;#FF1493
DeepSkyBlue;#00BFFF
DimGray;#696969
DodgerBlue;#1E90FF
FireBrick;#B22222
FloralWhite;#FFFAF0
ForestGreen;#228B22
Fuchsia;#FF00FF
Gainsboro;#DCDCDC
GhostWhite;#F8F8FF
Gold;#FFD700
GoldenRod;#DAA520
Gray;#808080
Green;#008000
GreenYellow;#ADFF2F
HoneyDew;#F0FFF0
HotPink;#FF69B4
IndianRed ;#CD5C5C
Indigo ;#4B0082
Ivory;#FFFFF0
Khaki;#F0E68C
Lavender;#E6E6FA
LavenderBlush;#FFF0F5
LawnGreen;#7CFC00
LemonChiffon;#FFFACD
LightBlue;#ADD8E6
LightCoral;#F08080
LightCyan;#E0FFFF
LightGoldenRodYellow;#FAFAD2
LightGray;#D3D3D3
LightGreen;#90EE90
LightPink;#FFB6C1
LightSalmon;#FFA07A
LightSeaGreen;#20B2AA
LightSkyBlue;#87CEFA
LightSlateGray;#778899
LightSteelBlue;#B0C4DE
LightYellow;#FFFFE0
Lime;#00FF00
LimeGreen;#32CD32
Linen;#FAF0E6
Magenta;#FF00FF
Maroon;#800000
MediumAquaMarine;#66CDAA
MediumBlue;#0000CD
MediumOrchid;#BA55D3
MediumPurple;#9370DB
MediumSeaGreen;#3CB371
MediumSlateBlue;#7B68EE
MediumSpringGreen;#00FA9A
MediumTurquoise;#48D1CC
MediumVioletRed;#C71585
MidnightBlue;#191970
MintCream;#F5FFFA
MistyRose;#FFE4E1
Moccasin;#FFE4B5
NavajoWhite;#FFDEAD
Navy;#000080
OldLace;#FDF5E6
Olive;#808000
OliveDrab;#6B8E23
Orange;#FFA500
OrangeRed;#FF4500
Orchid;#DA70D6
PaleGoldenRod;#EEE8AA
PaleGreen;#98FB98
PaleTurquoise;#AFEEEE
PaleVioletRed;#DB7093
PapayaWhip;#FFEFD5
PeachPuff;#FFDAB9
Peru;#CD853F
Pink;#FFC0CB
Plum;#DDA0DD
PowderBlue;#B0E0E6
Purple;#800080
Red;#FF0000
RosyBrown;#BC8F8F
RoyalBlue;#4169E1
SaddleBrown;#8B4513
Salmon;#FA8072
SandyBrown;#F4A460
SeaGreen;#2E8B57
SeaShell;#FFF5EE
Sienna;#A0522D
Silver;#C0C0C0
SkyBlue;#87CEEB
SlateBlue;#6A5ACD
SlateGray;#708090
Snow;#FFFAFA
SpringGreen;#00FF7F
SteelBlue;#4682B4
Tan;#D2B48C
Teal;#008080
Thistle;#D8BFD8
Tomato;#FF6347
Turquoise;#40E0D0
Violet;#EE82EE
Wheat;#F5DEB3
White;#FFFFFF
WhiteSmoke;#F5F5F5
Yellow;#FFFF00
YellowGreen;#9ACD32"""
                    render(template: '/page/colors', model: [colors: colors])
                }

//                def file = new File("/log/mcs/${new Date().format('dd.MM.yyyy')}.mcs")

                def commandType = input.trim().split(/[ ]+/)[0]
                def commandBody
                if (input.contains(' ')) {
                    commandBody = input.substring(input.indexOf(' ')).trim()
                    switch (commandType) {
                        case 'a':
//                            try {
//                                if (file.exists())
//                                    file.text += input + '\n'
//                                else
//                                    file.text = input + '\n'
//                            } catch (Exception e) {
//                                println 'Could not write to Nibras log file'
//                            }

                            quickAdd(commandBody)

                            break
                        case 'ا':
                            quickAdd(commandBody)
                            break
                        case 'f': findRecords(commandBody)
                            break
                        case 'ب': findRecords(commandBody)
                            break
                        case 'i': importPost(commandBody)
                            break
                        case 'q': queryRecords(commandBody)
                            break
                        case 'Q': queryUpdateRecords(commandBody)
                            break
                        case 'h': adHocQuery(commandBody)
                            break
                        case 's': luceneSearch(commandBody)
                            break
                        case 'p': assignCommand(commandBody)
                            break
                        case 't': batchAddTagToRecords(commandBody)
                            break
                    //                        case 't': addTagToAll(commandBody)
//                            break
                        case 'b': repostRecords(commandBody)
                            break

                        case 'u': updateCommand(commandBody)
                            break
                        case 'U': updateCommandWithId(commandBody)
                            break
                        case 'l': lookup(commandBody)
                            break
                        case 'c': convertDate(commandBody)
                            break

                        case 'v': fetchAya(commandBody)
                            break
                        case 'آ': fetchAya(commandBody)
                            break
                        case 'V': updateAyat(commandBody)
                            break
                        case 'S': updateAyatHeads(commandBody)
                            break

//                        case 'x': batchLogicallyDeleteRecords(commandBody)
//                            break
                        case 'x': batchPhysicallyDeleteRecords(commandBody)
                            break
                        case 'e': executeSavedSearch(
                                SavedSearch.findByCode(commandBody.substring(1))?.id ?:
                                        (commandBody.substring(1).isInteger() ? SavedSearch.get(commandBody.substring(1))?.id : null))
                            break
                        case '+': appendToScratch(commandBody)
                            break
                        default:
                            render '<br/><b>Wrong input!</b>'
                    }
                }
            } else {
                render ''
            }
        } catch (Exception e) {
            render('Exception occurred: ' + e.toString())
        }
    }

    // this now the used action dispatcher
    def batchAddPreprocessor(Long commandPrefix, String block) {

        /*
           def f = new File('/mhi/mdd/log/batch-add-' + new Date().format('dd.MM.yyyy') + '.txt')
        if(!f.exists()){
          f.write ''
    //	  print ' No add log file found'
        }
           f.text += block + '\n***\n\n'
      */

//        def prefixRecord = CommandPrefix.get(commandPrefix)
        def prefix = params.prefix //?: (prefixRecord.description ?: '')
//        println ' params.forEachLine ' + (params.forEachLine != 'null' ? 'on' : 'off')
//        println ' params.prefix ' + params.prefix
        def index = 1
        if (!prefix && block?.contains('***')){
            block?.replace('--', ' -- ')?.split(/\*\*\*/).each() {
                if (it.trim() != '')
                    if (params.verifyMode != 'on') {
                        render '#' + index++
                        batchAdd(it?.trim())
                    }
                else {
                        render(template: '/layouts/verification', model:
                                [line: it?.trim(), status: verifySmartCommand(it?.trim()), index: index++]) // prefix + ' ' +
                    }
            }
        }
            else if (!prefix && !block?.contains('***')){
            block?.replace('--', ' -- ')?.split('\n').each() {
                if (it.trim() != '')
                    if (params.verifyMode != 'on') {
                        render '#' + index++
                        batchAdd(it?.trim())
                    }
                    else {
//                        render '>>' + it
                        render(template: '/layouts/verification', model:
                                [line: it?.trim(), status: verifySmartCommand(it?.trim()), index: index++]) // prefix + ' ' +
                    }
            }
        }
        else if (prefix && !prefix.startsWith('A')){//.forEachLine != 'null') {
            block?.replace('--', ' -- ')?.eachLine() {
                if (it.trim() != '' && !it.startsWith('//'))

                    if (params.verifyMode != 'on') {
                        render '#' + index++
                        batchAdd(prefix?.replace('--', ' -- ') + it?.trim())
                    }
                    else {
                        render(template: '/layouts/verification', model:
                                [line: prefix?.replace('--', ' -- ') + it?.trim(),
                                 status: verifySmartCommand(prefix?.replace('--', ' -- ') + it?.trim()), index: index++]) // prefix + ' ' +
                    }



            }
        } else if (prefix.startsWith('A')) {

            if (params.verifyMode != 'on') {
                batchAdd(prefix?.replace('--', ' -- ') + block.trim())
            }
            else {
                render(template: '/layouts/verification', model:
                        [line: prefix?.replace('--', ' -- ') + it?.trim(),
                         status: verifySmartCommand(prefix?.replace('--', ' -- ') + it?.trim()), index: index++]) // prefix + ' ' +
            }
        }

        else
            render 'No action performed.'
        // block.split(/\*\*\*/).each() { region ->
        //              addWithDescription(region?.trim())
        //          }
        render ''


    }

    def batchAdd(String block) {

        def metaType = block.trim().split(/[ ]+/)[0]
        if (metaType == 'A') {
            block.split(/\*\*\*/).each() { region ->
                addWithDescription(region?.trim())
            }
        } else {
            block.eachLine { input ->
                input = input.trim()
                if (input && input != '') {

//                    def file = new File("/todo/new/${new Date().format('dd.MM.yyyy')}.mcs") //todo
                    if (input == '?')
                        render(template: '/page/help')


                    def commandType = input.trim().split(/[ ]+/)[0]
                    def commandBody
                    if (input.contains(' ')) {
                        commandBody = input.substring(input.indexOf(' ')).trim()
                        // println 'command ' + commandBody
                        switch (commandType) {
                            case 'a':
//                                try {
//                                    if (file.exists())
//                                        file.text += input + '\n'
//                                    else
//                                        file.text = input + '\n'
//                                } catch (Exception e) {
//                                    println 'cound not write to mcs-dev-actions.txt'
//                                }
                                quickAdd(commandBody)

                                break
                            case 'f': findRecords(commandBody)
                                break
                            case 'h': adHocQuery(commandBody)
                                break
                            case 'g': importPost(commandBody)
                                break
                            case 's': luceneSearch(commandBody)
                                break
                            case 'p': assignCommand(commandBody)
                                break
                            case 'q': queryRecords(commandBody)
                                break

                            case '!': updateRecordsByQuery(commandBody)
                                break
                            case 't': batchAddTagToRecords(commandBody)
                                break
                            case 'b': repostRecords(commandBody)
                                break
                            case 'x': batchLogicallyDeleteRecords(commandBody)
                                break

                            case 'X': batchPhysicallyDeleteRecords(commandBody)
                                break

                            case 'r': randomGet(commandBody)
                                break
                            case '+': parameterAdd(commandBody)
                                break

                            case 'u': updateCommand(commandBody)
                                break
                            case 'U': updateCommandWithId(commandBody)
                                break
                            case 'l': lookup(commandBody)
                                break
                            case 'c': convertDate(commandBody)
                                break
                            case 'v': fetchAya(commandBody)
                                break
                            case 'V': updateAyat(commandBody)
                                break
                            case 'S': updateAyatHeads(commandBody)
                                break
                            default:
                                render '<br/>Wrong input!'
                        }
                    }
                }
            }
        }
    }


    def commandBarAutocompleteOneAtATime() {

        def input = params.q.trim()
//        def prefix = params.prefix.trim()
        def entityCode
        def hintResponce = ''
        def responce = ''
//        def hint = (params.hint == '1')
//        println 'size ' + input.length()
        render(template: '/layouts/hintsOneAtATime', model: [hints: input]) // prefix + ' ' +
    }

  def commandBarAutocomplete() {

        def input = params.q.trim()
        def entityCode
        def hintResponce = ''
        def responce = ''
        def hint = (params.hint == '1')

//        if (!input || input?.trim() == '') {
//            hintResponce = '''Type ? for help'''
//        } else
        if ((!input || input?.trim() == '') || (input && input?.trim() == '?')) {
            hintResponce = '''
a : Add new records
g : Import posts as notes
f : Query in Nibras format
s : Full-text search
h : Ad hoc query e.g. select id, title from Book
u : Update selected records of type
U : Update record with ID
p : Assign selected tasks or goals to days
q : Query records using HQL code
c : Convert dates yyyy-MM-dd / WWd[.yy]
t : batch add tag to selected records of type ? (t r tag2)
x : physical delete
+ : append to scratch note
. : execute saved search
'''

            //v : Find aya (suray # aya #)
//            V : update Aya priority (e.g. V 15 3 55...)
//            S : set Ayat as start of paragraph e.g.  S 15 4 7 15 55...)

        } else {

            try {
                if (input.length() < 4) {
                    switch (input.substring(0, 1)) {
                        case 'a': hintResponce = """
<module> (options) -- summary :: description
p priority
c course
#type
?status
@location
r (resource)
!indicator
<startDate >endDate (<>ddd[.yy][_HH[mm]] or -+dd)"""//.encodeAsHTML()
                            break
                        case 's': hintResponce = 'c | w | m | r <lucene query>'
                            break
                        case 'f': hintResponce = "<module> <query in Nibras format>".encodeAsHTML()
                            break
                        case 'g': hintResponce = "<blogId> <postId>".encodeAsHTML()
                            break
                        case 'u': hintResponce = '<module> <query in Nibras format>'
                            break
                        case 'U': hintResponce = '<module> ID <query in Nibras format>'
                            break
                        case 'p': hintResponce = '<module> <t|g> <query in Nibras format to add plans>'
                            break
//                        case '=': hintResponce = '<module><id>'
//                            break
//                    case 'q': hintResponce = '<module> ??? p? c???? #type @location b???? <startDate >endDate'
//                        break
//                    case 'p': hintResponce = 'assign <module> to days'
//                        break
                        case 'h': hintResponce = 'ad hoc query e.g. h select id, description from Planner'
                            break
                        case 'v': hintResponce = 'v surah_id ayat_id'
                            break
                        case 't': hintResponce = 't module tagName'
                            break
                        case 'V': hintResponce = 'V surah_id priority ayat_ids'
                            break
                        case 'x': hintResponce = 'x entity_code [selected records]'
                            break
                        case 'e': hintResponce = '. saved search id or code <br/>'

if (input.length() < 3){
                            SavedSearch.findAll().each(){
                                hintResponce+= it.id + (it.code ? ' <b>' + it.code + '</b>' : '') + ' - ' + it.summary + '<br/>'
                            }
} else {
//    println 'hhhhhhhhhhhhhhh' + input
    SavedSearch.findAllByCodeLike(input.substring(1) + '%', [sort: 'code']).each() {
//        responce += (it.toString() + '|' + finalPart + ' =' + it.code + ' -- \n')
//        println 'eeeeeeeeeeeeeeeeeeee' + it.id
        hintResponce += (it.id + (it.code ?  ' <b>' + it.code + '</b>' : '') + ' - ' + it.summary + '\n')
    }
}
                            break
                    }
                }

//                if (input.substring(0, 1) == '!')
//                    entityCode = input.split(/[ ]+/)[2].toUpperCase()
//                else
                entityCode = input.split(/[ ]+/)[1].toUpperCase()

                def lastCharacter = input.split(/[ ]+/).last().substring(0, 1)


                def filter
                if (input.split(/[ ]+/).last().length() > 1)
                    filter = input.split(/[ ]+/).last().substring(1) + '%'
                else
                    filter = '%'

                def finalPart = input.substring(0, input.length() - filter.length())


                if (input.contains('###'))// || input.length() == 1)
                    return ' '
                else {
                    switch (lastCharacter) {
                        case 'p': responce = """1|p1
2|p2
3|p3
4|p4"""
                            hintResponce = """p1
p2
p3
p4"""
                            break
                        case "'":
                            hintResponce = """ar
fa
en
fr"""
                            break
                        case "=":
                            hintResponce = """record code"""
                            break
                        case 'c': Course.findAllByCodeLike(filter, [sort: 'code']).each() {
                            responce += (it.toString() + '|' + finalPart + ' c' + it.code + '\n')
                            hintResponce += (it.toString() + '\n')
                        }
                            break
                        case 'C': Course.findAllByCodeLike(filter, [sort: 'code']).each() {
                            responce += (it.toString() + '|' + finalPart + ' C' + it.code + '\n')
                            hintResponce += (it.toString() + '\n')
                        }
                            break
                        case '#':

                            hintResponce += ('Types\n\n')

                            switch (entityCode) {

                                case 'W': WritingType.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'N': WritingType.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'J': JournalType.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'P': PlannerType.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'G': GoalType.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break

                                case 'R': ResourceType.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                            }
                            break
                        case '?':
                            hintResponce += ('Statuses\n\n')
                            switch (entityCode) {

                                case 'W': WritingStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'N': WritingStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'I': WritingStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'P': WorkStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'G': WorkStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'T': WorkStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'R': ResourceStatus.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' ?' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break

                            }
                            break

                        case ']': ResourceType.findAllByCodeLike(filter, [sort: 'name']).each() {
                            responce += ('' + it.name + '|' + finalPart + ' #' + it.code + '\n')
                            hintResponce += ('' + it.code + '\n')
                        }
                            break

                        case '!': switch (entityCode) {

                            case 'I': Indicator.findAllByCodeLike(filter, [sort: 'code']).each() {
                                responce += ('' + it.name + '|' + finalPart + ' @' + it.code + '\n')
                                hintResponce += ('' + it.code + '\n')
                            }
                                break
                            case 'د':
                            case 'Q': PaymentCategory.findAllByCodeLike(filter, [sort: 'code']).each() {
                                responce += ('' + it.name + '|' + finalPart + ' @' + it.code + '\n')
                                hintResponce += ('' + it.code + '\n')
                            }
                                break
                        }
                            break
                        case 'g':
                            if (filter.length() > 2) {
                                switch (entityCode) {
                                    case 'G': Goal.findAllBySummaryLike('%' + filter, [sort: 'summary']).each() {
                                        responce += ('' + it.summary + '|' + finalPart + ' @' + it.summary + '\n')
                                        hintResponce += (it.id + ' ' + it.summary + '\n')
                                    }
                                        break
                                    case 'T': Goal.findAllBySummaryLike('%' + filter, [sort: 'summary']).each() {
                                        responce += ('' + it.summary + '|' + finalPart + ' @' + it.summary + '\n')
                                        hintResponce += (it.id + ' ' + it.summary + '\n')
                                    }
                                        break
                                }
                            }
                            break
                        case 'w':
                            if (filter.length() > 2) {
                                switch (entityCode) {
                                    case 'G': Writing.findAllBySummaryLike('%' + filter, [sort: 'summary']).each() {
                                        responce += ('' + it.summary + '|' + it.id + ' @' + it.summary + '\n')
                                        hintResponce += (it.id + ' ' + it.summary + '\n')
                                    }
                                        break
                                    case 'N': Writing.findAllBySummaryLike('%' + filter, [sort: 'summary']).each() {
                                        responce += ('' + it.summary + '|' + it.id + ' @' + it.summary + '\n')
                                        hintResponce += (it.id + ' ' + it.summary + '\n')
                                    }
                                        break
                                }
                            }
                            break
                        case 'r':

//                            if (filter.length() > 1){
                            Book.findAllById(filter.replace('%', ''), [sort: 'title']).each() {

                                responce += ('' + it.title + '|' + it.id + ' @' + it.title + '\n')
                                hintResponce += (it.id + ' ' + it.title + '\n')
                            }
//                            }
                            break
                        case '@':
                            hintResponce += ('Contexts\n\n')
                            switch (entityCode) {

                                case 'T': Context.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.name + '|' + finalPart + ' @' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break
                                case 'N': Contact.findAllByCodeLike(filter, [sort: 'name']).each() {
                                    responce += ('' + it.summary + '|' + finalPart + ' @' + it.code + '\n')
                                    hintResponce += ('' + it.code + '\n')
                                }
                                    break

                            }
                            break
                        case 'l': responce = """i|li
h|lh
d|ld
w|lw
M|lM
r|lr
y|ly
e|le
l|ll
"""
                            hintResponce = """li
lh
ld
lw
lM
lr
ly
le
ll
"""
                            break
                        case 'd': Department.findAllByCodeLike(filter, [sort: 'code']).each() {
                            responce += (it.toString() + '|' + finalPart + ' d' + it.code + ' -- \n')
                            hintResponce += (it.toString() + '|' + finalPart + ' d' + it.code + ' -- \n')
                        }
                            break
                        case '.':


//                            SavedSearch.findAllByCodeLike(input.substring(1) + '%', [sort: 'code']).each() {
//        responce += (it.toString() + '|' + finalPart + ' =' + it.code + ' -- \n')
//        println 'eeeeeeeeeeeeeeeeeeee' + it.id
//                                hintResponce += (it.id + (it.code ? ' =' + it.code : '') + ' - ' + it.summary + '\n')
//                            }

                            SavedSearch.findAllByCodeLike(filter + '%', [sort: 'code']).each() {
                            responce += (it.toString() + '|' + finalPart + ' =' + it.code + ' -- \n')
//                            hintResponce += (it.id + ' =' + it.code + ' - ' + it.summary + '\n')
                                hintResponce += (it.id + (it.code ? ' =' + it.code : '') + ' - ' + it.summary + '\n')
                        }
                            break

                    }
                }
            } catch (Exception e) {
                responce = 'Error occurred'
            }
        }

        //////////// validation
        /* bandwidth consuming checks
        input.eachLine() { line, i ->

            if (line && line.substring(0, 1).toLowerCase() == 'a') {
                def properties
                try {
                    properties = transformMcsNotation(line.substring(line.indexOf(' ')).trim())['properties']
                } catch (Exception) {
                    render("<span style='color: red'>Error parsing line $i</span><br/>")
                    println 'Error parsing line' + i
                }

                def n = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).newInstance()
                if (!properties) {
                    render("<span style='color: red'>Error parsing properties $i</span><br/>")
                    println 'Error parsing properties' + i
                } else {
                    n.properties = properties

                    if (n.hasErrors()) {

                        render("<span style='color: red'>Record has error $i</span><br/>")
                        println('record has error')
                    }
                }

            }


             }

*/

        if (hint) {

            render(template: '/layouts/hints', model: [hints: hintResponce?.replaceAll('\n', '<br/>')])
        } else
            render(responce)

    }


    def showDetails(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        render(template: '/gTemplates/recordDetails', model: [record: record])
        //  render(template: "/${record.entityController()}/edit", model: ["${record.entityController()}Instance": record, update: '${record.entityCode()}Record${record.id}'])
    }

    def showTags(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordTag', model: [record: record])
    }


    def showComment(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordComment', model: [record: record])
    }

    def showComments(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordComments', model: [record: record])
    }

    def showRelate(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordRelate', model: [record: record])
    }

    def showRelated(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/relationships', model: [record: record])
    }

    def showAddExcerpt(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordAddExcerpt', model: [record: record])
    }

    def showAppend(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordAppend', model: [record: record])
    }

    def showAppendNotes(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordAppendNotes', model: [record: record])
    }

    def showJP(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordJP', model: [record: record])
    }

    def showChildren(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordChildren', model: [record: record])
    }

    def showSubChildrenWithRecord(Long id, String entityCode, String childType) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        render(template: '/gTemplates/recordSummary', model: [record: record])
        render(template: '/gTemplates/recordChildren', model: [record: record, childType: childType])
    }

    def showSubChildren(Long id, String entityCode, String childType) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        render(template: '/gTemplates/recordChildren', model: [record: record, childType: childType])
    }

    def showIndexCards(Long id, String entityCode) {

//        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        if ('R'.contains(entityCode)) {
            render(template: '/indexCard/add', model:
                    [bookId: id, recordEntityCode: 'R', recordId: id])
        } else if ('W'.contains(entityCode)) {
            render(template: '/indexCard/add', model:
                    [writingId: id, recordEntityCode: 'W', recordId: id])
        } else {
            render(template: '/indexCard/add', model:
                    [recordId: id, recordEntityCode: entityCode])
        }

        //  render(template: "/${record.entityController()}/edit", model: ["${record.entityController()}Instance": record, update: '${record.entityCode()}Record${record.id}'])
    }

    def showSummary(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        if (record)
            render(template: '/gTemplates/recordSummary', model: [record: record, showFull: 'on', mobileView: params.mobileView])
        else render 'Record not found'
    }

    def logicalDelete(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        try {
//        record.delete()
            record.deletedOn = new Date()
//        render(template: '/layouts/achtung', model: [message: "Record with ID ${id} deleted"])
            render(template: '/gTemplates/recordSummary', model: [record: record])
        }
        catch (Exception) {
//            render(template: '/layouts/achtung', model: [message: "Record with ID ${id} could not be deleted"])
        }
    }

    def physicalDelete(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        try {
            record.delete()
            render(template: '/layouts/achtung', model: [message: "Record with ID ${id} deleted"])
//            render(template: '/gTemplates/recordSummary', model: [record: record])
        }
        catch (Exception) {
            render(template: '/layouts/achtung', model: [message: "Record with ID ${id} could not be deleted"])
        }
    }
def markAsMarkdowned(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        try {
            record.withMarkdown = true
            render 'is ? ' + record.withMarkdown
            render 'is ? ' + record.id
            render 'is ? ' + record.hasErrors()
            record.save()
            render(template: '/layouts/achtung', model: [message: "Record with ID ${id} has been marked as markdown"])
//            render(template: '/gTemplates/recordSummary', model: [record: record])
        }
        catch (Exception) {
            render(template: '/layouts/achtung', model: [message: "Record with ID ${id} could not be marked"])
            println 'Error saving record.'
        }
    }

    def openRpsFolder() {


        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        def typeSandboxPath, folder

        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true

        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true




        if (params.entityCode == 'R') {
            typeSandboxPath = OperationController.getPath('root.rps' + params.repository + '.path') + 'R' +
                    (resourceNestedByType ?  '/' +  record.type.code : '') +
                    (resourceNestedById ?  '/' +   (record.id / 100).toInteger() : '') +
                    '/' + record.id
        } else {
            typeSandboxPath = OperationController.getPath('root.rps' + params.repository + '.path') + '' + params.entityCode + '/' + record.id
        }
        folder = new File(typeSandboxPath)
        if (!folder.exists())
            folder.mkdirs()
//         println "dopus ${typeSandboxPath}"

//        if (System.properties['os.name'].toLowerCase().contains('windows')) {
//            println "it's Windows"
//        } else {
//            println "it's not Windows"
//        }

        if (org.apache.commons.lang.SystemUtils.IS_OS_WINDOWS) {
            "${OperationController.getPath('explorer.path.win')} ${typeSandboxPath}".execute()
            // /CMD Go NEWTAB PATH (for opus)
        } else //if (org.apache.commons.lang.SystemUtils.IS_OS_LINUX)
            "${OperationController.getPath('explorer.path.linux')} ${typeSandboxPath}".execute()

        render 'Folder opened...'
    }

    def openRpsFolderOld() {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        def typeSandboxPath, folder
        if (params.entityCode == 'R') {
            typeSandboxPath = OperationController.getPath('root.rps2.path') + 'R/' + record.type.code + '/' + (record.id / 100).toInteger() + '/' + record.id
        } else {
            typeSandboxPath = OperationController.getPath('root.rps2.path') + '' + record.entityCode() + '/' + record.id
        }
        folder = new File(typeSandboxPath)
        if (!folder.exists())
            folder.mkdirs()

        if (org.apache.commons.lang.SystemUtils.IS_OS_WINDOWS) {
            "${OperationController.getPath('explorer.path.win')}  /CMD Go NEWTAB PATH ${typeSandboxPath}".execute()
        } else if (org.apache.commons.lang.SystemUtils.IS_OS_LINUX)
            "${OperationController.getPath('explorer.path.linux')} ${typeSandboxPath}".execute()
    }

    def openLibFolder() {

        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        def typeSandboxPath, folder


        if (params.entityCode == 'R') {
            typeSandboxPath = OperationController.getPath('root.rps3.path') + 'R' +
                    record.type.code + '/' +
                    (record.id / 100).toInteger() +
                    '/' + record.id
        } else {
            typeSandboxPath = OperationController.getPath('root.rps3.path') + '' + record.entityCode() + '/' + record.id
        }
        //record.type.libraryPath + '/' + (record.id / 100).toInteger() + '/' + record.id
        folder = new File(typeSandboxPath)
        if (!folder.exists())
            folder.mkdirs()
//         println "dopus ${typeSandboxPath}"

        if (org.apache.commons.lang.SystemUtils.IS_OS_WINDOWS) {
            "${OperationController.getPath('explorer.path.win')}  /CMD Go NEWTAB PATH ${typeSandboxPath}".execute()
        } else if (org.apache.commons.lang.SystemUtils.IS_OS_LINUX)
            "${OperationController.getPath('explorer.path.linux')} ${typeSandboxPath}".execute()

    }

    def convertNoteToRecord() {
        def oldRecord = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        try {
            def newRecord
            if (params.type == 'J') {
                newRecord = new Journal()
                newRecord.summary = oldRecord.summary
                newRecord.description = oldRecord.description
                newRecord.startDate = oldRecord.writtenOn
                newRecord.priority = oldRecord.priority
                newRecord.bookmarked = oldRecord.bookmarked
                newRecord.save()
//            newRecord.dateCreated = oldRecord.dateCreated
                oldRecord.delete()

            } else if (params.type == 'P') {
                newRecord = new Planner()
                newRecord.summary = oldRecord.summary
                newRecord.description = oldRecord.description
                newRecord.startDate = oldRecord.writtenOn
                newRecord.priority = oldRecord.priority
                newRecord.bookmarked = oldRecord.bookmarked
                newRecord.save()
//            newRecord.dateCreated = oldRecord.dateCreated
                //oldRecord.delete()
                oldRecord.isMerged = true
                oldRecord.mergedOn = new Date()
                oldRecord.entityCode = params.type
                oldRecord.recordId = newRecord.id

            } else if (params.type == 'T') {
                newRecord = new Task()
                newRecord.summary = oldRecord.summary
                newRecord.description = oldRecord.description
                newRecord.startDate = oldRecord.writtenOn
                newRecord.priority = oldRecord.priority
                newRecord.bookmarked = oldRecord.bookmarked
                newRecord.language = oldRecord.language
                newRecord.save()
//            newRecord.dateCreated = oldRecord.dateCreated
              //  oldRecord.delete()
                oldRecord.isMerged = true
                oldRecord.mergedOn = new Date()
                oldRecord.entityCode = params.type
                oldRecord.recordId = newRecord.id
            }  else if (params.type == 'G') {
                newRecord = new Goal()
                newRecord.summary = oldRecord.summary
                newRecord.description = oldRecord.description
                newRecord.priority = oldRecord.priority
                newRecord.bookmarked = oldRecord.bookmarked
                newRecord.language = oldRecord.language
                newRecord.save()
//            newRecord.dateCreated = oldRecord.dateCreated
              //  oldRecord.delete()
                oldRecord.isMerged = true
                oldRecord.mergedOn = new Date()
                oldRecord.entityCode = params.type
                oldRecord.recordId = newRecord.id
            } else if (params.type == 'R') {
                newRecord = new Book()
                newRecord.course = oldRecord.course
                newRecord.title = oldRecord.summary ?: '...'
                newRecord.type = ResourceType.findByCode('art')
                newRecord.description = oldRecord.description
                newRecord.url = oldRecord.sourceFree
                newRecord.publicationDate = oldRecord.writtenOn
                newRecord.priority = oldRecord.priority
                newRecord.bookmarked = oldRecord.bookmarked
                newRecord.language = oldRecord.language
                newRecord.save()
                //oldRecord.delete()
                oldRecord.isMerged = true
                oldRecord.mergedOn = new Date()
                oldRecord.entityCode = params.type
                oldRecord.recordId = newRecord.id
//            newRecord.dateCreated = oldRecord.dateCreated

            } else if (params.type == 'W') {
                newRecord = new Writing()
                newRecord.course = oldRecord.course
                newRecord.summary = oldRecord.summary ?: '...'
                newRecord.description = oldRecord.description
                newRecord.source = oldRecord.sourceFree
                newRecord.priority = oldRecord.priority
                newRecord.language = oldRecord.language
                newRecord.bookmarked = oldRecord.bookmarked
                newRecord.save()
                //oldRecord.delete()
                oldRecord.isMerged = true
                oldRecord.mergedOn = new Date()
                oldRecord.entityCode = params.type
                oldRecord.recordId = newRecord.id

//            newRecord.dateCreated = oldRecord.dateCreated


            }

//        render(template: '/layouts/achtung', model: [message: "Record with ID ${id} deleted"])
            render(template: '/gTemplates/recordSummary', model: [record: newRecord])
        }
        catch (Exception e) {
            render(template: '/layouts/achtung', model: [message: "Record with ID ${params.id} could not be converted"])
            e.printStackTrace()

        }
    }

    def logicalUndelete(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        try {
//        record.delete()
            record.deletedOn = null
//        render(template: '/layouts/achtung', model: [message: "Record with ID ${id} deleted"])
            render(template: '/gTemplates/recordSummary', model: [record: record])
        }
        catch (Exception) {
//            render(template: '/layouts/achtung', model: [message: "Record with ID ${id} could not be deleted"])
        }
    }

    def bookmark(Long id, String entityCode) {
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!record.bookmarked) {
            record.bookmarked = true

        } else
            record.bookmarked = false

//        operation/countResourceFiles/15544?entityCode=R

//        operation/copyToRps1/15544?entityCode=R
        record.save(flush: true)

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def togglePrivacy() {
        def entityCode = params.id.split('-')[0]//substring(0, 1)
        def id = params.id.split('-')[1].toLong()

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        if ('GTJPRWN'.contains(entityCode)) {

            if (record.keepSecret == true) {
                record.keepSecret = false
            } else {
                record.keepSecret = true
            }

            render(template: '/gTemplates/recordSummary', model: [record: record])
        }

    }


    def markCompleted(Long id, String entityCode) {

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!'RP'.contains(entityCode) && record.class.declaredFields.name.contains('bookmarked') && record.bookmarked)
            record.bookmarked = false


        if ('GTP'.contains(entityCode)) {
            record.completedOn = new Date()

//        record.percentComplete = new Date()
            record.status = WorkStatus.findByCode('done')
        }

        if ('T'.contains(entityCode) && record.isRecurring) {
            def t = new Task()
//            t.properties = record.properties
            t.summary = 'rc: ' + t.summary
            t.description = 'rc: ' + t.description
            t.endDate = record.endDate + record.recurringInterval
            t.recurringInterval = record.recurringInterval
            t.isRecurring = true
            t.completedOn = null
            t.actualEndDate = null

            t.status = WorkStatus.findByCode('not-s')

            record.status = WorkStatus.findByCode('done')
            record.actualEndDate = new Date()
//            println 'the new t: ' + t.dump()

            t.save(flush: true)
        }

        if ('REN'.contains(entityCode)) {

            if (!record.readOn) {
                record.readOn = new Date()
            }
        }
        if ('R'.contains(entityCode)) {
            record.status = ResourceStatus.findByCode('core')
        }
        if ('W'.contains(entityCode)) {

            if (!record.firstReviewed) {
                record.firstReviewed = new Date()
            }
            if (!record.reviewCount) {
                record.reviewCount = 1
            } else record.reviewCount++

            record.lastReviewed = new Date()
            record.status = WritingStatus.findByCode('revised')
        }
        render(template: '/gTemplates/recordSummary', model: [record: record])
        render(template: '/layouts/achtung', model: [message: 'Record marked as completed'])
    }

//   static def markCompletedStatic(Long id, String entityCode) {
//
//
//       return record.id
//
//    }


    def markReviewed(Long id, String entityCode) {

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!record.firstReviewed)
            record.firstReviewed = new Date()

        if (!record.reviewHistory)
            record.reviewHistory = ''

//            new Date().format('dd.MM.yyyy') + '-'
//            else
        record.reviewHistory += new Date().format('dd.MM.yyyy') + '-'

//           if (!record.readOn)
//                record.readOn = new Date()

        record.lastReviewed = new Date()


        if (!record.reviewCount)
            record.reviewCount = 1
        else
            record.reviewCount++


        render(template: '/gTemplates/recordSummary', model: [record: record])
        render(template: '/layouts/achtung', model: [message: 'Record marked as reviewed'])
    }


    def markDismissed(Long id, String entityCode) {

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if ('GTP'.contains(entityCode)) {
//            record.completedOn = new Date()
            record.bookmarked = false
//        record.percentComplete = new Date()
            record.status = WorkStatus.findByCode('dismissed')
        } else if ('RE'.contains(entityCode)) {

        }


        render(template: '/gTemplates/recordSummary', model: [record: record])
        render(template: '/layouts/achtung', model: [message: 'Record marked as dismissed'])
    }


    def markReady(Long id, String entityCode) {

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!'BR'.contains(entityCode)) {
            //    record.completedOn = new Date()
//        record.percentComplete = new Date()
            record.status = WorkStatus.findByCode('ready')
        }
        //  else {
        //      record.readOn = new Date()
        //  }

        render(template: '/gTemplates/recordSummary', model: [record: record])
        render(template: '/layouts/achtung', model: [message: 'Record marked as ready'])
    }


    def quickBookmark() {
        def entityCode = params.id.split('-')[0]//substring(0, 1)
        def id = params.id.split('-')[1].toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)


        def resourceNestedById = false
        def resourceNestedByType = false

        if (OperationController.getPath('resourceNestedById') == 'yes')
            resourceNestedById = true
        if (OperationController.getPath('resourceNestedByType') == 'yes')
            resourceNestedByType = true

        if (!record.bookmarked || record.bookmarked == false) {
            if (record.class.declaredFields.name.contains('nbFiles')) {
//            OperationController.countResourceFiles2(grailsApplication, entityCode, id)


                def r
                if (entityCode == 'R')
                    r = Book.findById(id)
                else
                    r = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

                def filesList
                def message = ''

                if (r) {
//println ' b found'
                    filesList = []

                    def rps1Folder
                    def rps2Folder
                    if (entityCode == 'R') {
                        rps1Folder =
                                OperationController.getPath('root.rps1.path') + 'R' +
                                        (resourceNestedByType ?  '/' +  r.type.code : '') +
                                        (resourceNestedById ?  '/' +   (id / 100).toInteger() : '') +
                                        '/' + id
                        rps2Folder =
                                OperationController.getPath('root.rps2.path') + '/R' +
                                        (resourceNestedByType ?  '/' +  r.type.code : '') +
                                        (resourceNestedById ?  '/' +   (id / 100).toInteger() : '') +
                                        '/' + id
//                    println 'rps2 ' + rps2Folder

                    } else {
                        rps1Folder = OperationController.getPath('root.rps1.path') + '/' + entityCode + '/' + id
                        rps2Folder = OperationController.getPath('root.rps2.path') + '/' + entityCode + '/' + id
                    }

                    new File(rps1Folder).mkdirs()
/*
                    if (new File(rps2Folder).exists()) {

                        new File(rps2Folder).eachFile() {//Match(~/[\S\s]*\.[\S\s] (star)/) {
//                        println ' file ' + it
                            if (it.isFile())
                                filesList.add(it)
                        }
                    }
*/

            //        def ant = new AntBuilder()

            //        filesList.each() { f ->
           //             ant.copy(file: f.path, tofile: rps1Folder + '/' + f.name)
           //         }
//                    render filesList.size() + ' file(s) copied.'

              //      message = filesList.size() + ' file(s) copied.'
                } else {
                    render 'Record not found.'
                }

                if (entityCode == 'xE') {

                    supportService.pdfTitleUpdateNewPath(OperationController.getPath('module.sandbox.E.path'), record.id + 'e.pdf',
                            record.id + 'e_.pdf',
                            OperationController.getPath('onyx.path'),
                            record?.book?.course?.numberCode + ' ' + record?.book?.course?.code + ' ' + record.summary + ' ' + (record.book ? (' @ ' + record?.book?.title) : ''))
                    supportService.pdfTitleUpdateNewPath(OperationController.getPath('module.repository.E.path'), record.id + 'e.pdf',
                            record.id + 'e_.pdf',
                            OperationController.getPath('onyx.path'),
                            record?.book?.course?.numberCode + ' ' + record?.book?.course?.code + ' ' + record.summary + ' ' + (record.book ? (' @ ' + record?.book?.title) : ''))
                }


                def typeSandboxPath
                def typeLibraryPath
                def typeRepositoryPath

                def filesCount
                filesList = []
                def folders

                def list

                if (entityCode == 'R') {

                    if (id)
                        list = [Book.get(id)]
                    else list = [Book.get(1)] //Todo

                    for (b in list) {
                        filesCount = 0
                        folders = []
                        typeSandboxPath = OperationController.getPath('root.rps1.path') + '/R' +
                                (resourceNestedByType ?  '/' +  b.type.code : '')
//            typeLibraryPath = OperationController.getPath('root.rps3.path') + 'R/' + b.type?.code
                        //ResourceType.findByCode(type).libraryPath
                        typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/R' + (resourceNestedByType ?  '/' +  b.type.code : '')
                        folders.add(
                                [typeSandboxPath + '' + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')])
                        if (!b.bookmarked)
                            folders.add(
                                    [typeRepositoryPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '')])
//                    typeLibraryPath + '/' + (b.id / 100).toInteger()
                        //     ]
                        folders.each() { folder ->
//                        println 'folder' + folder
                            if (new File(folder[0]).exists()) {
                                new File(folder[0]).eachFileMatch(~/${b.id}[a-z][\S\s]*\.[\S\s]*/) {
                                    filesCount++
                                    filesList += it.name// + '\n'
                                }
                            }
                        }
                        folders = []
                        folders.add(
                                [typeSandboxPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '') + '/' + b.id])
//                    typeLibraryPath + '/' + (b.id / 100).toInteger() + '/' + b.id,
                        if (!b.bookmarked)
                            folders.add([typeRepositoryPath + (resourceNestedById ?  '/' +   (b.id / 100).toInteger() : '') + '/' + b.id])
//                ]

                        folders.each() { folder ->
//                    println 'fld ' + folder + ' class ' + folder.class
                            if (new File(folder[0]).exists()) {
                                new File(folder[0]).eachFile() {
//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                                    if (!it.isFile())
                                        filesList += '*** ' + it.name
                                    else {
                                        filesCount++
                                        filesList += it.name
                                    }
                                }
                            }
                        }
                        //println filesCount
                        b.nbFiles = filesCount
                        b.filesList = filesList.join('\n')


                    }
                } else {

                    list =
                            [grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)]

                    for (b in list) {
                        filesCount = 0
                        folders = []
                        typeSandboxPath = OperationController.getPath('root.rps1.path') + '/' + entityCode + '/'

                        typeRepositoryPath = OperationController.getPath('root.rps2.path') + '/' + entityCode + '/'
                        folders.add([typeSandboxPath + '/' + (b.id)])
                        if (!b.bookmarked)
                            folders.add([typeRepositoryPath + '/' + (b.id)])



                        folders.each() { folder ->
                            if (new File(folder[0]).exists()) {
                                new File(folder[0]).eachFile() {
//Match(~/[\S\s]*\.[\S\s]*/) { //ToDo: only files with extensions!
                                    if (!it.isFile())
                                        filesList += '*** ' + it.name
                                    else {
                                        filesCount++
                                        filesList += it.name
                                    }
                                }
                            }
                        }
                        //println filesCount
                        b.nbFiles = filesCount
                        b.filesList = filesList.join('\n')
                    }
                }
              //  render(template: '/layouts/achtung', model: [message: message + '...' + filesCount + ' files'])
// + filesList.join('\n').replace('\n', '<br/>')])
//                render '<br/>' + filesCount + ' files: <br/>' + filesList.join('\n').replace('\n', '<br/>')

//            OperationController.copyToRps21(grailsApplication, entityCode, id)


            }
            record.bookmarked = true
        } else

            record.bookmarked = false

        record.save(flush: true)


        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def setPriority() {

        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.priority = params.p?.toInteger()
        record.save(flush: true)
        render('<b>' + params.p + '</b>')
    }


    def increasePriority() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!record.priority) {
            record.priority = 3
        } else if (record.priority == 5) {
            record.priority = 5
        } else {
            record.priority = record.priority + 1
        }

        record.save(flush: true)

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def decreasePriority() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!record.priority) {
            record.priority = 1
        } else if (record.priority == 0) {
            record.priority = 0
        } else {
            record.priority = record.priority - 1
        }

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def increaseEndDate() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.bookmarked = true

        if (!record.endDate)
            record.endDate = new Date() + 1
        else
            record.endDate = record.endDate + 1

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def makeEndDateToday() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

//        if (!record.endDate)
        record.endDate = new Date()
        record.bookmarked = true
//        else
//            record.endDate = record.endDate  - 1

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def clearEndDate() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

//        if (!record.endDate)
        record.endDate = null
//        else
//            record.endDate = record.endDate  - 1

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def decreaseEndDate() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (!record.endDate)
            record.endDate = new Date() - 1
        else
            record.endDate = record.endDate - 1

        render(template: '/gTemplates/recordSummary', model: [record: record])
    }


    def setLanguage() {
        def entityCode = params.id.split('-')[1]//.substring(0, 1)
        def id = params.id.split('-')[0].toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.language = params.id.split('-')[2]
        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def setDepartment() {
        def entityCode = params.id.split('-')[1]//.substring(0, 1)
        def id = params.id.split('-')[0].toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.department = Department.findByCode(params.id.split('-')[2])
        render(template: '/gTemplates/recordSummary', model: [record: record])
    }
/*
    def setArabic() {
        def entityCode = params.entityCode//.substring(0, 1)
        def id = params.id.toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.language = 'ar'
        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def setPersian() {
        def entityCode = params.entityCode//.substring(0, 1)
        def id = params.id.toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.language = 'fa'
        render(template: '/gTemplates/recordSummary', model: [record: record])
    }


    def setEnglish() {
        def entityCode = params.entityCode//.substring(0, 1)
        def id = params.id.toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.language = 'en'
        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

    def setFrench() {
        def entityCode = params.entityCode//.substring(0, 1)
        def id = params.id.toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        record.language = 'fr'
        render(template: '/gTemplates/recordSummary', model: [record: record])
    }

  */

    def increasePercentCompleted() {
        def entityCode = params.id.substring(0, 1)
        def id = params.id.substring(1).toLong()
        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        if (record.class.declaredFields.name.contains('totalSteps') && record.totalSteps) {
            if (record.completedSteps)
                record.completedSteps = record.completedSteps + 1
            else
                record.completedSteps = 1

            if (!record.stepsHistory)
                record.stepsHistory = ''

//            new Date().format('dd.MM.yyyy') + '-'
//            else
            record.stepsHistory += new Date().format('dd.MM.yyyy') + '-'

//            if (!record.percentCompleted) {
//                record.percentCompleted = 10
            if (record.percentCompleted != 100) {
                record.percentCompleted = (Math.floor((100 * (record.completedSteps / record.totalSteps))).toInteger())
            }
//             else {
//                record.percentCompleted = 90
//            }
        } else {
            if (!record.percentCompleted) {
                record.percentCompleted = 10
            } else if (record.percentCompleted != 100) {
                record.percentCompleted = record.percentCompleted + 10
            } else {
                record.percentCompleted = 90
            }
        }

//        render (template: '/gTemplates/recordSummary', model: [record: record])
        render record.percentCompleted + '%'
    }


    def setRecordBlog() { //Long id, String entityCode, String blogCode
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        record.blogCode = params.blogCode
        record.publishedNodeId = params.publishedNodeId ?: null
        record.publishedOn = params.publishedOn ? Date.parse('dd.MM.yyyy', params.publishedOn) : null

        render(template: '/layouts/achtung', model: [message: 'Record blog set to ' + record.blogCode])
    }

/* 2012-09-30: First usage of Grails power and the generic record template to reduce repetitive code */

    def showBookmarkedRecords() {
        def results = []
        [mcs.Course,
         mcs.Goal,
         mcs.Task,
         mcs.Planner,
         mcs.Journal,

         mcs.Writing,
         app.IndexCard,

         mcs.Book,
         mcs.Excerpt,
         app.Contact
        ].each() {
            results += it.findAllByBookmarked(true)
        }
        render(template: '/gTemplates/recordListing', model: [list: results, title: '(' +
                'حزمة اليوم' +
                results.size() + ')'])
    }

    def recordsByCourse() {

        def course = Course.get(params.id)
        def results = [course]

        results += Writing.findAllByCourse(course, [sort: 'orderInCourse', order: 'asc'])
        results += Book.findAllByCourse(course, [sort: 'orderInCourse', order: 'asc'])

        allClassesWithCoursesMinusBW.each() {
            results += it.findAllByCourse(course)
        }
        render(template: '/gTemplates/recordListing', model: [list: results, title: 'Records with course ' + course])
    }

    def recordsByDepartment() {

        def department = Department.get(params.id)
        def results = [department]


        for (c in Course.findAllByDepartment(department)) {
            results += [c]
            results += Writing.findAllByCourse(c, [sort: 'orderInCourse', order: 'asc'])

            allClassesWithCoursesMinusBW.each() {
                results += it.findAllByCourse(c)
            }

            results += Book.findAllByCourse(c, [sort: 'orderInCourse', order: 'asc'])

        }


        render(template: '/gTemplates/recordListing', model: [list: results, title: 'Records with department ' + department])
    }


    def dotTextDump() {
        def results = []


        def f, csv
        def contents, csvContents
        def path = OperationController.getPath('root.rps1.path')
        csv = new File(path + '/dmp/all.csv')
        csvContents = ''
        csvContents += "Tb,ID,Version,Priority,Created,Updated,Summary,Description,Notes,Course,Type,Status,Location,Start,End,Level,Reality,Indicator,Date,Value,Title,Published,Book\n"

        for (C in ['R', 'G', 'T', 'P', 'W', 'N', 'J', 'E']) {

            def c = grailsApplication.classLoader.loadClass(entityMapping[C])
            f = new File(path + '/dmp/' + C + '.txt')

            def array, csvArray
            contents = ''

            def none = "-"
            def countRecords = 0
            def countFiles = 0

            def list = (C == 'R' ?
                    Book.findAllByStatus(ResourceStatus.findByCode('zbk', [sort: 'id', order: 'asc'])) :
                    (C == 'N' ? IndexCard.findAllByTypeNotEqual(WritingType.findByCode('aya'), [sort: 'id', order: 'asc']) : c.findAll( [sort: 'id', order: 'asc'])))

            for (r in list) {
                countRecords++
                array = []
                csvArray = [C]
                array.add('ID: ' + r.id)
                array.add('Version: ' + r.version)

                array.add('Priority: ' + r.priority)
                array.add('Date created:' + r.dateCreated?.format('dd.MM.yyyy')) //HH:mm:ss
                array.add('Last updated:' + r.lastUpdated?.format('dd.MM.yyyy'))


                if ('GTJPWIN'.contains(C)) {
                    array.add('Summary: ' + r.summary)
                    csvArray.add(r.summary.toString())
                } else
                    csvArray.add(none)


                array.add('Description: ' + r.description)
                array.add('Notes: ' + r.notes)


                csvArray.add(r.id)
                csvArray.add(r.version)

                csvArray.add(r.priority)
                csvArray.add(r.dateCreated?.format('dd.MM.yyyy HH:mm:ss'))
                csvArray.add(r.lastUpdated?.format('dd.MM.yyyy HH:mm:ss'))

                if ('GTJPWIN'.contains(C))
                    csvArray.add(StringUtils.abbreviate(r.summary, 120)) //r.summary?.replaceAll('\n',' -- ')


                csvArray.add(StringUtils.abbreviate(r.description, 120))
                csvArray.add(StringUtils.abbreviate(r.notes, 120))


                if ('GTJPWINR'.contains(C)) {
                    array.add('Course: ' + r.course.toString())
                    csvArray.add(r.course.toString())
                } else
                    csvArray.add(none)

                if ('GJPWNR'.contains(C)) {
                    array.add('Type: ' + r.type)
                    csvArray.add(r.type)
                } else
                    csvArray.add(none)


                if ('GWRTP'.contains(C)) {
                    array.add('Status: ' + r.status)
                    csvArray.add(r.status)
                } else
                    csvArray.add(none)


                if ('T'.contains(C)) {
                    array.add('Context:' + r.context)
                    csvArray.add(r.context)
                } else
                    csvArray.add(none)

//                if (''.contains(C)) {
//                  //  array.add('Status:' + r.status)
//                }

                if ('JP'.contains(C)) {
                    array.add('Start date:' + r.startDate?.format('dd.MM.yyyy HH:mm'))
                    array.add('End date:' + r.endDate?.format('dd.MM.yyyy HH:mm'))
                    array.add('Level:' + r.level)

                    csvArray.add(r.startDate?.format('dd.MM.yyyy HH:mm'))
                    csvArray.add(r.endDate?.format('dd.MM.yyyy HH:mm'))
                    csvArray.add(r.level)

                } else {
                    csvArray.add(none)
                    csvArray.add(none)
                    csvArray.add(none)
                }


                if ('P'.contains(C)) {
                    array.add('Reality:' + r.reality)
                    csvArray.add(r.reality)
                } else
                    csvArray.add(none)

                if ('I'.contains(C)) {
                    array.add('Indicator:' + r.indicator)
                    array.add('Date:' + r.date?.format('dd.MM.yyyy'))
                    array.add('Value:' + r.value)
                    csvArray.add(r.indicator)
                    csvArray.add(r.date?.format('dd.MM.yyyy'))
                    csvArray.add(r.value)

                } else {
                    csvArray.add(none)
                    csvArray.add(none)
                    csvArray.add(none)
                }


                if ('RE'.contains(C)) {
                    array.add('Title:' + r.title)
                    csvArray.add(StringUtils.abbreviate(r.title, 120))
                } else {
                    csvArray.add(none)
                }


                if ('N'.contains(C)) {
//                    array.add('Category:' + r.category)
//                    array.add('Source:' + r.source)
//                    array.add('Scope:' + r.scope)
                    array.add('Published on:' + r.publishedOn?.format('dd.MM.yyyy'))

//                    csvArray.add(r.category)
//                    csvArray.add(r.source)
//                    csvArray.add(r.scope)
                    csvArray.add(r.publishedOn?.format('dd.MM.yyyy'))

                } else {
//                    csvArray.add(none)
//                    csvArray.add(none)
//                    csvArray.add(none)
                    csvArray.add(none)
                }


                if ('E'.contains(C)) {
//                    array.add('Source type:' + r.sourceType)
//                    array.add('Source:' + r.source)
                    array.add('Book:' + r.book?.id)

//                    csvArray.add(r.sourceType)
//                    csvArray.add(r.source)
                    csvArray.add(r.book?.id)

                } else {
//                    csvArray.add(none)
//                    csvArray.add(none)
                    csvArray.add(none)
                }

                if ('R'.contains(C)) {
                    array.add('Legacy title:' + r.legacyTitle)
                    array.add('Status:' + r.status)
                    array.add('Author:' + r.author)
                    array.add('ISBN:' + r.isbn)
                    array.add('Publication date:' + r.publicationDate)
                    array.add('Publisher:' + r.publisher)
                }

                contents += array.join('\n') + '\n\n\n'
                csvContents += csvArray*.toString()*.replace(',', ' ')*.replace('null', '?')*.replace('\r', '\n')*.replace('\n', ' -- ').join(',') + '\n'

                if ((r.id / 100 ).toInteger() > countFiles){
//                if (countRecords == 100) {
                    f = new File(path + '/dmp/' + C + '-' + countFiles + '' + '.txt')
                    countFiles++
//                    countRecords = 0
                    f.write(contents, 'UTF8')
                    contents = ''
                }



            }

            f = new File(path + '/dmp/' + C + '-' + countFiles + '' + '.txt')
            countFiles++
//            countRecords = 0
            f.write(contents, 'UTF8')
            contents = ''



        }
        //csv.write(csvContents, 'UTF8')

        render(template: '/layouts/achtung', model: [message: "All text files has been dumped to " + path])
    }

    def showSelectedRecords() {
        def list = []
        selectedRecords.each() {
            if (it.value == 1) {
                def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))
                list.add(record)
            }
        }
        render(template: '/gTemplates/recordListing', model: [list: list, title: 'Selected records'])
    }

    def showTopPriority() {
        def results
        allClasses.each() {
            results = it.findAllByPriority(4)
        }
        render(template: '/gTemplates/recordListing', model: [list: results, title: 'Priority 4 records'])
    }


    def removeTagFromRecord() {

        def instance = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        def t = Tag.get(params.tagId)
        if (t) {
            instance.removeFromTags(t)
            if (!t.occurrence)
                t.occurrence = 0
            else t.occurrence--

            render(template: '/tag/tags', model: [instance: instance, entity: params.entityCode])
        } else render 'Tag not found'
    }

    def removeContactFromRecord() {
        def instance = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        def contact = Contact.get(params.tagId)
        if (contact) {
            instance.removeFromContacts(contact)
            render(template: '/tag/contacts', model: [instance: instance, entity: params.entityCode])
        } else render 'Tag not found'
    }

    def addTagToRecord() {

        def instance = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        def t = Tag.findByName(params.tag?.trim())
        if (t) {
            instance.addToTags(t)
            if (!t.occurrence)
                t.occurrence = 1
            else t.occurrence++
            render(template: '/tag/tags', model: [instance: instance, entity: params.entityCode])
        } else if (params.tag != '') {
            def newTag = new Tag([name: params.tag]).save(flush: true)
            instance.addToTags(newTag)
            newTag.occurrence = 1
            render('<b>' + params.tag + ' added </b>')
            render(template: '/tag/tags', model: [instance: instance, entity: params.entityCode])
        } else render(template: '/tag/tags', model: [instance: instance, entity: params.entityCode])
    }

    def addContactToRecord() {

        def instance = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        def contact = Contact.findBySummary(params.contact?.trim()) ?: new Contact([summary: params.contact?.trim()]).save(flush: true)
        if (contact) {
            instance.addToContacts(contact)
            render(template: '/tag/contacts', model: [instance: instance, entity: params.entityCode])
            render 'Contact added'

        } else render ''
    }


    def batchLogicallyDeleteRecords(String type) {

        def list = []

        selectedRecords.each() {
            if (it.value == 1 && it.key.substring(0, 1).toLowerCase() == type.toLowerCase()) {
                def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))

                record.deletedOn = new Date()

                list.add(record)
            }
        }

        render(template: '/gTemplates/recordListing', model: [
                list : list,
                title: 'Trashed records'])
    }

    def repostRecords(String choice) {

        def list = []

        selectedRecords.each() {
            if (it.value == 1 && it.key.substring(0, 1).toLowerCase() == choice.toLowerCase()) {
                def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))


                def tags = ''
                record.tags.each() {
                    if (!it.isKeyword)
                        tags += it.name + ', '
                }
                def categories = record?.type?.name + ','
                record.tags.each() {
                    if (it.isKeyword)
                        categories += it.name + ', '
                }

                String summary, contents, type

                switch (record.entityCode()) {
                    case 'W': summary = record.summary
                        contents =
//                                ys.wikiparser.WikiParser.renderXHTML(
                                record.description
//                                )?.decodeHTML()
                        type = record.type?.name
                        break
                    case 'N': summary = record.summary
                        contents = (record.language == 'ar' ? ('<div style="direction: rtl; text-align: right">' + record.description?.encodeAsHTML() + '</div>') : record.description?.encodeAsHTML())

                        //ys.wikiparser.WikiParser.renderXHTML(record.description)?.decodeHTML()
                        //record.description//?.encodeAsHTML()
                        type = record.type?.name
                        break
                    case 'J': summary = record.summary
                        contents =// ys.wikiparser.WikiParser.renderXHTML(
                                record.description
                        //  )?.decodeHTML()
                        //record.description//?.encodeAsHTML()
                        type = record.type?.name
                        break
                }

                // postToBlog(String blogId, String title, String categoriesString, String tags, String fullText) {
                sleep(2000)
                int r = supportService.postToBlog(record.blog.id, summary, categories, tags, contents, record.entityCode(), record.publishedNodeId)

                if (r) {
                    record.publishedNodeId = r
                    record.publishedOn = new Date()
                    //render r
                    render(template: '/layouts/achtung', model: [message: "Record published with id " + r])
                } else "Problem posting the record"


                list.add(record)
            }
        }

        render(template: '/gTemplates/recordListing', model: [
                list : list,
                title: 'Posted records'])
    }


    def batchPhysicallyDeleteRecords(String type) {

        selectedRecords.each() {
            if (it.value == 1 && it.key.substring(0, 1).toLowerCase() == type.toLowerCase()) {
                def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))

                record.delete()
            }
        }

        render(template: '/layouts/achtung', model: [message: 'Records physically deleted'])
    }


    def luceneSearch(String input) {

//        if (params.offset) {
//            iput = session.q
//        }
//        else {
//            session.q = params.q
//        }

        def q = input ? input.trim() : null
        params.escape = false
        params.max = 100

        if (q == '?')
            render(template: '/info/searchSyntax')
        else if (q.length() > 2) {
            try {
                def queryType = q.split(/[ ]+/)[0]
                def query = q.substring(q.indexOf(' ')).trim()
                def results

                switch (queryType) {
                    case '?': render(template: '/info/searchSyntax')
                        break

                    case '=':
//                        if (query ==~ /\d\d\d\d/) {
                        def entityCode = query.substring(0, 1).toUpperCase()
                        def id = query.substring(1)
                        def instance = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
//                        }
                        if (instance)
                            render(template: "/gTemplates/recordSummary", model: [record: instance])
                        else render 'Record not found'
                        break

//                    case 'x': results = searchableService.search(query, params)
//                        render(template: "/gTemplates/recordListing", model: [list: results.results,
//                                total: searchableService.countHits(q + '*'), title: query])
//                        break

                    case 'm': results = []
                        nonResourceClasses.each() { results += it.search(query + '*', params).results }
                        def total = 0
                        nonResourceClasses.each() { total += it.countHits(query + '*') }
                        render(template: "/gTemplates/recordListing", model: [list : results,
                                                                              total: total, title: query])
                        break

                    case 'w': params.withHighlighter = { highlighter, index, sr ->
                        if (!sr.highlights) {
                            sr.highlights = []
                        }
                        sr.highlights[index] = "..." + highlighter.fragmentsWithSeparator("summary") + " - " + highlighter.fragmentsWithSeparator("description")
                    }
                        results = Writing.search(query, params)
                        render(template: "/gTemplates/recordListing", model: [list      : results.results,
                                                                              highlights: results.highlights,
                                                                              total     : Writing.countHits(q), title: query])
                        break
                    case 'c': params.withHighlighter = { highlighter, index, sr ->
                        if (!sr.highlights) {
                            sr.highlights = []
                        }
                        sr.highlights[index] = "..." + highlighter.fragmentsWithSeparator("description") + '...'
                    }
                        results = IndexCard.search(query, params)
                        render(template: "/gTemplates/recordListing", model: [list      : results.results,
                                                                              highlights: results.highlights,
                                                                              total     : IndexCard.countHits(q), title: query])
                        break
                    case 'r':
                        params.withHighlighter = { highlighter, index, sr ->
                            if (!sr.highlights) {
                                sr.highlights = []
                            }
                            sr.highlights[index] = "..." + highlighter.fragmentsWithSeparator("title") + " - " + highlighter.fragmentsWithSeparator("description")
                        }
                        results = Book.search(query, params)
                        render(template: "/gTemplates/recordListing", model: [list      : results.results,
                                                                              highlights: results.highlights,
                                                                              total     : Book.countHits(q), title: query])
                        break
                }

            } catch (Exception e) {
                e.printStackTrace()
                log.error e
            }
        }

    }

    def quickSearch() {

//        if (params.offset) {
//            iput = session.q
//        }
//        else {
//            session.q = params.q
//        }

        def q = params.q ? params.q?.trim() : null
        params.escape = false
        params.max = 100

        if (q.length() > 2) {
            try {
                def query = q.trim()
                def results

//                    params.withHighlighter = { highlighter, index, sr ->
//                        if (!sr.highlights) {
//                            sr.highlights = []
//                        }
//                        sr.highlights[index] = "..." + highlighter.fragmentsWithSeparator("summary") + " - " + highlighter.fragmentsWithSeparator("description")
//                    }
                results = searchableService.search(query, params)
                render(template: "/gTemplates/recordListing", model: [list : results.results,
                                                                      //  highlights: results.highlights,
                                                                      total: searchableService.countHits(q), title: query])

            } catch (Exception e) {
                log.error e
            }
        }

    }

    def hqlSearchForm(Long id) {
        def types = []
        def statuses = []
        def topics = []
        def priorities = []
        def sources = []
        def departments = []
        def courses = []
        def locations = []
        def categories = []
//        def resourceTypes = []
        try {
            switch (params.id) {
                case 'T': WorkStatus.list([sort: 'name']).each() {
                    statuses.add([id: it.id, value: it.name + ' (' + Task.countByStatus(it) + ')'])
                }
                    Context.list([sort: 'name']).each() {
                        locations.add([id: it.id, value: it.name + ' (' + Task.countByContext(it) + ')'])
                    }
                    Task.executeQuery("select count(*), t.course from Task t group by t.course order by t.course.code asc").each() {
                        courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }
                    Task.executeQuery("select count(*), t.department from Task t group by t.department order by t.department.code asc").each() {
                        departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }
                    break
                case 'G':
                    WorkStatus.list([sort: 'name']).each() {
                        statuses.add([id: it.id, value: it.name + ' (' + Goal.countByStatus(it) + ')'])
                    }
                    GoalType.list([sort: 'name']).each() {
                        types.add([id: it.id, value: it.code + ' ' + it.name + ' (' + Goal.countByType(it) + ')'])
                    }
                    Goal.executeQuery("select count(*), t.course from Goal t group by t.course order by t.course.code asc").each() {
                        courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }

                    Goal.executeQuery("select count(*), t.department from Goal t group by t.department order by t.department.code asc").each() {
                        departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }
                    break
                case 'P': WorkStatus.list([sort: 'name']).each() {
                    statuses.add([id: it.id, value: it.code + ' (' + Planner.countByStatus(it) + ')'])
                }
                    PlannerType.list([sort: 'name']).each() {
                        types.add([id: it.id, value: it.code + ' (' + Planner.countByType(it) + ')'])
                    }
//                 Planner.executeQuery("select count(*), t.course from Goal t group by t.course order by t.course.code asc").each() {
//                     courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
//                 }
//
//                 Planner.executeQuery("select count(*), t.department from Planner t group by t.department order by t.department.code asc").each() {
//                     departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
//                 }
                    break

                case 'J':
//WorkStatus.list([sort: 'name']).each() {
//                 statuses.add([id: it.id, value: it.name + ' (' + Journal.countByStatus(it) + ')'])
//             }
                    JournalType.list([sort: 'name']).each() {
                        types.add([id: it.id, value: it.name + ' (' + Journal.countByType(it) + ')'])
                    }
//                 Planner.executeQuery("select count(*), t.course from Goal t group by t.course").each() {
//                     courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
//                 }
//
//                 Task.executeQuery("select count(*), t.department from Journal t group by t.department order by t.department.code asc").each() {
//                     departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
//                 }
                    break

                case 'W': WritingStatus.list([sort: 'name']).each() {
                    statuses.add([id: it.id, value: it.name + ' (' + Writing.countByStatus(it) + ')'])
                }
                    WritingType.list([sort: 'code']).each() {
                        types.add([id: it.id, value: it.code + ' - ' + it.name + ' (' + Writing.countByType(it) + ')'])
                    }

                    Task.executeQuery("select count(*), t.course from Writing t group by t.course order by t.course.code asc").each() {
                        courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }

                    Task.executeQuery("select count(*), t.course.department from Writing t group by t.course.department order by t.course.department.code asc").each() {
                        departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }

                    break

                case 'N': WritingStatus.list([sort: 'name']).each() {
                    statuses.add([id: it.id, value: it.name + ' (' + IndexCard.countByStatus(it) + ')'])
                }
                    WritingType.list([sort: 'code']).each() {
                        types.add([id: it.id, value: it.code + ' - ' + it.name + ' (' + IndexCard.countByType(it) + ')'])
                    }

                    IndexCard.executeQuery("select count(*), t.course from IndexCard t group by t.course order by t.course.code asc").each() {
                        courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }

                    IndexCard.executeQuery("select count(*), t.department from IndexCard t group by t.department order by t.department.code asc").each() {
                        departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }

                    break


                case 'R': ResourceStatus.list([sort: 'name']).each() {
                    statuses.add([id: it.id, value: it.name + ' (' + Book.countByStatus(it) + ')'])
                }
                    Book.executeQuery("select count(*), t.course from Book t where t.course is not null group by t.course order by t.course asc").each() {
                        courses.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }
                    Book.executeQuery("select count(*), t.course.department from Book t group by t.course.department order by t.course.department asc").each() {
                        departments.add([id: it[1].id, value: it[1].toString() + ' (' + it[0] + ')'])
                    }

/*   types = ResourceType.list([sort: 'code'])

                    Book.executeQuery("select count(*), t.type from Book t where t.type is not null group by t.type").each() {
                        types.add([id: it[1].id, value: it[1].code + ' ' + it[1].name + ' (' + it[0] + ')'])
                    }
*/
                    ResourceType.list([sort: 'code']).each() {
                        types.add([id: it.id, value: it.code + ' - ' + it.name + ' (' + Book.countByType(it) + ')'])
                    }

//                    Book.executeQuery("select count(*), t.resourceType from Book t where t.resourceType is not null group by t.resourceType").each() {
//                        resourceTypes.add([id: it[1], value: it[1].toString() + ' (' + it[0] + ')'])
//                    }

                    break

            }


            render(template: '/gTemplates/searchForm', model: [entityCode : params.id,
                                                               types      : types,
                                                               statuses   : statuses,
                                                               topcis     : topics,
                                                               priorities : priorities,
                                                               sources    : sources,
                                                               departments: departments,
                                                               courses    : courses,
                                                               locations  : locations,
                                                               categories : categories

            ])
        }
        catch (Exception e) {
            render "Exception " + e
            print "Exception " + e.printStackTrace()
        }
    }


    def fetchAddForm = {

        def types = []
        def statuses = []
        def topics = []
        def priorities = []
        def sources = []
        def departments = []
        def courses = []
        def locations = []
        def contexts = []
        def categories = []
        def writings = []
        def goals = []

        def indicators = app.Indicator.executeQuery('from Indicator  order by code')
        //where category != null

        courses = Course.list([sort: 'numberCode'])
        departments = Department.list([sort: 'summary'])


        try {
            switch (params.entityController) {
                case 'mcs.Task':
                    statuses = WorkStatus.list([sort: 'name'])
                    locations = Location.list([sort: 'name'])
                    contexts = Context.list([sort: 'name'])
                    goals = Goal.list([sort: 'summary'])
                    break
                case 'mcs.Goal':
                    statuses = WorkStatus.list([sort: 'name'])
                    types = GoalType.list([sort: 'name'])
                    writings = Writing.list([sort: 'summary'])
                    break
                case 'mcs.Planner':
                    statuses = WorkStatus.list([sort: 'name'])
                    goals = Goal.list([sort: 'summary'])
                    types = PlannerType.list([sort: 'name'])
                    break

                case 'app.Payment':
                    categories = PaymentCategory.list([sort: 'code'])
                    break

                case 'mcs.Journal':
                    types = JournalType.list([sort: 'name'])
                    break
                case 'mcs.Writing':
                    statuses = WritingStatus.list([sort: 'name'])
                    types = WritingType.list([sort: 'code'])

                    break
                case 'app.IndexCard':
                    statuses = WritingStatus.list([sort: 'name'])
                    types = WritingType.list([sort: 'code'])
                    writings = Writing.list([sort: 'summary'])
                    sources = Contact.list([sort: 'summary'])
                    break
                case 'mcs.Book':
                    statuses = ResourceStatus.list([sort: 'name'])
                    types = ResourceType.list([sort: 'code'])
//                    Book.executeQuery("select count(*), t.resourceType from Book t where t.resourceType is not null group by t.resourceType").each() {
//                        resourceTypes.add([id: it[1], value: it[1].toString() + ' (' + it[0] + ')'])
                    break
            }

            def record
            if (params.id)
                record = grailsApplication.classLoader.loadClass(params.entityController).get(params.id)


            render(template: '/gTemplates/addForm', model: [entityController: params.entityController,
                                                            fields          : grailsApplication.classLoader.loadClass(params.entityController).declaredFields.name,
                                                            updateRegion    : params.updateRegion,
                                                            record          : record,
                                                            types           : types,
                                                            statuses        : statuses,
                                                            writings        : writings,
                                                            goals           : goals,
                                                            topcis          : topics,
                                                            priorities      : priorities,
                                                            sources         : sources,
                                                            indicators      : indicators,
                                                            departments     : departments,
                                                            courses         : courses,
                                                            locations       : locations,
                                                            contexts        : contexts,
                                                            categories      : categories
            ])
            if (params.isParameter)
                render(template: '/gTemplates/recordListing', model: [list: grailsApplication.classLoader.loadClass(params.entityController).findAll([sort: 'id', order: 'desc'])])

        }
        catch (Exception e) {
            render "Exception " + e
            print "Exception " + e
        }
    }

    def fetchQuickAddForm = {

        def record
        if (params.id)
            record = grailsApplication.classLoader.loadClass(params.entityController).get(params.id)

        render(template: '/gTemplates/addQuickForm', model: [entityController: params.entityController,
                                                             fields          : grailsApplication.classLoader.loadClass(params.entityController).declaredFields.name,
                                                             updateRegion    : '3rdPanel',
                                                             record          : record
        ])
    }

    def hqlSearch = {

        def list = null

        def query = []
        def count = 0

        def c = params.isTodo

        ['entityCode', 'isTodo', 'location', 'status', 'type', 'author', 'publisher',
         'fullText', 'department', 'course', 'priority',
         'sortBy', 'order', 'max', 'dateField', 'dateA', 'dateB'].each() {
            if (params.offset)
                params[it] = session[it]
            else session[it] = params[it]
        }

//        if (c == 'on'){
//            queryWhere += 'isTodo = ? and '
//            queryParams.add(true)
//        } else {
//            queryWhere += 'isTodo = ? and '
//            queryParams.add(false)
//        }

        c = params.location
        if (c && c != 'null')
            query += ('context.id = ' + c)

//        c = params['location.id']
//        if (c != 'null'){
//            queryWhere += 'location = ? and '
//            query += 'location.id = ' + c
//            queryParams.add(Location.get(c.toLong()))
//        }

        c = params.status
        if (c && c != 'null') {
            query += 'status.id = ' + c
        }

        c = params.type
        if (c && c != 'null') {
            query += 'type.id = ' + c
        }

        c = params.fullText
        if (c != '') {
            if (params.entityCode != 'R')
                query += "(summary like '%" + c + "%' or description like  '%" + c + "%' or notes like '%" + c + "%')"
            else
                query += "(title like '%" + c + "%' or description like  '%" + c + "%' or legacyTitle like '%" + c + "%' or notes like '%" + c + "%')"
        }

        c = params.course
        if (c && c != 'null') {
            query += 'course.id = ' + c
        }

        c = params.department
        if (c && c != 'null') {
            query += 'course.department.id = ' + c
        }
        c = params.priority
        if (c && c != 'null') {
            query += 'priority = ' + c
        }
        c = params.author
        if (c && c != 'null') {
            query += "author like '%" + c + "%'"
        }

        c = params.publisher
        if (c && c != 'null') {
            query += "publisher like '%" + c + "%'"
        }

        c = params.publicationDate
        if (c && c != 'null') {
            query += "publicationDate like '%" + c + "%'"
        }

        c = params.language
        if (c && c != 'null') {
            query += "language = '" + c + "'"
        }
//        c = params.resourceType
//        if (c && c != 'null') {
//            query += "resourceType = '" + c + "'"
//        }

        c = params.dateField
        if (c != 'null' && params.dateA && params.dateB) {
            query += ("datediff($c, current_date()) >= " + params.dateA + ' and ' + "datediff($c , current_date()) <= " + params.dateB)
        }

//        query += ' order by department.departmentCode desc'
//        queryWhere = StringUtils.removeEnd(queryWhere, ' and ')
//        query = StringUtils.removeEnd(queryWhere, ' and ')

//        results = Task.executeQuery('from Task ' + (queryWhere != '' ? ' where ' : '') + queryWhere + '  order by department.departmentCode desc', queryParams, params)
        def fullQuery = 'from ' + entityMapping[params.entityCode] + ' ' +
                (query.size == 0 ? '' : ' where ' + query.join(' and ')) +
                ' order by ' + params.sortBy + ' ' + params.order.toLowerCase()

        if (!params.groupBy || params.groupBy == 'null') {

            list = Task.executeQuery(fullQuery, [], params)


            if (OperationController.getPath('enable.autoselectResults') == 'yes') {
                selectedRecords.keySet().each() {
                    session[it] = 0
                }
                selectedRecords = [:]
                for (r in list) {
                    selectedRecords[r.entityCode() + r.id] = 1
                    session[r.entityCode() + r.id] = 1
                }
            }


            count = Task.executeQuery('select count(*) from ' + entityMapping[params.entityCode] + ' ' +
                    (query.size == 0 ? '' : ' where ' + query.join(' and ')))[0]


            render(template: '/gTemplates/recordListing', model: [list : list, searchResultsTotal: count,
                                                                  title: 'Total: ' + count + ' - Query : ' + fullQuery
            ])
        } else {
            def groups

            def input = fullQuery

            def groupBy = params.groupBy

            switch (groupBy) {
                case 'department':
                    groups = Department.list([sort: 'code'])
                    break
            //   case 'course':
            //       groups = Course.list([sort: 'summary'])
            //       break
                case 'course':
                    groups = Course.findAllByBookmarked(true, [sort: 'summary'])
                    break

                case 'type':
                    if (input.contains('from Goal')) {
                        groups = GoalType.list([sort: 'name'])
                    } else if (input.contains('from Journal')) {
                        groups = JournalType.list([sort: 'name'])
                    } else if (input.contains('from Planner')) {
                        groups = PlannerType.list([sort: 'name'])
                    } else if (input.contains('from Journal')) {
                        groups = PlannerType.list([sort: 'name'])
                    } else if (input.contains('from Writing') || input.contains('from IndexCard')) {
                        groups = WritingType.list([sort: 'name'])
                    }
                    break
                case 'status':
                    if (input.contains('from Goal')) {
                        groups = WorkStatus.list([sort: 'name'])
                    } else if (input.contains('from Journal')) {
                        groups = JournalType.list([sort: 'name'])
                    } else if (input.contains('from Writing') || input.contains('from IndexCard')) {
                        groups = WritingStatus.list([sort: 'name'])
                    } else if (input.contains('from Book')) {
                        groups = ResourceStatus.list([sort: 'name'])
                    } else if (input.contains('from Goal') || input.contains('from Task') || input.contains('from Planner')) {
                        groups = WorkStatus.list([sort: 'name'])
                    }
                    break
                case 'location':
                    groups = Location.list([sort: 'name'])
                    break
                case 'context':
                    groups = mcs.parameters.Context.list([sort: 'name'])
                    break
                case 'goal':
                    groups = Goal.findAllByBookmarked([true], [sort: 'summary'])
                    break
            }
            params.max = 500


            selectedRecords.keySet().each() {
                session[it] = 0
            }
            selectedRecords = [:]


            def list2 = Task.executeQuery(fullQuery, [], params)
            for (r in list2) {
                selectedRecords[r.entityCode() + r.id] = 1
                session[r.entityCode() + r.id] = 1
            }


            render(template: '/reports/genericGrouping', model: [groups: groups, groupBy: params.groupBy,
                                                                 title : 'Generic grouping: ' + fullQuery,
                                                                 items : list2])
        }

    }

    def findRecords(String input) {

        if (input.contains(' ++')) {
            params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5
            def entityCode = input.split(/[ ]+/)[0]?.toUpperCase()

            def queryHead = 'from ' + entityMapping[entityCode]
            def queryCriteria = transformMcsNotation(input.split(/\+\+/)[0])['queryCriteria']


            def s = new SavedSearch()
            s.entity = entityCode
            s.summary = input.split(/\+\+/)[1].trim()
            s.query = queryHead + (queryCriteria ? ' where ' + queryCriteria : '')
            s.countQuery = 'select count(*) ' + queryHead + (queryCriteria ? ' where ' + queryCriteria : '')
            s.queryType = 'hql'
            s.save(flush: true)
            render(template: '/gTemplates/recordSummary', model: [record: s])
        }
        else if (input.endsWith(' +')) {
            try {
                //println new Date().format('HH:mm:ss')
                def entityCode = input.split(/[ ]+/)[0]?.toUpperCase()

                def queryHead = 'from ' + entityMapping[entityCode]
                def queryCriteria = transformMcsNotation(input.substring(0, input.length() - 2))['queryCriteria']

                def fullquery = queryHead + (queryCriteria ? ' where ' + queryCriteria : '')
                // println 'fq ' + fullquery
                def list = Task.executeQuery(fullquery + ' order by lastUpdated desc', [], params)
                def r
                def limit = ker.OperationController.getPath('updateResultSet.max-items')?.toInteger() ?: 100
                if (list.size() < limit) {
                    list.each() {
                        r = it.entityCode() + it.id
                        if (!selectedRecords[r] || selectedRecords[r] == 0) {
                            selectedRecords[r] = 1
                            session[r] = 1
                        } else {
                            selectedRecords[r] = 0
                            session[r] = 0
                        }
                    }
                    def fullquerySort = 'select count(*) ' + queryHead + (queryCriteria ? ' where ' + queryCriteria : '')
                    def queryKey = '_' + new Date().format('ddMMyyHHmmss')
                    session[queryKey] = fullquery

//                    println '-> ' + Task.executeQuery(fullquerySort)[0]
                    params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5
                    render(template: '/gTemplates/recordListing', model: [
                            totalHits: Task.executeQuery(fullquerySort)[0].toLong(), //.size(),
                            list     : list,
                            queryKey : queryKey,
                            fullquery: fullquery,
                            title    : fullquery
                    ])
                } else {
                    render '<br/><br/><b>Result set size is greater than ' + limit + '. Please narrow your search.</b><br/><br/>'
                }
            } catch (Exception e) {
                println e.printStackTrace()
            }

        }
        else {
            params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5
            if (input.contains(' {')) {

                def groupBy = input.split(/ \{/)[1]

                def entityCode = input.split(/[ ]+/)[0]?.toUpperCase()

                def groups

                switch (groupBy) {
                    case 'department':
                        groups = Department.list([sort: 'code'])
                        break
                //  case 'course':
                //      groups = Course.list([sort: 'summary'])
                //      break
                    case 'course':
                        groups = Course.findAllByBookmarked(true, [sort: 'summary'])
                        break

                    case 'type':
                        if (entityCode == 'G') {
                            groups = GoalType.list([sort: 'name'])
                        } else if (entityCode == 'J') {
                            groups = JournalType.list([sort: 'name'])
                        } else if (entityCode == 'P') {
                            groups = PlannerType.list([sort: 'name'])
                        } else if (entityCode == 'P') {
                            groups = PlannerType.list([sort: 'name'])
                        } else if (entityCode == 'W' || entityCode == 'N') {
                            groups = WritingType.list([sort: 'name'])
                        }
                        break
                    case 'status':
                        //if (input.contains('from mcs.Goal')) {

                        if ("TPG".contains(entityCode)) {
                            groups = WorkStatus.list([sort: 'name'])
                        } else if (entityCode == 'J') {
                            groups = JournalType.list([sort: 'name'])
                        } else if (entityCode == 'W' || entityCode == 'N') {
                            groups = WritingStatus.list([sort: 'name'])
                        } else if (entityCode == 'R') {
                            groups = ResourceStatus.list([sort: 'name'])
                        }
                        break
                    case 'location':
                        groups = Location.list([sort: 'name'])
                        break
                    case 'context':
                        groups = Context.list([sort: 'name'])
                        break
                    case 'goal':

                        groups = Goal.executeQuery('from Goal where bookmarked = ? order by department.code asc ', [true])
                        break
                    case 'priority':
                        groups = [1, 2, 3, 4, 5]
                        break
                }

//        input = params.input.substring(params.input.indexOf(' '))

                def queryHead = 'from ' + entityMapping[entityCode]
                def queryCriteria = transformMcsNotation(input)['queryCriteria']

                def queryParams = ''


                render(template: '/reports/genericGrouping', model: [
                        items : Task.executeQuery(queryHead + (queryCriteria ? ' where ' + queryCriteria : '') + ' order by lastUpdated desc', []),
                        groups: groups, groupBy: groupBy,
                        title : 'HQL Query: ' + input]
                )
            } else {
                def fullquery
                def fullquerySort
                def queryKey
                if (input.startsWith('_')) {
                    fullquery = session[input]
                    fullquerySort = 'select count(*) ' + fullquery
                    queryKey = input
                } else {
                    def entityCode = input.split(/[ ]+/)[0]?.toUpperCase()

//        input = params.input.substring(params.input.indexOf(' '))

                    def queryHead = 'from ' + entityMapping[entityCode]
                    def queryCriteria = transformMcsNotation(input)['queryCriteria']

                    def queryParams = ''

                    fullquery = queryHead + (queryCriteria ? ' where ' + queryCriteria : '')
                    fullquerySort = 'select count(*) ' + queryHead + (queryCriteria ? ' where ' + queryCriteria : '')
                    queryKey = '_' + entityCode + '-' + new Date().format('ddMMyyHHmmss')
                    session[queryKey] = fullquery

                }

                def list = Task.executeQuery(fullquery + ' order by lastUpdated desc', [], params)
//            if (OperationController.getPath('enable.autoselectResults') == 'yes'){
//                selectedRecords.keySet().each() {
//                    session[it] = 0
//                }
//                selectedRecords = [:]
//
//                for (r in list) {
//                selectedRecords[r.entityCode() + r.id] = 1
//                session[r.entityCode() + r.id] = 1
//            }
//            }

                render(template: '/gTemplates/recordListing', model: [
                        totalHits: Task.executeQuery(fullquerySort)[0], //.size(),
                        list     : list,
                        entity: fullquery?.split('where')[0]?.replace('from', '').trim(),
                        queryKey : queryKey,
                        fullquery: fullquery,
                        title    : fullquery.split(' ')[1]?.split(/\./).last() + ': ' + transformMcsNotation(input)['properties']// + ' ('+ Task.executeQuery(fullquerySort)[0] + ' result(s))'
                ])

            }
        }
    }

    def queryRecords(String input) {


        if (input.contains(' {')) {

            def groupBy = input.split(/ \{/)[1]

            def groups

            switch (groupBy) {
                case 'department':
                    groups = Department.list([sort: 'code'])
                    break
            //   case 'course':
            //        groups = Course.list([sort: 'summary'])
            //        break
                case 'course':
                    groups = Course.findAllByBookmarked(true, [sort: 'summary'])
                    break

                case 'type':
                    if (input.contains('from Goal')) {
                        groups = GoalType.list([sort: 'name'])
                    } else if (input.contains('from Journal')) {
                        groups = JournalType.list([sort: 'name'])
                    } else if (input.contains('from Planner')) {
                        groups = PlannerType.list([sort: 'name'])
                    } else if (input.contains('from Journal')) {
                        groups = PlannerType.list([sort: 'name'])
                    } else if (input.contains('from Writing') || input.contains('from IndexCard')) {
                        groups = WritingType.list([sort: 'name'])
                    }
                    break
                case 'status':
                    if (input.contains('from Goal')) {
                        groups = WorkStatus.list([sort: 'name'])
                    } else if (input.contains('from Journal')) {
                        groups = JournalType.list([sort: 'name'])
                    } else if (input.contains('from Writing') || input.contains('from app.IndexCard')) {
                        groups = WritingStatus.list([sort: 'name'])
                    } else if (input.contains('from Book')) {
                        groups = ResourceStatus.list([sort: 'name'])
                    } else if (input.contains('from Goal') || input.contains('from Task') || input.contains('from Planner')) {
                        groups = WorkStatus.list([sort: 'name'])
                    }
                    break
                case 'location':
                    groups = Location.list([sort: 'name'])
                    break
                case 'context':
                    groups = Context.list([sort: 'name'])
                    break
            }
            def query = input.split(/ \{/)[0]


            render(template: '/reports/genericGrouping', model: [
                    items : Task.executeQuery(query, []),
                    groups: groups, groupBy: groupBy,
                    title : 'HQL Query: ' + input]
            )
        } else {


            def fullquery
            def fullquerySort
            def queryKey
            if (input.startsWith('_')) {
                fullquery = session[input]
                fullquerySort = 'select count(*) ' + fullquery
                queryKey = input
            } else {

                fullquery = input
                fullquerySort = 'select count(*) ' + input
                queryKey = '_' + new Date().format('ddMMyyHHmmss')
                session[queryKey] = fullquery
            }

            params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5
            def list = Task.executeQuery(fullquery, [], params)
            if (OperationController.getPath('enable.autoselectResults') == 'yes') {
                selectedRecords.keySet().each() {
                    session[it] = 0
                }
                selectedRecords = [:]

                for (r in list) {
                    selectedRecords[r.entityCode() + r.id] = 1
                    session[r.entityCode() + r.id] = 1

                }
            }

            render(template: '/gTemplates/recordListing', model: [
                    list     : Task.executeQuery(fullquery, [], params),
                    totalHits: Task.executeQuery(fullquerySort)[0],
                    queryKey2: queryKey, fullquery: fullquery,
                    title    : 'HQL Query ' + (!input.contains('select') ? '(' + Task.executeQuery(fullquerySort)[0] + ')' : '') + ' : ' + fullquery
            ])

        }

    }

    def queryUpdateRecords(String input) {




            def fullquery
            def fullquerySort
            def queryKey


                fullquery = input
//                fullquerySort = 'select count(*) ' + input
                queryKey = '_' + new Date().format('ddMMyyHHmmss')
//                session[queryKey] = fullquery


            params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5
            def list = Task.executeUpdate(fullquery, [], params)
            render(template: '/gTemplates/recordListing', model: [
                    list     : list,
                    totalHits: list.size(),
                    queryKey2: queryKey, fullquery: fullquery,
                    title    : 'HQL Query: ' + fullquery
            ])

    }

    def randomGet(String input, String queryName) {

        try {
            def results = Task.executeQuery(input)
            def resultsIds = Task.executeQuery(input).id

            def list = [:]
            def randomRecords = []
            resultsIds.eachWithIndex() { b, i ->
                list[i] = b
            }
            def total = results.size()
            def record
            def randomNumber
            for (t in (1..3)) {
                randomNumber = Math.floor(Math.random() * total).toInteger()
                record = results[randomNumber]
                randomRecords.add(record)
            }

            render(template: '/gTemplates/recordListing',
                    model: [list : randomRecords,
                            title: 'Random records' + (queryName ? ' from ' + queryName : '')])
        }
        catch (Exception e) {

            println 'Problem ' + e
            render 'Problem occurred ' + e
        }
    }

    def updateRecordsByQuery(String input) {

        try {


            render(Task.executeUpdate(input, []))//    title: 'HQL Query ' + input

        } catch (Exception e) {
//            println 'here ' + e
            render 'Problem occurred ' + e
        }

    }

    def importPost(String input) {

        render(template: '/gTemplates/recordSummary', model: [record:
                                                                      IndexCard.get(supportService.post2xcd(input.split(/ /)[0], input.split(/ /)[1].toInteger()))
        ])

    }

    def adHocQuery(String input) {

        def list = mcs.Task.executeQuery(input)

        render(template: '/reports/adHocQueryResults', model: [
                list : list,
                title: 'Ad hoc query / ' + list.size() + ' : ' + input
        ])

    }

// Todo: what's its use over query?
    def lookup(String input) {

        def entityCode = input.split(/[ ]+/)[0]?.toUpperCase()

//        def input = params.input.substring(params.input.indexOf(' '))

        def queryCriteria = transformMcsNotation(input)['queryCriteria']
        def queryHead = 'from ' + entityMapping[entityCode] + ' where '
        def queryParams = ''

        render(template: '/gTemplates/recordListing', model: [
                list : Task.executeQuery(queryHead + queryCriteria),
                title: queryHead + queryCriteria
        ])

    }

    def quickAdd(String input) {

        def entityCode = input.trim().split(/[ ]+/)[0]?.toUpperCase()

//        def input = params.input.substring(params.input.indexOf(' '))
        def properties
        def queryCriteria = []
        try {
            properties = transformMcsNotation(input)['properties']
            if (!properties['language']) {
                def dlang = OperationController.getPath('default.language') ?: 'en'
                properties['language'] = dlang
                queryCriteria.add("language = '" + dlang + "'")
            }
//        def queryCriteria = transformMcsNotation(input)['queryCriteria']
//        def queryHead = 'from ' + entityMapping[entityCode] + ' where '
//        def queryParams = ''


            if (!properties) {
                render 'Error parsing command'

            } else {
                def n = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).newInstance(properties)
//                n.properties = properties
                if (!n.hasErrors() && n.save()) {
                    render(template: '/gTemplates/recordSummary', model: [
                            record: n, justSaved: true, justSaved: true])
                } else {
                    render 'Errors when saving the record<br/>'
                    render(template: '/gTemplates/recordSummary', model: [
                            record: n])
//            n.errors.each() {
//                render it
//            }

                }

            }
        }
        catch (Exception e) {
            render 'Exception in quick add: <b style="color: red">' + input + '</b>'
            println 'Exception in quick add: ' + input + ' \n\n\n' + e.printStackTrace()
        }

    }

    def parameterAdd(String input) {

        def entityCode = input.trim().split(/[ ]+/)[0]

//        def input = params.input.substring(params.input.indexOf(' '))
        def properties
        try {
            properties = transformMcsNotation(input)['properties']
//        def queryCriteria = transformMcsNotation(input)['queryCriteria']
//        def queryHead = 'from ' + entityMapping[entityCode] + ' where '
//        def queryParams = ''
//            def entityCode = notation?.trim()?.split(/[ ]+/)[0]?.toUpperCase()//substring(0, 1).toUpperCase()
//            println 'code ' + entityCode
//            println 'notation ' + notation
//            def input = StringUtils.removeStart(notation?.trim(), entityCode.toLowerCase())?.trim()
//            println 'input ' + input


        } catch (Exception) {
            ;//          render 'Exception in quick add' + e
            //       print 'Exception in quick add' + e
        }

        def n = grailsApplication.classLoader.loadClass(entityCode).newInstance()
        if (!properties) {
            render 'Error parsing command'
        } else {
            n.properties = properties

            if (!n.hasErrors() && n.save()) {
                render(template: '/gTemplates/recordSummary', model: [
                        record: n, justSaved: true])
            } else {
                render 'Errors when saving the record<br/>'
                render(template: '/gTemplates/recordSummary', model: [
                        record: n])
//            n.errors.each() {
//                render it
//            }

            }

        }
    }

    def saveViaQuickForm() {

        def entityCode = params.entityCode
        def entityController = params.entityController

        def n
        def savedOk
        n = grailsApplication.classLoader.loadClass(entityController).get(params.id)
        n.properties = params
        savedOk = true

        if (!n.hasErrors() && n.save()) {
            render(template: '/layouts/panel', model: [entityCode: entityCode, record: n])
        } else render "Problem occurred."
    }

    def savePayment() {

        def n = new app.Payment()
        n.properties = params

        if (!n.hasErrors() && n.save()) {
//            render('Saved with id ' + n.id)
            render(template: '/layouts/achtung', model: [message: 'Payment [' + n.summary + '] saved with id ' + n.id + '.'])
        } else {
            render('Problem saving.')
//            n.errors.each() {
//                render it
//            }

        }

    }

    def saveTaskWithContext() {

        def n = new mcs.Task()

        n.properties = params
        n.isTodo = true
//        n.bookmarked = true
        //n.startDate = new Date()
        //n.endDate = new Date() + 3

        if (n.summary && !n.hasErrors() && n.save(flush: true)) {
            render(n.summary)
        } else {
            render('Problem saving.')
//            n.errors.each() {
//                render it
//
//     }

        }

    }

    def saveJournalSheetEntry() {

        def n = new mcs.Journal()

        n.properties = params
//        n.bookmarked = true

        if (n.summary && !n.hasErrors() && n.save(flush: true)) {
            render(n.summary)
        } else {
            render('Problem saving.')
//            n.errors.each() {
//                render it
//            }

        }

    }

    def saveViaForm() {

        def entityCode = params.entityCode

        def entityController = params.entityController

        def n
        def savedOk
        if (!params.id) {
            n = grailsApplication.classLoader.loadClass(entityController).newInstance(params)

        } else {
            n = grailsApplication.classLoader.loadClass(entityController).get(params.id)
            n.properties = params
            savedOk = true
        }


        if (!params.startTime)
            params.startTime = '00.00'
        if (!params.endTime)
            params.endTime = '00.00'


        if (params.startDate && params.startTime)
            n.startDate = Date.parse('dd.MM.yyyy HH.mm', params.startDate + ' ' + params.startTime)

        if (params.endTime && params.endDate)
            n.endDate = Date.parse('dd.MM.yyyy HH.mm', params.endDate + ' ' + params.endTime)


        def types = []
        def statuses = []
        def topics = []
        def priorities = []
        def sources = []
        def departments = []
        def courses = []
        def locations = []
        def categories = []

        def indicators = app.Indicator.executeQuery('from Indicator order by code')
        //where category != null

        courses = Course.list()
        departments = Department.list()


        switch (params.entityController) {
            case 'mcs.Task':
                statuses = WorkStatus.list([sort: 'name'])
                locations = Location.list([sort: 'name'])
                break
            case 'mcs.Goal':
                statuses = WorkStatus.list([sort: 'name'])
                types = GoalType.list([sort: 'name'])

                break
            case 'mcs.Planner':
                statuses = WorkStatus.list([sort: 'name'])
                types = PlannerType.list([sort: 'name'])
                goals = Goal.list([sort: 'summary'])
                break

             case 'app.Payment':
                categories = PaymentCategory.list([sort: 'code'])
                break

            case 'mcs.Journal':
                types = JournalType.list([sort: 'name'])
                break
            case 'mcs.Writing':
                statuses = WritingStatus.list([sort: 'name'])
                types = WritingType.list([sort: 'code'])
                break
            case 'app.IndexCard':
                statuses = WritingStatus.list([sort: 'name'])
                types = WritingType.list([sort: 'code'])
                break
            case 'mcs.Book':
                statuses = ResourceStatus.list([sort: 'name'])
                types = ResourceType.list([sort: 'code'])

//                Book.executeQuery("select count(*), t.resourceType from Book t where t.resourceType is not null group by t.resourceType").each() {
//                    resourceTypes.add([id: it[1], value: it[1].toString() + ' (' + it[0] + ')'])
//                }
                break
        }

        if (!n.hasErrors() && n.save(flush: true) && !params.id) {
            render(template: '/gTemplates/addForm', model: [
                    fields          : n.class.declaredFields.name,
                    hideForm        : false,
                    updateRegion    : params.updateRegion,
                    entityController: entityController,
                    savedRecord     : n,

                    types           : types,
                    statuses        : statuses,
                    topcis          : topics,
                    priorities      : priorities,
                    sources         : sources,
                    indicators      : indicators,
                    departments     : departments,
                    courses         : courses,
                    locations       : locations,
                    categories      : categories
            ])
        } else if (!n.hasErrors() && params.id && n.save(flush: true)) {
            render(template: '/gTemplates/recordSummary', model: [savedOk: true, justUpdated: 1, justSaved: true,
                                                                  record : n])

        } else {
            render(template: '/gTemplates/addForm', model: [
                    entityController: entityController,
                    updateRegion    : params.updateRegion,
                    fields          : n.class.declaredFields.name,
                    record          : n,
                    savedRecord     : n,

                    types           : types,
                    statuses        : statuses,
                    topcis          : topics,
                    priorities      : priorities,
                    sources         : sources,
                    indicators      : indicators,
                    departments     : departments,
                    courses         : courses,
                    locations       : locations,
                    categories      : categories
            ])
//            n.errors.each() {
//                render it
//            }

        }

    }


    def autoCompleteMainEntities() {
//        println params.dump()
        def input = params.q
        def responce = []
        def filter = '%'


        Writing.findAllBySummaryLike(filter, [sort: 'summary']).each() {
            responce += [value: 'w ' + it.id + ' ' + it.summary]
        }
        Goal.findAllBySummaryLike(filter, [sort: 'summary']).each() {
            responce += [value: 'g ' + it.id + ' ' + it.summary]
        }
        Task.findAllBySummaryLike(filter, [sort: 'summary']).each() {
//            responce += (it.summary + '|t' + '' + it.id + '\n')
            responce += [value: 't ' + it.id + ' ' + it.summary]
        }


        if (1 == 2 && input && input.contains(' ') && input.split(/[ ]+/).size() >= 2) {
            def entityCode = input.split(/[ ]+/)[0].toUpperCase()
            def lastCharacter = input.split(/[ ]+/).last().substring(0, 1)

            //    def filter
            if (input.length() > 2)
                filter = '%' + input.substring(2) + '%'
            else
                filter = '%'

            switch (entityCode) {
                case 'W': Writing.findAllBySummaryLike(filter, [sort: 'summary']).each() {
                    responce += (it.summary + '|w' + '' + it.id + '\n')
                }
                    break
                case 'G': Goal.findAllBySummaryLike(filter, [sort: 'summary']).each() {
                    responce += (it.summary + '|g' + '' + it.id + '\n')
                }
                    break

                case 'T': Task.findAllBySummaryLike(filter, [sort: 'summary']).each() {
                    responce += (it.summary + '|t' + '' + it.id + '\n')
                }
                    break
//                case 'L': WordSource.findAllByNameLike(filter, [sort: 'name']).each() {
//                    responce += (it.name + '|l' + '' + it.id + '\n')
//                }
//                    break
                case 'R': Book.findAllByTitleLike(filter, [sort: 'title']).each() {
                    responce += (it.title + ' ' + it.id + '|b' + '' + it.id + '\n')
                }
                    break
                case 'U': WordSource.findAllBySummaryLikeOrDescriptionLike(filter, filter, [sort: 'summary']).each() {
                    responce += (it.summary + ': ' + it.description + '|u' + '' + it.id + '\n')
                }
                    break
            }


        }
        Book.findAllByStatus(ResourceStatus.get(1), [sort: 'title']).each() { // only textbooks
            responce += [id: it.id, value: 'r ' + it.id + ' ' + it.title, text: 'r ' + '' + it.id + '\n']
        }
//
        render responce as JSON
    }

    def addRelationship = {

        def r = new Relationship()

        // the child
        r.entityA = entityMapping[params.entityCode]
        r.entityACode = params.entityCode

        r.recordA = params.id.toLong()
        def child = grailsApplication.classLoader.loadClass(r.entityA).get(r.recordA)

        // the parent
        def parentEntityCode = params.recordB.substring(0, 1).toUpperCase()
        r.entityB = entityMapping[parentEntityCode]
        r.entityBCode = parentEntityCode

        r.recordB = params.recordB.split(' ')[1].toLong()

        def parent = grailsApplication.classLoader.loadClass(r.entityB).get(r.recordB)


        r.type = RelationshipType.get(params.type)

        if (params.type == '5') {
            if (params.entityCode == 'T' && parentEntityCode == 'G') {
                child.parentGoal = parent
            } else if (params.entityCode == 'G' && parentEntityCode == 'W') {
                child.writing = parent
            } else if (params.entityCode == 'J' && parentEntityCode == 'G') {
                child.goal = parent
            } else if (params.entityCode == 'P' && parentEntityCode == 'G') {
                child.goal = parent
            }
        } else
            r.save(flush: true)

        render(template: '/gTemplates/relationships', model: [record: child])

    }

    def quickAddRecord(String block) {

        if (block && block.trim() != '') {

//        def lines = block.readLines()

//            def line1 = lines[0]?.trim()

            def entityCode = params.recordType

            def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).newInstance()

            def summary
            def description


            if (entityCode == 'T') {
                summary = block
                description = ''
            } else {
                summary = 'Untitled ' + new Date().format('dd.MM.yyyy HH:mm')
                description = block
            }

//        if (lines.size() > 1) {

//            if (!line1.contains(';'))
//                summary = lines[0]?.trim()
//            else {
            //      record.properties = transformMcsNotation(line1.substring(line1.indexOf(' ')).trim())['properties']
//                }

//            description = ''
//            (1..lines.size() - 1).each() {
//                description += lines[it] + '\n'
//            }
//        }
//        else

            //    record.type = WritingType.findByCode('note')
            //    record.summary = summary
            //   if (entityCode != 'B')
            record.summary = summary
            record.description = description
            //    else
            //    record.fullText = description

            if (!record.hasErrors() && record.save()) {
                render(template: '/gTemplates/recordSummary', model: [
                        record: record, justSaved: true])
            } else {
                render 'Errors when saving the record<br/>'
                render(template: '/gTemplates/recordSummary', model: [
                        record: record])
                record.errors.each() {
                    render it
                }

            }

//            render(template: '/gTemplates/recordSummary', model: [record: record, expandedView: true])
//        render(template: '/gTemplates/recordDetails', model: [record: record])
        } else render 'Empty block'

    }


    def addWithDescription(String block) {
        if (block && block.trim() != '') {

            def summary = '?'
            def description = '?'

            def lines = block.readLines()

            def line1 = lines[0]?.trim()
            def entityCode = line1.trim().split(/[ ]+/)[1]?.toUpperCase()
            //    println 'entitycode ' + entityCode

            def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).newInstance()

            if (lines.size() > 1) {

//            if (!line1.contains(';'))
//                summary = lines[0]?.trim()
//            else {
                record.properties = transformMcsNotation(line1.substring(line1.indexOf(' ')).trim())['properties']
//                }

                description = ''
                (1..lines.size() - 1).each() {
                    description += lines[it] + '\n'
                }
            } else description = block

            //record.type = WritingType.findByCode('note')
            //   record.summary = summary
            if (entityCode == 'X') {
                record.countQuery = description
            } else if (entityCode == 'R')
                record.fullText = description
            else
                record.description = description


            if (!record.hasErrors() && record.save()) {
                render(template: '/gTemplates/recordSummary', model: [
                        record: record, justSaved: true])
            } else {
                render 'Errors when saving the record<br/>'
                render(template: '/gTemplates/recordSummary', model: [
                        record: record])
                record.errors.each() {
                    render it
                }

            }

//            render(template: '/gTemplates/recordSummary', model: [record: record, expandedView: true])
//        render(template: '/gTemplates/recordDetails', model: [record: record])
        } else render 'Empty block'

    }

    def addNote = {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        if (!record.notes)
            record.notes = ''

        record.notes += ('  ' + new Date().format('dd.MM.yyyy HH:mm') + ': ' + params.note + '||')

        render(template: '/gTemplates/recordNotes', model: [record: record])

    }
    def resetCompletedOnStatus = {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
//        if (record.notes)
        record.completedOn = null
        render('Status reset')
    }
    def resetReadOnStatus = {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
//        if (record.notes)
        record.readOn = null
        render('Status reset')
    }

    def appendText = {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        if (!record.description)
            record.description = ''

//        record.description += ('\n' + params.text + ' (' + new Date().format('dd.MM.yyyy') + ')')
        record.description += ('\n\n' + params.text)
render params.text
//        render(template: '/gTemplates/recordSummary', model: [record: record])
        //render(template: '/gTemplates/recordDetails', model: [record: record])

    }


    def appendTextToNotes = {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
        if (!record.notes)
            record.notes = ''

//        record.notes += ('\n' + params.text + ' (' + new Date().format('dd.MM.yyyy') + ')')
        record.notes += ('\n\n' + params.text)

        render(template: '/gTemplates/recordSummary', model: [record: record])
        //render(template: '/gTemplates/recordDetails', model: [record: record])

    }

//    def quickAddAutoHint(String input) {
//        if (!input){
//            render '''
//a               : Add new records
//s (=, m, x, w)  : Full-text search
//u <type>        : Update selected records of type <type>
//p <date>        : Assign selected records to days
//'''
//    }
//        else if(input.length() > 0) {
//            switch(input.substring(0,1)){
//                case 'a' : render "p? c???? #type @location b???? <startDate >endDate"
//                    break
//                case 's' : render '~ ???'
//                    break
//            }
//        }
//    }

    static Map transformMcsNotation(String notation) {

        try {
//            def entityCode = notation?.trim()?.split(/[ ]+/)[0]?.toUpperCase()//substring(0, 1).toUpperCase()
//            println 'code ' + entityCode
//            println 'notation ' + notation
//            def input = StringUtils.removeStart(notation?.trim(), entityCode.toLowerCase())?.trim()
//            println 'input ' + input

            def entityCode = notation?.trim()?.split(/[ ]+/)[0]?.toUpperCase()
//notation.trim().substring(0, 1).toUpperCase()


            def input = StringUtils.removeStart(notation?.trim(), entityCode.toLowerCase())?.trim()

            def result = [:]
            def properties = [:]
            def queryCriteria = []

            def endParametersEncountered = false

            input = ' ' + input.trim()
            input?.split('::')[0]?.split('--')[0]?.split(/[ ]+/).each() {

                if (it.contains('--'))
                    endParametersEncountered = true
                if (!endParametersEncountered) {
                    if (it.startsWith('i') && it.length() > 1) {
                        properties['id'] = it.substring(1).toLong()
                        queryCriteria.add('id = ' + it.substring(1))
                    }
                    if (it.startsWith('p')) {

                        if (it.trim().length() == 1) {
//                              properties['type'] = null
                            queryCriteria.add("priority = null")
                        } else {

                            properties['priority'] = it.substring(1, 2).toInteger()
                            queryCriteria.add('priority = ' + it.substring(1, 2))
                        }
                    }
                    if (it.startsWith(',')) {
                        properties['pages'] = it.substring(1)
                        queryCriteria.add('pages = ' + it.substring(1))
                    }

                    if (it.startsWith('_') && 'NE'.contains(entityCode)) {
                        properties['chapters'] = it.substring(1)
                        queryCriteria.add('chapters = ' + it.substring(1))
                    }

                    if (it.startsWith("'")) {
                        properties['language'] = it.substring(1)
                        queryCriteria.add("language = '" + it.substring(1) + "'")
                    }
                    if (it.startsWith('e')) {
                        properties['energyLevel'] = it.substring(1).toInteger()
//                        queryCriteria.add('priority = ' + it.substring(1, 2))
                    }
                    if (it.startsWith('c')) { // && it.length() == 5) {

                        if (it.trim() == 'c-') {
                            properties['course'] = null
                            queryCriteria.add("course is null")
                        } else {
                            def crsId = Course.findByCode(it.substring(1)).id
                            properties['course'] = crsId
                            queryCriteria.add('course.id = ' + crsId)
                        }

                    }
                    if (it.startsWith('C')) {
                        if (it.trim().length() == 2) {
                            properties['course'] = null
                            queryCriteria.add("course is null")
                        } else {
                            def crsId = Course.findById(it.substring(1)).id
                            // TODO: changed to allow scans filename to be looked up w156.21
                            properties['course'] = crsId
                            queryCriteria.add('course.id = ' + crsId)
                        }

                    }
                    if (it.startsWith('r') && it.length() > 1) {
                        if (it.substring(1).isInteger()) {
                            properties['book'] = Book.get(it.substring(1).toInteger()).id
                            queryCriteria.add('book.id = ' + it.substring(1))
                        } else {
                            def b = Book.findByCode(it.substring(1))
                            if (b) {
                                def bid = b.id
                                properties['book'] = bid
                                queryCriteria.add('book.id = ' + bid)
                            }
                        }
                    }
                    if (it.startsWith('w') && it.length() > 1) {


                        if (it.trim() == 'w-') {
                            properties['writing'] = null
                            queryCriteria.add("writing is null")
                        } else {


                            properties['writing'] = Writing.get(it.substring(1).toInteger()).id
                            queryCriteria.add('writing.id = ' + it.substring(1))
                        }
                    }
                    if (it.startsWith('o') && it.length() > 1) {
                        properties['orderNumber'] = it.substring(1)
                        queryCriteria.add('orderNumber = ' + it.substring(1))
                    }
//if (it.startsWith('O') && it.length() > 1) {
//                        properties['orderInCourse'] = it.substring(1)
//                        queryCriteria.add('orderInCourse = ' + it.substring(1))
//                    }

                    if (it.startsWith('"') && it.length() > 1) {
                        properties['plannedDuration'] = it.substring(1).toInteger()
                        queryCriteria.add('plannedDuration = ' + it.substring(1))
                    }

                    /*       if (it.startsWith('s')) {
                               properties['pages'] = it.substring(1)
                               queryCriteria.add('pages = ' + it.substring(1))
                           }
                           */
                    if (it.startsWith('d')) {

                        if (it.trim() == 'd-') {
//                              properties['type'] = null
                            queryCriteria.add("department = null")
                        } else {

                            if ('X'.contains(entityCode)) {

                                properties['entity'] = it.substring(1)
                                queryCriteria.add("entity = '" + it.substring(1) + "'")
                            } else {

                                if (it.substring(1) != '-') {
                                    properties['department'] = Department.findByCode(it.substring(1)).id
                                    queryCriteria.add("department.code = '" + it.substring(1) + "'")
                                } else {
                                    properties['department'] = null
                                    queryCriteria.add("department = null")
                                }
                            }
                        }
                    }

                    if (it.startsWith('D')) {

                        if (it.trim() == 'D-') {
//                              properties['type'] = null
                            queryCriteria.add("department = null")
                        } else {


                            if (it.substring(1) != '-') {
                                properties['department'] = Department.findByCode(it.substring(1)).id
                                queryCriteria.add("course.department.code =  '" + it.substring(1) + "'")
                            } else {
                                properties['department'] = null
                                queryCriteria.add("department = null")
                            }
                        }

                    }
                    if (it.startsWith('G')) {
                        if ('T'.contains(entityCode)) {
                            properties['goal'] = Goal.findById(it.substring(1)).id
                            queryCriteria.add("goal.id = '" + it.substring(1) + "'")
                        }
                        if ('JP'.contains(entityCode)) {
                            properties['goal'] = it.substring(1)
                            queryCriteria.add("goal.id = '" + it.substring(1) + "'")
                        }

                    }
                    if (it.startsWith('g')) {
                        if ('T'.contains(entityCode)) {
                            properties['goal'] = Goal.findByCode(it.substring(1)).id
                            queryCriteria.add("goal.code = '" + it.substring(1) + "'")
                        }
                        if ('JP'.contains(entityCode)) {
                            properties['goal'] = Goal.findByCode(it.substring(1)).id
                            queryCriteria.add("goal.code = '" + it.substring(1) + "'")
                        }

                    }
                    if (it.startsWith('=')) {
                        properties['code'] = it.substring(1)
                        queryCriteria.add("code = '" + it.substring(1) + "'")
                    }
                    if (it.startsWith('!')) {
                        if ('I'.contains(entityCode)) {
                            properties['indicator'] = Indicator.findByCode(it.substring(1)).id
                            queryCriteria.add("indicator.code = '" + it.substring(1) + "'")
                        }

                        if ('Qد'.contains(entityCode)) {
                            properties['category'] = PaymentCategory.findByCode(it.substring(1)).id
                            queryCriteria.add("category.code = '" + it.substring(1) + "'")
                        }
                        if ('X'.contains(entityCode)) {
                            properties['queryType'] = it.substring(1)
                            queryCriteria.add("queryType= '" + it.substring(1) + "'")
                        }
                        if ('CD'.contains(entityCode)) {
                            properties['code'] = it.substring(1)
                            queryCriteria.add("code = '" + it.substring(1) + "'")
                        }

                    }

                    if (it.startsWith('l')) {
                        if (it.trim().length() == 1) {
//                              properties['type'] = null
                            queryCriteria.add("level = null")
                        } else {
                            properties['level'] = it.substring(1)
                            queryCriteria.add("level = '" + it.substring(1) + "'")
                        }
                    }
                    if (it.startsWith('^')) {
                        if (it.trim().length() == 1) {
//                              properties['type'] = null
                            queryCriteria.add("orderNumber = null")
                        } else {
                            properties['orderNumber'] = it.substring(1)
                            queryCriteria.add("orderNumber = '" + it.substring(1) + "'")
                        }
                    }

                    if (it.startsWith('@') && entityCode == 'N') {
                        def id = WritingType.findByCode(it.substring(1)).id
                        properties['sourceType'] = id

                        queryCriteria.add("sourceType.code = '" + it.substring(1) + "'")
                    } else if (it.startsWith('?')) {
                        if (it.trim() == '?-') {
//                        if (it.trim().length() == 1) {
//                              properties['type'] = null
                            queryCriteria.add("status = null")
                        } else {

                            def statusId
                            if ('TGP'.contains(entityCode))
                                statusId = WorkStatus.findByCode(it.substring(1)).id
                            else if ('WN'.contains(entityCode))
                                statusId = WritingStatus.findByCode(it.substring(1)).id
                            else if ('R'.contains(entityCode))
                                statusId = ResourceStatus.findByCode(it.substring(1)).id

                            properties['status'] = statusId
                            queryCriteria.add("status.code = '" + it.substring(1) + "'")
                        }

                    }
                    if (it.startsWith('@') && 'T'.contains(entityCode)) {
                        if (it.trim() == '@-') {
//                        if (it.trim().length() == 1) {
//                              properties['type'] = null
                            queryCriteria.add("context = null")
                        } else {

                            def id = Context.findByCode(it.substring(1)).id

                            properties['context'] = id
                            queryCriteria.add("context.code = '" + it.substring(1) + "'")
                        }
                    }
                    if (it.startsWith('{') && 'I'.contains(entityCode)) {
                        properties['trackSequence'] = it.substring(1)
                        queryCriteria.add("trackSequence = '" + it.substring(1) + "'")
                    }

                    if (it.startsWith('%') && 'MGTB'.contains(entityCode)) {

                        properties['percentCompleted'] = it.substring(1)
                        queryCriteria.add("percentCompleted = '" + it.substring(1) + "'")
                    }

//                    if (it.startsWith('@') && 'N'.contains(entityCode)) {
//                        def id = NewsSource.findByCode(it.substring(1)).id
//
//                        properties['source.id'] = id
//                        queryCriteria.add("source.code = '" + it.substring(1) + "'")
//                    }
                    if (it.startsWith('k') && 'N'.contains(entityCode)) {

                        if (it.trim().length() == 1) {
                            properties['contact'] = null
                            queryCriteria.add("contact = null")
                        } else {
//println 'here' + it.substring(1)
                            def id = Contact.findByCode(it.substring(1)).id

                            properties['contact'] = id
                            queryCriteria.add("contact.code = '" + it.substring(1) + "'")
                        }
                    }

//                    if (it.startsWith('#') && entityCode == 'N') {
//                        def id = NewsScope.findByCode(it.substring(1)).id
//
//
//                        properties['scope.id'] = id
//                        queryCriteria.add("scope.code = '" + it.substring(1) + "'")

//                    }
                    else if (it.startsWith('#')) {
                        if (it.trim() == '#-') {
//                              properties['type'] = null
                            queryCriteria.add("type = null")
                        } else {
                            def id
                            if ('WN'.contains(entityCode))
                                id = WritingType.findByCode(it.substring(1)).id
                            else if ('G'.contains(entityCode))
                                id = GoalType.findByCode(it.substring(1)).id
                            else if ('J'.contains(entityCode))
                                id = JournalType.findByCode(it.substring(1)).id
                            else if ('P'.contains(entityCode))
                                id = PlannerType.findByCode(it.substring(1)).id
                            else if ('R'.contains(entityCode))
                                id = ResourceType.findByCode(it.substring(1)).id


                            properties['type'] = id
                            queryCriteria.add("type.code = '" + it.substring(1) + "'")
                        }
                    }

                    //Todo: note there the detail
                    if (it.startsWith('<') || it.startsWith('(')) {
                        def dateField = 'startDate'
                        if ('I'.contains(entityCode))
                            dateField = 'date'
                        if ('Q'.contains(entityCode))
                            dateField = 'date'
                        if ('R'.contains(entityCode))
                            dateField = 'publishedOn'
                        if ('N'.contains(entityCode))
                            dateField = 'writtenOn'

                        def core = it.substring(1)
                        if (it.startsWith('<+') || it.startsWith('<-') || it.startsWith('(+') || it.startsWith('(-')) {
                            properties[dateField] = new Date() + core.toInteger()
                            queryCriteria.add(dateField + " >= (current_date() " + core + ')')
                        } else {

                            if (core.matches(/^\d\d\d$/) ||
                                    core.matches(/^\d\d\d\.[0-9]{2}/) ||
                                    core.matches(/^\d\d\d[\_][0-9]{1,4}$/) ||
                                    core.matches(/^\d\d\d[\_][0-9]{1,4}[\.][0-9]{2}$/)) {
                                properties[dateField] = OperationController.fromWeekDateAsDateTimeFullSyntax(core)
                                queryCriteria.add("date(" + dateField + ') = str_to_date("' + OperationController.fromWeekDateAsDateTimeFullSyntax(core).format('dd.MM.yyyy') + '", "%d.%m.%Y")')
                                // todo: test
                            } else if (core.contains('_')) {
                                def format = Setting.findByName('datetime.format')
                                properties[dateField] = Date.parse(format ? format.value : 'dd.MM.YYYY_HHmm', core)
                                queryCriteria.add("date(" + dateField + ") = " + Date.parse(format ? format.value : 'dd.MM.YYYY_HHMM', core)?.format('YYYY-MM-DD'))
                            } else {
                                def format = Setting.findByName('date.format')
                                properties[dateField] = Date.parse(format ? format.value : 'dd.MM.yyyy', core)
                                queryCriteria.add("date(" + dateField + ") =  str_to_date('" + Date.parse(format ? format.value : 'dd.MM.yyyy', core).format('dd.MM.YYYY') + "', '%d.%m.%Y')")
                            }
                        }
                    }
                    if (it.startsWith('>') || it.startsWith(')')) {
                        def dateField = 'endDate'
                        def core = it.substring(1)
                        if (it.startsWith('>+') || it.startsWith('>-') || it.startsWith(')+') || it.startsWith(')-')) {
                            properties['endDate'] = new Date() + core.toInteger()
                            queryCriteria.add("endDate <= (current_date() " + core + ')')
                        } else {
                            if (core.matches(/^\d\d\d$/) ||
                                    core.matches(/^\d\d\d\.[0-9]{2}/) ||
                                    core.matches(/^\d\d\d[\_][0-9]{1,4}$/) ||
                                    core.matches(/^\d\d\d[\_][0-9]{1,4}[\.][0-9]{2}$/)) {
                                properties[dateField] = OperationController.fromWeekDateAsDateTimeFullSyntax(core)
                                queryCriteria.add("date(" + dateField + ') = str_to_date("' + OperationController.fromWeekDateAsDateTimeFullSyntax(core).format('dd.MM.yyyy') + '", "%d.%m.%Y")')
                            } else if (core.contains('_')) {
                                def format = Setting.findByName('datetime.format')
                                properties[dateField] = Date.parse(format ? format.value : 'dd.MM.YYYY_HHmm', core)
                                queryCriteria.add("date(" + dateField + ") = " + Date.parse(format ? format.value : 'dd.MM.YYYY_HHMM', core)?.format('YYYY-MM-DD'))
                            } else {
                                def format = Setting.findByName('date.format')
                                properties[dateField] = Date.parse(format ? format.value : 'dd.MM.yyyy', core)
                                queryCriteria.add("date(" + dateField + ') = str_to_date("' + OperationController.fromWeekDateAsDateTimeFullSyntax(core).format('dd.MM.yyyy') + '", "%d.%m.%Y")')
                            }
                        }
                    }


                    if (it.startsWith('.')) {
                        properties['blog'] = Blog.findByCode(it.substring(1)).id
                        queryCriteria.add("blog.code = '" + it.substring(1) + "'")
                    }
                    if (it.startsWith('/')) {
                        properties['url'] = it.substring(1)
                        queryCriteria.add("url like '%" + it.substring(1) + "%'")
                    }
                    if ((it.startsWith('*') || it.startsWith('x')) && it.length() == 1) {
                        properties['bookmarked'] = true
                        queryCriteria.add("bookmarked = true")
                    }
                    if (it.startsWith('*-')) {
                        properties['bookmarked'] = false
                        queryCriteria.add("bookmarked = false")
                    }
                    if (it.startsWith('[')) {
                        properties['isbn'] = it.substring(1)
                        queryCriteria.add("isbn = '" + it.substring(1) + "'")
                    }

//                    if (it.startsWith(']')) {
//                        properties['resourceType'] = it.substring(1)
//                        queryCriteria.add("resourceType = '" + it.substring(1) + "'")
//                    }

//		    if (it.startsWith('b')) {
//                        properties['book.id'] = it.substring(1)
//                        queryCriteria.add("book.id = '" + it.substring(1) + "'")
//                    }

                }
            }

            def summary
            def description
//            if (input.contains(';')) {
//                if (input.contains('::')) {
//                    summary = input.substring(input.indexOf(';') + 1, input.indexOf('::')).trim()
//                }
//                else {
//                    summary = input.substring(input.indexOf(';') + 1).trim()
//                }
//
//                properties['summary'] = summary
//                queryCriteria.add("summary like '%" + summary + "%'")
//            }

            def summaryFieldName = 'summary'
            def descriptionFieldName = 'description'
            if ('Rم'.contains(entityCode)) {
                summaryFieldName = 'title'
                descriptionFieldName = 'fullText'
            }
            if ('I'.contains(entityCode))
                summaryFieldName = 'value'
            if ('Qد'.contains(entityCode))
                summaryFieldName = 'amount'
            if ('X'.contains(entityCode)) { // for saved search - gallery vision
                descriptionFieldName = 'query'

            }
            if ('Y' == entityCode.toUpperCase()) { // for settings
                //    println 'here in ST'
                summaryFieldName = 'name'
                descriptionFieldName = 'value'
            }
            if (entityCode.length() > 1) { // for settings
//                println 'here in ST'
                summaryFieldName = 'name'
                descriptionFieldName = 'notes'
            }

            if (input.contains('::')) {
                description = input.substring(input.indexOf('::') + 2).trim()
                properties[descriptionFieldName] = description
                if (entityCode == 'R')
                    queryCriteria.add("fullText like '%" + description + "%' or description like '%" + description + "%'")
                else
                    queryCriteria.add(descriptionFieldName + " like '%" + description + "%'")

                if (input.contains(' -- ')) {
                    summary = input.substring(input.indexOf('--') + 2, input.indexOf('::')).trim().replaceAll("'", " ")
                    properties[summaryFieldName] = summary
                    if (entityCode == 'R')
                        queryCriteria.add('(' + summaryFieldName + " like '%" + summary + "%' or legacyTitle like '%" +
                                summary + "%' or author like '%" + summary + "%')")
                    else
                        queryCriteria.add(summaryFieldName + " like '%" + summary + "%'")
                }

            } else if (input.contains(' -- ')) {
                summary = input.substring(input.indexOf('--') + 2).trim().replaceAll("'", " ")
                properties[summaryFieldName] = summary


                if (entityCode == 'R')
                    queryCriteria.add('(' + summaryFieldName + " like '%" + summary + "%' or legacyTitle like '%" + summary + "%' or author like '%" + summary + "%')")
                else
                    queryCriteria.add(summaryFieldName + " like '%" + summary + "%'")

            }


            result['queryCriteria'] = queryCriteria.join(' and ')
            result['properties'] = properties
            // println result['queryCriteria']

            return result
        }
        catch (Exception e) {
//            println 'Exception while transforming Nibras syntax: ' + e//.printStackTrace()
            return null
        }
    }


    def assignCommand(String input) {
        def list = []
        def command = input.trim()//.substring(2).trim()
        def type = command.split(/[ ]+/)[0].toLowerCase()
//        def summary = '?'
//                    if (command.contains(';'))
//                    summary = command.substring(command.indexOf(';') + 1)?.trim()

        //  def level = command.split(/[ ]+/)[1]

//        def startDate = supportService.fromWeekDateAsDateTime(command.split(/[ ]+/)[2] + '.12')

        selectedRecords.each() {
            if (it.value == 1) {
//                        def type = it.key.substring(0, 1).toLowerCase()
                def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))

                def p
                if (type == 't' && it.key.substring(0, 1).toLowerCase() == 't') {
//                            p = new Planner([summary: summary, startDate: startDate, status: WorkStatus.get(2), type: PlannerType.get(7), endDate: startDate, level: level, task: record]).save()
                    p = new Planner([type: PlannerType.findByCode('assign'), status: WorkStatus.findByCode('pending'), task: record])

                    def properties = transformMcsNotation(command)['properties']
                    p.properties = properties
                    p.save()
                    p.errors.each() {
                        println it
                    }
                } else if (type == 'g' && it.key.substring(0, 1).toLowerCase() == 'g') {
                    p = new Planner([type: PlannerType.findByCode('assign'), status: WorkStatus.findByCode('pending'), goal: record])
                    def properties = transformMcsNotation(command)['properties']
                    p.properties = properties
                    p.save()
                    p.errors.each() {
                        println it
                    }
                }

                list.add(p)
            }
        }
//                        println p.dump()

        render(template: '/gTemplates/recordListing', model: [
                list : list,
                title: 'Updated records'])

    }

    def updateCommand(String input) {
        def properties = [:]
        def list = []
        def command = input.trim()

        def updatedInfo = command//.substring(1)
        def type = command.substring(0, 1)
        properties = transformMcsNotation(updatedInfo)['properties']

        selectedRecords.each() {
            if (it.value == 1 && it.key.substring(0, 1).toLowerCase() == type.toLowerCase()) {
                def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))
                record.properties = properties
                list.add(record)
            }
        }

        render(template: '/gTemplates/recordListing', model: [
                list : list,
                title: 'Updated records'])

    }

/* duplicated action
def addTagToAll(String input) {
   def properties = [:]
   def list = []
   def command = input.trim()

   def updatedInfo = command//.substring(1)
   def type = command.substring(0, 1)
//        properties = transformMcsNotation(updatedInfo)['properties']

   selectedRecords.each() {
       if (it.value == 1 && it.key.substring(0, 1).toLowerCase() == type.toLowerCase()) {
           def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))

           command = command.substring(2)

           if (Tag.findByName(command)) {
               record.addToTags(Tag.findByName(command))
           } else if (command != '') {
               def newTag = new Tag([name: command]).save(flush: true)
               record.addToTags(newTag)
               render('<b>' + params.tag + ' added </b>')
           }

           list.add(record)
       }
   }

   render(template: '/gTemplates/recordListing', model: [
           list: list,
           title: 'Tagged records'])

}

 */


    def batchAddTagToRecords(String tag) {

        def list = []
        def type = tag.split(' ')[0]
        tag = tag.split(' ')[1]
        try {
            selectedRecords.each() {
                if (it.value == 1 && it.key.substring(0, 1).toLowerCase() == type.toLowerCase()) {
                    def record = grailsApplication.classLoader.loadClass(entityMapping[it.key.substring(0, 1)]).get(it.key.substring(1))

                    if (Tag.findByName(tag?.trim())) {
                        record.addToTags(Tag.findByName(tag?.trim()))
                    } else if (params.tag != '') {
                        def newTag = new Tag([name: tag]).save(flush: true)
                        record.addToTags(newTag)
                    }

                    list.add(record)
                }
            }

            render(template: '/gTemplates/recordListing', model: [
                    list : list,
                    title: 'Updated records'])
        } catch (Exception e) {
            println e.printStackTrace()
        }
    }


    def updateCommandWithId(String input) {
        def properties = [:]
        def list = []

        def command = input.trim()

        def updatedInfo = command//.substring(input.indexOf(' ')).trim()
        def type = command.substring(0, 1).toUpperCase()
        def recordId = command.split(/[ ]+/)[1].toLong()

        properties = transformMcsNotation(updatedInfo)['properties']

        def record = grailsApplication.classLoader.loadClass(entityMapping[type]).get(recordId)
        record.properties = properties

        render(template: '/gTemplates/recordSummary', model: [
                record: record,
                title : 'Updated record'])

    }

    def select = {

        if (!selectedRecords[params.id] || selectedRecords[params.id] == 0) {
            selectedRecords[params.id] = 1
            session[params.id] = 1
        } else {
            selectedRecords[params.id] = 0
            session[params.id] = 0
        }
        render selectionSize()
    }

    def countSelection() {
        render selectedRecords.size()
    }

    def selectOnly = {

        selectedRecords[params.id] = 1
        session[params.id] = 1
        render selectionSize()
    }
    def deselectOnly = {

        selectedRecords[params.id] = 0
        session[params.id] = 0
        render selectionSize()
    }

    def deselectAll = {
        selectedRecords.keySet().each() {
            session[it] = 0
        }
        selectedRecords = [:]

        render selectionSize()
    }

/*

    def autoCompleteCourse() {
        if (params.q && params.q != '') {
            def responce = ''
            Course.findByNameLike(filter, [sort: 'code']).each() {
                responce += (it.code + ' ' + it.title + '|' + it.code + ' ; \n')
            }
            def fresponce = ''
//    if (params.q && params.q != '' && params.q.length() < 14) {
            responce.eachLine() {
                if (it.startsWith(params.q))
                    fresponce += it + '\n'
            }
            render fresponce
        }

    }

    def autoCompleteLookup() {
        def responce = ''

        if (params.q && params.q != '' && params.q.length() < 12 && params.q.length() > 2) {
//            responce += """
            //jrm type ddd time1 time2 ; ...
            //plm type ddd time1 time2 ; ...
            //jrn type date level ; ...
            //pln type date level ; ...
            //t front ; ...
            //g writingId front type ; ... / descrip
            //"""

            //            Department.findAll([sort: 'departmentCode']).each() {d ->
            //            Course.findAll([sort: 'code']).each() { c ->
            //                Writing.findAllByCourse(c, [sort: 'orderNumber']).each() {
            //                    responce += ('> ' + c.code + ' ' + c.title + ' : ' + it.orderNumber + ' ' + it.title + '   ' + it.id + " ; |> ${it.id} ; \n")
            //                }
            //            }

            Writing.findAll([sort: 'title']).each() {
                responce += ('w ' + it.title + '   ' + it.id + " ; |${it.id} ${it.title} ; \n")
            }


            Goal.findAll([sort: 'title']).each() {
                responce += ('g ' + it.title + '   ' + it.id + ' ; \n')
            }
            Task.findAll([sort: 'name']).each() {
                responce += ('t ' + it.name + '   ' + it.id + ' ; \n')
            }
            Course.findAll([sort: 'code']).each() {
                responce += ('c ' + it.code + ' ' + it.title + '\n')
            }

            JournalType.findAll([sort: 'name']).each() {
                responce += ('jt ' + it.name + ' \n')
            }
            PlannerType.findAll([sort: 'name']).each() {
                responce += ('pt ' + it.name + ' \n')
            }
            GoalType.findAll([sort: 'name']).each() {
                responce += ('gt ' + it.name + ' \n')
            }

        }

        def fresponce = ''
        if (params.q && params.q != '' && params.q.length() < 12 && params.q.length() > 2) {
            responce.eachLine() {
                if (it.toLowerCase().startsWith(params.q.toLowerCase()) ||
                        it.toLowerCase().contains(params.q.substring(2).toLowerCase()))
                    fresponce += it + '\n'
            }

        }
        render fresponce
    }
*/


    def updateTagCount() {
        Tag.list().each() { t ->
            def count = 0
            taggedClasses.each() {
                count += it.createCriteria().count() { tags { idEq(t.id) } }
            }
            t.occurrence = count
        }
        render(template: '/layouts/achtung', model: [message: 'Tag occurrence count completed'])
    }

    def tagCloud() {

//        Tag.list().each() { t ->
//            def count = 0
//            taggedClasses.each() {
//                count += it.createCriteria().count() { tags { idEq(t.id) } }
//            }
//            t.occurrence = count
//        }
        render(template: '/reports/tagCloud', model: [])
    }

    def contactCloud() {

        Tag.list().each() { t ->
            def count = 0
            taggedClasses.each() {
                count += it.createCriteria().count() { tags { idEq(t.id) } }
            }
            t.occurrence = count
        }

        render(template: '/reports/contactCloud', model: [])
    }

    def updateContactCount() {
        Contact.list().each() { t ->
            def count = 0
            taggedClasses.each() {
                count += it.createCriteria().count() { contacts { idEq(t.id) } }
            }
            t.occurrence = count
        }
        render(template: '/layouts/achtung', model: [message: 'Contact occurrence count completed'])
    }

    def executeSavedSearch(Long id) {

         if (id != null) {
             def savedSearch = SavedSearch.get(id)


             if (params.reportType != 'tab') {
                 render(template: '/gTemplates/recordSummary', model: [record: savedSearch])
                 render('<br/>')
             }


             if (savedSearch.queryType == 'random' || params.reportType == 'random') {

                 randomGet(savedSearch.query, savedSearch.summary)

             } else if (savedSearch.queryType == 'hql') {
                 //queryRecords(savedSearch.query)
                 params.max = Setting.findByNameLike('savedSearch.pagination.max.link') ? Setting.findByNameLike('savedSearch.pagination.max.link').value.toInteger() : 5


                 if (savedSearch.query?.contains('{')) {

                     def groups

                     def input = savedSearch.query.split(/ \{/)[0]

                     def groupBy = savedSearch.query.split(/ \{/)[1]

                     switch (groupBy) {
                         case 'department':
                             groups = Department.list([sort: 'code'])
                             break
                     //   case 'course':
                     //       groups = Course.list([sort: 'summary'])
                     //     break
                         case 'course':
                             groups = Course.list([sort: 'summary'])
                             break
                         case 'type':
                             if (input.contains('Goal ')) {
                                 groups = GoalType.list([sort: 'name'])
                             } else if (input.contains('Journal ')) {
                                 groups = JournalType.list([sort: 'name'])
                             } else if (input.contains('Planner ')) {
                                 groups = PlannerType.list([sort: 'name'])
                             } else if (input.contains('Journal ')) {
                                 groups = PlannerType.list([sort: 'name'])
                             } else if (input.contains('Writing ') || input.contains('IndexCard ')) {
                                 groups = WritingType.list([sort: 'name'])
                             }
                             break
                         case 'status':
                             if (input.contains('Goal ')) {
                                 groups = WorkStatus.list([sort: 'name'])
                             } else if (input.contains('Journal ')) {
                                 groups = JournalType.list([sort: 'name'])
                             } else if (input.contains('Writing ')) {
                                 groups = WritingStatus.list([sort: 'name'])
                             } else if (input.contains('IndexCard ')) {
                                 groups = WritingStatus.list([sort: 'name'])
                             } else if (input.contains('Book ')) {
                                 groups = ResourceStatus.list([sort: 'name'])
                             } else if (input.contains('Goal ') || input.contains('Task ') || input.contains('Planner ')) {
                                 groups = WorkStatus.list([sort: 'name'])
                             }
                             break
                         case 'location':
                             groups = Location.list([sort: 'name'])
                             break
                         case 'context':
                             groups = Context.list([sort: 'name'])
                             break
                         case 'goal':
                             groups = Goal.findAllByBookmarked([true], [sort: 'summary'])
                             break
                     }
                     params.max = 100


                     def list2 = Task.executeQuery(input, [], params)


                     if (params.reportType == 'tab') {
                         params.max = null
                         render(view: '/page/kanbanCrs', model: [groups: groups, groupBy: groupBy,
                                                                 title : savedSearch.summary,
                                                                 ssId  : savedSearch.id,
                                                                 items : Task.executeQuery(input, [])])
                     } else {
                         render(template: '/reports/genericGrouping', model: [groups: groups, groupBy: groupBy,
                                                                              title : savedSearch.summary,
                                                                              ssId  : savedSearch.id,
                                                                              items : list2])
                     }

                 } else {

                     /*

               if (OperationController.getPath('enable.autoselectResults') == 'yes'){
                   selectedRecords.keySet().each() {
                       session[it] = 0
                   }
                   selectedRecords = [:]
                   for (r in list) {
                       selectedRecords[r.entityCode() + r.id] = 1
                       session[r.entityCode() + r.id] = 1
                   }

               }
               */

                     if (params.reportType == 'cal')
                         render(view: '/reports/calendar', model: [
                                 id           : id,
                                 savedSearchId: id,
                                 title        : savedSearch.summary])
                     else if (params.reportType == 'tab') {
                         params.max = null
                         render(view: '/page/kanbanCrs', model: [
                                 ssId              : id,
                                 searchResultsTotal: savedSearch.countQuery ? Task.executeQuery(savedSearch.countQuery)[0] : '',
                                 totalHits         : savedSearch.countQuery ? Task.executeQuery(savedSearch.countQuery)[0] : '',
                                 list              : Task.executeQuery(savedSearch.query, []),
                                 title             : savedSearch.summary + (savedSearch.countQuery ? ' (' + Task.executeQuery(savedSearch.countQuery)[0] + ')' : '')]
                         )
                     } else {
                         def list = Task.executeQuery(savedSearch.query, [], params)

                         render(template: '/gTemplates/recordListing', model: [
                                 ssId              : id,
                                 searchResultsTotal: savedSearch.countQuery ? Task.executeQuery(savedSearch.countQuery)[0] : '',
                                 totalHits         : savedSearch.countQuery ? Task.executeQuery(savedSearch.countQuery)[0] : '',
                                 list              : list,
                                 title             : savedSearch.summary
                         ])
                     }
                 }

                 //  + (! savedSearch.query.contains('select') ? '(' + Task.executeQuery('select count(*) ' +  savedSearch.query)[0] + ')' : '') + ' : ' +  savedSearch.query

//            render(template: '/gTemplates/recordListing', model: [
//                    list: Task.executeQuery(savedSearch.query, [max: 100]),
//                    title: savedSearch.summary + " (" + savedSearch.query + ")"
//            ])
             } else if (savedSearch.queryType == 'lucene') {
                 render(template: '/gTemplates/recordListing', model: [
                         list : searchableService.search(savedSearch.query, [max: 100]),
                         title: savedSearch.summary + " (" + savedSearch.query + ")"])
             } else if (savedSearch.queryType == 'adhoc') {
                 render(template: '/reports/adHocQueryResults', model: [
                         list : mcs.Task.executeQuery(savedSearch.query),
                         ssId : savedSearch.id,
                         title: '' + savedSearch.summary + " (" + savedSearch.query + ")"
                 ])
             } else
                 render(template: '/layouts/achtung', model: [message: 'Unknown query type'])
         }
        else {
             render(template: '/layouts/achtung', model: [message: 'Saved search not found.'])
         }
    }

    def showCalendar() {
        def ss = SavedSearch.get(params.id)
        if (ss.calendarEnabled) {
            render(view: '/reports/calendar', model: [
                    id           : ss.id,
                    savedSearchId: ss.id,
                    title        : ss.summary])
        } else render 'Calendar is not enabled for this saved search.'
    }

    def fixedFarsiArabic() {

        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
// TODO: fix 
        if (record.description) {
            record.description = record.description?.replace(' وَ ', ' وَ')?.replaceAll(/\nوَ /, ' وَ')
                    .replaceAll(/\nوَ /, ' وَ')
                    .replaceAll(/^و /, ' و')
                    .replace(/^وَ /, '\n وَ').replace(' و ', ' و').replace('ی', 'ي').replace('ک', 'ك')
            record.save(flush: true)
            render(record.description.replace('\n', '<br/>'))
        }
        if (record.notes) {
            record.notes = record.notes?.replace(' وَ ', ' وَ')?.replaceAll(/\nوَ /, ' وَ')
                    .replaceAll(/\nوَ /, ' وَ')
                    .replaceAll(/^و /, 'و')
                    .replaceAll(/\nو /, '\nو')
                    .replace(/^وَ /, '\n وَ').replace(' و ', ' و').replace('ی', 'ي').replace('ک', 'ك')
            record.save(flush: true)
            render(record.notes.replace('\n', '<br/>'))
        }
        if (record.class.declaredFields.name.contains('fullText') && record.fullText) {
            record.fullText = record.fullText?.replace(' وَ ', ' وَ')?.replaceAll(/\nوَ /, ' وَ')
                    .replaceAll(/\nوَ /, ' وَ')
                    .replaceAll(/^و /, ' و')
                    .replace(/^وَ /, '\n وَ').replace(' و ', ' و').replace('ی', 'ي').replace('ک', 'ك')
            record.save(flush: true)
            render(record.fullText.replace('\n', '<br/>'))
        }

//        println record.hasErrors()

    }

    def publish() {

        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        def tags = ''
        record.tags.each() {
            if (!it.bookmarked)
                tags += it.name + ','
        }
//        println 'tags: ' + tags + '.'
        def categories = ''
        record.tags.each() {
            if (it.bookmarked == true)
                categories += it.name + ','
        }

        String summary, contents, type

        switch (params.entityCode) {
            case 'W': summary = record.summary
                contents = //ys.wikiparser.WikiParser.renderXHTML(record.description)?.decodeHTML()
                        (record.language == 'ar' ? ('<div style="direction: rtl; text-align: right">' + record.descriptionHTML + '</div>') : record.descriptionHTML)
                //fix markdown??
                type = record.type?.name
                break
            case 'N': summary = record.summary
                contents = (record.language == 'ar' ? ('<div style="direction: rtl; text-align: right">' + record.descriptionHTML + '</div>') : record.descriptionHTML)
                //record.description//?.encodeAsHTML()
                type = record.type?.name
                break
            case 'J': summary = record.summary
                contents = record.description//ys.wikiparser.WikiParser.renderXHTML(record.description)?.decodeHTML()
                //record.description//?.encodeAsHTML()
                type = record.type?.name
                break
        }

        // postToBlog(String blogId, String title, String categoriesString, String tags, String fullText) {
        int r = supportService.postToBlog(record.blog.id, record.code ?: record.id?.toString(), summary, categories, tags,
                contents, record.shortDescription, params.entityCode, record.publishedNodeId)


        if (r) {
            record.publishedNodeId = r
            record.publishedOn = new Date()
            record.status = WritingStatus.findByCode('pub')
            record.save(flush: true)
            render 'Published with id : ' + r + ' class ' + r.class
            render(template: '/layouts/achtung', model: [message: "Record published with id " + r])
        } else "Problem posting the record"

    }


    def recentRecords() {

        def recentRecords = []
        allClassesWithCourses.each() {
            recentRecords += it.findAllByDateCreatedLessThanAndDateCreatedGreaterThan(new Date() + 1, new Date() - 7, [sort: 'dateCreated', order: 'desc', max: 4])
            //    recentRecords += it.findAllByLastUpdatedGreaterThan(new Date() - 7, [max: 7])
        }

        recentRecords = recentRecords.sort({ it.dateCreated }).reverse()
        //recentRecords.unique()
        if (recentRecords.size() > 0)
            render(template: '/gTemplates/recordListing', model: [
                    title: 'Recent records',
                    list : recentRecords
            ])
        else
            render(template: '/layouts/message', model: [messageCode: 'help.recent.records.no'])


    }
  def todaysRecords() {

        def recentRecords = []

        allClassesWithCourses.each() {
            recentRecords += it.executeQuery('from ' + it.name + ' where date(dateCreated) = date(?)', [new Date()])
            //    recentRecords += it.findAllByLastUpdatedGreaterThan(new Date() - 7, [max: 7])
        }

        recentRecords = recentRecords.sort({ it.dateCreated }).reverse()
        //recentRecords.unique()
        if (recentRecords.size() > 0)
            render(template: '/gTemplates/recordListing', model: [
                    title: "Today's records",
                    list : recentRecords
            ])
        else
            render(template: '/layouts/message', model: [messageCode: 'help.recent.records.no'])


    }

    def countRecentRecords() {

        def recentRecords = []

        allClassesWithCourses.each() {
            recentRecords += it.findAllByDateCreatedLessThanAndDateCreatedGreaterThan(new Date() + 1, new Date() - 7, [sort: 'dateCreated', order: 'desc', max: 4])
            //    recentRecords += it.findAllByLastUpdatedGreaterThan(new Date() - 7, [max: 7])
        }
        render recentRecords.size()
    }

    static long countRecentRecordsStatic() {

        def recentRecords = []

        allClassesWithCourses.each() {
            recentRecords += it.findAllByDateCreatedLessThanAndDateCreatedGreaterThan(new Date() + 1, new Date() - 7, [sort: 'dateCreated', order: 'desc', max: 4])
            //    recentRecords += it.findAllByLastUpdatedGreaterThan(new Date() - 7, [max: 7])
        }
        return recentRecords.size()
    }

    def logicallyDeletedRecords() {

        def recentRecords = []

        allClasses.each() {
            recentRecords += it.findAllByDeletedOnIsNotNull([sort: 'lastUpdated', order: 'desc'])
        }

        render(template: '/gTemplates/recordListing', model: [
                title: 'Logically deleted records',
                list : recentRecords
        ])
    }

    def physicallyDeleteRecords() {

        def recentRecords = []

        allClasses.each() {
            recentRecords += it.findAllByDeletedOnIsNotNull()
        }

        def c = 0
        def d = 0
        for (r in recentRecords) {
            try {
                r.delete()
//                if ('N' == r.entityCode()) {
//                    def file = new File((OperationController.getPath('attachments.repository.path') ?: null) + '/' + r.id)
//
//                    if (file?.exists())
//                        file?.delete()
//                }
                c++
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                d++
            }
        }

        render(template: '/layouts/achtung', model: [
                message: c + ' records were deleted, ' + d + ' not deleted'
        ])
    }

    def convertDate(String input) {
        if (input.length() == 10) {
//            try {
            render supportService.toWeekDate(Date.parse("dd.MM.yyyy", input))
//            } catch (Exception e) {
//                render 'A problem has occurred: ' + e.toString()
//            }
        } else {
//            try {
            render supportService.fromWeekDate(input)
//            }
//            catch (Exception e) {
//                render  'A problem has occurred: ' + e.toString()
//            }

        }
    }

    def appendToScratch(String input) {
//     ToDo
        def record = IndexCard.executeQuery('from IndexCard i where i.summary = ? order by dateCreated desc', ['Quick Drafts'])[0]
        if (!record)
            record = new IndexCard([summary: 'Quick Drafts', language: 'en']).save()

        def date = new Date()?.format('EEE dd.MM.yyyy HH:mm')
        if (!record.description)
            record.description = (date + ':\n' + input)
        else
            record.description += ('\n\n' + date + ':\n' + input)

        render(template: '/gTemplates/recordSummary', model: [record: record])

    }

    def fetchAya(String input) {

        render(template: '/gTemplates/recordListing', model: [list:
                                                                      IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ? and orderInWriting >= ? and orderInWriting <= ?',
                                                                              [Writing.findByOrderInBookAndType(input.split(' ')[0], mcs.parameters.WritingType.get(77)).id.toString(),
                                                                               'W',
                                                                               input.split(' ')[1].toInteger() - 2, input.split(' ')[1].toInteger() + 2
                                                                              ]
                                                                      )
        ]
        )

    }

    def updateAyat(String input) {

        def ayat = input.split(' ')[2..input.split(' ').size() - 1]

        def list = []

        ayat.each() {
            list += IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ? and orderInWriting = ?',
                    [Writing.findByOrderInBookAndType(input.split(' ')[0], mcs.parameters.WritingType.get(77)).id.toString(),
                     'W',
                     it.toInteger()
                    ]
            )[0]
        }

        def priority = input.split(' ')[1].toInteger()

        list.each() {
            it.priority = priority
        }


        render(template: '/reports/ayatReport', model: [list: list])
        render(template: '/gTemplates/recordListing', model: [list: list])

    }

    def updateAyatHeads(String input) {
        println 'input ' + input
        try {
            def ayat = input.split(' ')[1..input.split(' ').size() - 1]
//
//           IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ?',
//                   [Writing.findByOrderInBookAndType(input.split(' ')[0], mcs.parameters.WritingType.get(77)).id.toString(),
//                    'W'
//                   ]
//           ).each() {
//               it.isNewSection = false
//           }

            def list = []

            ayat.each() {
                list += IndexCard.executeQuery('from IndexCard where recordId = ? and entityCode = ? and orderInWriting = ?',
                        [Writing.findByOrderInBookAndType(input.split(' ')[0], mcs.parameters.WritingType.get(77)).id.toString(),
                         'W',
                         it.toInteger()
                        ]
                )[0]
            }

            list.each() {
//               println 'now on ' + it.orderInWriting
                it.isNewSection = true
            }

            render(template: '/reports/ayatReport', model: [list: list])
        } catch (Exception e) {
            e.printStackTrace()
            render e
        }
        //render(template: '/gTemplates/recordListing', model: [list: list])

    }

    def tagReport() {

        def tag = Tag.get(params.id)
        def list = []

        taggedClasses.each() {
            list += it.createCriteria().list() { tags { idEq(params.id.toLong()) } }
        }
        render(template: '/gTemplates/recordSummary', model: [record: tag])
        render(template: '/gTemplates/recordListing', model: [list: list, title: 'Tag: ' + tag.name])
    }

    def contactReport() {

        def list = [Contact.get(params.id)]

        taggedClasses.each() {
            list += it.createCriteria().list() { contacts { idEq(params.id.toLong()) } }
        }
        render(template: '/gTemplates/recordListing', model: [list: list, title: 'Contact: ' + Contact.get(params.id).summary])
    }


    def quickEdit = {
        render(template: '/forms/quickEdit', model:
                [id   : params.id, entityCode: params.entityCode,
                 field: params.field, valueId: params.valueId, updateDiv: params.updateDiv])
    }

    def quickSave = {
        def id, entityCode, field, valueId
        def values = params.id.split('-')
        id = values[0].toLong()
        entityCode = values[1]
        field = values[2]
        valueId = values[3]//.toLong()

        def record = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)
        if (field == 'department') {
            def department = Department.get(valueId)
            record.department = department
            render 'd' + department.code

        }

        if (field == 'course') {
            def course = Course.get(valueId)
            record.course = course
            render 'N' + course.code

        }


        if (field == 'resourceStatus') {
            def status = ResourceStatus.get(valueId)
            record.status = status
            render '?' + status.code
        }
        if (field == 'workStatus') {
            def status = WorkStatus.get(valueId)
            record.status = status
            render '?' + status.code
        }
        if (field == 'writingStatus') {
            def status = WritingStatus.get(valueId)
            record.status = status
            render '?' + status.code
        }

        if (field == 'plannerType') {
            def type = PlannerType.get(valueId.toLong())
            record.type = type
            render '#' + type.code
        }
        if (field == 'journalType') {
            def type = JournalType.get(valueId.toLong())
            record.type = type
            render '#' + type.code
        }
        if (field == 'writingType') {
            def type = WritingType.get(valueId.toLong())
            record.type = type
            render '#' + type.code
        }
        if (field == 'goalType') {
            def type = GoalType.get(valueId.toLong())
            record.type = type
            render '#' + type.code
        }
        if (field == 'taskLocation') {
            def location = Location.get(valueId.toLong())
            record.location = location
            render location.code
        }

        if (field == 'priority') {
            record.priority = valueId.toInteger()
            render valueId
        }

        if (field == 'percentCompleted') {
            record.percentCompleted = valueId.toInteger()
            render valueId
        }
        if (field == 'plannedDuration') {
            record.plannedDuration = valueId.toInteger()
            render(valueId + "''")
        }

        if (field == 'blog') {
            if (valueId != 'null') {
                def b = Blog.get(valueId)
                record.blog = b
                record.publishedNodeId = null
                render "" + b.code
            } else {
                record.blog = null
                render ''
            }

        }
        if (field == 'pomegranate') {
            if (valueId != 'null') {
                def b = Pomegranate.get(valueId)
                record.pomegranate = b
                render "" + b.code
            } else {
                record.pomegranate = null
                render ''
            }

        }

    }

    def commandNotes() {
        def r = [
                'prefix': CommandPrefix.get(params.q)?.description,
                'isForEachLine': CommandPrefix.get(params.q)?.multiLine,

                'info'  : CommandPrefix.get(params.q)?.notes?.replaceAll(/\?date/, ker.OperationController.toWeekDate(new Date() - 1))]

        render(r as JSON)
    }


    def fetchIsbnInfo(String line) {

        def isbn
        try {
            java.util.regex.Matcher matcher = line =~ /(\d{13}|\d{12}X|\d{12}x|\d{9}X|\d{9}x|\d{10})[^\d]*/
            // todo: fix it to be exact match, anythwere in the filename
            isbn = matcher[0][1]

            def b = Book.findByIsbn(isbn)
            if (isbn && b)
                render 'Dup ' + b.id
            else if (isbn)
                render isbn
            else '-'

        }
        catch (Exception e) {

            render '-'
        }


    }

    def verifySmartFileName(String line) {

        def properties
        try {
            properties = transformMcsNotation(line)['properties']

            def n = grailsApplication.classLoader.loadClass(entityMapping[line.split(' ')[0].toUpperCase()]).newInstance()

            if (!properties) {
                render("error")

            } else {
                n.properties = properties


                if (!n.validate()) {

                    render('error')
//                    println('record has error')
                } else render("correct")
            }


        } catch (Exception e) {
            render("error")
            //    e.printStackTrace()
            //return
        }
        //render("correct")


    }

    String verifySmartCommand(String line) {
        def properties
//println 'line ' + line
        try {
            if (line.length() > 2) {
                properties = transformMcsNotation(line.substring(2))['properties']
//                println 'ine' + line.substring(2)
                def n = grailsApplication.classLoader.loadClass(entityMapping[line.substring(2).split(' ')[0].toUpperCase()]).newInstance()

                if (properties) {
//                    render("wrongCommand")
//                } else {
                    n.properties = properties
                    if (!n.validate()) {
                        render ('wrongCommand')
                        return ('wrongCommand')
                    println('record has error')
                    } else
                        render ("correctCommand")
                        return ("correctCommand")
                    println('record has no error')
                }
            } else {
                render ''
            }
        } catch (Exception e) {
	 // todo : command line bar needs a render result! as it used javascript!
            render("wrongCommand")
            return("wrongCommand")
            //    e.printStackTrace()
            //return
        }
        //render("correct")
    }



    def viewRecordImage() {


        def f
//		def f2
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)


        f = new File(OperationController.getPath('module.sandbox.' + record.entityCode() + '.path') + '/' + record.id + record.entityCode().toLowerCase() + '.jpg')

//		f2 = new File(OperationController.getPath('module.sandbox.' + record.entityCode() + '.path') + '/' + record.id + 'n.jpg')


        if (f?.exists()) {
            byte[] image = f.readBytes()
            response.outputStream << image
        }
//		else if (f2?.exists()) {
//            byte[] image = f2.readBytes()
//            response.outputStream << image
//        }
        //  else println 'cover not there for book ' + params.id

    }


    def setPageMax() {
        def d = Setting.findByNameLike('savedSearch.pagination.max.link')
        if (d)
            d.value = params.id
        else
            new Setting([name: 'savedSearch.pagination.max.link', value: params.id]).save(flush: true)
        render ''//rps -> ' + params.id
    }


    def fetchCoursesForDepartment = {
        def parentArray = [:]
        if (params['department.id'] && params['department.id'] != 'null' && params['department.id'] != '0' && params['department.id'] != '') {
            Course.findAllByDepartment(Department.get(params['department.id'].toLong())).each() {
                parentArray[it.id] = it.toString()
            }
        }
        render parentArray as JSON

    }

    def fetchWritingsForCourse() {
        def parentArray = [:]
        if (params['course.id'] && params['course.id'] != 'null' && params['course.id'] != '0' && params['course.id'] != '') {
            Writing.findAllByCourse(Course.get(params['course.id'].toLong()), [sort: 'orderNumber', order: 'asc']).each() {
                parentArray[it.id] = it.toString()

            }
        }
        render parentArray as JSON

    }

    def showFullDescription() {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        render(template: '/gTemplates/fullDescription', model: [record: record])
    }

    def showAnswer() {
        def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)

        render(template: '/gTemplates/fullDescription', model: [record: record])
    }
/**
 def convertMarkupToHtml() {def record = grailsApplication.classLoader.loadClass(entityMapping[params.entityCode]).get(params.id)
 StringWriter writer = new StringWriter()
 HtmlDocumentBuilder builder = new HtmlDocumentBuilder(writer)
 MarkupParser mp = new MarkupParser()
 mp.setMarkupLanguage(new MarkdownLanguage())
 //        MarkupParser mp = new MarkupParser(ServiceLocator.getInstance().getMarkupLanguage('Textile'), builder)
 render mp.parseToHtml(record?.description)
 // render writer.toString()
 //        render ys.wikiparser.WikiParser.renderXHTML(record.description)?.decodeHTML()}*/




    def checkoutRecordText(Long id, String entityCode) {

        def r = grailsApplication.classLoader.loadClass(entityMapping[entityCode]).get(id)

        def filename = r?.summary ? r?.summary?.replace('\n', ' - ')?.trim() : 'Untitled'
        for (c in '?"/\\*:<>' + '!$^&{}|') {
            filename = filename.replace(c, ' ')
        }
        def f
        if (r.entityCode() == 'W') {
            f = new File(OperationController.getPath('editBox.path') + '/' +
                    r.entityCode() + '-' + r.id + '.txt') // + ' ' + filename
        } else if (r.entityCode() == 'N') {
            f = new File(OperationController.getPath('editBox.path') + '/N-' +
                    r.id + '.txt') // + ' ' + filename
        }
        // + ' ' + filename

//        if (r.entityCode() == 'W') {
//            java.util.regex.Matcher matcher = r.description =~ /\}\{([\S\_-]*)\}/
//            def book
//            matcher.eachWithIndex() { match, i ->
//                book = mcs.Book.findByCode(match[1])
//                if (book) {
//                    authors += book.authorInBib + '<br/>'
//                    println r.description.replace('{' + match[1] + '}', '{' + book.authorInBib + '}')
//                }
//                else authors += ('Author not found: ' + match[1] + '<br/>')
//            }
//        }

//        def f2 = new File(OperationController.getPath('editBox.path') + '/' +
//                r.entityCode() + '/' + r.id + '.out') // + ' ' + filename
        if (!f.exists()) {
            f.write(r?.description ?: '...', 'UTF-8')
//            f2.write(r?.description ?: '...', 'UTF-8')
            render('Text checked out')
        } else render 'File already checkout.'


    }


    def commitTextChanges() {

        def f = new File(OperationController.getPath('root.rps1.path') + '/edit/' + params.name)
        def r
        if (params.entityCode == 'W'){
        r = Writing.get(params.id.replace('.md', '').toLong())//.replace('W-', ''))
    r.description = (f.text != '' ? f.text : '...')
    if (r.description == f.text)
    f.delete()
    }
        else if (params.entityCode == 'N') {
    r = IndexCard.get(params.id.replace('.md', '').toLong())
    r.description = (f.text != '' ? f.text : '...')
    if (r.description == f.text)
        f.delete()

}
 else if (params.entityCode == 'R') {
    r = Book.get(params.id.replace('.md', '').toLong())
    r.fullText = (f.text != '' ? f.text : '...')
            if (r.fullText == f.text)
                f.delete()


}


if (1 == 2) {
    def htmlFile = new File(OperationController.getPath('root.rps1.path') + '/edit/' + params.name.replace('.md', '.md.html'))

    def command = "D:\\app\\pandoc281\\pandoc -f markdown --metadata rtl=true -i r:/W/W-${r.id}.md -o r:/W/W-${r.id}.md.html"
//        println 'cmd: ' + command
    try {
        println 'command: ' + command
        println 'exit: ' + command.execute().exitValue()

        println 'out: ' + command.execute().outputStream
        println 'err: ' + command.execute().errorStream
        render 'done'
    } catch (Exception e) {
        println e.toString()
        render 'error pandoc...'
    }

    sleep(2000) // wait for pandoc to finish converting the document

    if (htmlFile.exists()) {
//            println 'here !!! exists... '
        r.descriptionHTML = htmlFile.text
        htmlFile.delete()
    }
}
//         if contents is correctly set in database, delete file to declutter the editing folder

        // changes to DB after file editing
        //r.description = r.description?.replace('< ', '«')?.replace(' >', '»')

        if (!r.firstReviewed)
            r.firstReviewed = new Date()

//           if (!r.firstReviewed)
//                r.firstReviewed = new Date()

        r.lastReviewed = new Date()

//        if (params.entityCode == 'N' || params.entityCode == 'W')
//        r.status = WritingStatus.findByCode('repub')

        if (!r.reviewCount)
            r.reviewCount = 1
        else
            r.reviewCount++

//        def f2 = new File(OperationController.getPath('editBox.path') + '/' +
//                params.entityCode + '-' + params.id + '-' + r.course.code + '/chapters.md') // + ' ' + filename
//        f2.write(f?.text ?: '...', 'UTF-8')

        render(template: '/gTemplates/recordSummary', model: [record: r])
        render(template: '/layouts/achtung', model: [message: "Changes saved to database and files deleted."])
    }
//TODO: remove
//    def sajaList() {
//        def list = Book.createCriteria().list() { tags { idEq(new Long(437)) } }
//        println list.dump()
//        render(view: '/page/kanbanCrs', model: [
//                searchResultsTotal: list.size(),
//                totalHits         : list.size(),
//                list              : list,
//                title             : "Saja's Files"]
//        )
//    }

    def selectionSize() {
        def c = 0
        selectedRecords.each() {
            if (it.value == 1)
                c++
        }
        return c
    }


}
