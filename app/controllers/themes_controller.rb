class ThemesController < ApplicationController
  def show
    @parent_theme = @business.themes.find(params[:id])
    requested_version = params[:version].to_i

    if params[:version] && requested_version != @parent_theme.version
      requested_version = params[:version].to_i      
      if requested_version > @parent_theme.version
        raise ActionController::RoutingError.new('Not Found') 
      end

      @theme = @parent_theme.versions.to_a.find { |theme_version| 
        theme_version.version == requested_version
      }
    else
      @theme = @parent_theme
    end

    @packages = @parent_theme.packages.includes(:purchases)

    @newer_versions = @parent_theme.get_newer_versions_than (@theme)
    @older_versions = @parent_theme.get_older_versions_than (@theme)
  end

  def index
    @themes = @business.themes
  end

  def create
    @tp = ThemeParser.new(params[:file].tempfile)

    respond_to do |format|
      if @tp.valid?
        @theme = @business.themes.new(@tp.attributes.merge(archive: params[:file]))

        format.json do
          if @theme.valid?
            @theme.save
            render status: 200, json: { code: 200, status: "OK", theme: @theme }
          else
            render status: 200, json: { code: 400, status: "FAILED", theme: @theme, errors: @theme.errors }
          end
        end
      else        
        format.json do
          # #%"#€1i310"#!"" plupload
          render status: 200, json: { code: 400, status: "FAILED", theme: @tp, errors: @tp.errors }
        end
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
      if @tp.valid?
        format.json do
          if @theme.update_attributes(@tp.attributes.merge(archive: params[:file]))
            render status: 200, json: { code: 200, status: "OK", theme: @theme }
          else
            render status: 200, json: { code: 400, status: "FAILED", theme: @theme, errors: @theme.errors }
          end
        end
      else
        format.json do
          render status: 200, json: { code: 400, status: "FAILED", theme: @tp, errors: @tp.errors }
        end
      end
    end

  end
end