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
        FactoryGirl.build(:theme, business: @business, version: nil).should_not be_valid
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
end