# TODO:
# Add "index" option to identify each step instead of using integers
#
# Usage:
# # initialize the tour
# tour = new BootstrapTour
#
# # then add steps
# tour.addStep({
#	  path: "" # page on which the step popover should be shown
#   element: "" # element next to which the popover should be shown
#   placement: "" # placement of the popover in relation to the element
#   title: "" # title of the popover
#   content: "" # content of the popover
#   next: 0 # index of the step to show next
#   onShow: (tour) -> # function to run before the step is shown
#   onHide: (tour) -> # function to run after the step is shown
# })
#
# # and show the tour
# tour.start
#

(($, window) ->
  document = window.document

  class BootstrapTour
    constructor: (options) ->
      @_options = $.extend({
        afterSaveState: (key, value) ->
        afterGetState: (key, value) ->
      }, options)

      @_steps = []
      @setCurrentStep()

      # Go to next step after click on element with class .next
      $(document).on "click", ".popover .next", (e) =>
        e.preventDefault()
        @nextStep()

      # End tour after click on element with class .end
      $(document).on "click", ".popover .end", (e) =>
        e.preventDefault()
        @end()

    saveState: (key, value) ->
      $.cookie("tour_" + key, value, { expires: 36500, path: '/' })
      @_options.afterSaveState(key, value)

    getState: (key) ->
      value = $.cookie("tour_" + key)
      @_options.afterGetState(key, value)
      return value

    # Add a new step
    addStep: (step) ->
      @_steps.push step

    # Start tour from current step
    start: ->
      @showStep(@_current)

    # Hide current step and show next step
    nextStep: ->
      @hideStep(@_current)
      @showNextStep()

    # End tour
    end: ->
      @hideStep(@_current)
      @saveState("end", "yes")

    # Verify if tour is enabled
    yes: ->
      !@getState("end")

    # Hide the specified step
    hideStep: (i) ->
      step = @_steps[i]
      return unless step?

      step.onHide(@) if step.onHide?

      $(step.element).popover("hide")

    # Show the specified step
    showStep: (i) ->
      step = @_steps[i]

      # If step doesn't exist, end tour
      unless step?
        @end
        return

      @saveStep(i)

      # Redirect to step path if not already there
      if document.location.pathname != step.path
        document.location.href = step.path
        return

      @setNextStep(i)

      # If step element is hidden, skip step
      if $(step.element).is(":hidden")
        @showNextStep()
        return

      # Setup even handler for hiding step
      endOnClick = step.endOnClick || step.element
      $(endOnClick).one "click", () =>
        @endCurrentStep()

      step.onShow(@) if step.onShow?

      # Show popover
      @showPopover(step, i)

    # Show step popover
    showPopover: (step, i) ->
      content = "#{step.content}<br /><p>"
      if i == @_steps.length - 1
        content += "<a href='#' class='end'>Close</a>"
      else
        content += "<a href='##{@_next}' class='next'>Next &raquo;</a>
          <a href='#' class='pull-right end'>Never show again</a></p>"

      $(step.element).popover({
        placement: step.placement
        trigger: "manual"
        title: step.title
        content: content
      }).popover("show")

      # Bootstrap doesn't prevent elements to cross over the edge of the window, so we do that here
      tip = $(step.element).data("popover").tip()
      tipOffset = tip.offset()

      offsetBottom = $(document).outerHeight() - tipOffset.top - $(tip).outerHeight()
      tipOffset.top = tipOffset.top + offsetBottom if offsetBottom < 0
      offsetRight = $(document).outerWidth() - tipOffset.left - $(tip).outerWidth()
      tipOffset.left = tipOffset.left + offsetRight if offsetRight < 0

      tipOffset.top = 0 if tipOffset.top < 0
      tipOffset.left = 0 if tipOffset.left < 0
      tip.offset(tipOffset)

    # Return current step
    getCurrentStep: -> @_steps[@_current]

    # Setup current step variable
    setCurrentStep: ->
      @_current = @getState("current_step")
      if (@_current == null || @_current == "null")
        @_current = 0
      else
        @_current = parseInt(@_current)

    # Save step
    saveStep: (value) ->
      @_current = value
      @saveState("current_step", value)

    # Hide current step and save next step
    endCurrentStep: ->
      @hideStep(@_current)
      @saveStep(@_next)

    # Show next step
    showNextStep: ->
      step = @_steps[@_current]
      next_step = if step.next then step.next else @_current + 1
      @showStep(next_step)

    # Set next step variable
    setNextStep: (i) ->
      i = @_current unless i?
      step = @_steps[i]
      @_next = if step.next then step.next else i + 1

  window.BootstrapTour = BootstrapTour

)(jQuery, window)
