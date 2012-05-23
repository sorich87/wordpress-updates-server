require 'spec_helper'

describe Business do
  before do
    @valid_attributes = {
      email: "somecompany@example.com",
      name: "Some Company"
    }
  end
    
  context '#CREATE' do
    it "should be successful given valid attributes" do
      Business.new( @valid_attributes ).should be_valid
    end

    it "should fail without an email" do
      Business.new( @valid_attributes.merge(email: nil) ).should_not be_valid
    end

    it "should fail without a name" do
      Business.new( @valid_attributes.merge(name: nil) ).should_not be_valid
    end

    it "should require a certain length of the name" do
      Business.new( @valid_attributes.merge(name: 'a') ).should_not be_valid
    end

    it "should reject names that are too long" do
      Business.new( @valid_attributes.merge(name: 'a'*70) ).should_not be_valid
    end

    it "should reject invalid emails" do
      invalid_emails = ["notatallcorrect", "without@tld", "without@.domain"]
      invalid_emails.each do |e|
        Business.new( @valid_attributes.merge(email: e) ).should_not be_valid
      end
    end

    it "rejects duplicate emails" do
      Business.create!(@valid_attributes)
      Business.new( @valid_attributes.merge(name: 'Other Name') ).should_not be_valid
    end

    it "rejects duplicate names" do
      Business.create!(@valid_attributes)
      Business.new( @valid_attributes.merge(email: "otheremail@example.com") ).should_not be_valid
    end
  end

  it 'should have many customers' do
    b = Business.create!(@valid_attributes)
    b.should respond_to(:customers)
    #b.should respond_to(:customer_ids)
  end

  it 'should have many packages' do
    b = Business.create!(@valid_attributes)
    b.should respond_to(:packages)
  end
end
