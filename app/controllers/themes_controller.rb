class ThemesController < ExtensionsController
  private

  def extension_parser
    ThemeParser.new(params[:file].tempfile)
  end
end
