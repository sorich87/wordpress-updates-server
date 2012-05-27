require 'spec_helper'

describe Package do
  before do
    @business = FactoryGirl.create(:business)

    @valid_attributes = {
      name: "ExampleTheme 1.0",
      description: "Light weight theme with focus on readability.",
      price: 19.99,
      validity: Package::VALIDITY[:lifetime],
      billing: Package::BILLING[:one_time_payment],
      themes: Package::THEMES[:one_theme],
      domains: 0, # Unlimited,
      business_id: @business.id
    }
  end

  context "helpers" do
    before { @package = @business.packages.create!(@valid_attributes) }

    it 'should respond to validity methods' do
      @package.should respond_to(:is_valid_for_life?)
    end

    it 'should respond to payment methods' do
      @package.should respond_to(:is_subscription?)
    end
  end

  context '#CREATE' do
    it 'should be valid given valid attributes' do
      Package.new(@valid_attributes).should be_valid
    end

    it 'should require a business' do
      Package.new( @valid_attributes.merge(business: nil) ).should_not be_valid
    end

    it 'should be invalid without a name' do
      Package.new( @valid_attributes.merge(name: nil) ).should_not be_valid
    end

    it 'should be invalid without a description' do
      Package.new( @valid_attributes.merge(description: nil) ).should_not be_valid
    end

    it 'should be invalid without a price' do
      Package.new( @valid_attributes.merge(price: nil) ).should_not be_valid
    end

    it 'should reject invalid prices' do
      [-919, -1, nil, '-5'].each do |p|
        Package.new( @valid_attributes.merge(price: p) ).should_not be_valid
      end
    end

    it 'should reject invalid validity values' do
      [-1, 999, "invalid", :lifetime].each do |v|
        Package.new( @valid_attributes.merge(validity: v) ).should_not be_valid
      end
    end

    it 'should reject invalid themes values' do
      [-1, 999, "one_theme", :one_theme].each do |v|
        Package.new( @valid_attributes.merge(themes: v) ).should_not be_valid
      end
    end

    it 'should reject invalid billing values' do
      [-1, 999, :one_time_payment, "one time payment"].each do |v|
        Package.new( @valid_attributes.merge(billing: v) ).should_not be_valid
      end
    end
  end

  it 'should belong to a business' do
    c = Package.create!(@valid_attributes)
    c.should respond_to(:business)
  end

  it 'should belong to many customers' do
    c = Package.create!(@valid_attributes)
    c.should respond_to(:customers)
  end
end
