require 'spec_helper'

describe Customer do
  before do
    @valid_attributes = {
      first_name: "Test",
      last_name: "User",
      email: "test.user@example.com"
    }
  end

  context "helper methods" do
    before { @customer = Customer.create!(@valid_attributes) }

    it 'should return the full name' do
      @customer.full_name.should == "#{@valid_attributes[:first_name]} #{@valid_attributes[:last_name]}"
    end
  end

  context '#CREATE' do
    it "should be successful given valid attributes" do
      Customer.new(@valid_attributes).should be_valid
    end

    it "should reject empty first names" do
      Customer.new( @valid_attributes.merge(first_name: nil) ).should_not be_valid
    end

    it "should reject empty last names" do
      Customer.new( @valid_attributes.merge(last_name: nil) ).should_not be_valid
    end

    it "should reject empty emails" do
      Customer.new( @valid_attributes.merge(email: nil) ).should_not be_valid
    end

    it "should reject invalid emails" do
      ["notatallcorrect", "without@tld", "without@.domain"].each do |e|
        Customer.new( @valid_attributes.merge(email: e) ).should_not be_valid
      end
    end

    it "should reject duplicate emails" do
      Customer.create!(@valid_attributes)
      Customer.new(@valid_attributes).should_not be_valid
    end
  end

  it 'should belong to a business' do
    c = Customer.create!(@valid_attributes)
    c.should respond_to(:business)
  end
  
  it 'should have many packages' do
    c = Customer.create!(@valid_attributes)
    c.should respond_to(:packages)
  end
end
