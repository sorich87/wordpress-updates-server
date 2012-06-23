# RailsAdmin config file. Generated on June 23, 2012 11:17
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_admin } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, Admin

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, Admin

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Theme My', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Admin, Business, Customer, Extension, Package, Plugin, Purchase, Site, Theme, User, Version]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Admin, Business, Customer, Extension, Package, Plugin, Purchase, Site, Theme, User, Version]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Admin do
  #   # Found associations:
  #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :email, :text 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :text         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :text 
  #     configure :last_sign_in_ip, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Business do
  #   # Found associations:
  #     configure :customers, :has_and_belongs_to_many_association 
  #     configure :users, :has_many_association 
  #     configure :packages, :has_many_association 
  #     configure :extensions, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :customer_ids, :serialized         # Hidden 
  #     configure :name, :string 
  #     configure :email, :text 
  #     configure :country, :text 
  #     configure :time_zone, :text 
  #     configure :street1, :text 
  #     configure :street2, :text 
  #     configure :city, :text 
  #     configure :state, :text 
  #     configure :zip, :text 
  #     configure :phone, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Customer do
  #   # Found associations:
  #     configure :businesses, :has_and_belongs_to_many_association 
  #     configure :purchases, :has_many_association 
  #     configure :sites, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :authentication_token, :text 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :text 
  #     configure :last_sign_in_ip, :text 
  #     configure :first_name, :text 
  #     configure :last_name, :text 
  #     configure :email, :text 
  #     configure :business_ids, :serialized         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Extension do
  #   # Found associations:
  #     configure :business, :belongs_to_association 
  #     configure :purchases, :has_and_belongs_to_many_association 
  #     configure :packages, :has_and_belongs_to_many_association 
  #     configure :versions, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :name, :string 
  #     configure :current_version, :text 
  #     configure :screenshot_file_name, :string         # Hidden 
  #     configure :screenshot_content_type, :string         # Hidden 
  #     configure :screenshot_file_size, :integer         # Hidden 
  #     configure :screenshot_updated_at, :datetime         # Hidden 
  #     configure :screenshot, :paperclip 
  #     configure :business_id, :bson_object_id         # Hidden 
  #     configure :purchase_ids, :serialized         # Hidden 
  #     configure :package_ids, :serialized         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Package do
  #   # Found associations:
  #     configure :business, :belongs_to_association 
  #     configure :extensions, :has_and_belongs_to_many_association 
  #     configure :purchases, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :price, :float 
  #     configure :number_of_extensions, :integer 
  #     configure :number_of_domains, :integer 
  #     configure :billing, :integer 
  #     configure :validity, :integer 
  #     configure :business_id, :bson_object_id         # Hidden 
  #     configure :extension_ids, :serialized         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Plugin do
  #   # Found associations:
  #     configure :business, :belongs_to_association 
  #     configure :purchases, :has_and_belongs_to_many_association 
  #     configure :packages, :has_and_belongs_to_many_association 
  #     configure :versions, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :name, :string 
  #     configure :current_version, :text 
  #     configure :screenshot_file_name, :string         # Hidden 
  #     configure :screenshot_content_type, :string         # Hidden 
  #     configure :screenshot_file_size, :integer         # Hidden 
  #     configure :screenshot_updated_at, :datetime         # Hidden 
  #     configure :screenshot, :paperclip 
  #     configure :business_id, :bson_object_id         # Hidden 
  #     configure :purchase_ids, :serialized         # Hidden 
  #     configure :package_ids, :serialized         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Purchase do
  #   # Found associations:
  #     configure :customer, :belongs_to_association 
  #     configure :package, :belongs_to_association 
  #     configure :extensions, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :customer_id, :bson_object_id         # Hidden 
  #     configure :package_id, :bson_object_id         # Hidden 
  #     configure :extension_ids, :serialized         # Hidden 
  #     configure :purchase_date, :date   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Site do
  #   # Found associations:
  #     configure :customer, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :customer_id, :bson_object_id         # Hidden 
  #     configure :domain_name, :text 
  #     configure :secret_key, :text 
  #     configure :unconfirmed_secret_key, :text 
  #     configure :confirmation_token, :text 
  #     configure :confirmed_at, :datetime 
  #     configure :confirmation_sent_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Theme do
  #   # Found associations:
  #     configure :business, :belongs_to_association 
  #     configure :purchases, :has_and_belongs_to_many_association 
  #     configure :packages, :has_and_belongs_to_many_association 
  #     configure :versions, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :name, :string 
  #     configure :current_version, :text 
  #     configure :screenshot_file_name, :string         # Hidden 
  #     configure :screenshot_content_type, :string         # Hidden 
  #     configure :screenshot_file_size, :integer         # Hidden 
  #     configure :screenshot_updated_at, :datetime         # Hidden 
  #     configure :screenshot, :paperclip 
  #     configure :business_id, :bson_object_id         # Hidden 
  #     configure :purchase_ids, :serialized         # Hidden 
  #     configure :package_ids, :serialized         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :business, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :email, :text 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :text         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :text 
  #     configure :last_sign_in_ip, :text 
  #     configure :confirmation_token, :text 
  #     configure :confirmed_at, :datetime 
  #     configure :confirmation_sent_at, :datetime 
  #     configure :unconfirmed_email, :text 
  #     configure :authentication_token, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :business_id, :bson_object_id         # Hidden 
  #     configure :first_name, :text 
  #     configure :last_name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Version do
  #   # Found associations:
  #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :uri, :text 
  #     configure :version, :text 
  #     configure :author, :text 
  #     configure :author_uri, :text 
  #     configure :description, :text 
  #     configure :license, :text 
  #     configure :license_uri, :text 
  #     configure :tags, :serialized 
  #     configure :status, :text 
  #     configure :template, :text 
  #     configure :domain_path, :text 
  #     configure :network, :text 
  #     configure :text_domain, :text 
  #     configure :attachment_file_name, :string         # Hidden 
  #     configure :attachment_content_type, :string         # Hidden 
  #     configure :attachment_file_size, :integer         # Hidden 
  #     configure :attachment_updated_at, :datetime         # Hidden 
  #     configure :attachment, :paperclip   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
