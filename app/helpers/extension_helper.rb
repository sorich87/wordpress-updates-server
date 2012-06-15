module ExtensionHelper
  def extension_path(extension)
    if extension.is_a? Theme
      theme_path(extension)
    elsif extension.is_a? Plugin
      plugin_path(extension)
    end
  end
end