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

  def themes
    if params[:domain_name].nil? || params[:themes].nil?
      render status: 400, json: { code: 1, message: "The request must contain a domain name and the themes to get." }
      return
    end

    installed_themes = params[:themes].values.collect { |t| [t[:Name], t] }.uniq
    installed_themes = Hash[installed_themes]
    theme_names = params[:themes].values.collect { |t| t[:Name] }.uniq
    themes = Hash.new

    Theme.where(:name.in => theme_names).each do |t|
      latest_version = t.current_version
      installed_theme = installed_themes[t.name]
      installed_version = installed_theme["Version"]
      slug = installed_theme["Stylesheet"]

      if PHPVersioning::compare(installed_version, latest_version) < 0
        version = t.versions.where(version: installed_theme["Version"],
                                   author: installed_theme["Author"],
                                   author_uri: installed_theme["Author URI"])
        if version
          themes[slug] = Hash["package" => download_theme_url(t).concat("?auth_token=#{params[:auth_token]}"),
                              "new_version" => t.current_version,
                              "url" => t.versions.current.uri]
        end
      end
    end

    render status: 200, json: themes
  end

end
