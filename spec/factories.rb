FactoryGirl.define do
  factory :business do
    name 'Spider Themes'
    email   "contact@spider.thm"
  end

  factory :user do
    first_name            'Peter'
    last_name             'Parker'
    email                 'peter@spider.thm'
    password              '1Q!w2@'
    password_confirmation '1Q!w2@'
    confirmed_at          Time.now

    factory :designer do
      business
    end
  end

  factory :package do
    name            "Standard"
    description     "Awesome"
    price           40.00
    themes          Package::THEMES[:one_theme]
    domains         0
    billing         Package::BILLING[:subscription]
    validity        Package::VALIDITY[:one_month]
  end

  factory :customer do
    first_name  "Tom"
    last_name   "Sawyer"
    email       "tom.sawyer@somemail.email"
  end
end
