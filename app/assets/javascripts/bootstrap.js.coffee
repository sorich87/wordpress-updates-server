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
  $("p.toggle-next").click (e) ->
    e.preventDefault()
    $(this).next().toggle()

  $("a.hide-target").click (e) ->
    e.preventDefault()
    target = $(this).attr("href")
    $(target).hide()
