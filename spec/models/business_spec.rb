require 'spec_helper'

describe Business do
  describe 'validation' do
    it 'passes with valid attributes' do
      FactoryGirl.build(:business).should be_valid
    end

    describe 'of name' do
      it 'requires presence' do
        FactoryGirl.build(:business, :name => nil).should_not be_valid
      end

      it 'requires minimum length' do
        FactoryGirl.build(:business, :name => 'a').should_not be_valid
      end

      it 'requires maximum length' do
        FactoryGirl.build(:business, :name => 'a' * 70).should_not be_valid
      end
    end

    describe 'of email' do
      it 'requires presence' do
        FactoryGirl.build(:business, :email => nil).should_not be_valid
      end

      it 'requires uniqueness' do
        business = FactoryGirl.attributes_for(:business)
        Business.create(business)
        Business.create(business).should_not be_valid
      end

      it "requires valid email" do
        invalid_emails = ["notatallcorrect", "without@tld", "without@.domain"]
        invalid_emails.each do |e|
          FactoryGirl.build(:business, :email => e).should_not be_valid
        end
      end
    end
  end

  it 'should have many users' do
    FactoryGirl.create(:business).should respond_to(:users)
  end

  it 'should have many customers' do
    FactoryGirl.create(:business).should respond_to(:customers)
  end

  it 'should have many packages' do
    FactoryGirl.create(:business).should respond_to(:packages)
  end
end
