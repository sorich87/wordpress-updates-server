require 'spec_helper'

describe Site do
  let(:site) { Fabricate.build(:site) }

  it { should be_embedded_in(:customer) }

  it { should validate_presence_of(:domain_name) }
  it { should validate_uniqueness_of(:domain_name) }
  it { should allow_value('test.com').for(:domain_name) }
  it { should_not allow_value('test.c').for(:domain_name) }
  it { should_not allow_value('test').for(:domain_name) }
  it { should_not allow_value('.com').for(:domain_name) }

  it 'is valid given valid attributes' do
    site.should be_valid
  end

  context 'helper method' do
    let!(:site) { Fabricate.build(:unconfirmed_site) }

    describe '.generate_confirmation_token' do
      it 'should set a confirmation token' do
        site.confirmation_token = nil
        site.generate_confirmation_token
        site.confirmation_token.should_not be_nil
      end
    end

    describe '.send_confirmation_instructions' do
      it 'should send the confirmation instructions email' do
        expect {
          site.send_confirmation_instructions
        }.to change(ActionMailer::Base.deliveries, :length).by(1)
      end

      it 'should set the date the confirmation instructions have been sent at' do
        site.send_confirmation_instructions
        site.confirmation_sent_at.should_not be_nil
      end
    end

    describe '.confirm!' do
      it 'should copy the unconfirmed secret key' do
        unconfirmed_secret_key = site.unconfirmed_secret_key
        site.confirm!
        site.unconfirmed_secret_key.should be_nil
        site.secret_key.should == unconfirmed_secret_key
      end

      it 'should nillify the confirmation token' do
        site.confirm!
        site.confirmation_token.should be_nil
      end

      it 'should set the confirmation date' do
        site.confirm!
        site.confirmed_at.should_not be_nil
      end
    end

    describe '.confirmed?' do
      it 'should return false if the site does not have a confirmation date' do
        site.confirmed?.should == false
      end

      it 'should return true if the site has a confirmation date' do
        site.confirm!
        site.confirmed?.should == true
      end
    end
  end
end
