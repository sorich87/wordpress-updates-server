Fabricator :customer do
	first_name { Forgery(:name).first_name }
	last_name  { Forgery(:name).last_name }
	email      { Forgery(:email).address }
end
