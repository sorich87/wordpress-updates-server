require 'spec_helper'

describe Business do
  describe 'validation' do
    it 'passes with valid attributes' do
      FactoryGirl.build(:business).should be_valid
    end

    describe 'of business_name' do
      it 'requires presence' do
        FactoryGirl.build(:business, :business_name => nil).should_not be_valid
      end
    end

    describe 'of account_name' do
      it 'requires presence' do
        FactoryGirl.build(:business, :account_name => nil).should_not be_valid
      end

      it 'requires uniqueness' do
        FactoryGirl.create(:business)
        FactoryGirl.build(:business, :business_name => 'Venom Themes').should_not be_valid
      end

      it 'requires letters, numbers and underscore only' do
        FactoryGirl.build(:business, :account_name => 'spideR').should be_valid
        FactoryGirl.build(:business, :account_name => 'spider1').should be_valid
        FactoryGirl.build(:business, :account_name => 'spide_r').should be_valid
        FactoryGirl.build(:business, :account_name => 'spider@').should_not be_valid
        FactoryGirl.build(:business, :account_name => 'spide r').should_not be_valid
      end

      it 'downcases' do
        business = FactoryGirl.build(:business, :account_name => 'SpIdEr')
        business.valid?
        business.account_name.should == 'spider'
      end

      it 'strips whitespaces' do
        business = FactoryGirl.build(:business, :account_name => '   spider ')
        business.valid?
        business.account_name.should == 'spider'
      end
    end
  end

  it 'should have many users' do
    FactoryGirl.create(:business).should respond_to(:users)
  end
end
