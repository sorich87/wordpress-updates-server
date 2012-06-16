@pushLy.extensionForm ||= {
  config: {
    model: ''
  }
}

@pushLy.extensionForm.insertNewExtension = (html) ->
  $newButton = $('a#upload_new_extension_file')
  html = $(html).insertBefore($newButton.parent())
  html.addClass('new_extension')
  pushLy.ui.createFlashMessage("#{pushLy.extensionForm.config.model.capitalize()} saved.")
  return html

@pushLy.extensionForm.handleUploadErrors = (errors) ->
  $.each(errors, (attribute, attribute_errors) ->
    $.each(attribute_errors, (index, error) ->
      message = attribute.capitalize() + ' ' + error
      pushLy.ui.createFlashMessage(message, 'error')
    )
  )

@pushLy.extensionForm.updateExtension = (extension_id, html) ->
  $container = $('#extension-'+extension_id)
  $container.removeClass('new_extension')

  $container.replaceWith( $(html) )

  new_extension = $("#extension-#{extension_id}")

  pushLy.ui.createFlashMessage("#{pushLy.extensionForm.config.model.capitalize()} updated.")
  new_extension.addClass('new_extension')
  new_extension.attr('data-updated', 'true')
  return new_extension

@pushLy.extensionForm.initExtension = ($element, update_path) ->
  extensionId = $element.attr('data-extension-id')
  $updateButton = $element.find('a#update-'+extensionId)

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
      {title: "Compressed #{pushLy.extensionForm.config.model} file", extensions: "zip"}
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
  $('li.extension').each( (index, element) ->
    pushLy.extensionForm.initExtension($(element))
  )
)
