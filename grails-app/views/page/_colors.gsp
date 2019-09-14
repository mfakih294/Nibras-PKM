<table>
    <thead style="font-weight: bold">
        <th>Color code</th>
        <th>Text color: White</th>

        <th>Text color: Gray</th>
        <th>Text color: Black</th>
    </thead>

%{--
  - Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
  -
  - This program is free software: you can redistribute it and/or modify
  - it under the terms of the GNU General Public License as published by
  - the Free Software Foundation, either version 3 of the License, or
  - (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  - GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License
  - along with this program.  If not, see <http://www.gnu.org/licenses/>
  --}%

<g:each in="${colors.readLines()}" var="c">
             <tr>
                 <td>${c.split(';')[1]}</td>
                 <td style="color: white; background: ${c.split(';')[1]}">${c.split(';')[0]}</td>

                 <td style="color: gray; background: ${c.split(';')[1]}">${c.split(';')[0]}</td>
                 <td style="color: black; background: ${c.split(';')[1]}">${c.split(';')[0]}</td>
             </tr>
    </g:each>



</table>

<br/><br/>

Source of colors and names: http://www.computerhope.com/htmcolor.htm

<br/><br/>