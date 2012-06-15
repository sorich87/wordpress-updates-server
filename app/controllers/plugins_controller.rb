class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :download

  def show
    @plugin = @business.plugins.find(params[:id])
    @packages = @plugin.packages.includes(:purchases)
    @versions = @plugin.versions
  end

  def index
    @plugins = @business.plugins
  end

  def create
    @pp = PluginParser.new(params[:file].tempfile)

    respond_to do |format|
      format.js do
        if @pp.valid?
          @extension = @business.plugins.new(name: @pp.attributes[:plugin_name],
                                        new_version: @pp.attributes.merge(attachment: params[:file]))
          unless @extension.save
            @errors = @extension.errors
          end
        else
          @errors = @pp.errors
        end
        render 'extensions/create'
      end
    end
  end

  def destroy
    @plugin = @business.plugins.find(params[:id])
    @plugin.destroy

    redirect_to plugins_path, notice: 'plugin deleted.'
  end

  def update
    @extension = @business.plugins.find(params[:id])
    @pp = PluginParser.new(params[:file].tempfile)

    respond_to do |format|
      format.js do
        if @pp.valid?
          unless @extension.update_attributes(new_version: @pp.attributes.merge(attachment: params[:file]))
            @errors = @extension.errors
          end
        else
          @errors = @pp.errors
        end

        render 'extensions/update'
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
      @plugin = current_user.business.plugins.find(params[:id])
    elsif current_customer
      @plugin = current_customer.plugins.find { |t| t.id = params[:id] }
    end

    if @plugin
      redirect_to @plugin.download_url
    else
      render status: 404, nothing: true
    end
  end
end
