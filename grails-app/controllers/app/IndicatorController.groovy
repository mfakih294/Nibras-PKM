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
class IndicatorController { // entity id = 22


	def supportService

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete:'POST', save:'POST', update:'POST']

	def list () {

//		params.max = (params.max ?: 15)
		params.sort = (params.sort ? params.sort: 'lastUpdated')
		params.order = (params.order? params.order: 'desc')
  
		render(template: "/indicator/list", model: [
			list: Indicator.list(params),
			total: Indicator.count()
		])

	}

	def changes () {
		def changes = DataChangeAudit.findAllByEntityIdAndRecordId(22, params.id)
		render(template: "/indicator/changes", model: [changes: changes])
	}

	def documents () {
		def documents = Document.executeQuery("from Document where entityId = ? and recordId = ?",
			[new Long(22), params.id.toLong()], [sort: 'dateCreated', order: 'desc'])

		render(template: "/indicator/documents", model: [changes: changes])
	}

	def show () {

		def indicatorInstance = Indicator.get(params.id)
		if (!indicatorInstance) {

		flash.message = "record.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Indicator not found with id ${params.id}"

			render 'Record not found'
		}
		else {
			render(template: "/indicator/show", model: [
				indicatorInstance: indicatorInstance, changes: changes, documents: documents
			])
		}

	} // end of show


	def delete () {
		def indicatorInstance = Indicator.get(params.id)
		if (indicatorInstance) {
		 try {
			indicatorInstance.delete()
			//indicatorInstance.deletedOn = new Date()
			
			 flash.message = "Indicator.deleted"
			 flash.args = [params.id]
			 flash.defaultMessage = "Indicator ${params.id} deleted"
			 render "Indicator ${params.id} deleted"
		}
		catch (org.springframework.dao.DataIntegrityViolationException e) {
			 flash.message = "indicatorInstance.not.deleted"
			 flash.args = [params.id]
			 flash.defaultMessage = "Indicator ${params.id} could not be deleted"
			 render "Indicator ${params.id} could not be deleted" //redirect(action:'show',id:params.id)
		 }
		}
		else {
			flash.message = "indicatorInstance.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Indicator not found with id ${params.id}"
			render "Indicator not found with id ${params.id}" //redirect(action:'list')
		}
	} // end of delete

def update () {
		def indicatorInstance = Indicator.get(params.id)
		if (indicatorInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (indicatorInstance.version > version) {
					 indicatorInstance.errors.rejectValue("version", "optimistic.locking.failure", "Another user has updated this Indicator while you were editing")
					 
					 render(template: "indicator/edit", model:[indicatorInstance:indicatorInstance])
				}
			}
			indicatorInstance.properties = params
			if (!indicatorInstance.hasErrors() && indicatorInstance.save(flush: true) ) {
				flash.message = "Indicator.updated"
				flash.args = [params.id]
				flash.defaultMessage = "Indicator ${params.id} updated"
				
				//render('<script>Modalbox.hide()</script>')
                render(template: '/gTemplates/recordSummary',model:[record: indicatorInstance])
			}
			else {
				render(view:'edit',model:[indicatorInstance:indicatorInstance])
			}
		}
		else {
			flash.message = "indicator.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "indicator not found with id ${params.id}"
			
			render ("indicator.not.found")

		}
	} // end of update


	def edit () {

		def indicatorInstance = Indicator.get(params.id)
		if (!indicatorInstance) {
			flash.message = "Indicator.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Indicator not found with id ${params.id}"

			render 'Record not found'
		}
		else {
			render(template: "/indicator/edit", model: [indicatorInstance: indicatorInstance])
		}

	} // end of edit

	def save () {

		def indicatorInstance = new Indicator(params)

		if (!indicatorInstance.hasErrors() && indicatorInstance.save(flush: true)) {
			/* save the last entered value to speed up data entry */
			// session['last'] = indicatorInstance.parent.id
			flash.message = "indicator.created"
			flash.args = [indicatorInstance.id]
			flash.defaultMessage = "Indicator ${indicatorInstance.id} created"

			// params.max = (params.max ?: 10)
			params.sort = (params.sort ? params.sort: 'lastUpdated')
			params.order = (params.order? params.order: 'desc')
			
			render(template: "/indicator/list", model: [
				indicatorInstance: new Indicator(), list: Indicator.list(params), total: Indicator.count()
			])
		}
		else {
			render(template: "/indicator/list", model:[
				indicatorInstance:indicatorInstance,
				list: Indicator.list(params), 
				total: Indicator.count()
			])
		}
	} // end of save

    def showEvolution () {

		params.max = (params.max ?: 100)
		params.sort = (params.sort ? params.sort: 'date')
		params.order = (params.order? params.order: 'desc')
        def indicator = Indicator.get(params.id)
        if (indicator) {


		render(template: "/gTemplates/recordSummary", model: [
                record: indicator
                ])
//		render(template: "/gTemplates/recordListing", model: [
//			list: IndicatorData.findAllByIndicator(Indicator.get(params.id)),
//			total: IndicatorData.countByIndicator(Indicator.get(params.id)),
//                indicator: Indicator.get(params.id)])
        }
                else render("Indicator not found")

	}



} // end of class