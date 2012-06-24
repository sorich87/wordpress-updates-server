Given /^I have a confirmed site$/ do
  @site = Fabricate(:confirmed_site)
end

When /^I send and accept JSON$/ do
  header 'Content-Type', 'application/json'
  header 'Accept', 'application/json'
end

When /^I send a POST request to the tokens endpoint with my email, a domain name and its secret key$/ do
  request_body = { email: @site.customer.email, domain_name: @site.domain_name, secret_key: @site.secret_key }.to_json
  post api_v1_tokens_path, request_body
end

When /^I send a POST request to the sites endpoint with my email, a domain name and its secret key$/ do
  request_body = { email: @site.customer.email, domain_name: @site.domain_name, secret_key: @site.unconfirmed_secret_key }.to_json
  post api_v1_sites_path, request_body
end

Then /^the JSON response should contain the token$/ do
  response_body = JSON.parse(last_response.body)
  response_body.has_key?("token").should be_true
end

When /^I send a DELETE request with my token$/ do
  @customer = @site.customer
  @customer.ensure_authentication_token!
  delete api_v1_token_path(@customer.authentication_token)
end

Then /^my token should be reset$/ do
  Customer.where(authentication_token:@customer.authentication_token).first.should be_nil
end

Given /^I have an unconfirmed site$/ do
  @site = Fabricate(:unconfirmed_site)
end

Then /^a site confirmation message should be sent my email$/ do
  unread_emails_for(@site.customer.email).size.should == parse_email_count(1)
end

When /^I click on the site confirmation link$/ do
  open_email(@site.customer.email)
  visit_in_email('Confirm my website')
end

Then /^I should see a message that my site was confirmed$/ do
  page.should have_content "Your website has been confirmed"
end
