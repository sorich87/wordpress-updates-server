class ThemesController < ApplicationController
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

  # We just inactive it in reality, but destroy 'makes sense'
  def destroy_version
    @theme = @business.themes.find(params[:id])

    requested_version = params[:version].to_i
    if @theme.archives.where(version: requested_version)
      flash[:notice] = "Version deleted."
      redirect_to @theme
    else
      flash[:notice] = "Theme version could not be found."
    end
  end

  def update
    @theme = @business.themes.find(params[:id])
    @tp = ThemeParser.new(params[:file].tempfile)

    respond_to do |format|
      format.js do
        if @tp.valid?
          unless @theme.update_attributes(@tp.attributes.merge(archive: params[:file]))
            @errors = @theme.errors
          end
        else
          @errors = @tp.errors
        end

        render
      end
    end
  end
end
