$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;
 

  var dropzone = new Dropzone (".dropzone", {
    maxFilesize: 5, // Set the maximum file size to 5 MB
    paramName: "collage_image[image]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: false // Don't show remove links on dropzone itself.
  }); 

  dropzone.on("success", function(file) {
    this.removeFile(file)
    $.getScript("/collage_images")
  })
});