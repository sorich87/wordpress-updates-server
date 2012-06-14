Fog.mock!
Fog.credentials_path = Rails.root.join('config/fog.yml')
Fog.credential = :test
connection = Fog::Storage.new(:provider => 'AWS')
connection.directories.create(:key => 'thememy-test')
