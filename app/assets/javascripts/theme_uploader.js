var handleCreate = function(info) {
  var response = $.parseJSON(info.response);

  if (response.code == 200) {
    insertNewTheme(response.theme);
  } else {
    handleUploadErrors(response);
  }
};

var insertNewTheme = function(theme) {
  var html = 
    '<li class="span3 theme">'+
      '<div class="thumbnail">'+
        '<img src="http://placehold.it/300x225" alt="'+theme.name+'" />'+
        '<div class="caption">'+
          '<h4>'+theme.name+' '+theme.version+'</h4>'+
          '<div class="btn-toolbar">'+
            '<div class="btn-group">'+
              '<a class="btn btn-mini btn-primary" href="">new version</a>'+
              '<a class="btn btn-mini btn-danger" href="">delete theme</a>'+
            '</div>'+
          '</div>'+
        '</div>'+
      '</div>'+
    '</li>';

  $newButton = $('a#upload_new_theme_file');
  $(html).insertBefore($newButton.parent());

  var $flashHTML = $(
    '<div class="alert alert-info">'+
      'Theme saved.'+
    '</div>'
  );

  $flashHTML.prependTo('div#main_content');
};

var handleUploadErrors = function(theme) {
  var $flashHTML = $(
    '<div class="alert alert-error">'+
      'There were errors in the theme archive. Please review the problems below:'+
      '<ul class="errors">'+
      '</ul>'+
    '</div>'
  );

  var $ul = $flashHTML.find('ul.errors').first();

  $.each(theme.errors, function(attribute, attribute_errors) {
    $.each(attribute_errors, function(index, error) {
      var $li = $(
        '<li>'+attribute.capitalize()+' '+error+
        '</li>'
      );
      $li.appendTo($ul);
    });
  });


  $flashHTML.prependTo('div#main_content');
}

var handleUpdate = function(info) {
  var response = $.parseJSON(info.response);

  if (response.code == "200") {
    updateTheme(response.theme);
  } else {
    handleUploadErrors(response);
  }
};

var updateTheme = function(theme) {
  var   
      $container = $('#theme-'+theme._id),
      $name = $container.find('span.name').first();
      $version = $container.find('span.version').first();

  $name.text(theme.name);
  $version.text(theme.version);

  var $flashHTML = $(
    '<div class="alert alert-info">'+
      'Theme updated.'+
    '</div>'
  );
  $flashHTML.prependTo('div#main_content');

  $container.attr('data-updated', 'true');
}

$(function() {
  var 
      updatePath = '/themes/:id',
      createPath = '/themes';

  $('li.theme').each(function(index, element) {
    var 
        $element = $(element),
        themeId = $element.attr('data-theme-id'),
        $updateButton = $element.find('a#update-'+themeId);

    var theUploader = new plupload.Uploader({
      runtimes: 'html5, flash, silverlight',
      url: updatePath.replace(':id', themeId),
      max_file_size: '10mb',
      container: $element.attr('id'),
      multiple_queues: false,
      browse_button: $updateButton.attr('id'),
      multipart: true,
      multipart_params: uploaderSettings,
      filters: [
        {title: "Compressed theme file", extensions: "zip"}
      ],
    });

    theUploader.init();

    theUploader.bind('FileUploaded', function(up, file, info) {
      handleUpdate(info);
    });

    theUploader.bind('FilesAdded', function(up, files) {
      theUploader.start();
    });
  });
});