require 'spec_helper'

describe User do
  describe 'validation' do
    it 'passes with valid attributes' do
      FactoryGirl.build(:user).should be_valid
    end

    describe 'of email' do
      it 'requires presence' do
        FactoryGirl.build(:user, :email => nil).should_not be_valid
      end

      it 'requires uniqueness' do
        FactoryGirl.create(:user)
        FactoryGirl.build(:user).should_not be_valid
      end
    end
  end

  it 'should belong to a business' do
    FactoryGirl.create(:user).should respond_to(:business)
  end
end
