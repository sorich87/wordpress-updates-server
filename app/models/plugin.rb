class Plugin < Extension

  def info
    {
      name: name,
      slug: id,
      version: current_version,
      author: author,
      author_profile: author_uri,
      contributors: { author => author_uri },
      requires: "",
      tested: "",
      compatibility: "",
      rating: "",
      num_ratings: "",
      downloaded: "",
      last_updated: updated_at.strftime('%F'),
      added: created_at.strftime('%F'),
      homepage: "",
      sections: {
        description: '',
        installation: '',
        faq: '',
        screenshots: '',
        changelog: '',
        other_notes: ''
      },
      download_link: download_url,
      tags: Hash[tags.collect { |t| [t,t] }]
    }
  end
end
