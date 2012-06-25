module ApplicationHelper
  def create_action_matcher(controller, &additional_condition)
    action_matcher(controller, ["new", "create"], &additional_condition)
  end

  def update_action_matcher(controller, &additional_condition)
    action_matcher(controller, ["edit", "update"], &additional_condition)
  end

  def action_matcher(controller, action, &additional_condition)
    controllers = Array(controller)
    actions = Array(action)
    lambda do
      controllers.include?(controller_name) &&
        actions.include?(action_name) &&
        ( additional_condition.nil? ? true : additional_condition.call )
    end
  end

  def number_of_domains_description(object)
    case object.number_of_domains
    when 0
      I18n.t :unlimited_domains, scope: [:descriptions, :domains]
    else
      I18n.t :limited_domains, scope: [:descriptions, :domains], domains: object.number_of_domains, count: object.number_of_domains
    end
  end

  def subscription_description(object)
    if object.is_subscription
      I18n.t :subscription, scope: [:descriptions, :is_subscription]
    else
      I18n.t :one_time_payment, scope: [:descriptions, :is_subscription]
    end
  end
end
