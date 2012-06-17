class Api::V1::SitesController < Api::V1::BaseController
  skip_before_filter :authenticate_customer!, only: :create

  def create
    if params[:email].nil? || params[:domain_name].nil? || params[:secret_key].nil?
      render status: 400, json: { code: 1, message: "The request must contain an email, domain name and secret key." }
      return
    end

    @customer = Customer.find_or_create_by(email: params[:email].downcase)

    unless @customer.valid?
      render status: 400, json: { code: 2, message: "An error occured.", errors: @customer.errors.full_messages }
      return
    end

    @site = @customer.sites.where(domain_name: params[:domain_name].downcase).first

    if @site.nil?
      @site = @customer.sites.new(domain_name: params[:domain_name])
    end

    if @site.confirmed? && @site.secret_key == params[:secret_key]
      render status: 400, json: { code: 22, message: "The site has already been confirmed." }
      return
    end

    @site.unconfirmed_secret_key = params[:secret_key]
    if @site.save
      @site.send_confirmation_instructions
      render status: 200, json: { domain_name: @site.domain_name }
    else
      render status: 400, json: { code: 2, message: "An error occured.", errors: @site.errors.full_messages }
    end
  end

  def update_check
    if params[:domain_name].nil? || ( params[:themes].nil? && params[:plugins].nil? )
      render status: 400, json: { code: 1, message: "The request must contain a domain name and the themes and plugins to check updates for." }
      return
    end

    # this hash will be returned to the client
    extensions = Hash.new

    # names of all extensions the customer owns
    customer_extensions = params[:themes].nil? ? current_customer.plugin_names : current_customer.theme_names

    # queried extensions with names as keys
    installed = params[:themes].nil? ? params[:plugins] : params[:themes]
    installed = installed.collect do |i, e|
      e[:slug] = i
      [e[:Name], e]
    end.uniq
    installed = Hash[installed]

    # search extensions by names
    type = params[:themes].nil? ? "Plugin" : "Theme"

    Extension.where(:name.in => installed.keys, :_type => type).each do |e|
      installed_extension = installed[e.name]

      # continue search if extension match name but not other details
      next if e.versions.where(version: installed_extension["Version"],
                               author: installed_extension["Author"],
                               author_uri: installed_extension["Author URI"]).nil?

      # check the customer is allowed to get updates
      if customer_extensions.include?(e.name)
        next unless PHPVersioning::compare(installed_extension[:Version], e.current_version) < 0

        if e._type == "Theme"
          slug = installed_extension[:Stylesheet]
        elsif e._type == "Plugin"
          slug = installed_extension[:slug]
        end

        extensions[slug] = extension_details_for_update(e, slug)
      else
        # ask for permission when customer not allowed
        e.send_permission_notification(current_customer)
      end
    end

    render status: 200, json: extensions
  end

  private

  def extension_details_for_update(extension, slug)
    details = Hash[package: extension.download_url,
                   new_version: extension.current_version,
                   url: extension.versions.current.uri]

    details["slug"] = File.basename(slug, '.php') if extension._type == "Plugin"

    details
  end

end
