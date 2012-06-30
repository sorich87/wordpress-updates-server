jQuery ($) ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  # Add js class to body for javascript interactions
  $("body").addClass("js")

  # Toggle next element
  $(".toggle-next").click (e) ->
    e.preventDefault()
    $(this).next().toggle()

  # Hide target element specified in href
  $(".hide-target").click (e) ->
    e.preventDefault()
    target = $(this).attr("href")
    $(target).hide()

  # Display validity or billing frequency field depending on value of billing field on package page
  $("input[name='package[is_subscription]']").change ->
    value = $(this).filter(":checked").val()
    if value == "false"
      $("#validity").show()
      $("#frequency").hide()
    else if value == "true"
      $("#validity").hide()
      $("#frequency").show()
