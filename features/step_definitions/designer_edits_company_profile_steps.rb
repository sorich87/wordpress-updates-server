When /^I go to the edit company profile page$/ do
  visit settings_business_path
end

Then /^I should be on the edit company profile page$/ do
  current_path.should == settings_business_path
end

When /^the company profile form fields contain my company details$/ do
  business = FactoryGirl.attributes_for(:business)
  find_field("Company Name").value.should == business[:name]
  find_field("Email Address").value.should == business[:email]
  find_field("Country").value.should == business[:country]
  find_field("Street 1").value.should == business[:street1]
  find_field("Street 2").value.should == business[:street2]
  find_field("City").value.should == business[:city]
  find_field("State/Province/Region").value.should == business[:state]
  find_field("Zip/Postal Code").value.should == business[:zip]
  find_field("Phone").value.should == business[:phone]
  find_field("Time Zone").value.should == business[:time_zone]
end

When /^I fill in new company details$/ do
  @business = Business.new({
    name: 'Paris Themes',
    email: 'contact@paris.thm',
    country: 'France',
    street1: '1 Rue Imaginaire',
    street2: '',
    city: 'Paris',
    state: '',
    zip: '90000',
    phone: '01 44 18 90 64',
    time_zone: 'Paris'
  })
  fill_in "Company Name", with: @business.name
  fill_in "Email Address", with: @business.email
  select @business.country, from: "Country"
  fill_in "Street 1", with: @business.street1
  fill_in "Street 2", with: @business.street2
  fill_in "City", with: @business.city
  fill_in "State/Province/Region", with: @business.state
  fill_in "Zip/Postal Code", with: @business.zip
  fill_in "Phone", with: @business.phone
  select @business.time_zone, from: "Time Zone"
end

Then /^the company profile form fields should contain my new company details$/ do
  find_field("Company Name").value.should == @business.name
  find_field("Email Address").value.should == @business.email
  find_field("Country").value.should == @business.country
  find_field("Street 1").value.should == @business.street1
  find_field("Street 2").value.should == @business.street2
  find_field("City").value.should == @business.city
  find_field("State/Province/Region").value.should == @business.state
  find_field("Zip/Postal Code").value.should == @business.zip
  find_field("Phone").value.should == @business.phone
  find_field("Time Zone").value.should == @business.time_zone
end

Then /^the company profile form fields should contain my company details$/ do
  step "the company profile form fields contain my company details"
end
