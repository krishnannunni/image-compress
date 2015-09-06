
<% String contextPath=request.getContextPath();%>
<!doctype html>
<html>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
	<head>
		<title>JavaScript Image Resample :: WebReflection</title>
	</head>
	<body>
		<input id="width" type="hidden" value="320" />
		<input id="height" type="hidden" />
		<input id="data" type="hidden" />
		<input id="file" type="file" />
		<br /><span id="message"></span><br />
		<canvas id="canvas"  height="240" width="320"></canvas>
		<div id="img"></div>
		
    
	</body>
	<script>
	(function ( $width, $height, $file, $img) {
		
		// (C) WebReflection Mit Style License
		
		// simple FileReader detection
		
		
		// async callback, received the
		// base 64 encoded resampled image
		function resampled(data) {
			//$message.innerHTML = "done";
			alert("===data="+data);
			 ($img.lastChild || $img.appendChild(new Image)
			).src = data; 
			document.getElementById("data").value=data;
			var canvas = document.getElementById("canvas");
			  var context = canvas.getContext("2d");
			  var img = document.getElementById("img");
			  var width = parseInt(img.width);
			  var height = parseInt(img.height);
			  context.drawImage(img, 0, 0, width, height);
	       alert(document.getElementById("data").value);
		}
		
		// async callback, fired when the image
		// file has been loaded
		function load(e) {
			//$message.innerHTML = "resampling ...";
			// see resample.js
			Resample(
					this.result,
					this._width || null,
					this._height || null,
					resampled
			);
			
		}
		
		// async callback, fired if the operation
		// is aborted ( for whatever reason )
		function abort(e) {
			//$message.innerHTML = "operation aborted";
		}
		
		// async callback, fired
		// if an error occur (i.e. security)
		function error(e) {
			//$message.innerHTML = "Error: " + (this.result || e);
		}
		
		// listener for the input@file onchange
		$file.addEventListener("change", function change() {
			var
				// retrieve the width in pixel
				width = parseInt($width.value, 10),
				// retrieve the height in pixels
				height = parseInt($height.value, 10),
				// temporary variable, different purposes
				file
			;
			// no width and height specified
			// or both are NaN
			if (!width && !height) {
				// reset the input simply swapping it
				$file.parentNode.replaceChild(
					file = $file.cloneNode(false),
					$file
				);
				// remove the listener to avoid leaks, if any
				$file.removeEventListener("change", change, false);
				// reassign the $file DOM pointer
				// with the new input text and
				// add the change listener
				($file = file).addEventListener("change", change, false);
				// notify user there was something wrong
				//$message.innerHTML = "please specify width or height";
			} else if(
				// there is a files property
				// and this has a length greater than 0
				($file.files || []).length &&
				// the first file in this list 
				// has an image type, hopefully
				// compatible with canvas and drawImage
				// not strictly filtered in this example
				/^image\//.test((file = $file.files[0]).type)
			) {
				// reading action notification
				//$message.innerHTML = "reading ...";
				// create a new object
				file = new FileReader;
				// assign directly events
				// as example, Chrome does not
				// inherit EventTarget yet
				// so addEventListener won't
				// work as expected
				file.onload = load;
				file.onabort = abort;
				file.onerror = error;
				// cheap and easy place to store
				// desired width and/or height
				file._width = width;
				file._height = height;
				// time to read as base 64 encoded
				// data te selected image
				file.readAsDataURL($file.files[0]);
				// it will notify onload when finished
				// An onprogress listener could be added
				// as well, not in this demo tho (I am lazy)
			} else if (file) {
				// if file variable has been created
				// during precedent checks, there is a file
				// but the type is not the expected one
				// wrong file type notification
				//$message.innerHTML = "please chose an image";
			} else {
				// no file selected ... or no files at all
				// there is really nothing to do here ...
				//$message.innerHTML = "nothing to do";
			}
		}, false);
	}(
	
		// all required fields ...
		document.getElementById("width"),
		document.getElementById("height"),
		document.getElementById("file"),
		document.getElementById("img")
	));
	</script>
</html>
