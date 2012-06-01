FactoryGirl.define do
  factory :business do
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

  factory :user do
    first_name   { Forgery(:name).first_name }
    last_name    { Forgery(:name).last_name }
    email        { Forgery(:email).address }
    password     { Forgery(:basic).password }
    confirmed_at { Forgery(:date).date(past: true) }

    factory :designer do
      business
    end
  end

  factory :package do
    name        { Forgery(:lorem_ipsum).title }
    description { Forgery(:lorem_ipsum).sentence }
    price       { Forgery(:monetary).money }
    themes      Package::THEMES[:one_theme]
    domains     { Forgery(:basic).number(at_least: 0) }
    billing     Package::BILLING[:subscription]
    validity    Package::VALIDITY[:one_month]
  end

  factory :customer do
    first_name { Forgery(:name).first_name }
    last_name  { Forgery(:name).last_name }
    email      { Forgery(:email).address }
  end

  factory :theme do
    name            "Awesome Theme"
    uri             "http://awesome.example.com"
    description     "My awesome theme"
    license         "MIT License"
    license_uri     "http://license.example.com"
    tags            ['awesome', 'nice', 'pretty']
  end
end
