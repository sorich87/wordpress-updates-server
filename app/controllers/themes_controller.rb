class ThemesController < ApplicationController
  skip_before_filter :authenticate_user!, only: :download

  def show
    @theme = @business.themes.find(params[:id])
    @packages = @theme.packages.includes(:purchases)
    @versions = @theme.versions
  end

  def index
    @themes = @business.themes
  end

  def create
    @tp = ThemeParser.new(params[:file].tempfile)

    respond_to do |format|
      format.js do
        if @tp.valid?
          @theme = @business.themes.new(name: @tp.attributes[:theme_name],
                                        new_version: @tp.attributes.merge(attachment: params[:file]))
          unless @theme.save
            @errors = @theme.errors
          end
        else
          @errors = @tp.errors
        end
        render
      end
    end
  end

  def destroy
    @theme = @business.themes.find(params[:id])
    @theme.destroy

    redirect_to themes_path, notice: 'Theme deleted.'
  end

  def update
    @theme = @business.themes.find(params[:id])
    @tp = ThemeParser.new(params[:file].tempfile)

    respond_to do |format|
      format.js do
        if @tp.valid?
          unless @theme.update_attributes(new_version: @tp.attributes.merge(attachment: params[:file]))
            @errors = @theme.errors
          end
        else
          @errors = @tp.errors
        end

        render
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
      @theme = current_user.business.themes.find(params[:id])
    elsif current_customer
      @theme = current_customer.themes.find { |t| t.id = params[:id] }
    end

    if @theme
      redirect_to @theme.download_url
    else
      render status: 404, nothing: true
    end
  end
end
