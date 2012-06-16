class PluginsController < ExtensionsController
  private

  def extension_parser
    PluginParser.new(params[:file].tempfile)
  end
end
