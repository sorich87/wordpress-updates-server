Fabricator :extension do
	name               { Forgery(:lorem_ipsum).title }
	business
  versions(count: 2) { |extension, i| Fabricate(:version, extension: extension) }
  screenshot         File.open(Rails.root.join('spec/fixtures/screenshot.png'))
end

Fabricator :plugin do
	name               { Forgery(:lorem_ipsum).title }
	business
  versions(count: 2) { |extension, i| Fabricate(:plugin_version, extension: extension) }
  screenshot         File.open(Rails.root.join('spec/fixtures/screenshot.png'))
end

Fabricator :theme, from: :extension do
	name               { Forgery(:lorem_ipsum).title }
	business
  versions(count: 2) { |extension, i| Fabricate(:theme_version, extension: extension) }
  screenshot         File.open(Rails.root.join('spec/fixtures/screenshot.png'))
end
