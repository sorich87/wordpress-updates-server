FactoryGirl.define do
  factory :business do
    business_name 'Spider Themes'
    account_name  'spider'
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
end
