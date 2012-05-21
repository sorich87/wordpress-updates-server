require 'spec_helper'

describe Package do
  before do
    @valid_attributes = {
      name: "ExampleTheme 1.0",
      description: "Light weight theme with focus on readability.",
      price: 19.99,
      validity: Package::VALIDITY[:lifetime],
      billing: Package::BILLING[:one_time_payment],
      themes: Package::THEMES[:one_theme],
      domains: 0 # Unlimited
    }
  end

  context "helpers" do
    before { @package = Package.create!(@valid_attributes) }

    it 'should respond to vadility methods' do
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
      [0, -1, nil].each do |p|
        Package.new( @valid_attributes.merge(price: p) ).should_not be_valid
      end
    end


  end
end
