using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Microsoft.SharePoint.UserCode;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Workflow;
using Microsoft.SharePoint.Utilities;

namespace MyActivity
{
    class Activities
    {
        // http://www.wictorwilen.se/Post/Sandboxed-workflow-activities-in-SharePoint-2010.aspx
        // http://developers.de/blogs/nadine_storandt/archive/2008/08/04/deploying-custom-activity-for-sharepoint-designer.aspx
        // http://spdactivities.codeplex.com/
        // http://msdn.microsoft.com/en-us/library/ff798499.aspx
        // http://msdn.microsoft.com/en-us/library/ff798427.aspx

        // Note that the parameter names here need to matches the parameter names in Elements.xml
        public Hashtable DoSomething(SPUserCodeWorkflowContext context, string FieldName, string ExtraString)
        {
            try
            {
                using (SPSite site = new SPSite(context.CurrentWebUrl))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        // Add a line item to the workflow history
                        SPWorkflow.CreateHistoryEvent(web, context.WorkflowInstanceId, 0, web.CurrentUser, TimeSpan.Zero, "Information", "History Event from Sandboxed Activity", string.Empty);

                        // Get Metadata for List Item
                        SPList CurrList = web.Lists[context.ListId];
                        SPListItem currentItem = CurrList.GetItemById(context.ItemId);
                        string Title = currentItem.Title;

                        string FieldData = currentItem[FieldName].ToString();

                        try
                        {
                            var proxyArgs = new MySandboxProxy.MyProxyArguments();
                            proxyArgs.FileName = Title;
                            proxyArgs.FieldData = FieldData;
                            proxyArgs.FolderForResult = ExtraString;

                            // Execute the Proxy activity
                            var result = SPUtility.ExecuteRegisteredProxyOperation(MySandboxProxy.MyProxyArguments.ProxyAssemblyName,
                                                                                   MySandboxProxy.MyProxyArguments.ProxyOperationTypeName,
                                                                                   proxyArgs);

                            // Any exceptions raised will be returned as an exception
                            if (result is Exception)
                            {
                                throw (Exception)result;
                            }
                            string LogMessage = "The result from My Sandbox Proxy is: " + result.ToString();
                            SPWorkflow.CreateHistoryEvent(web, context.WorkflowInstanceId, 0, web.CurrentUser, TimeSpan.Zero, "Information", LogMessage, string.Empty);
                        }
                        catch (Exception ex)
                        {
                            string Message = ex.Message;
                            SPWorkflow.CreateHistoryEvent(web, context.WorkflowInstanceId, 0, web.CurrentUser, TimeSpan.Zero, "Error", "Message: " + Message, string.Empty);
                            throw ex;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle Exception
            }

            return null;
        }
    }
}
