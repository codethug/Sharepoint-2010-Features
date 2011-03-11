using System;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Security;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.UserCode;

namespace MySandboxProxy.Features.My_Sandbox_Proxy
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("2635c5b3-11c1-40bf-9eaa-0ad92e81af7c")]
    public class My_Sandbox_ProxyEventReceiver : SPFeatureReceiver
    {
        // Uncomment the method below to handle the event raised after a feature has been activated.

        public override void FeatureActivated(SPFeatureReceiverProperties properties)
        {
            SPUserCodeService userCodeService = SPUserCodeService.Local;

            var MyOperation = new SPProxyOperationType(MyProxyArguments.ProxyAssemblyName, MyProxyArguments.ProxyOperationTypeName);

            if (userCodeService.ProxyOperationTypes.Contains(MyOperation))
            {
                userCodeService.ProxyOperationTypes.Remove(MyOperation);
            }

            userCodeService.ProxyOperationTypes.Add(MyOperation);
            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                userCodeService.Update();
            });
        }


        // Uncomment the method below to handle the event raised before a feature is deactivated.

        public override void FeatureDeactivating(SPFeatureReceiverProperties properties)
        {
            SPUserCodeService userCodeService = SPUserCodeService.Local;

            var MyOperation = new SPProxyOperationType(MyProxyArguments.ProxyAssemblyName, MyProxyArguments.ProxyOperationTypeName);

            userCodeService.ProxyOperationTypes.Remove(MyOperation);
            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                userCodeService.Update();
            });
        }


        // Uncomment the method below to handle the event raised after a feature has been installed.

        //public override void FeatureInstalled(SPFeatureReceiverProperties properties)
        //{
        //}


        // Uncomment the method below to handle the event raised before a feature is uninstalled.

        //public override void FeatureUninstalling(SPFeatureReceiverProperties properties)
        //{
        //}

        // Uncomment the method below to handle the event raised when a feature is upgrading.

        //public override void FeatureUpgrading(SPFeatureReceiverProperties properties, string upgradeActionName, System.Collections.Generic.IDictionary<string, string> parameters)
        //{
        //}
    }
}
