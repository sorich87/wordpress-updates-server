module PackageHelper
  def collection_for_package_billings
    Package::BILLING.map do |key, val|
      label = I18n.t key, :scope => [:packages, :values, :billing]
      [label, val]
    end
  end

  def package_extension_price_description(package)
    price = number_to_currency(package.price, precision: 2)
    case package.number_of_extensions
    when 0
      I18n.t :price_for_all, scope: [:packages, :descriptions, :extensions], price: price
    else
      I18n.t :price_for_number, scope: [:packages, :descriptions, :extensions], price: price, extensions: package.number_of_extensions, count: package.number_of_extensions
    end
  end

  def package_validity_description(package)
    case package.validity
    when 0
      I18n.t :valid_for_life, scope: [:packages, :descriptions, :validity]
    else
      I18n.t :valid_for_months, scope: [:packages, :descriptions, :validity], months: package.validity, count: package.validity
    end
  end

  def package_domains_description(package)
    case package.number_of_domains
    when 0
      I18n.t :unlimited_domains, scope: [:packages, :descriptions, :domains]
    else
      I18n.t :limited_domains, scope: [:packages, :descriptions, :domains], domains: package.number_of_domains, count: package.number_of_domains
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
