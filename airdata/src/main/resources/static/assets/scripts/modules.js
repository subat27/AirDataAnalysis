const editor_imageUploader = (blobInfo, progress) => new Promise((resolve, reject) => {
	let csrfToken = document.querySelector("meta[name='_csrf']").getAttribute("content");
   	let csrfHeader = document.querySelector("meta[name='_csrf_header']").getAttribute("content");
   	
   	const xhr = new XMLHttpRequest();
   	
   	xhr.withCredentials = true;
   	xhr.open('POST', '/uploader');
   	xhr.setRequestHeader(csrfHeader, csrfToken);
   	
   	xhr.upload.onprogress = (event) => {
		progress(event.loaded / event.total * 100);   
	};
	
	xhr.onload = () => {
		if (xhr.status === 403) {
			reject({ message: 'HTTP Error : ' + xhr.status, remove: true });
			return;
		}
		if (xhr.status < 200 || xhr.status >= 300) {
    		reject('HTTP Error : ' + xhr.status);
    	  	return;
    	}
    	
    	const json = JSON.parse(xhr.responseText);
    	
    	if (!json || typeof json.location != 'string') {
			reject('Invalid JSON : ' + xhr.responseText);
			return;
		}
		
		resolve(json.location);
	};
	
	xhr.onerror = () => {
		reject('');
	}
	
	const formData = new FormData();
    formData.append('file', blobInfo.blob(), blobInfo.filename());

    xhr.send(formData);
});