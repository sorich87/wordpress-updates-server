jQuery ($) ->
  tour = new BootstrapTour

  if tour.yes()
    tour.addStep({
      path: "/"
      element: ".brand"
      placement: "bottom"
      title: "Welcome to Push.ly!"
      content: "<p>Now you can push Plugin and Theme updates straight to WordPress.
        <br /><br />Follow this tour to get yourself up and running.</p>"
    })
    tour.addStep({
      path: "/"
      element: "#nav-item-settings"
      placement: "bottom"
      content: "<p>To get started add some information about yourself.
        Click on the Settings link to add info about you and your company.</p>"
    })
    tour.addStep({
      path: "/settings/business"
      element: "#business_name"
      placement: "right"
      content: "<p>Fill in your contact details.
        The email address you use will be the one your customers receive emails from.</p>"
      endOnClick: ".settings-form .btn-primary"
    })
    tour.addStep({
      path: "/settings/business"
      element: "#nav-item-themes"
      placement: "bottom"
      content: "<p>Make your choice: start out by uploading a plugin or a theme.</p>"
      # Set next step depending on if the user clicked on Plugins or Themes
      onShow: (tour) ->
        $("#nav-item-plugins").one "click", () =>
          tour.saveStep(4)
        $("#nav-item-themes").one "click", () =>
          tour.saveStep(5)
    })
    tour.addStep({
      path: "/plugins"
      element: "#upload_new_extension_file"
      placement: "right"
      content: "<p>Click to upload your Plugin.</p>"
      next: 6
      # Show next step after file upload
      onShow: (tour) ->
        $(document).on "change", "input[type=file]", =>
          tour.showStep(6)
    })
    tour.addStep({
      path: "/themes"
      element: "#upload_new_extension_file"
      placement: "right"
      content: "<p>Click to upload your Theme.</p>"
      next: 7
      # Show next step after file upload
      onShow: (tour) ->
        $(document).on "change", "input[type=file]", =>
          tour.showStep(7)
    })
    tour.addStep({
      path: "/plugins"
      element: "#nav-item-packages"
      placement: "bottom"
      content: "<p>Time to create a package. Packages are bundles of plugins\
      and/or themes that your customers have access to updates for.</p>"
      next: 8
    })
    tour.addStep({
      path: "/themes"
      element: "#nav-item-packages"
      placement: "bottom"
      content: "<p>Time to create a package. Packages are bundles of plugins\
      and/or themes that your customers have access to updates for.</p>"
      next: 8
    })
    tour.addStep({
      path: "/packages"
      element: ".toggle-next a"
      placement: "right"
      content: "<p>Click to add a package.</p>"
      # Show next step after making the package creation form visible
      onShow: (tour) ->
        $(".toggle-next a").one "click", () =>
          setTimeout (-> tour.showStep(9)), 0
    })
    tour.addStep({
      path: "/packages"
      element: "#package_name"
      placement: "right"
      content: "<p>Give your package a name, and add your plugins and themes to it.\
      You can offer a one-off payment, or a subscription. Choose the products you want to\
      include and fine-tune the access that you want your customers to have. When you're done, save!</p>"
      endOnClick: ".new-package-form .btn-primary"
    })
    tour.addStep({
      path: "/packages"
      element: "#nav-item-customers"
      placement: "bottom"
      content: "<p>Got a bunch of customers already? Use our bulk importer to add them automatically.</p>"
    })
    tour.addStep({
      path: "/customers"
      element: "#nav-item-themes"
      placement: "bottom"
      content: "<p>When you've got an update, just upload it and we'll push it straight to your WordPress customers.</p>"
    })
    tour.start()
