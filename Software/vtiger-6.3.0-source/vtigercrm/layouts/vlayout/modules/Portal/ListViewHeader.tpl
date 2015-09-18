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
    	<div class="listViewPageDiv" id="portalListViewPage">
		<div class="listViewTopMenuDiv noprint">
			<div class="listViewActionsDiv row-fluid">
				<span class="btn-toolbar span4">
					<span class="btn-group listViewMassActions">
                        <button class="btn dropdown-toggle" data-toggle="dropdown"><strong>{vtranslate('LBL_ACTIONS', $MODULE)}</strong>&nbsp;&nbsp;<i class="caret"></i></button>
                        <ul class="dropdown-menu">
                            <li id="massDelete"><a href="javascript:void(0);" onclick="Portal_List_Js.massDeleteRecords();">{vtranslate('LBL_DELETE', $MODULE)}</a></li>
                        </ul>
					</span>
                    <span class="btn-group">
                        <button class="btn addButton addBookmark"><i class="icon-plus"></i>&nbsp;<strong>{vtranslate('LBL_ADD_BOOKMARK', $MODULE)}</strong></button>
                    </span>
				</span>
                <span class="span4">&nbsp;</span>
                <span class="span4 btn-toolbar row-fluid">
                    <div class="listViewActions pull-right">
                            <div class="pageNumbers alignTop">
                                <span>
                                    <span class="pageNumbersText" style="padding-right:5px">{if $RECORD_COUNT neq 0}{$PAGING_INFO['startSequence']} {vtranslate('LBL_to', $MODULE)} {$PAGING_INFO['endSequence']}{else}<span>&nbsp;</span>{/if}</span>
                                    <span class="icon-refresh pull-right totalNumberOfRecords cursorPointer {if $RECORD_COUNT eq 0}hide{/if}"></span>
                                </span>
                            </div>
                        <div class="btn-group alignTop margin0px">
                            <span class="pull-right">
                                <span class="btn-group">
                                    <button class="btn" id="previousPageButton" type="button" {if $CURRENT_PAGE eq 1}disabled{/if}><span class="icon-chevron-left"></span></button>
                                        <button class="btn dropdown-toggle" type="button" id="listViewPageJump" data-toggle="dropdown">
                                            <i class="vtGlyph vticon-pageJump" title="{vtranslate('LBL_LISTVIEW_PAGE_JUMP',$MODULE)}"></i>
                                        </button>
                                        <ul class="listViewBasicAction dropdown-menu" id="listViewPageJumpDropDown">
                                            <li>
                                                <span class="row-fluid">
                                                    <span class="span3 pushUpandDown2per"><span class="pull-right">{vtranslate('LBL_PAGE',$MODULE)}</span></span>
                                                    <span class="span4">
                                                        <input type="text" id="pageToJump" class="listViewPagingInput" value="{$CURRENT_PAGE}"/>
                                                    </span>
                                                    <span class="span2 textAlignCenter pushUpandDown2per">
                                                        {vtranslate('LBL_OF',$MODULE)}&nbsp;
                                                    </span>
                                                    <span class="span3 pushUpandDown2per" id="totalPageCount">{$PAGING_INFO['pageCount']}</span>
                                                </span>
                                            </li>
                                        </ul>
                                    <button class="btn" id="nextPageButton" type="button" {if !$PAGING_INFO['nextPageExists']}disabled{/if}><span class="icon-chevron-right"></span></button>
                                </span>
                            </span>
                        </div>
                    </div>
                </span>
            </div>
		</div>
        <div class="listViewContentDiv" id="listViewContents">
{/strip}