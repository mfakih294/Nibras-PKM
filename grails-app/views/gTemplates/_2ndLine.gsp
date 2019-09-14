<%@ page import="ker.OperationController; mcs.Writing; mcs.Book; cmn.Setting; org.apache.commons.lang.StringEscapeUtils; app.Payment; app.IndicatorData; app.IndexCard; mcs.Excerpt; java.text.DecimalFormat; mcs.parameters.WorkStatus; mcs.Goal; mcs.parameters.JournalType; mcs.Journal; mcs.Planner; mcs.Task" %>


<div class="recordContainer"
	 style="background: #f2f2f2; opacity: 0.6; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2); padding: 3px;  margin-top: 0px; border-radius: 2px; margin-bottom: 1px;">

	<table class="fixed-layout">
		<tr class="secondLine">


			<td style="width: 60% !important;">

				<g:remoteLink controller="generics" action="showSummary"
							  params="${[id: record.id, entityCode: entityCode]}"
							  update="${entityCode}Record${record.id}"
							  title="ID ${record.id}. Click to refresh">


					<g:if test="${record.class.declaredFields.name.contains('department')}">

						<g:set value="department" var="field"></g:set>

						<a href="#" id="${field}${record.id}" class="${field}" data-type="select"
						   data-value="${record[field]?.id}"
						   data-name="${field}-${entityCode}"
						   style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 10px; font-style: italic; padding-left: 1px; padding-right: 1px;"
						   data-source="/nibras/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
						   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
							${record[field] ? record[field]?.code : 'No dept.'}
						</a>
						<script type="text/javascript">
							jQuery("#${field}${record.id}").editable();
						</script>

						<script type="text/javascript">
							%{--jQuery("#${field}${recordId}").editable()--}%
							//				{
							//            typeahead: {
							//                name: 'value'
							//            }
							//                });
						</script>

					</g:if>
					&nbsp;

			</g:remoteLink>

			<g:if test="${record.class.declaredFields.name.contains('type')}">
			<g:set value="type" var="field"></g:set>

			<a href="#" id="2${field}${record.id}" class="${field}" data-type="select"
			   data-value="${record.type?.id}"
			   data-name="${field}-${entityCode}"
			   style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 10px; font-style: bold; padding-left: 1px; padding-right: 1px;"

			   data-source="/nibras/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
			   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
				${record.type?.code}
			</a>

			<script type="text/javascript">
				jQuery("#2${field}${record.id}").editable();
			</script>
			</g:if>

				<g:if test="${record.class.declaredFields.name.contains('status')}">
					&nbsp;
					 &nbsp;


					<g:set value="status" var="field"></g:set>

					<a href="#" id="${field}${record.id}" class="${field}" data-type="select"
					   data-value="${record[field]?.id}"
					   data-name="${field}-${entityCode}"
					   class="${record.class.declaredFields.name.contains('status') && record.status ? 'status-' + record?.status?.code : ''}"
					   style="${record.status ? record.status?.style : ''}; border: 0.5px solid #808080; border-radius: 3px; font-size: 10px; font-style: italic; padding-left: 1px; padding-right: 1px;"
					   data-source="/nibras/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
					   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
						${record[field] ? record[field]?.code : 'No status'}
					</a>
					<script type="text/javascript">
						jQuery("#${field}${record.id}").editable();
					</script>

				</g:if>


			<g:if test="${entityCode == 'N'}">

				&nbsp;
				 &nbsp;

				<g:set value="writing" var="field"></g:set>

				<a href="#" id="2${field}${record.id}" class="${field}" data-type="select"
				   data-value="${record.recordId ?: null}"
				   data-name="${field}-${entityCode}"
				   style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 10px; font-style: italic; padding-left: 1px; padding-right: 1px;"
				   data-source="/nibras/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
				   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
					${record.recordId ? Writing.get(record.recordId): 'No wrt'}
				</a>
				<script type="text/javascript">
					jQuery("#2${field}${record.id}").editable();
				</script>

			</g:if>



				<g:if test="${record.class.declaredFields.name.contains('course')}">

					&nbsp;
					 &nbsp;

					<g:set value="course" var="field"></g:set>

					<a href="#" id="${field}${record.id}" class="${field}" data-type="select"
					   data-value="${record[field]?.id}"
					   data-name="${field}-${entityCode}"
					   style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 10px; font-style: italic; padding-left: 1px; padding-right: 1px;"
					   data-source="/nibras/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
					   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
						${record[field] ? record[field] : 'No course'}
					</a>
					<script type="text/javascript">
						jQuery("#${field}${record.id}").editable();
					</script>
			</g:if>



				<span id="actionsButtons2${record.id}"
					  class="temp442 actionsButtons hiddenActions"
					  style="font-size: 9px !important; color: #4A5C69;">



				</span>

				<g:if test="${'E'.contains(entityCode)}">
					<b style="font-family: Courier">${record.book?.course?.code}</b>
				</g:if>

				<g:if test="${entityCode == 'Q'}">
					${record?.category?.code}
				</g:if>


				<g:if test="${entityCode == 'T'}">


					&nbsp;
					<g:set value="context" var="field"></g:set>

					<a href="#" id="${field}${record.id}" class="${field}" data-type="select"
					   data-value="${record[field]?.id}"
					   data-name="${field}-${record.entityCode()}"
					   data-source="/nibras/operation/getQuickEditValues?entity=${record.entityCode()}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
					   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
						${record[field]?.code ?: 'No context'}
					</a>
					<script>
						jQuery("#${field}${record.id}").editable();
					</script>



					&nbsp;
					&nbsp;
				</g:if>

				<g:if test="${record.class.declaredFields.name.contains('plannedDuration') && record.plannedDuration}">
					&nbsp;
					<g:set value="plannedDuration" var="field"></g:set>

					<a href="#" id="${field}${recordId}" class="${field}" data-type="select"
					   data-value="${record[field] ?: 0}"
					   data-name="${field}-${record.entityCode()}"
					   data-source="/nibras/operation/getQuickEditValues?entity=${record.entityCode()}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
					   data-pk="${record.id}" data-url="/nibras/operation/quickSave2" data-title="Edit ${field}">
						+${record[field] ?: ''}
					</a>
					<script>
						%{--jQuery('#${field}${recordId}').editable();--}%
					</script>

				</g:if>



				<g:if test="${entityCode == 'I'}">
					${record.indicator?.code}
				</g:if>

				<g:if test="${entityCode == 'Q'}">

				</g:if>

						<g:if test="${entityCode == 'Q'}">
					${record.amount}
				</g:if>

				<g:if test="${entityCode == 'I'}">
					<g:formatNumber number="${record.value}" format="#,###"/>
				</g:if>


				<g:if test="${entityCode == 'N'}">

					<g:if test="${record.recordId}">

						<g:remoteLink controller="generics" action="showSummary" id="${record.recordId}"
									  params="[entityCode: record.entityCode]"
									  update="below${entityCode}Record${record.id}"
									  title="Go to parent record">
							<span class="ui-icon-arrow-2-e-w"></span>
						</g:remoteLink>

					</g:if>
				</g:if>




				<g:if test="${'CGR'.contains(entityCode)}">

				</g:if>

			</td>

			<td class="record-date" style="text-align: right; width: 250px;">

				<g:if test="${record.class.declaredFields.name.contains('writtenOn') && record.writtenOn}">

					<span style="font-size: 11px; font-weight: bold;  padding-right: 4px;"
						  title="${record.writtenOn?.format(OperationController.getPath('datetime.format'))}">
						<g:if test="${record.class.declaredFields.name.contains('approximateDate') && record.approximateDate}">
							~
						</g:if>

						%{--${record.writtenOn?.format(OperationController.getPath('date.format'))}--}%
						w<pkm:weekDate date="${record?.writtenOn}"/>
					</span>
				</g:if>



				<g:remoteLink controller="generics" action="showDetails"
							  params="${[id: record.id, entityCode: entityCode]}"
							  update="below${entityCode}Record${record.id}"
							  title="Created ${record?.dateCreated?.format('dd.MM.yyyy')}">

					<g:if test="${record.class.declaredFields.name.contains('completedOn') && record.completedOn}">
						<span title="${record.completedOn?.format(OperationController.getPath('datetime.format'))}"
							  style="font-size: 10px; font-style: italic;">

							c<pkm:weekDate date="${record?.completedOn}"/>
						</span>
					</g:if>


					<g:if test="${'R'.contains(entityCode)}">
						<g:if test="${record.publishedOn}">
							p<pkm:weekDate date="${record?.publishedOn}"/>
						</g:if>
					</g:if>


				<g:if test="${record.class.declaredFields.name.contains('startDate') && record.startDate}">

						<span title="s${record.startDate?.format(OperationController.getPath('datetime.format'))} e${record.endDate?.format(OperationController.getPath('datetime.format'))}">


						<g:if test="${'JP'.contains(entityCode)}">

							<g:if test="${record.level != 'd'}">
							%{--<div style="display: inline; padding: 2px; margin: 3px;" class="record-level level${record.level}"--}%
							%{--title="Level">--}%
								${record.level}<sup>l</sup>
							%{--</div>--}%

							</g:if>


							<g:if test="${record.level == 'm'}">

								<span class="hour">${record.startDate?.format('HH')}</span>
								_<span class="hour">${record.endDate?.format('HH')}</span>
								_<pkm:weekDate date="${record?.startDate}"/>

							</g:if>
							<g:elseif test="${record.level == 'r'}">
								s<pkm:weekDate date="${record?.startDate}"/>
								e<pkm:weekDate date="${record?.endDate}"/>
							</g:elseif>
							<g:else>
								s<pkm:weekDate date="${record?.startDate}"/>
							</g:else>

							</span>

						</g:if>
						<g:else>

							<span title="${record.startDate?.format(OperationController.getPath('datetime.format'))}">
								s<pkm:weekDate date="${record?.startDate}"/>
							</span>
						</g:else>
					</g:if>

					<g:if test="${record.class.declaredFields.name.contains('endDate') && !record.startDate && record.endDate}">
						<g:if test="${'T'.contains(entityCode)}">
							<span class="${ record.endDate < new Date() && record.completedOn == null ? 'overDueDate' : ''}" title="s${record.endDate?.format(OperationController.getPath('datetime.format'))}">
								e<pkm:weekDate date="${record?.endDate}"/>
							</span>
							</g:if>
						<g:else>
						<span title="s${record.endDate?.format(OperationController.getPath('datetime.format'))}">
								e<pkm:weekDate date="${record?.endDate}"/>
						</span>
						</g:else>
					</g:if>



					<g:if test="${'I'.contains(entityCode)}">
						<pkm:weekDate date="${record?.date}"/>
					</g:if>
					<g:elseif test="${'Q'.contains(entityCode)}">
						<pkm:weekDate date="${record?.date}"/>
					</g:elseif>

				%{--<g:else>--}%
				 %{--<i><prettytime:display date="${record?.dateCreated}"></prettytime:display></i>--}%
				%{--<pkm:weekDate date="${record?.dateCreated}"/>--}%
				%{----}%
				%{--</g:else>--}%
				</g:remoteLink>
			</td>



			<td class="record-selection">

				%{--onchange="jQuery('#logRegion').load('/nibras/generics/select/${entityCode}${record.id}')"--}%
				<g:checkBox name="select-${record.id}-${entityCode}" title="Select record"
							value="${session[entityCode + record.id] == 1}"

							onclick="jQuery('#logRegion').load('/nibras/generics/select/${entityCode}${record.id}')"/>
				<!--a style="width: 10px; color: #000000"
           onclick="jQuery('#below${entityCode}Record${record.id}').html('')">&chi;</a-->

			</td>



			<td class="actionTd">

				<g:if test="${record.class.declaredFields.name.contains('bookmarked')}">
					<g:if test="${!record.bookmarked}">
						<a name="bookmark${record.id}${entityCode}" title="Toggle bookmark"
						   value="${record.bookmarked}"
						   onclick="jQuery('#${entityCode}Record${record.id}').load('/nibras/generics/quickBookmark/${entityCode}-${record.id}')">
							<span class="icon-star-gm"></span>
						</a>
					</g:if>

					<g:if test="${record.bookmarked}">
						<a name="bookmark${record.id}${entityCode}" title="Toggle bookmark"
						   value="${record.bookmarked}"
						   onclick="jQuery('#${entityCode}Record${record.id}').load('/nibras/generics/quickBookmark/${entityCode}-${record.id}')">
							<span class="icon-starred-gm"></span>
						</a>

					</g:if>
				</g:if>

			</td>



			%{--<td class="record-statistics">--}%
			%{--<span title="Statistics">--}%

			%{--<g:if test="${params.action != 'luceneSearch'}">--}%
			%{--<g:if test="${entityCode == 'G'}">--}%
			%{--${Planner.countByGoal(record)} <sup>P</sup>--}%

			%{--${Task.countByGoal(record)} <sup>T</sup>--}%

			%{--</g:if>--}%



			%{--<g:if test="${entityCode == 'T'}">--}%

			%{--<g:remoteLink controller="task" action="showPlans" id="${record.id}"--}%
			%{--update="below${entityCode}Record${record.id}"--}%
			%{--title="Show plans">--}%
			%{--${Planner.countByTask(record)} <sup>P</sup>--}%
			%{--</g:remoteLink>--}%

			%{--</g:if>--}%

			%{--<g:if test="${entityCode == 'R' && record.resourceType == 'ebk'}">--}%
			%{--R <sup>${Excerpt.countByBook(mcs.Book.get(record.id))}</sup>--}%
			%{--${IndexCard.countByBook(mcs.Book.get(record.id))} <sup>C</sup>--}%
			%{--</g:if>--}%

			%{--<g:if test="${entityCode == 'K'}">--}%
			%{--# <i>${IndicatorData.countByIndicator(record)}</i>--}%

			%{--</g:if>--}%

			%{--<g:if test="${entityCode == 'Q'}">--}%
			%{--# <sup>${PaymentData.countByCategory(record)}</sup>--}%
			%{--todo--}%
			%{--</g:if>--}%
			%{--</g:if>--}%
			%{--</span>--}%
			%{--</td>--}%






			%{--<g:if test="${'CW'.contains(entityCode)}">--}%

			%{--<td class="actionTd">--}%

			%{--<g:link controller="page" action="publish" target="_blank"--}%
			%{--params="${[id: record.id, entityCode: entityCode]}"--}%
			%{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
			%{--title="Publish">--}%
			%{--<span class="ui-icon ui-icon-script"></span>--}%
			%{--</g:link>--}%

			%{--<g:link controller="page" action="presentation" target="_blank"--}%
			%{--params="${[id: record.id, entityCode: entityCode]}"--}%
			%{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
			%{--title="presentation">--}%
			%{--<span class="ui-icon ui-icon-script"></span>--}%

			%{--</g:link>--}%




			%{--</td>--}%


			%{--</g:if>--}%





			%{--<tdclass="actionTd">--}%
			%{----}%
			%{--</td>--}%

		</tr>

		<tr id="appendRow${entityCode}-${record.id}">
			<td colspan="2">

			</td>

	</table>
</div>