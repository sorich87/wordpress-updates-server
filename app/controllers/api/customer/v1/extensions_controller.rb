class Api::Customer::V1::ExtensionsController < Api::Customer::V1::BaseController

  def update_check
    if params[:domain_name].nil?
      render status: 400, json: { code: 1, message: "The request must contain a domain name." } and return
    end

    type = params[:model]

    if type == "Plugin" && params[:plugins].nil?
      render status: 400, json: { code: 1, message: "The request must contain a domain name and the plugins to check updates for." } and return
    elsif type == "Theme" && params[:themes].nil?
      render status: 400, json: { code: 1, message: "The request must contain a domain name and the themes to check updates for." } and return
    end

    # this hash will be returned to the client
    extensions = Hash.new

    # names of all extensions the customer owns
    customer_extensions = type == "Plugin" ? current_customer.plugin_names : current_customer.theme_names

    # queried extensions with names as keys
    installed = type == "Plugin" ? params[:plugins] : params[:themes]
    installed = installed.collect do |i, e|
      e[:Slug] = i
      [e[:Name], e]
    end.uniq
    installed = Hash[installed]

    # search extensions by names
    Extension.where(:name.in => installed.keys, :_type => type).each do |e|
      installed_extension = installed[e.name]

      # continue search if extension match name but not other details
      next if e.versions.where({
        version: installed_extension[:Version],
        author: installed_extension[:Author],
        author_uri: installed_extension["Author URI"]
      }).nil?

      # check the customer is allowed to get updates
      if customer_extensions.include?(e.name)
        next unless PHPVersioning::compare(installed_extension[:Version], e.current_version) < 0

				slug = installed_extension[:Slug]
        extensions[slug] = e.for_update
      else
        # ask for permission when customer not allowed
        e.send_permission_notification(current_customer)
      end
    end

    render status: 200, json: extensions
  end

  def show
    if params[:domain_name].nil?
      render status: 400, json: { code: 1, message: "The request must contain a domain name." } and return
    end

    extension = current_customer.extensions.select { |e| e.id.to_s == params[:id] }.first

    if extension.nil?
      render status: 200, nothing: true and return
    end

    render status: 200, json: extension.info
  end
end
