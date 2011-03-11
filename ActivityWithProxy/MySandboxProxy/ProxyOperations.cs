using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SharePoint.UserCode;
using System.IO;

namespace MySandboxProxy
{
    public class ProxyOperations : SPProxyOperation
    {
        public override object Execute(SPProxyOperationArgs args)
        {
            try
            {
                MyProxyArguments MyProxyArgs = (MyProxyArguments)args;

                // Do stuff - full trust available, so you can write to the filesystem,
                // make HTTP requests, talk to a database, etc.

                // Return the result of your calculations / work
                return 84;
            }
            catch (Exception e)
            {
                // We'll return the exception so we can deal with it in the calling
                // class rather than letting it fail here
                return e;
            }
        }
    }
}
