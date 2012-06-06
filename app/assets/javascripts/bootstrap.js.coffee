jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $("body").addClass("js")
  $(".actions").parent().hover(
    () -> $(".actions", this).show()
    () -> $(".actions", this).hide()
  )
