Paperclip::Attachment.default_options[:storage] = :fog
Paperclip::Attachment.default_options[:fog_credentials] = File.join(Rails.root, 'config', 'fog.yml')
Paperclip::Attachment.default_options[:fog_directory] = Rails.env.production? ? ENV['S3_BUCKET_NAME'] : 'thememy-test'
