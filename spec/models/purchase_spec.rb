require 'spec_helper'

describe Purchase do
  let(:purchase) { Fabricate.build(:purchase) }

  it { should be_embedded_in(:customer) }
  it { should have_and_belong_to_many(:extensions) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:purchase_date) }
  it { should validate_presence_of(:extension_ids) }
  it { should validate_presence_of(:package_name) }

  it { should validate_numericality_of(:number_of_domains) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:validity) }

  it 'is valid given valid attributes' do
    purchase.should be_valid
  end

  it 'is valid given all extensions' do
    purchase = Fabricate.build(:purchase, extensions: [], has_all_extensions: true)
    purchase.should be_valid
  end

  it 'is not valid with no extensions' do
    purchase = Fabricate.build(:purchase, extensions: [], has_all_extensions: false)
    purchase.should_not be_valid
  end

  it 'sets the expiration date' do
    purchase = Fabricate.build(:purchase, validity: 3)
    purchase.expiration_date.should_not be_nil
  end

  describe '.renew_subscription!' do
    it 'renews the subscription' do
      purchase = Fabricate.build(:purchase, is_subscription: true, validity: 3)
      old_expiration_date = purchase.expiration_date
      purchase.renew_subscription!
      purchase.expiration_date.should == old_expiration_date >> purchase.validity
    end

    it 'does not renew the one-time payment' do
      purchase = Fabricate.build(:purchase, is_subscription: false, validity: 3)
      old_expiration_date = purchase.expiration_date
      purchase.renew_subscription!
      purchase.expiration_date.should == old_expiration_date
    end
  end

  describe '.price' do
    it 'returns the formatted price' do
      purchase.price.should == "%.2f" % purchase[:price]
    end
  end

  describe '.expired?' do
    it 'returns the expiration status' do
      purchase.expiration_date = Date.today + 2
      purchase.expired?.should == false
      purchase.expiration_date = Date.today - 2
      purchase.expired?.should == true
    end
  end

  describe '.package=' do
    it 'saves the package details' do
      package = Fabricate.build(:package)
      purchase = Fabricate.build(:purchase, package: package)
      purchase.package_name.should == package.name
      purchase.price.should == package.price
      purchase.is_subscription.should == package.is_subscription
      purchase.validity.should == package.validity
      purchase.number_of_domains.should == package.number_of_domains
      purchase.has_all_extensions.should == package.has_all_extensions
    end
  end

  describe 'extension methods' do
    let(:plugin) { Fabricate(:plugin) }
    let(:theme) { Fabricate(:theme) }
    let(:purchase) { Fabricate.build(:purchase, extensions: [plugin, theme]) }

    describe '.plugins' do
      it 'returns the plugins' do
        purchase.plugins.all.entries.should == [plugin]
      end
    end

    describe '.themes' do
      it 'returns the themes' do
        purchase.themes.all.entries.should == [theme]
      end
    end
  end
end
