var insertFormDetails = function(details) {
  var $form     = $('form#new_theme'),
      $uploader = $('#upload_theme'),
      $step2    = $('#form-step-2');

  var $name         = $step2.find('#theme_name').first(),
      $version      = $step2.find('#theme_version').first(),
      $description  = $step2.find('#theme_description').first(),
      $license      = $step2.find('#theme_license').first(),
      $license_uri  = $step2.find('#theme_license_uri').first(),
      $tags         = $step2.find('#theme_tags').first();

  var theme = details.theme;
  $name.val(theme.theme_name);
  $version.val(theme.version);
  $description.val(theme.description);
  $license.val(theme.license);
  $license_uri.val(theme.license_uri);
  $tags.val(theme.tags.join(', '));

  $step2.hide().removeClass('hidden');
  $step2.fadeIn('slow');
}


var handleUpload = function(info) {
  if (info.status == 200) {
    insertFormDetails( $.parseJSON(info.response) );
  } else {
    handleFormErrors( $.parseJSON(info.response) );
  }
}