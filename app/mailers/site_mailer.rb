class SiteMailer < ActionMailer::Base
  default :from => "no-reply@push.ly"

  def confirmation_instructions(site)
    @site = site
    mail to: @site.customer.email, subject: "Confirm Your Website for Automatic Updates"
  end
end
