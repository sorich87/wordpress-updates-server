require 'spec_helper'

describe User do
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:business) }

  describe 'validation' do
    it 'passes with valid attributes' do
      FactoryGirl.build(:user).should be_valid
    end

    describe 'of email' do
      it 'requires presence' do
        FactoryGirl.build(:user, :email => nil).should_not be_valid
      end

      it 'requires uniqueness' do
        user = FactoryGirl.attributes_for(:user)
        User.create(user)
        User.create(user).should_not be_valid
      end
    end

    describe 'of first name' do
      it 'requires presence' do
        FactoryGirl.build(:user, :first_name => nil).should_not be_valid
      end
    end

    describe 'of last name' do
      it 'requires presence' do
        FactoryGirl.build(:user, :last_name => nil).should_not be_valid
      end
    end
  end

  it 'should belong to a business' do
    FactoryGirl.create(:user).should respond_to(:business)
  end

  describe '.full_name' do
    before { @user = FactoryGirl.create(:user) }

    it 'should return the full name' do
      @user.full_name.should == "#{@user.first_name} #{@user.last_name}"
    end
  end
end
