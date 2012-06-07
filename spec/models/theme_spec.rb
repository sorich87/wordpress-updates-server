require 'spec_helper'

describe Theme do 
  before do
    @business = FactoryGirl.create(:business)
  end

  describe 'validations' do
    describe 'without attribute' do
      specify 'name' do
        FactoryGirl.build(:theme, business: @business, name: nil).should_not be_valid
      end

      specify 'version' do
        FactoryGirl.build(:theme, business: @business, theme_version: nil).should_not be_valid
      end

      specify 'business' do
        FactoryGirl.build(:theme, business: nil).should_not be_valid
      end
    end

    it 'should not let the designer upload a theme with the same name' do
      first_theme = FactoryGirl.create(:theme, business: @business, name: "Some theme")
      second_theme = FactoryGirl.build(:theme, business: @business, name: "Some theme")

      second_theme.should_not be_valid
    end

    it 'should accept duplicate names if the designers are different' do
      second = FactoryGirl.create(:business)
      first_theme = FactoryGirl.create(:theme, business: @business, name: "Some theme")
      second_theme = FactoryGirl.build(:theme, business: second, name: "Some theme")

      second_theme.should be_valid
    end
  end

  it { should belong_to(:business) }
  it { should have_and_belong_to_many(:package_purchases) }
  it { should have_and_belong_to_many(:packages) }

  describe 'versioning' do
    before do
      @theme = FactoryGirl.create(:theme, business: @business)
    end

    it 'should add another version when being updated' do
      lambda {
        @theme.update_attributes(theme_version: '2.0')
      }.should change(@theme, :version).by(1)
    end

    describe 'changing the theme name' do
      it 'should not be allowed' do
        @theme.update_attributes(name: 'Some other name').should be_false
      end

      it  'should generate an error message' do
        @theme.name = "Some other theme name"
        @theme.should_not be_valid
        @theme.should have(1).error_on(:name)
      end
    end
  end
end
