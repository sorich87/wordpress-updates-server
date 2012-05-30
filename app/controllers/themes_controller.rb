class ThemesController < ApplicationController
  def index
    #@themes = @business.themes
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = @business.themes.new(compressed_file: params[:file])
    respond_to do |format|
      if @theme.save 
        format.html { redirect_to edit_theme_path(@theme), notice: "Theme saved." }
      else
        render :edit
      end
    end
  end

  def destroy
  end

  def validate_zip
    file = params[:file]
    tp = ThemeParser.new(file.tempfile)
    respond_to do |format|
      if tp.valid?
        format.json { 
          render status: 200, json: { status: "OK", theme: tp.css.attributes } 
        }
      else
        format.json { 
          render status: 403, json: { status: "FAILED", message: "File contained errors." } 
        } 
      end
    end
  end
end