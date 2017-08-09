library (httpuv)
library (methods)
#----------------------------------------------------------------------------------------------------
browserVizTemplateBrowserFile <- system.file(package="BrowserVizTemplate", "browserCode", "dist", "template.html")
#----------------------------------------------------------------------------------------------------
.BrowserVizTemplate <- setClass ("BrowserVizTemplateClass",
                            representation = representation (),
                            contains = "BrowserVizClass",
                            prototype = prototype (uri="http://localhost", 9000)
                            )

#----------------------------------------------------------------------------------------------------
setGeneric ('ping',  signature='obj', function (obj) standardGeneric ('ping'))
setGeneric ('getSelection',  signature='obj', function (obj) standardGeneric ('getSelection'))
#----------------------------------------------------------------------------------------------------
setupMessageHandlers <- function()
{
   addRMessageHandler("handleResponse", "handleResponse")

} # setupMessageHandlers
#----------------------------------------------------------------------------------------------------
# constructor
BrowserVizTemplate = function(portRange, host="localhost", title="BrowserVizTemplate", quiet=TRUE)
{
  .BrowserVizTemplate(BrowserViz(portRange, host, title, quiet, browserFile=browserVizTemplateBrowserFile))

} # BrowserVizTemplate: constructor
#----------------------------------------------------------------------------------------------------
setMethod('ping', 'BrowserVizTemplateClass',

  function (obj) {
     send(obj, list(cmd="ping", callback="handleResponse", status="request", payload=""))
     while (!browserResponseReady(obj)){
        if(!obj@quiet) message(sprintf("plot waiting for browser response"));
        Sys.sleep(.1)
        }
     getBrowserResponse(obj)
     }) # ping

#----------------------------------------------------------------------------------------------------
setMethod('getSelection', 'BrowserVizTemplateClass',

  function (obj) {
     send(obj, list(cmd="getSelection", callback="handleResponse", status="request", payload=""))
     while (!browserResponseReady(obj)){
        if(!obj@quiet) message(sprintf("getSelection waiting for browser response"));
        Sys.sleep(.1)
        }
     getBrowserResponse(obj)
     })

#----------------------------------------------------------------------------------------------------
