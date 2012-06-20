jQuery ($) ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  # Add js class to body for javascript interactions
  $("body").addClass("js")

  # Toggle actions links when hovering parent element
  $("span.row-actions").parents("tr").hover(
    () -> $(".row-actions", this).show()
    () -> $(".row-actions", this).hide()
  )

  # Toggle next element
  $(".toggle-next").click (e) ->
    e.preventDefault()
    $(this).next().toggle()

  # Hide target element specified in href
  $(".hide-target").click (e) ->
    e.preventDefault()
    target = $(this).attr("href")
    $(target).hide()
