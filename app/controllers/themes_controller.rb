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
          render status: 200, json: { code: 400, status: "FAILED", theme: @tp.attributes, errors: @tp.errors }
        end
      end
    end
  end

  def destroy
  end
end