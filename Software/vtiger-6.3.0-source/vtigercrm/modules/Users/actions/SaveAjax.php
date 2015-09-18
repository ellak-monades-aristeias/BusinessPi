<?php
/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
vimport('~~/include/Webservices/Custom/ChangePassword.php');

class Users_SaveAjax_Action extends Vtiger_SaveAjax_Action {
	
	function __construct() {
		parent::__construct();
		$this->exposeMethod('userExists');
		$this->exposeMethod('savePassword');
                $this->exposeMethod('restoreUser');
	}

	public function checkPermission(Vtiger_Request $request) {
            $currentUserModel = Users_Record_Model::getCurrentUserModel();

            $userId = $request->get('userid');
            if (!$currentUserModel->isAdminUser()) {
                $mode = $request->getMode();
                if ($mode == 'savePassword' && (isset($userId) && $currentUserModel->getId() != $userId)) {
                    throw new AppException(vtranslate('LBL_PERMISSION_DENIED', 'Vtiger'));
                }
                 else if ($mode != 'savePassword' && ($currentUserModel->getId() != $request->get('record'))) {
                    throw new AppException(vtranslate('LBL_PERMISSION_DENIED', 'Vtiger'));
                }
            }
    }

	public function process(Vtiger_Request $request) {

                $mode = $request->get('mode');
		if (!empty($mode)) {
			$this->invokeExposedMethod($mode, $request);
			return;
		}
		
		$recordModel = $this->saveRecord($request);

                $fieldModelList = $recordModel->getModule()->getFields();
		$result = array();
		foreach ($fieldModelList as $fieldName => $fieldModel) {
			$fieldValue = $displayValue = Vtiger_Util_Helper::toSafeHTML($recordModel->get($fieldName));
			if ($fieldModel->getFieldDataType() !== 'currency') {
				$displayValue = $fieldModel->getDisplayValue($fieldValue, $recordModel->getId());
			}
			if($fieldName == 'language') {
				$displayValue =  Vtiger_Language_Handler::getLanguageLabel($fieldValue);
			}
            
            if(($fieldName == 'currency_decimal_separator' || $fieldName == 'currency_grouping_separator') && ($displayValue == '&nbsp;')) {
                $displayValue = vtranslate('LBL_Space', 'Users');
            }
            
			$result[$fieldName] = array('value' => $fieldValue, 'display_value' => $displayValue);
		}

		$result['_recordLabel'] = $recordModel->getName();
		$result['_recordId'] = $recordModel->getId();

		$response = new Vtiger_Response();
		$response->setEmitType(Vtiger_Response::$EMIT_JSON);
		$response->setResult($result);
		$response->emit();
	}

	/**
	 * Function to get the record model based on the request parameters
	 * @param Vtiger_Request $request
	 * @return Vtiger_Record_Model or Module specific Record Model instance
	 */
	public function getRecordModelFromRequest(Vtiger_Request $request) {
		$recordModel = parent::getRecordModelFromRequest($request);
		$fieldName = $request->get('field');
                $currentUserModel=  Users_Record_Model::getCurrentUserModel();
		if ($fieldName === 'is_admin' && (!$currentUserModel->isAdminUser()||!$request->get('value'))) {
			$recordModel->set($fieldName, 'off');
                        $recordModel->set('is_owner',0);
		}
                else if($fieldName === 'is_admin' && $currentUserModel->isAdminUser()){
                    $recordModel->set($fieldName, 'on');
                    $recordModel->set('is_owner',1);
                }       
                return $recordModel;
	}
	
		
	public function userExists(Vtiger_Request $request){
		$module = $request->getModule();
		$userName = $request->get('user_name');
		$userModuleModel = Users_Module_Model::getCleanInstance($module);
		$status = $userModuleModel->checkDuplicateUser($userName);
		$response = new Vtiger_Response();
		$response->setResult($status);
		$response->emit();
	}
	
	public function savePassword(Vtiger_Request $request) {
		$module = $request->getModule();
		$userModel = vglobal('current_user');
		$newPassword = $request->get('new_password');
		$oldPassword = $request->get('old_password');
		
		$wsUserId = vtws_getWebserviceEntityId($module, $request->get('userid'));
		$wsStatus = vtws_changePassword($wsUserId, $oldPassword, $newPassword, $newPassword, $userModel);
		
		$response = new Vtiger_Response();
		if ($wsStatus['message']) {
			$response->setResult($wsStatus);
		} else {
			$response->setError('JS_PASSWORD_INCORRECT_OLD', 'JS_PASSWORD_INCORRECT_OLD');
		}
		$response->emit();
	}
        
        /*
         * To restore a user
         * @param Vtiger_Request Object
         */
        public function restoreUser(Vtiger_Request $request) {
                $moduleName = $request->getModule();
                $record = $request->get('userid');
                
                $recordModel = Users_Record_Model::getInstanceById($record, $moduleName);
                $recordModel->set('status', 'Active');
                $recordModel->set('id', $record);
                $recordModel->set('mode', 'edit');
                $recordModel->set('user_hash', $recordModel->getUserHash());
                $recordModel->save();
                
                $db = PearDatabase::getInstance();
                $db->pquery("UPDATE vtiger_users SET deleted=? WHERE id=?", array(0,$record));
                
                $userModuleModel = Users_Module_Model::getInstance($moduleName);
		$listViewUrl = $userModuleModel->getListViewUrl();
		
		$response = new Vtiger_Response();
		$response->setResult(array('message'=>vtranslate('LBL_USER_RESTORED_SUCCESSFULLY', $moduleName), 'listViewUrl' => $listViewUrl));
		$response->emit();
        }
        }
