/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Inventory_Edit_Js("SalesOrder_Edit_Js",{},{
	
	/**
	 * Function which will register event for Reference Fields Selection
	 */
	registerReferenceSelectionEvent : function(container) {
		this._super(container);
		var thisInstance = this;
		
		jQuery('input[name="account_id"]', container).on(Vtiger_Edit_Js.referenceSelectionEvent, function(e, data){
			thisInstance.referenceSelectionEventHandler(data, container);
		});
	},

	/**
	 * Function to get popup params
	 */
	getPopUpParams : function(container) {
		var params = this._super(container);
        var sourceFieldElement = jQuery('input[class="sourceField"]',container);

		if(sourceFieldElement.attr('name') == 'contact_id' || sourceFieldElement.attr('name') == 'potential_id') {
			var form = this.getForm();
			var parentIdElement  = form.find('[name="account_id"]');
			if(parentIdElement.length > 0 && parentIdElement.val().length > 0 && parentIdElement.val() != 0) {
				var closestContainer = parentIdElement.closest('td');
				params['related_parent_id'] = parentIdElement.val();
				params['related_parent_module'] = closestContainer.find('[name="popupReferenceModule"]').val();
			} else if(sourceFieldElement.attr('name') == 'potential_id') {
				parentIdElement  = form.find('[name="contact_id"]');
				if(parentIdElement.length > 0 && parentIdElement.val().length > 0) {
					closestContainer = parentIdElement.closest('td');
					params['related_parent_id'] = parentIdElement.val();
					params['related_parent_module'] = closestContainer.find('[name="popupReferenceModule"]').val();
				}
			}
        }
        return params;
    },

	/**
	 * Function to search module names
	 */
	searchModuleNames : function(params) {
		var aDeferred = jQuery.Deferred();

		if(typeof params.module == 'undefined') {
			params.module = app.getModuleName();
		}
		if(typeof params.action == 'undefined') {
			params.action = 'BasicAjax';
		}

		if (params.search_module == 'Contacts' || params.search_module == 'Potentials') {
			var form = this.getForm();
			var parentIdElement  = form.find('[name="account_id"]');
			if(parentIdElement.length > 0 && parentIdElement.val().length > 0) {
				var closestContainer = parentIdElement.closest('td');
				params.parent_id = parentIdElement.val();
				params.parent_module = closestContainer.find('[name="popupReferenceModule"]').val();
			} else if(params.search_module == 'Potentials') {
				parentIdElement  = form.find('[name="contact_id"]');
				if(parentIdElement.length > 0 && parentIdElement.val().length > 0) {
					closestContainer = parentIdElement.closest('td');
					params.parent_id = parentIdElement.val();
					params.parent_module = closestContainer.find('[name="popupReferenceModule"]').val();
				}
			}
		}

		AppConnector.request(params).then(
			function(data){
				aDeferred.resolve(data);
			},
			function(error){
				aDeferred.reject();
			}
		)
		return aDeferred.promise();
	},
	
	/**
	 * Function to register event for enabling recurrence
	 * When recurrence is enabled some of the fields need
	 * to be check for mandatory validation
	 */
	registerEventForEnablingRecurrence : function(){
		var thisInstance = this;
		var form = this.getForm();
		var enableRecurrenceField = form.find('[name="enable_recurring"]');
		var fieldsForValidation = new Array('recurring_frequency','start_period','end_period','payment_duration','invoicestatus');
		enableRecurrenceField.on('change',function(e){
			var element = jQuery(e.currentTarget);
			var addValidation;
			if(element.is(':checked')){
				addValidation = true;
			}else{
				addValidation = false;
			}
			
			//If validation need to be added for new elements,then we need to detach and attach validation
			//to form
			if(addValidation){
				form.validationEngine('detach');
				thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,addValidation);
				//For attaching validation back we are using not using attach,because chosen select validation will be missed
				form.validationEngine(app.validationEngineOptions);
				//As detach is used on form for detaching validationEngine,it will remove any actions on form submit,
				//so events that are registered on form submit,need to be registered again after validationengine detach and attach
				thisInstance.registerSubmitEvent();
			}else{
				thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,addValidation);
			}
		})
		if(!enableRecurrenceField.is(":checked")){
			thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,false);
		}else if(enableRecurrenceField.is(":checked")){
			thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,true);
		}
	},
	
	/**
	 * Function to add or remove required validation for dependent fields
	 */
	AddOrRemoveRequiredValidation : function(dependentFieldsForValidation,addValidation){
		var form = this.getForm();
		jQuery(dependentFieldsForValidation).each(function(key,value){
			var relatedField = form.find('[name="'+value+'"]');
			if(addValidation){
				var validationValue = relatedField.attr('data-validation-engine');
				if(validationValue.indexOf('[f') > 0){
					relatedField.attr('data-validation-engine','validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]');
				}
				if(relatedField.is("select")){
					relatedField.attr('disabled',false).trigger("liszt:updated");
				}else{
					relatedField.removeAttr('disabled');
				}
			}else if(!addValidation){
				if(relatedField.is("select")){
					relatedField.attr('disabled',true).trigger("liszt:updated");
				}else{
					relatedField.attr('disabled',"disabled");
				}
				relatedField.validationEngine('hide');
				if(relatedField.is('select') && relatedField.hasClass('chzn-select')){
					var parentTd = relatedField.closest('td');
					parentTd.find('.chzn-container').validationEngine('hide');
				}
			}
		})
	},

	registerEvents: function(){
		this._super();
		this.registerEventForEnablingRecurrence();
		this.registerForTogglingBillingandShippingAddress();
		this.registerEventForCopyAddress();
	}
});


