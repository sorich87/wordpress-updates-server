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
    name              { Forgery(:lorem_ipsum).title }
    description       { Forgery(:lorem_ipsum).sentence }
    price             { Forgery(:monetary).money }
    number_of_themes  { Forgery(:basic).number(at_least: 0) }
    number_of_domains { Forgery(:basic).number(at_least: 0) }
    billing           Package::BILLING[:subscription]
    validity          { Forgery(:basic).number(at_least: 0) }
    business
    theme_ids         { [] }

    ignore do
      themes_count 3
    end

    after(:build) do |package, evaluator|
      FactoryGirl.create_list(:theme_in_business, evaluator.themes_count, packages: [package])
    end

    factory :invalid_package do
      name nil
    end
  end

  factory :customer do
    first_name { Forgery(:name).first_name }
    last_name  { Forgery(:name).last_name }
    email      { Forgery(:email).address }
  end

  factory :theme do
    name            { Forgery(:lorem_ipsum).title }
    uri             "http://awesome.example.com"
    description     { Forgery(:lorem_ipsum).sentence }
    theme_version   "0.1.0"
    license         "MIT License"
    license_uri     "http://license.example.com"
    tags            ['awesome', 'nice', 'pretty']

    factory :theme_in_business do
      business
    end
  end

  factory :site do
    domain_name { Forgery(:internet).domain_name }
    customer

    factory :unconfirmed_site do
      unconfirmed_secret_key { Forgery(:basic).password }
      confirmation_token { Forgery(:basic).password }
      confirmation_sent_at Time.now.utc
    end

    factory :confirmed_site do
      secret_key { Forgery(:basic).password }
      confirmed_at { Forgery(:date).date(past: true) }
    end
  end
end
