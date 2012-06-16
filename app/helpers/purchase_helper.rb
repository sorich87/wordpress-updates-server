module PurchaseHelper
  def purchase_themes_description(purchase)
    themes_count = purchase.themes.count

    if themes_count == @business.themes.count
      I18n.t :all_themes, scope: [:purchases, :descriptions]
    else
      I18n.t :themes, scope: [:purchases, :descriptions],
        themes: purchase.themes.collect { |theme| theme.name }.join(", "), count: themes_count
    end
  end

  def purchase_plugins_description(purchase)
    plugins_count = purchase.plugins.count

    if plugins_count == @business.plugins.count
      I18n.t :all_plugins, scope: [:purchases, :descriptions]
    else
      I18n.t :plugins, scope: [:purchases, :descriptions],
        themes: purchase.plugins.collect { |plugin| plugin.name }.join(", "), count: plugins_count
    end
  end

  def purchase_date_description(purchase)
    I18n.t :purchase_date, scope: [:purchases, :descriptions],
      date: purchase.purchase_date.to_formatted_s(:long)
  end

  def purchase_expiration_description(purchase)
    scope = [:purchases, :descriptions, :expiration]

    if purchase.expiration_date
      if purchase.expired?
        I18n.t :expired_on, scope: scope, date: purchase.expiration_date.to_formatted_s(:long)
      else
        I18n.t :expire_on, scope: scope, date: purchase.expiration_date.to_formatted_s(:long)
      end
    else
      I18n.t :no_expiration, scope: scope
    end
  end
end
