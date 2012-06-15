# Small set of functions that adds some functionality
# to javascript prototypes/the site that are re-usable


# "hello world".capitalize() # 'Hello world'
String.prototype.capitalize = ->
  return @.charAt(0).toUpperCase() + @.slice(1);


# Our 'namespace'
@pushLy = {
  ui: {}
}

pushLy.ui.createFlashMessage = (message, type='notice') ->
  $flashHTML = $('
    <div class="alert alert-'+type+'">    
    </div>'
  )

  if typeof message == "string"
    $($flashHTML).text(message)
  else
    $(message).appendTo($flashHTML)
  
  # Yes, prepend it
  $('<a class="close" data-dismiss="alert" href="#">&times;</a>').prependTo($flashHTML)
  
  $flashHTML.prependTo('div#main_content')
