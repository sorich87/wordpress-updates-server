class ThemesController < ApplicationController
  def show
    @theme = @business.themes.find(params[:id])
    @packages = @theme.packages.includes(:purchases)
    @older_versions = @theme.get_older_versions_than (@theme)
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

  # We just inactive it in reality, but destroy 'makes sense'
  def destroy_version
    @theme = @business.themes.find(params[:id])

    requested_version = params[:version].to_i
    if @theme.deactivate_version!(requested_version)
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