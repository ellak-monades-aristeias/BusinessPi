/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Settings_Vtiger_List_Js("Settings_Users_List_Js",{

	/*
	 * function to trigger delete record action
	 * @params: delete record url.
	 */
    deleteRecord : function(deleteRecordActionUrl) {
		var message = app.vtranslate('LBL_DELETE_USER_CONFIRMATION');
		Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(function(data) {
				AppConnector.request(deleteRecordActionUrl).then(
				function(data){
					if(data){
						var callback = function(data) {
						var params = app.validationEngineOptions;
						params.onValidationComplete = function(form, valid){
							if(valid){
								Settings_Users_List_Js.deleteUser(form)
							}
							return false;
						}
						jQuery('#deleteUser').validationEngine(app.validationEngineOptions);
					}
					app.showModalWindow(data, function(data){
						if(typeof callback == 'function'){
							callback(data);
						}
					});
					}
				});
			},
			function(error, err){
			}
		);
	},
	
	deleteUser: function (form){
		var userid = form.find('[name="userid"]').val();
		var transferUserId = form.find('[name="tranfer_owner_id"]').val();
        var progressInstance = jQuery.progressIndicator({
                'position' : 'html',
                'blockInfo' : {
                        'enabled' : true
                }
        });
		var params = {
			'module': app.getModuleName(),
			'action' : "DeleteAjax",
			'transfer_user_id' : transferUserId,
			'userid' : userid,
            'permanent' : jQuery('[name="deleteUserPermanent"]:checked', form).val()
		}		
		AppConnector.request(params).then(
			function(data) {
				if(data.success){
					app.hideModalWindow();
                                        progressInstance.progressIndicator({
                                                'mode' : 'hide'
                                        });
                    params = {
                        title : app.vtranslate('JS_MESSAGE'),
                        text : data.result.message,
                        animation: 'show',
						type: 'error'
                    };
					Vtiger_Helper_Js.showPnotify(params);
                    jQuery('[data-id='+userid+"]").hide();
				}
			}
		);
	},
                
        /*
         *Function to delete a user permanently
         *@param userId, event
         */
        deleteUserPermanently : function(userId, e) {
                e.stopPropagation();
                var message = app.vtranslate('LBL_DELETE_USER_PERMANENT_CONFIRMATION');
                var deleteRecordActionUrl = 'index.php?module='+app.getModuleName()+'&parent='+app.getParentModuleName()+'&view=DeleteUser&mode=permanent&record='+userId;
                Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
                    function(data) {
                        AppConnector.request(deleteRecordActionUrl).then(
                        function(data) {
                                if(data){
                                    var callback = function(data) {
                                        var params = app.validationEngineOptions;
                                        params.onValidationComplete = function(form, valid){
                                                if(valid){
                                                        var progressInstance = jQuery.progressIndicator({
                                                                'position' : 'html',
                                                                'blockInfo' : {
                                                                        'enabled' : true
                                                                }
                                                        });
                                                        var params = {
                                                                'module': app.getModuleName(),
                                                                'action' : "DeleteAjax",
                                                                'userid' : userId,
                                                                'transfer_user_id' : form.find('[name="tranfer_owner_id"]').val(),
                                                                'mode' : 'permanent'
                                                        }
                                                        app.hideModalWindow();
                                                        AppConnector.request(params).then(
                                                                function(response) {
                                                                        if(response.success){
                                                                                progressInstance.progressIndicator({
                                                                                        'mode' : 'hide'
                                                                                });
                                                                                params = {
                                                                                    title : app.vtranslate('JS_MESSAGE'),
                                                                                    text : response.result.message,
                                                                                    animation: 'show',
                                                                                    type: 'error'
                                                                                };
                                                                                Vtiger_Helper_Js.showPnotify(params);
                                                                                jQuery('[data-id='+userId+"]").hide();
                                                                        }
                                                                }
                                                        );
                                                }
                                                return false;
                                        }
                                        jQuery('#deleteUser').validationEngine(app.validationEngineOptions);
                                    }
                                    app.showModalWindow(data, function(data){
                                            if(typeof callback == 'function'){
                                                    callback(data);
                                            }
                                    });
                                }
                        });
                    }
		);
        },
        
        /*
         *Function to restore Inactive User
         *@param userId, event
         */
        restoreUser : function(userId, e) {
                e.stopPropagation();
                Vtiger_Helper_Js.showConfirmationBox({
			'message' : app.vtranslate('LBL_RESTORE_CONFIRMATION')
		}).then( function() {
                        var progressInstance = jQuery.progressIndicator({
                                'position' : 'html',
                                'blockInfo' : {
                                        'enabled' : true
                                }
                        });
                        var params = {
                                'module': app.getModuleName(),
                                'action' : "SaveAjax",
                                'userid' : userId,
                                'mode' : 'restoreUser'
                        }
                        AppConnector.request(params).then(
                                function(response) {
                                        if(response.success){
                                                progressInstance.progressIndicator({
                                                        'mode' : 'hide'
                                                });
                                                Vtiger_Helper_Js.showPnotify(response.result.message);
                                                var url = response.result.listViewUrl;
                                                window.location.href=url;
                                        }
                                }
                        );
                });
        },

        triggerExportAction: function() {
            var url = window.location.href;
            var siteUrl = url.split('?');
            var newForm = jQuery('<form>', {
                'method': 'post',
                'action': siteUrl[0] + '?module=Users&source_module=Users&action=ExportData',
            }).append(jQuery('<input>', {
                'name': csrfMagicName,
                'value': csrfMagicToken,
                'type': 'hidden'
            }));
           jQuery(newForm).appendTo('body')[0].submit();
    }
	
},{

	
	/*
	 * Function to get Page Jump Params
	 */
	getPageJumpParams : function(){
		var module = app.getModuleName();
		var cvId = this.getCurrentCvId();
		var pageCountParams = {
			'module' : module,
			'view' : "ListAjax",
			'mode' : "getPageCount",
			'search_key' : 'status',
            'operator' : 'e',
            'search_value' : jQuery('#usersFilter').val()
		}
		return pageCountParams;
	},
	/*
	 * Function to register the list view delete record click event
	 */
	registerDeleteRecordClickEvent: function(){
		var listViewContentDiv = this.getListViewContentContainer();
		listViewContentDiv.on('click','.deleteRecordButton',function(e){
			var elem = jQuery(e.currentTarget);
			var rowElement = elem.closest('tr');
			var deleteActionUrl = jQuery('[name="deleteActionUrl"]',rowElement).val();
			Settings_Users_List_Js.deleteRecord(deleteActionUrl);
			e.stopPropagation();
		});
	},
        
        /*
         *Function to filter Active and Inactive users from Users List View
         */
        usersFilter : function() {
                var thisInstance = this;
                jQuery('#usersFilter').change(function() {
                        var progressInstance = jQuery.progressIndicator({
                                'position' : 'html',
                                'blockInfo' : {
                                        'enabled' : true
                                }
                        });
                        var params = {
                            'module' : app.getModuleName(),
                            'view' : 'List',
                            'parent' : app.getParentModuleName(),
                            'search_key' : 'status',
                            'operator' : 'e',
                            'search_value' : jQuery('#usersFilter').val()
                        };
                        AppConnector.request(params).then(
                            function(data){
                                        progressInstance.progressIndicator({
                                                'mode' : 'hide'
                                        });
                                        jQuery('#listViewContents').html(data);
                                        thisInstance.updatePagination();
                            }
                        );
                });
        },
        
        
	registerEvents : function() {
		this._super();
		this.registerEventForAlphabetSearch();
                this.registerEmailFieldClickEvent();
		this.registerUrlFieldClickEvent();
		this.registerDeleteRecordClickEvent();
                this.usersFilter();
	}
});
