using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SharePoint.UserCode;

namespace MySandboxProxy
{
    // http://msdn.microsoft.com/en-us/library/ff798427.aspx

    [Serializable]
    public class MyProxyArguments : SPProxyOperationArgs
    {
        // These properties can be anything you want, so long as they 
        // are serializable.  These properties are your definition
        // of what can be passed from the activity (or any sandboxed
        // solution) to this proxy
        public string FileName { get; set; }
        public string FieldData { get; set; }
        public string FolderForResult { get; set; }

        public static string ProxyOperationTypeName
        {
          get
          {
            return "MySandboxProxy.ProxyOperations";
          }
        }
 
        public static string ProxyAssemblyName
        {
          get
          {
              return "MySandboxProxy, Version=1.0.0.0, Culture=neutral, PublicKeyToken=7db569b6ef62f7b9";
          }
        }

    }
}
