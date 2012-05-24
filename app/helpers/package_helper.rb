module PackageHelper
  def collection_for_package_validities
    Package::VALIDITY.map do |key, val|
      label = I18n.t key, :scope => [:packages, :values, :validity]
      [label, val]
    end
  end

  def collection_for_package_themes
    Package::THEMES.map do |key, val|
      label = I18n.t key, :scope => [:packages, :values, :themes]
      [label, val]
    end
  end

  def collection_for_package_billings
    Package::BILLING.map do |key, val|
      label = I18n.t key, :scope => [:packages, :values, :billing]
      [label, val]
    end
  end
end