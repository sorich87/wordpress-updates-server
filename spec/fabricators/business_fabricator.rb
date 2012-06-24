Fabricator :business do
	name      { Forgery(:name).company_name }
	email     { Forgery(:email).address }
	country   { Forgery(:address).country }
	street1   { Forgery(:address).street_address }
	street2   ''
	city      { Forgery(:address).city }
	state     { Forgery(:address).state }
	zip       { Forgery(:address).zip }
	phone     { Forgery(:address).phone }
	time_zone { Forgery(:time).zone }
end
