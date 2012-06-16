module ExtensionHelper
  def extension_path(extension)
    if extension._type == "Theme"
      theme_path(extension)
    elsif extension._type == "Plugin"
      plugin_path(extension)
    end
  end
end
