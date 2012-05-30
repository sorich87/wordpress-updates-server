When /^I go to the edit company profile page$/ do
  visit settings_business_path
end

Then /^I should be on the edit company profile page$/ do
  current_path.should == settings_business_path
end

When /^the company profile form fields contain my company details$/ do
  find_field("Company Name").value.should == @business[:name]
  find_field("Email Address").value.should == @business[:email]
  find_field("Country").value.should == @business[:country]
  find_field("Street 1").value.should == @business[:street1]
  find_field("Street 2").value.should == @business[:street2]
  find_field("City").value.should == @business[:city]
  find_field("State/Province/Region").value.should == @business[:state]
  find_field("Zip/Postal Code").value.should == @business[:zip]
  find_field("Phone").value.should == @business[:phone]
  find_field("Time Zone").value.should == @business[:time_zone]
end

When /^I fill in new company details$/ do
  fill_in "Company Name", with: 'Paris Themes'
  fill_in "Email Address", with: 'contact@paris.thm'
  select 'France', from: "Country"
  fill_in "Street 1", with: '1 Rue Imaginaire'
  fill_in "Street 2", with: 'Appartement 3'
  fill_in "City", with: 'Paris'
  fill_in "State/Province/Region", with: 'Paris'
  fill_in "Zip/Postal Code", with: '90000'
  fill_in "Phone", with: '01 44 18 90 64'
  select 'Paris', from: "Time Zone"
end

Then /^the company profile form fields should contain my new company details$/ do
  find_field("Company Name").value.should == 'Paris Themes'
  find_field("Email Address").value.should == 'contact@paris.thm'
  find_field("Country").value.should == 'France'
  find_field("Street 1").value.should == '1 Rue Imaginaire'
  find_field("Street 2").value.should == 'Appartement 3'
  find_field("City").value.should == 'Paris'
  find_field("State/Province/Region").value.should == 'Paris'
  find_field("Zip/Postal Code").value.should == '90000'
  find_field("Phone").value.should == '01 44 18 90 64'
  find_field("Time Zone").value.should == 'Paris'
end

Then /^the company profile form fields should contain my company details$/ do
  step "the company profile form fields contain my company details"
end
