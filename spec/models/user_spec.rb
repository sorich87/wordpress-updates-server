require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }

  it 'is valid given valid attributes' do
    user.should be_valid
  end

  it { should validate_presence_of(:email) }
  it {
    Fabricate(:user)
    should validate_uniqueness_of(:email)
  }
  it { should_not allow_value("notatallcorrect").for(:email) }
  it { should_not allow_value("without@tld").for(:email) }
  it { should_not allow_value("without@.domain").for(:email) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should belong_to(:business) }

  describe '.full_name' do
    it 'should return the full name' do
      user.full_name.should == "#{user.first_name} #{user.last_name}"
    end
  end
end
