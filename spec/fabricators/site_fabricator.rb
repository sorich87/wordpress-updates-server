Fabricator :site do
	domain_name { Forgery(:internet).domain_name }
	customer
end

Fabricator :unconfirmed_site, from: :site do
	unconfirmed_secret_key { Forgery(:basic).password }
	confirmation_token { Forgery(:basic).password }
	confirmation_sent_at Time.now.utc
	secret_key nil
	confirmed_at nil
end

Fabricator :confirmed_site, from: :site do
	secret_key { Forgery(:basic).password }
	confirmed_at { Forgery(:date).date(past: true) }
end
