class ExtensionMailer < ActionMailer::Base
  default :from => "no-reply@push.ly"

  def permission_notification(extension, customer)
    @extension = extension
    @user = @extension.business.users.first
    @user.ensure_authentication_token!
    @customer = customer
    mail to: @user.email, subject: "Push.ly Customer Authorization"
  end
end
