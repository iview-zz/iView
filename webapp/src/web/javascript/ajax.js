/* ***********************************************************************
*  Cyberoam iView - The Intelligent logging and reporting solution that 
*  provides network visibility for security, regulatory compliance and 
*  data confidentiality 
*  Copyright  (C ) 2009  Elitecore Technologies Ltd.
*  
*  This program is free software: you can redistribute it and/or modify 
*  it under the terms of the GNU General Public License as published by 
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*  
*  This program is distributed in the hope that it will be useful, but 
*  WITHOUT ANY WARRANTY; without even the implied warranty of 
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
*  General Public License for more details.
*  
*  You should have received a copy of the GNU General Public License 
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*  
*  The interactive user interfaces in modified source and object code 
*  versions of this program must display Appropriate Legal Notices, as 
*  required under Section 5 of the GNU General Public License version 3.
*  
*  In accordance with Section 7(b) of the GNU General Public License 
*  version 3, these Appropriate Legal Notices must retain the display of
*   the "Cyberoam Elitecore Technologies Initiative" logo.
*************************************************************************/

var	g_ajax_obj = new ajax_object;	
function ajax_object() {
	// THIS SPACE FOR RENT
};


ajax_object.prototype._dm_xmlhttprequest_type=null;		// Used when trying for the correct XMLHTTP object type.
ajax_object.prototype._dm_xmlhttprequestobject=null;	// This is the HTTP Request Object for this instance.
ajax_object.prototype._dm_callback_function=null;		// The function to be called upon completion of a request.
ajax_object.prototype._dm_param=null;						// An additional parameter to be passed to the function
ajax_object.prototype._dm_partialcallback_function=null;	// A function to be called for the interactive phase
ajax_object.prototype._dm_param2=null;						// An additional parameter to be passed to that function
ajax_object.prototype._dm_phase=0;							// The phase during which this function is called (Default 20).
ajax_object.prototype._dm_queue=new Array();				// This is the queue
ajax_object.prototype._dm_queue_state=true;				// This is the queue state
																			// 	false = paused
																			// 	true = normal
ajax_object.prototype._dm_committed=false;					// This is set to true when the HTTPRequest reaches Stage 20.
ajax_object.prototype._dm_pre_queue_in_url=null;			// These are all used for the "pre-queue."
ajax_object.prototype._dm_pre_queue_in_callback=null;
ajax_object.prototype._dm_pre_queue_in_method=null;
ajax_object.prototype._dm_pre_queue_in_param=null;
ajax_object.prototype._dm_pre_queue_in_pcallback=null;
ajax_object.prototype._dm_pre_queue_in_param2=null;
ajax_object.prototype._dm_pre_queue_in_c2_phase=0;

/******************************************************************
	Constructs a new HTTP Request object. IE and the rest of the
	world have different ideas about what constitutes an HTTP
	Request class, so we deal with that here.
	
	We use the conditional Jscript stuff that IE supports to create
	an *.XMLHTTP object, or the standard Mozilla/Netscape XMLHttpRequest object.
	
	We use this as a test. If this object can't create the HTTP request object
	(either XMLHttpRequest or *.XMLHTTP), then the browser can't handle AJAX.
*/


ajax_object.prototype.GetNewRequestObject = function() {
	// check the dom to see if this is IE or not
	if (window.XMLHttpRequest) {
		// Not IE
		this._dm_xmlhttprequestobject = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		// Hello IE!
		// Instantiate the latest MS ActiveX Objects
		if (this._dm_xmlhttprequest_type) {
			this._dm_xmlhttprequestobject = new ActiveXObject(this._dm_xmlhttprequest_type);
		} else {
			// loops through the various versions of XMLHTTP to ensure we're using the latest
			var versions = ["Msxml2.XMLHTTP.7.0", "Msxml2.XMLHTTP.6.0", "Msxml2.XMLHTTP.5.0", "Msxml2.XMLHTTP.4.0", "MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP", "Microsoft.XMLHTTP"];
			for (var i = 0; i < versions.length ; i++) {
         	try {
					// try to create the object
						// if it doesn't work, we'll try again
						// if it does work, we'll save a reference to the proper one to speed up future instantiations
					this._dm_xmlhttprequestobject = new ActiveXObject(versions[i]);
					if (this._dm_xmlhttprequestobject) {
						this._dm_xmlhttprequest_type = versions[i];
						break;
					}
            }
            catch (objException) {
            	// trap; try next one
				};
			};
		}
	}
};

 	
/******************************************************************
	Kills the Queue (non-negotiable cancel).
	If there is still an HTTPRequest out there, it will allow that to complete.
*/

ajax_object.prototype.QueueFlush = function ( ) {
	this._dm_queue = new Array();
	this.QueueResume();	// If the queue was paused, it is now re-enabled
}

/******************************************************************
	This pauses the queue by clearing a semaphore.
	If there is still an HTTPRequest out there, it will allow that to complete.
*/

ajax_object.prototype.QueuePause = function ( ) {
	this._dm_queue_state = false;
}

/******************************************************************
	This re-enables the queue. It calls Dequeue() to start the chain
	going again.
*/

ajax_object.prototype.QueueResume = function ( ) {
	this._dm_queue_state = true;
	this.Dequeue();
}

/******************************************************************
	This bypasses the queue, and injects an HTTPRequest right in.
	This is a dangerous call, as it wipes out any command currently
	being run.
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_method:		The HTTP method to use (default is GET).
		in_param:		A parameter (any type) that is passed into the callback
		in_pcallback:	Partial callback
		in_param2:		A second parameter for the partial callback
		in_phase:		The phase during which the second callback will be made (1-20), Default is 20.
*/

ajax_object.prototype.QueueInterrupt = function ( in_url, in_callback, in_method, in_param, in_pcallback, in_param2, in_phase ) {
	var url = in_url;
	this._dm_callback_function = in_callback;	// The basic callback
	var method = in_method;
	this._dm_param = in_param;	// If there is a parameter, we get it here.
	this._dm_partialcallback_function = in_pcallback;	// If there is a partial callback, we get it here.
	this._dm_param2 = in_param2;	// If there is a second parameter, we get it here.
	this._dm_phase = in_phase;	// If there is a second parameter, we get it here.
	
	if ( url && method ) {
		ret = this._CallXMLHTTPObject ( url, method );
		}
	
	return ret;
}

/******************************************************************
	This is a gentler version of the above. It injects the command
	as the next one to be processed, cutting the line.
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_method:		The HTTP method to use (default is GET).
		in_param:		A parameter (any type) that is passed into the callback
		in_pcallback:	Partial callback
		in_param2:		A second parameter for the partial callback
		in_phase:		The phase during which the second callback will be made (1-20), Default is 20.
*/

ajax_object.prototype.QueueInject = function ( in_url, in_callback, in_method, in_param, in_pcallback, in_param2, in_phase ) {

	this._dm_queue_state = false;

	// Move the queue up one to make room at the start.
	for ( var counter = this._dm_queue.length; counter > 0; counter-- ) {
		this._dm_queue[counter] = this._dm_queue[counter - 1];
		}
		
	this._dm_queue[0] = new Array ( in_url, in_callback, in_method, in_param, in_pcallback, in_param2, in_phase );

	this._dm_queue_state = true;	// We don't call DeQueue, so we won't interrupt any request in progress.
}

/******************************************************************
	Basic Ajax Call for GET method
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
*/

ajax_object.prototype.CallXMLHTTPObjectGET = function ( in_url, in_callback ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "GET", null, null, 0 );
}

/******************************************************************
	Basic Ajax Call for GET method (with additional parameter)
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_param:		A parameter (any type) that is passed into the callback
							This parameter is used to pass things such as a field ID,
							etc. to the callback, and can be used to propagate a
							context. Callbacks tend to be free of context, so this
							helps to get around that problem.
*/

ajax_object.prototype.CallXMLHTTPObjectGETParam = function ( in_url, in_callback, in_param ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "GET", in_param, null, 0 );
}

/******************************************************************
	Basic Ajax Call for GET method (with additional parameter and partial callback)
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_param:		A parameter (any type) that is passed into the callback
							This parameter is used to pass things such as a field ID,
							etc. to the callback, and can be used to propagate a
							context. Callbacks tend to be free of context, so this
							helps to get around that problem.
		in_pcallback:	This specifies a "partial callback" function that is called
							when the request reaches Phase 20 (interactive).
		in_param2:		A second parameter for the partial callback
*/

ajax_object.prototype.CallXMLHTTPObjectGETParamPartial = function ( in_url, in_callback, in_param, in_pcallback, in_param2 ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "GET", in_param, in_pcallback, in_param2, 0 );
}

/******************************************************************
	Basic Ajax Call for GET method (with additional parameter, partial
	callback and partial callback phase)
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_param:		A parameter (any type) that is passed into the callback
							This parameter is used to pass things such as a field ID,
							etc. to the callback, and can be used to propagate a
							context. Callbacks tend to be free of context, so this
							helps to get around that problem.
		in_pcallback:	This specifies a "partial callback" function that is called
							when the request reaches Phase 20 (interactive).
		in_param2:		A second parameter for the partial callback
		in_phase:		The request phase (1-20) during which the partial callback is made.
*/

ajax_object.prototype.CallXMLHTTPObjectGETParamPartialPhase = function ( in_url, in_callback, in_param, in_pcallback, in_param2, in_phase ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "GET", in_param, in_pcallback, in_param2, in_phase );
}

/******************************************************************
	Basic Ajax Call for POST method
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
*/

ajax_object.prototype.CallXMLHTTPObjectPOST = function ( in_url, in_callback ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "POST", null, null, 0 );
}

/******************************************************************
	Basic Ajax Call for POST method (with additional parameter)
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_param:		A parameter (any type) that is passed into the callback
							This parameter is used to pass things such as a field ID,
							etc. to the callback, and can be used to propagate a
							context. Callbacks tend to be free of context, so this
							helps to get around that problem.
*/

ajax_object.prototype.CallXMLHTTPObjectPOSTParam = function ( in_url, in_callback, in_param ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "POST", in_param, null, 0 );
}

/******************************************************************
	Basic Ajax Call for POST method (with additional parameter and partial callback)
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_param:		A parameter (any type) that is passed into the callback
							This parameter is used to pass things such as a field ID,
							etc. to the callback, and can be used to propagate a
							context. Callbacks tend to be free of context, so this
							helps to get around that problem.
		in_pcallback:	This specifies a "partial callback" function that is called
							when the request reaches Phase 20 (interactive).
		in_param2:		A second parameter for the partial callback
*/

ajax_object.prototype.CallXMLHTTPObjectPOSTParamPartial = function ( in_url, in_callback, in_param, in_pcallback, in_param2 ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "POST", in_param, in_pcallback, in_param2, 0 );
}

/******************************************************************
	Basic Ajax Call for POST method (with additional parameter, partial
	callback and partial callback phase)
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_param:		A parameter (any type) that is passed into the callback
							This parameter is used to pass things such as a field ID,
							etc. to the callback, and can be used to propagate a
							context. Callbacks tend to be free of context, so this
							helps to get around that problem.
		in_pcallback:	This specifies a "partial callback" function that is called
							when the request reaches Phase 20 (interactive).
		in_param2:		A second parameter for the partial callback
		in_phase:		The request phase (1-20) during which the partial callback is made.
*/

ajax_object.prototype.CallXMLHTTPObjectPOSTParamPartialPhase = function ( in_url, in_callback, in_param, in_pcallback, in_param2, in_phase ) {
	return this.CallXMLHTTPObject ( in_url, in_callback, "POST", in_param, in_pcallback, in_param2, in_phase );
}

/******************************************************************
	Prime a call to the queue
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_method:		The HTTP method to use (default is GET).
		in_param:		A parameter (any type) that is passed into the callback
		in_pcallback:	Partial callback
		in_param2:		A second parameter for the partial callback
		in_phase:		The phase during which the second callback will be made (1-20), Default is 20.
*/

ajax_object.prototype.CallXMLHTTPObject = function ( in_url, in_callback, in_method, in_param, in_pcallback, in_param2, in_phase ) {
	// Set up the "pre queue."
	this._dm_pre_queue_in_url=in_url;
	this._dm_pre_queue_in_callback=in_callback;
	this._dm_pre_queue_in_method=in_method;
	this._dm_pre_queue_in_param=in_param;
	this._dm_pre_queue_in_pcallback=in_pcallback;
	this._dm_pre_queue_in_param2=in_param2;
	this._dm_pre_queue_in_c2_phase=in_phase;
	if ( (this._dm_pre_queue_in_c2_phase < 1) || (this._dm_pre_queue_in_c2_phase > 20) ) {
		this._dm_pre_queue_in_c2_phase = 20;
		}
	this.Enqueue();
	return true;
};

/******************************************************************
	Add a call to the queue
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_method:		The HTTP method to use (default is GET).
		in_param:		A parameter (any type) that is passed into the callback
		in_pcallback:	Partial callback
		in_param2:		A second parameter for the partial callback
*/

ajax_object.prototype.Enqueue = function ( ) {
	// Set up the main queue from the prequeue.
	this._dm_queue[this._dm_queue.length] = new Array ( this._dm_pre_queue_in_url, this._dm_pre_queue_in_callback,
		this._dm_pre_queue_in_method, this._dm_pre_queue_in_param, this._dm_pre_queue_in_pcallback,
		this._dm_pre_queue_in_param2, this._dm_pre_queue_in_c2_phase );
	
	// As you were...
	this._dm_pre_queue_in_url=null;
	this._dm_pre_queue_in_callback=null;
	this._dm_pre_queue_in_method=null;
	this._dm_pre_queue_in_param=null;
	this._dm_pre_queue_in_pcallback=null;
	this._dm_pre_queue_in_param2=null;
	this._dm_pre_queue_in_c2_phase=0;
		
	// If there are no other commands in progress, we start the daisy-chain.
	if ( !this._dm_xmlhttprequestobject ) {
		this.Dequeue();
		}
};

/******************************************************************
	Dequeue and execute
*/

ajax_object.prototype.Dequeue = function ( ) {
	var command = null;
	var ret=false;
	
	if ( this._dm_queue.length && this._dm_queue_state ) {
		command = this._dm_queue[0];
		
		var url = command[0];
		this._dm_callback_function = command[1];	// The basic callback
		var method = command[2];
		this._dm_param = command[3];	// If there is a parameter, we get it here.
		this._dm_partialcallback_function = command[4];	// If there is a partial callback, we get it here.
		this._dm_param2 = command[5];	// If there is a second parameter, we get it here.
		this._dm_phase = command[6];	// If there is a second parameter, we get it here.
		
		for ( var counter = 1; counter < this._dm_queue.length; counter++ ) {
			this._dm_queue[counter - 1] = this._dm_queue[counter];
			}
		
		this._dm_queue.length = counter - 1;
		}
	
	if ( url && method ) {
		ret = this._CallXMLHTTPObject ( url, method );
		}
	
	return ret;
};

/******************************************************************
	Basic low-level Ajax Call
	
	Params:
		in_url: 			The URL to call
		in_callback:	A function to be called upon completion
		in_method:		The HTTP method to use (default is GET).
*/

ajax_object.prototype._CallXMLHTTPObject = function ( in_url, in_method ) {
	try {
		var sVars = null;
		
		// Split the URL up, if this is a POST.
		if ( in_method == "POST" ) {
			var rmatch = /^([^\?]*)\?(.*)$/.exec ( in_url );
			in_url = rmatch[1];
			sVars = unescape ( rmatch[2] );
			}
		
		this._dm_committed = false;
		this.GetNewRequestObject();
		this._dm_xmlhttprequestobject.open(in_method, in_url, true);
		
		if ( in_method == "POST" ) {
		  this._dm_xmlhttprequestobject.setRequestHeader("Method", "POST "+in_url+" HTTP/1.1");
		  this._dm_xmlhttprequestobject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			}
		
		this._dm_xmlhttprequestobject.onreadystatechange = Handle_HTTP_Response;
		this._dm_xmlhttprequestobject.send(sVars);
		
		return true;
		}
	catch ( z ) { }
	
	return false;
};

/******************************************************************
	This is the callback router. This is set as the callback in the
	request object, and it then routes the callback to the one provided
	by the calling context. It uses the global object to associate the
	parameters provided to the callback.
	
	This is a fairly typical pattern used by "faux OOP" systems. I call
	the pattern FALSE OBJECT. It allows a procedural language to establish
	an object context. Javascript is (sort of) object-oriented, but HTTP
	requests are not. When you get a callback from an HTTP Request, it is
	context-free. I use the SINGLETON global object to re-establish a
	context, and restore the object-oriented code.
	
	Note the partial callback we make. We can choose the stage at which
	this partial callback is made. Default is 20 (Interactive). You cannot
	make a partial callback at Stage 0.
*/

function Handle_HTTP_Response () {
	/*
		Okay, what I needed to do was test for IE. If you even take a peek at the responseXML or responseBody fields
		during an incomplete request (0 - 20), in Windows IE 6 or IE 7, you get a JavaScript error. If the UA is IE,
		then I skip looking at the field (That's what all that stuff with "resp" down there is for).
		
		The long and the short of it is that you get no reliable responseXML in IE. You will get your callback, along
		with the partial callback parameter you sent, but no text. Mozilla/KDE will give you text as of Stage 20.
	*/
	var ie = navigator.appName=='Microsoft Internet Explorer';	// Are we IE?
	
	if ( g_ajax_obj && g_ajax_obj._dm_xmlhttprequestobject ) {	// Don't even bother if we don't have a request object to use.
		if ( g_ajax_obj._dm_xmlhttprequestobject.readyState == 0 ) {	// Uninitialized (sent, but no information yet)
			}
		else {
			if ( g_ajax_obj._dm_xmlhttprequestobject.readyState == 1 ) {	// Loading (probably received)
				if ( g_ajax_obj._dm_phase == g_ajax_obj._dm_xmlhttprequestobject.readyState ) {
					if ( g_ajax_obj._dm_partialcallback_function ) {
						var resp;	// This is all about the IE fix mentioned above.
						if(!ie && g_ajax_obj._dm_xmlhttprequestobject.responseXML){
							resp=g_ajax_obj._dm_xmlhttprequestobject.responseXML;
							}
						g_ajax_obj._dm_partialcallback_function ( resp, g_ajax_obj._dm_param2 ? g_ajax_obj._dm_param2 : g_ajax_obj._dm_param );
						}
					}
				}
			else {
				if ( g_ajax_obj._dm_xmlhttprequestobject.readyState == 2 ) {	// Loaded (received for sure, but no further data)
					// At this point, the server has the request, and is executing it (probably).
					if ( g_ajax_obj._dm_phase == g_ajax_obj._dm_xmlhttprequestobject.readyState ) {
						if ( g_ajax_obj._dm_partialcallback_function ) {
							var resp;
							if(!ie && g_ajax_obj._dm_xmlhttprequestobject.responseXML){
								resp=g_ajax_obj._dm_xmlhttprequestobject.responseXML;
								}
							g_ajax_obj._dm_partialcallback_function ( resp, g_ajax_obj._dm_param2 ? g_ajax_obj._dm_param2 : g_ajax_obj._dm_param );
							}
						}
					}
				else {
					if ( g_ajax_obj._dm_xmlhttprequestobject.readyState == 3 ) {	// Interactive
						// At this point, the server has the request, and is executing it. A partial response MAY be available
						// in the g_ajax_obj._dm_xmlhttprequestobject.responseXML and g_ajax_obj._dm_xmlhttprequestobject.responseBody
						// fields.
						// We have the option of sending a "Partial Callback" function, which we can use to do things like
						// disable a button to prevent additional requests.
						g_ajax_obj._dm_committed = true;
						if ( g_ajax_obj._dm_phase == g_ajax_obj._dm_xmlhttprequestobject.readyState ) {
							if ( g_ajax_obj._dm_partialcallback_function ) {
								var resp;
								if(!ie && g_ajax_obj._dm_xmlhttprequestobject.responseXML){
									resp=g_ajax_obj._dm_xmlhttprequestobject.responseXML;
									}
								g_ajax_obj._dm_partialcallback_function ( resp, g_ajax_obj._dm_param2 ? g_ajax_obj._dm_param2 : g_ajax_obj._dm_param );
								}
							}
						}
					else {
						if ( g_ajax_obj._dm_xmlhttprequestobject.readyState == 4 ) {	// We're done. Back to you.
							// We send both parameters, just in case they both apply (for example, the partial disables a field,
							// so the complete one re-enables it).
							g_ajax_obj._dm_callback_function ( g_ajax_obj._dm_xmlhttprequestobject.responseXML, g_ajax_obj._dm_param, g_ajax_obj._dm_param2 );
							if( typeof g_ajax_obj != 'undefined' ) { // Just in case they nuked the object in the callback.
								g_ajax_obj._dm_xmlhttprequestobject = null;	// Kill the request object. we're done.
								g_ajax_obj._dm_committed = false;
								g_ajax_obj._dm_phase = 0;
								g_ajax_obj.Dequeue();
								}
							}
						}
					}
				}
			}
		}
return true;
};

/******************************************************************
	Returns true if the browser will support Ajax
	
	Very simple. We just create a request object. If it succeeds, we're in like Flint.
*/

if (typeof SupportsAjax == 'undefined'){	// In case we included ajax_threads.js
	function SupportsAjax ( ) {
		var test_obj = new ajax_object;
		
		if( typeof test_obj != 'undefined' ) {
			test_obj.GetNewRequestObject();
			
			if ( test_obj._dm_xmlhttprequestobject ) {
				test_obj._dm_xmlhttprequestobject = null;
				test_obj = null;
				return true;
				}
			
			test_obj = null;
			}
		
		return false;
	};
}

/******************************************************************
	Completely simplified AJAX Call. Just add a callback.
	
	Params:
		in_uri: 			The URI to call. Even if it is a POST, you
							specify the URI as if it were a GET. The class
							will take care of stripping out the parameters.
							This parameter is required.
							
		in_callback:	A function to be called upon completion
							Your callback should have the following format:
							
							function Callback(in_string)
							
							You don't have to worry about a parameter, as
							none will be sent in this simplified callback.
							This parameter is required.
							
		in_method:		The HTTP method to use (default is GET).
							Must be either 'GET' or 'POST' (case-insensitive)
							This parameter is optional.
							
		in_param:		A "context keeper" parameter. This will be passed
							into your callback.
							This parameter is optional.
							
	Function return:
		true if the call was successfully queued (not actually sent as
		a request), false if there was any type of error. The type of
		error is not specified. It could be a required parameter was not
		sent in, the browser does not support AJAX, or there was an issue
		with the queue mechanism.
*/

function SimpleAJAXCall ( in_uri, in_callback, in_method, in_param ) {
	// The method indicator is actually optional, so we make it GET if nothing was passed.
	if ( (typeof in_method == 'undefined') || ((in_method != 'GET')&&(in_method != 'POST')) ) {
		in_method = 'GET';
		}
	
	in_method = in_method.toUpperCase();
	
	// We verify that the proper parameters have been passed in.
	if ( SupportsAjax() && (typeof in_uri != 'undefined') && in_uri && (typeof in_callback == 'function') ) {
		if ( in_method == 'POST' ) {
			return g_ajax_obj.CallXMLHTTPObjectPOSTParam ( in_uri, in_callback, in_param );
			} else {
			return g_ajax_obj.CallXMLHTTPObjectGETParam ( in_uri, in_callback, in_param );
			}
		} else {
			return false;
		}
};
