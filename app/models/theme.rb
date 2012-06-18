class Theme < Extension

  def info
    {
      name: name,
      slug: id,
      version: current_version,
      author: author,
      preview_url: '',
      screenshot_url: screenshot.public_url,
      rating: '',
      num_ratings: '',
      homepage: '',
      description: description
    }
  end
end
