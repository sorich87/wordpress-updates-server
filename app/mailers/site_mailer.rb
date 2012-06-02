class SiteMailer < ActionMailer::Base
  def confirmation_instructions(site)
    @site = site
    mail to: @site.customer.email, subject: "Please Confirm Your Website"
  end
end