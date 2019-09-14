package app


      import app.*
      import app.parameters.*

      import cmn.*
      import grails.converters.*

      import java.text.SimpleDateFormat
    
import jxl.*
import jxl.format.*
import jxl.write.*
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class IndicatorDataController { // entity id = 21


	def supportService

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete:'POST', save:'POST', update:'POST']

	def list () {

		params.max = (params.max ?: 15)
		params.sort = (params.sort ? params.sort: 'lastUpdated')
		params.order = (params.order? params.order: 'desc')

        render(template: "/gTemplates/recordListing", model: [
			list: IndicatorData.list(params),
			total: IndicatorData.count()
		])

	}

	def changes () {
		def changes = DataChangeAudit.findAllByEntityIdAndRecordId(21, params.id)
		render(template: "/indicatorData/changes", model: [changes: changes])
	}

	def documents () {
		def documents = Document.executeQuery("from Document where entityId = ? and recordId = ?",
			[new Long(21), params.id.toLong()], [sort: 'dateCreated', order: 'desc'])

		render(template: "/indicatorData/documents", model: [changes: changes])
	}

	def show () {

		def indicatorDataInstance = IndicatorData.get(params.id)
		if (!indicatorDataInstance) {

		flash.message = "record.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "IndicatorData not found with id ${params.id}"

			render 'Record not found'
		}
		else {
			render(template: "/indicatorData/show", model: [
				indicatorDataInstance: indicatorDataInstance, changes: changes, documents: documents
			])
		}

	} // end of show


	def delete () {
		def indicatorDataInstance = IndicatorData.get(params.id)
		if (indicatorDataInstance) {
		 try {
			indicatorDataInstance.delete()
			//indicatorDataInstance.deletedOn = new Date()
			
			 flash.message = "IndicatorData.deleted"
			 flash.args = [params.id]
			 flash.defaultMessage = "IndicatorData ${params.id} deleted"
			 render "IndicatorData ${params.id} deleted"
		}
		catch (org.springframework.dao.DataIntegrityViolationException e) {
			 flash.message = "indicatorDataInstance.not.deleted"
			 flash.args = [params.id]
			 flash.defaultMessage = "IndicatorData ${params.id} could not be deleted"
			 render "IndicatorData ${params.id} could not be deleted" //redirect(action:'show',id:params.id)
		 }
		}
		else {
			flash.message = "indicatorDataInstance.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "IndicatorData not found with id ${params.id}"
			render "IndicatorData not found with id ${params.id}" //redirect(action:'list')
		}
	} // end of delete

def update () {
		def indicatorDataInstance = IndicatorData.get(params.id)
		if (indicatorDataInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (indicatorDataInstance.version > version) {
					 indicatorDataInstance.errors.rejectValue("version", "optimistic.locking.failure", "Another user has updated this IndicatorData while you were editing")
					 
					 render(template: "indicatorData/edit", model:[indicatorDataInstance:indicatorDataInstance])
				}
			}
			indicatorDataInstance.properties = params
			if (!indicatorDataInstance.hasErrors() && indicatorDataInstance.save(flush: true) ) {
				flash.message = "IndicatorData.updated"
				flash.args = [params.id]
				flash.defaultMessage = "IndicatorData ${params.id} updated"
				
				render('<script>Modalbox.hide()</script>')
			}
			else {
				render(view:'edit',model:[indicatorDataInstance:indicatorDataInstance])
			}
		}
		else {
			flash.message = "indicatorData.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "indicatorData not found with id ${params.id}"
			
			render ("indicatorData.not.found")

		}
	} // end of update


	def edit () {

		def indicatorDataInstance = IndicatorData.get(params.id)
		if (!indicatorDataInstance) {
			flash.message = "IndicatorData.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "IndicatorData not found with id ${params.id}"

			render 'Record not found'
		}
		else {
			render(template: "/indicatorData/edit", model: [indicatorDataInstance: indicatorDataInstance])
		}

	} // end of edit

	def save () {

		def indicatorDataInstance = new IndicatorData(params)

		if (!indicatorDataInstance.hasErrors() && indicatorDataInstance.save(flush: true)) {
			/* save the last entered value to speed up data entry */
//			session['lastIndicatorId'] = indicatorDataInstance.indicator.id
//			flash.message = "indicatorData.created"
//			flash.args = [indicatorDataInstance.id]
//			flash.defaultMessage = "IndicatorData ${indicatorDataInstance.id} created"

			// params.max = (params.max ?: 10)
			params.sort = (params.sort ? params.sort: 'lastUpdated')
			params.order = (params.order? params.order: 'desc')
			
			render(indicatorDataInstance.value)//template: "/indicatorData/list", model: [
//				indicatorDataInstance: new IndicatorData(), list: IndicatorData.list(params), total: IndicatorData.count()
//			])
		}
		else {
            render 'Problem! Check uniqueness.'
            indicatorDataInstance.errors.each(){
                println it
            }
//			render(template: "/indicatorData/list", model:[
//				indicatorDataInstance:indicatorDataInstance,
//				list: IndicatorData.list(params),
//				total: IndicatorData.count()
//			])
		}
	} // end of save

} // end of class