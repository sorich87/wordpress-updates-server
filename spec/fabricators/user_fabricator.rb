Fabricator :user do
	first_name   { Forgery(:name).first_name }
	last_name    { Forgery(:name).last_name }
	email        { Forgery(:email).address }
	password     { Forgery(:basic).password }
	confirmed_at { Forgery(:date).date(past: true) }
	business
end
