Fabricator :purchase do
	purchase_date        { Forgery(:date).date(past: true) }
	customer
	package
	extensions(count: 3) { Fabricate(:extension) }
end
