Fabricator :version do
	uri             { "http://#{Forgery(:internet).domain_name}" }
	description     { Forgery(:lorem_ipsum).sentence }
	version         Forgery(:basic).number(at_least: 0)
	author          Forgery(:lorem_ipsum).title
	author_uri      { "http://#{Forgery(:internet).domain_name}" }
	license         Forgery(:lorem_ipsum).title
	license_uri     { "http://#{Forgery(:internet).domain_name}" }
  archive         File.open(Rails.root.join('spec/fixtures/themes/zips/twentyeleven.zip'))
end

Fabricator :theme_version, from: :version do
	tags(count: 3)  { |version, i| Forgery(:lorem_ipsum).word }
	status          { Forgery(:lorem_ipsum).word }
	template        { Forgery(:lorem_ipsum).word }
  archive         File.open(Rails.root.join('spec/fixtures/themes/zips/twentyeleven.zip'))
end

Fabricator :plugin_version, from: :version do
	domain_path     { "/#{Forgery(:lorem_ipsum).word}" }
	network         { Forgery(:basic).boolean }
	text_domain     { Forgery(:lorem_ipsum).word }
  archive         File.open(Rails.root.join('spec/fixtures/plugins/zips/acobot.1.1.2.zip'))
end
