Fabricator :package do
	name                 { Forgery(:lorem_ipsum).title }
	description          { Forgery(:lorem_ipsum).sentence }
	price                { Forgery(:monetary).money }
	number_of_extensions { Forgery(:basic).number(at_least: 0) }
	number_of_domains    { Forgery(:basic).number(at_least: 0) }
	billing              Package::BILLING[:one_time_payment]
	validity             { Forgery(:basic).number(at_least: 0) }
	extensions(count: 3) { |package, i| Fabricate(:extension) }
	business
end

Fabricator :invalid_package, from: :package do
  name nil
end
