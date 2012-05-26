def get_or_create_business
  Business.first || FactoryGirl.create(:business)
end

FactoryGirl.define do
  factory :business do
    email   "factory@example.com"
    name    "FActory Company"
  end

  factory :package do
    name            "Standard"
    description     "Awesome"
    price           40.00
    themes          Package::THEMES[:one_theme]
    domains         0
    billing         Package::BILLING[:subscription]
    validity        Package::VALIDITY[:one_month]
    business        get_or_create_business
  end

  factory :customer do
    first_name  "Tom"
    last_name   "Sawyer"
    email       "tom.sawyer@somemail.email"
  end
end