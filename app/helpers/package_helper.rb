module PackageHelper
  def collection_for_package_subscription_frequencies
    Hash['1 Month', 1, '3 Months', 3, '6 Months', 6, 'Annual', 12]
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
end
