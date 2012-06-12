@themeMy.themeForm ||= {
}

@themeMy.themeForm.insertNewTheme = (html) ->
  $newButton = $('a#upload_new_theme_file')
  html = $(html).insertBefore($newButton.parent())
  html.addClass('new_theme')
  themeMy.ui.createFlashMessage('Theme saved.')
  return html

@themeMy.themeForm.handleUploadErrors = (errors) ->
  $ul = $('<ul class="errors"></ul>')

  $.each(errors, (attribute, attribute_errors) ->
    $.each(attribute_errors, (index, error) ->
      $li = $(
        '<li>'+attribute.capitalize()+' '+error+
        '</li>'
      )
      $li.appendTo($ul)
    )
  )
  themeMy.ui.createFlashMessage($ul, 'error')

@themeMy.themeForm.updateTheme = (theme_id, html) ->
  $container = $('#theme-'+theme_id)
  $container.removeClass('new_theme')

  $container.replaceWith( $(html) )

  new_theme = $("#theme-#{theme_id}")

  themeMy.ui.createFlashMessage('Theme updated.')
  new_theme.addClass('new_theme')
  new_theme.attr('data-updated', 'true')
  return new_theme

@themeMy.themeForm.initTheme = ($element, update_path) ->
  themeId = $element.attr('data-theme-id')
  $updateButton = $element.find('a#update-'+themeId)

  theUploader = new plupload.Uploader({
    runtimes: 'html5, flash, silverlight',
    url: $element.attr('data-update-path'),
    max_file_size: '10mb',
    container: $element.attr('id'),
    multiple_queues: false,
    browse_button: $updateButton.attr('id'),
    multipart: true,
    multipart_params: uploaderSettings,
    filters: [
      {title: "Compressed theme file", extensions: "zip"}
    ],
  })

  theUploader.init()

  theUploader.bind('FileUploaded', (up, file, info) ->
    eval(info.response)
  )

  theUploader.bind('FilesAdded', (up, files) ->
    theUploader.start()
  )


$( ->
  $('li.theme').each( (index, element) ->
    themeMy.themeForm.initTheme($(element))
  )
)