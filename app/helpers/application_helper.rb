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
end
