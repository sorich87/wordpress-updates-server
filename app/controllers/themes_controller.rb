class ThemesController < ApplicationController
  def index
    @themes = @business.themes
  end

  def edit
  end

  def create
    @tp = ThemeParser.new(params[:file].tempfile)

    respond_to do |format|
      if @tp.valid?
        @theme = @business.themes.new(@tp.attributes)

        format.json do
          if @theme.valid?
            @theme.save
            render status: 200, json: { code: 200, status: "OK", theme: @theme }
          else
            render status: 200, json: { code: 403, status: "FAILED", theme: @theme, errors: @theme.errors }
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
          if @theme.update_attributes(@tp.attributes)
            render status: 200, json: { code: 200, status: "OK", theme: @theme }
          else
            render status: 403, json: { code: 400, status: "FAILED", theme: @theme, errors: @theme.errors }
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