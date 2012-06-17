class ExtensionsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :download

  def show
    @extension = @business.extensions.find(params[:id])
    @packages = @extension.packages.includes(:purchases)
    @versions = @extension.versions
  end

  def index
    @type = params[:model]
    @extensions = @business.extensions.where(_type: @type)
  end

  def create
    @parser = extension_parser

    respond_to do |format|
      format.js do
        if @parser.valid?
          @extension = @business.extensions.new(name: @parser.attributes[:name],
                                                new_version: @parser.attributes.merge(attachment: params[:file]),
                                                _type: params[:model])
          unless @extension.save
            @errors = @extension.errors
          end
        else
          @errors = @parser.errors
        end
      end
    end
  end

  def destroy
    @extension = @business.extensions.find(params[:id])

    case @extension._type
    when "Plugin"
      redirect_path = plugins_path
    when "Theme"
      redirect_path = themes_path
    end

    @extension.destroy

    redirect_to redirect_path, notice: 'Theme deleted.'
  end

  def update
    @extension = @business.extensions.find(params[:id])
    @parser = extension_parser

    respond_to do |format|
      format.js do
        if @parser.valid?
          unless @extension.update_attributes(new_version: @parser.attributes.merge(attachment: params[:file]))
            @errors = @extension.errors
          end
        else
          @errors = @parser.errors
        end
      end
    end
  end

  def download
    if params[:auth_token]
      authenticate_customer!
    else
      authenticate_user!
    end

    if current_user
      @extension = current_user.business.extensions.find(params[:id])
    elsif current_customer
      @extension = current_customer.extensions.find { |e| e.id == params[:id] }
    end

    if @extension
      redirect_to @extension.download_url
    else
      render status: 404, nothing: true
    end
  end

  private

  def extension_parser
    if params[:model] == "Theme"
      ThemeParser.new(params[:file].tempfile)
    elsif params[:model] == "Plugin"
      PluginParser.new(params[:file].tempfile)
    end
  end
end
