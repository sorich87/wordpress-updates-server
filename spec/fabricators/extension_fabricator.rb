Fabricator :extension do
	name               { Forgery(:lorem_ipsum).title }
	business
  versions(count: 2) { |extension, i| Fabricate(:version, extension: extension, version: i) }
  screenshot         File.open(Rails.root.join('spec/fixtures/screenshot.png'))
  current_version    2
end

Fabricator :plugin do
	name               { Forgery(:lorem_ipsum).title }
	business
  versions(count: 2) { |extension, i| Fabricate(:plugin_version, extension: extension, version: i) }
  screenshot         File.open(Rails.root.join('spec/fixtures/screenshot.png'))
  current_version    2
end

Fabricator :theme do
	name               { Forgery(:lorem_ipsum).title }
	business
  versions(count: 2) { |extension, i| Fabricate(:theme_version, extension: extension, version: i) }
  screenshot         File.open(Rails.root.join('spec/fixtures/screenshot.png'))
  current_version    2
end
