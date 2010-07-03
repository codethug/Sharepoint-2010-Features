<%@ Assembly Name="LC.ReadWriteSecurity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e28d9bb7b80d4e13"%>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="advsetng.aspx.cs" Inherits="LC.ReadWriteSecurity.ReadWriteSecurity" MasterPageFile="../application.master" %>

<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormSection" src="../../_controltemplates/InputFormSection.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormControl" src="../../_controltemplates/InputFormControl.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="ButtonSection" src="../../_controltemplates/ButtonSection.ascx" %>
<%@ Register Tagprefix="wssawc" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint.Meetings"  %>

<asp:Content ID="Content1" ContentPlaceHolderId="PlaceHolderPageTitle" runat="server">    
	<SharePoint:FormattedStringWithListType ID="FormattedStringWithListType2" runat="server"
		String="{0} Read/Write Security Settings" LowerCase="false" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderId="PlaceHolderPageTitleInTitleArea" runat="server">
	<SharePoint:FormattedStringWithListType ID="FormattedStringWithListType1" runat="server"
		String="{0} Read/Write Security Settings:" LowerCase="false" />
	<a id=onetidListHlink HREF=<% SPHttpUtility.AddQuote(SPHttpUtility.UrlPathEncode(List.DefaultViewUrl,true),Response.Output);%>>
	    <%SPHttpUtility.HtmlEncode(List.Title,Response.Output);%>
	</a>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderId="PlaceHolderPageDescription" runat="server">
This setting is available for lists under 'Advanced Settings', but is hidden on the Advanced Settings page for Document Libraries.  This page
allows you to set that setting for either lists or Document Libraries.
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">
<script language="javascript">
function _spBodyOnLoad()
{
	if (typeof(SetReadWriteSecuritySettings) == "function")
	{
		SetReadWriteSecuritySettings();
	}
	ShowHideDocumentTemplate();
}
function _spFormOnSubmit()
{
	return true;
}
</script>
</asp:Content>


<asp:Content ID="Content5" ContentPlaceHolderId="PlaceHolderMain" runat="server">
	<table class=propertysheet border="0" width="100%" cellspacing="0" cellpadding="0">
<!-- Security Settings -->
	<asp:PlaceHolder runat="server" id="ItemLevelSecurityPanel">
	<wssuc:InputFormSection runat="server"
		id="ItemLevelSecuritySection"
		Title="<%$Resources:wss,lstsetng_itemlevel_perm%>"
		>
		<Template_Description>
			<% if (!IsSurvey) { %><SharePoint:EncodedLiteral ID="EncodedLiteral4" runat="server" text="<%$Resources:wss,lstsetng_itemlevel_desc_list%>" EncodeMethod='HtmlEncode'/><br><br>
				<b><SharePoint:EncodedLiteral ID="EncodedLiteral5" runat="server" text="<%$Resources:wss,multipages_note_colon%>" EncodeMethod='HtmlEncode'/></b>
				<SharePoint:EncodedLiteral ID="EncodedLiteral6" runat="server" text="<%$Resources:wss,lstsetng_itemlevel_desc_list2%>" EncodeMethod='HtmlEncode'/>
			<% } else { %><SharePoint:EncodedLiteral ID="EncodedLiteral7" runat="server" text="<%$Resources:wss,lstsetng_itemlevel_desc_survey%>" EncodeMethod='HtmlEncode'/><br><br>
				<b><SharePoint:EncodedLiteral ID="EncodedLiteral8" runat="server" text="<%$Resources:wss,multipages_note_colon%>" EncodeMethod='HtmlEncode'/></b>
				<SharePoint:EncodedLiteral ID="EncodedLiteral9" runat="server" text="<%$Resources:wss,lstsetng_itemlevel_desc_survey2%>" EncodeMethod='HtmlEncode'/>
			<% } %><SharePoint:FormattedString id="helptopic_MS_WSS_ItemLevelPermissions" FormatText="<%$Resources:wss,helptopic_link%>" EncodeMethod="NoEncode" runat="server"> <SharePoint:EncodedLiteral ID="EncodedLiteral10" runat="server" text="<%$Resources:wss,CSH_ItemLevelPermissions%>" EncodeMethod='HtmlEncode'/> <SharePoint:EncodedLiteral ID="EncodedLiteral11" runat="server" text='MS_WSS_ItemLevelPermissions' EncodeMethod='EcmaScriptStringLiteralEncode'/> </SharePoint:FormattedString>
		</Template_Description>
		<Template_InputFormControls>
			<wssuc:InputFormControl runat="server"
				>
				<Template_LabelText>
					<b><SharePoint:EncodedLiteral ID="EncodedLiteral12" runat="server" text="<%$Resources:wss,lstsetng_readacc%>" EncodeMethod='HtmlEncode'/></b>&nbsp;&nbsp;
					<% if (!IsSurvey) { %><SharePoint:EncodedLiteral ID="EncodedLiteral13" runat="server" text="<%$Resources:wss,lstsetng_readacc_list%>" EncodeMethod='HtmlEncode'/><% } else { %><SharePoint:EncodedLiteral ID="EncodedLiteral14" runat="server" text="<%$Resources:wss,lstsetng_readacc_survey%>" EncodeMethod='HtmlEncode'/><% } %></Template_LabelText>
				<Template_Control>
					<asp:RadioButton runat="server"
						id="RadReadSecurityAll"
						GroupName="ReadSecurity"
						Title="lstsetng_readsec_title"
						Value="1"
						Text="<%$Resources:wss,lstsetng_allitems%>"
						/>
					<br>
					<asp:RadioButton runat="server"
						id="RadReadSecurityOwn"
						GroupName="ReadSecurity"
						Title="<%$Resources:wss,lstsetng_readsec_own%>"
						Value="2"
						Text="<%$Resources:wss,lstsetng_own_label%>"
						/>
				</Template_Control>
			</wssuc:InputFormControl>
			<wssuc:InputFormControl runat="server"
				>
				<Template_LabelText>
					<b><SharePoint:EncodedLiteral ID="EncodedLiteral15" runat="server" text="<%$Resources:wss,lstsetng_editsec%>" EncodeMethod='HtmlEncode'/></b>&nbsp;&nbsp;
					<% if (!IsSurvey) { %><SharePoint:EncodedLiteral ID="EncodedLiteral16" runat="server" text="<%$Resources:wss,lstsetng_editsec_list%>" EncodeMethod='HtmlEncode'/><% } else { %><SharePoint:EncodedLiteral ID="EncodedLiteral17" runat="server" text="<%$Resources:wss,lstsetng_editsec_survey%>" EncodeMethod='HtmlEncode'/><% } %></Template_LabelText>
				<Template_Control>
					<asp:RadioButton runat="server"
						id="RadWriteSecurityAll"
						GroupName="WriteSecurity"
						title="<%$Resources:wss,lstsetng_writesec1%>"
						Text="<%$Resources:wss,lstsetng_allitems%>"
						Value="1"
						/>
					<br/>
					<asp:RadioButton runat="server"
						id="RadWriteSecurityOwn"
						GroupName="WriteSecurity"
						title="<%$Resources:wss,lstsetng_writesec2%>"
						text="<%$Resources:wss,lstsetng_ws_theirown%>"
						value="2"
						/>
					<br/>
					<asp:RadioButton runat="server"
						id="RadWriteSecurityNone"
						GroupName="WriteSecurity"
						title="<%$Resources:wss,lstsetng_writesec3%>"
						Text="<%$Resources:wss,lstsetng_ws_none%>"
						Value="4"
						/>
				</Template_Control>
			</wssuc:InputFormControl>
		</Template_InputFormControls>
	</wssuc:InputFormSection>
<script>
	function SetReadWriteSecuritySettings()
	{
<%
int iReadSecurity = List.ReadSecurity;
int iWriteSecurity = List.WriteSecurity;
%>
		var readSecurity = <%SPHttpUtility.NoEncode(iReadSecurity,Response.Output);%>;
		var writeSecurity = <%SPHttpUtility.NoEncode(iWriteSecurity,Response.Output);%>;
		(document.getElementById("<%= RadReadSecurityAll.ClientID %>")).checked = (1 == readSecurity) ;
		(document.getElementById("<%= RadReadSecurityOwn.ClientID %>")).checked = (2 == readSecurity);
		(document.getElementById("<%= RadWriteSecurityAll.ClientID %>")).checked = (1 == writeSecurity);
		(document.getElementById("<%= RadWriteSecurityOwn.ClientID %>")).checked = (2 == writeSecurity);
		(document.getElementById("<%= RadWriteSecurityNone.ClientID %>")).checked = (4 == writeSecurity);
	}
</script>
	</asp:PlaceHolder>

		<tr>
			<td height="10px" class="ms-descriptiontext" colspan="2"><IMG SRC="/_layouts/images/blank.gif" width=1 height=10 alt=""></td>
		</tr>
		<tr>
			<td colspan="2">
				<table cellpadding="0" cellspacing="0" width="100%">
					<colgroup>
						<col width="99%">
						<col width="1%">
					</colgroup>
					<tr>
						<td>
							&nbsp;</td>
						<td nowrap>
            				<asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="BtnSaveAdvancedSettings_Click" Text="<%$Resources:wss,multipages_okbutton_text%>" id="BtnSaveAsTemplate" accesskey="<%$Resources:wss,okbutton_accesskey%>"/>            				
                    		<span id="idSpace" class=ms-SpaceBetButtons></span>
                    		<INPUT class="ms-ButtonHeightWidth" ID=onetidCancelItem accesskey=c Type="button" Value="<SharePoint:EncodedLiteral runat='server' text='<%$Resources:wss,multipages_cancelbutton_text%>' EncodeMethod='HtmlEncode'/>" onclick="if (window.parent.history.length > 0) window.parent.history.back(); else window.close()">            				
						</td>
					</tr>
				</table>
			</td>
		</tr>


	</TABLE>
</asp:Content>


