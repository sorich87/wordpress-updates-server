@themeMy.themeForm ||= {}
@themeMy.themeForm.handleCreate = (info) ->
  response = $.parseJSON(info.response)

  if response.code == 200
    this.insertNewTheme(response.theme)
  else 
    this.handleUploadErrors(response)

@themeMy.themeForm.insertNewTheme = (theme) ->
  html = 
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
    '</li>'

  $newButton = $('a#upload_new_theme_file')
  $(html).insertBefore($newButton.parent())

  themeMy.ui.createFlashMessage('Theme saved.')

@themeMy.themeForm.handleUploadErrors = (theme) ->
  $ul = $('<ul class="errors"></ul>')

  $.each(theme.errors, (attribute, attribute_errors) ->
    $.each(attribute_errors, (index, error) ->
      $li = $(
        '<li>'+attribute.capitalize()+' '+error+
        '</li>'
      )
      $li.appendTo($ul)
    )
  )

  themeMy.ui.createFlashMessage($ul, 'error')


@themeMy.themeForm.handleUpdate = (info) ->
  response = $.parseJSON(info.response)

  if response.code == 200
    this.updateTheme(response.theme)
  else
    this.handleUploadErrors(response)

@themeMy.themeForm.updateTheme = (theme) ->
  $container = $('#theme-'+theme._id)
  $name = $container.find('span.name').first()
  $version = $container.find('span.version').first()

  $name.text(theme.name)
  $version.text(theme.version)

  themeMy.ui.createFlashMessage('Theme updated.')
  $container.attr('data-updated', 'true')

$( ->
  updatePath = '/themes/:id'
  createPath = '/themes'

  $('li.theme').each( (index, element) ->
    $element = $(element)
    themeId = $element.attr('data-theme-id')
    $updateButton = $element.find('a#update-'+themeId)

    theUploader = new plupload.Uploader({
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
    })

    theUploader.init()

    theUploader.bind('FileUploaded', (up, file, info) ->
      themeMy.themeForm.handleUpdate(info)
    )

    theUploader.bind('FilesAdded', (up, files) ->
      theUploader.start()
    )
  )
)