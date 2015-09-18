{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
*
 ********************************************************************************/
-->*}
{strip}
	<div class="container-fluid settingsIndexPage">
		<div class="widget_header row-fluid"><h3>{vtranslate('LBL_SUMMARY',$MODULE)}</h3></div>
		<hr>
		<div class="row-fluid">
			<span class="span4 settingsSummary">
				<a href="index.php?module=Users&parent=Settings&view=List">
					 <h2 style="font-size: 44px" class="summaryCount">{$USERS_COUNT}</h2> 
			         <p class="summaryText" style="margin-top:20px;">{vtranslate('LBL_ACTIVE_USERS',$MODULE)}</p> 
				</a>
			</span>
			<span class="span4 settingsSummary">
				<a href="index.php?module=Workflows&parent=Settings&view=List">
					<h2 style="font-size: 44px" class="summaryCount">{$ACTIVE_WORKFLOWS}</h2> 
                    <p class="summaryText" style="margin-top:20px;">{vtranslate('LBL_WORKFLOWS_ACTIVE',$MODULE)}</p> 
				</a>
			</span>
			<span class="span4 settingsSummary">
				<a href="index.php?module=ModuleManager&parent=Settings&view=List">
					 <h2 style="font-size: 44px" class="summaryCount">{$ACTIVE_MODULES}</h2> 
		             <p class="summaryText" style="margin-top:20px;">{vtranslate('LBL_MODULES',$MODULE)}</p>
				</a>
			</span>
		</div>
		<br><br>
		<h3>{vtranslate('LBL_SETTINGS_SHORTCUTS',$MODULE)}</h3>
		<hr>
		 {assign var=SPAN_COUNT value=1}
                <div class="row-fluid">
                    <div class="span1">&nbsp;</div>
                    <div id="settingsShortCutsContainer" class="span11">
                        <div  class="row-fluid">
		{foreach item=SETTINGS_SHORTCUT from=$SETTINGS_SHORTCUTS name=shortcuts}
			{include file='SettingsShortCut.tpl'|@vtemplate_path:$MODULE}
                        {if $SPAN_COUNT==3}</div>{$SPAN_COUNT=1}{if not $smarty.foreach.shortcuts.last}<div class="row-fluid">{/if}{continue}{/if}
                        {$SPAN_COUNT=$SPAN_COUNT+1}
		{/foreach}
                </div>
	</div>
                </div>
{/strip}
