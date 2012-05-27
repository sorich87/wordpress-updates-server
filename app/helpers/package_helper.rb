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

  def package_theme_price_description(package)
    price = number_to_currency(package.price, precision: 2)
    case package.themes
    when Package::THEMES[:one_theme]
      I18n.t :price_for_one, scope: [:packages, :descriptions, :themes], price: price
    when Package::THEMES[:all_themes]
      I18n.t :price_for_all, scope: [:packages, :descriptions, :themes], price: price
    end
  end

  def package_validity_description(package)
    if package.unlimited?
      scope = [:packages, :descriptions, :validity, :unlimited_domains]
    else
      scope = [:packages, :descriptions, :validity, :limited_domains]
    end

    case package.validity
    when Package::VALIDITY[:lifetime]
      I18n.t :valid_for_life, scope: scope, domains: package.domains, count: package.domains
    when Package::VALIDITY[:one_month]
      I18n.t :valid_for_one_month, scope: scope, domains: package.domains, count: package.domains
    when Package::VALIDITY[:one_year]
      I18n.t :valid_for_one_year, scope: scope, domains: package.domains, count: package.domains
    end
  end

  def package_renewal_description(package)
    case package.billing
    when Package::BILLING[:one_time_payment]
      I18n.t :one_time_payment, scope: [:packages, :descriptions, :billing]
    when Package::BILLING[:subscription]
      I18n.t :subscription, scope: [:packages, :descriptions, :billing]
    end
  end
end