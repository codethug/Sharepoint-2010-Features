using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Microsoft.SharePoint;
using System.Data;
using Microsoft.SharePoint.WebControls;
using Microsoft.SharePoint.ApplicationPages;
using Microsoft.SharePoint.Utilities;

namespace LC.ReadWriteSecurity
{
    public partial class ReadWriteSecurity : ListPageBase
    {
        // Methods
        protected void BtnSaveAdvancedSettings_Click(object sender, EventArgs e)
        {
            if (this.ItemLevelSecurityPanel.Visible)
            {
                int num = 1;
                if (this.RadReadSecurityOwn.Checked)
                {
                    num = 2;
                }
                int num2 = 1;
                if (!this.RadWriteSecurityOwn.Checked)
                {
                    if (this.RadWriteSecurityNone.Checked)
                    {
                        num2 = 4;
                    }
                }
                else
                {
                    num2 = 2;
                }
                base.List.ReadSecurity = num;
                base.List.WriteSecurity = num2;
            }
            base.List.Update();

            SPUtility.Redirect(base.List.DefaultViewUrl, SPRedirectFlags.Default, this.Context);
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            this.Page.SetFocus(this.RadReadSecurityOwn);
            if (this.Page.IsPostBack)
            {
                return;
            }
            SPBaseType baseType = base.List.BaseType;
            SPListTemplateType baseTemplate = base.List.BaseTemplate;

            this.ItemLevelSecurityPanel.Visible = true;
            if (this.ItemLevelSecurityPanel.Visible && this.IsSurvey)
            {
                this.RadReadSecurityAll.Text = SPHttpUtility.HtmlEncode(base.GetResourceString("lstsetng_allresponses", new object[0]));
                this.RadWriteSecurityAll.Text = SPHttpUtility.HtmlEncode(base.GetResourceString("lstsetng_allresponses", new object[0]));
            }
        }

        // Properties
        protected bool IsSurvey
        {
            get
            {
                return (base.List.BaseType == SPBaseType.Survey);
            }
        }

        protected override SPBasePermissions RightsRequired
        {
            get
            {
                return (SPBasePermissions.EmptyMask | SPBasePermissions.ManageLists);
            }
        }

    }
}
