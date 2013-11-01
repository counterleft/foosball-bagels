SECRET_KEY_BASE_FILE = File.join(Rails.root.to_s, '..', '..', '..', '..', 'shared', 'config', 'webapps', 'foosball', 'secret_key_base')

secret_key_base= "testingkey9812741289473%%%%%"
if File.readable?(SECRET_KEY_BASE_FILE)
  secret_key_base = File.read(SECRET_KEY_BASE_FILE).chomp
end

Foosball::Application.config.session_store :cookie_store, :key => '_bcs'
Foosball::Application.config.secret_key_base = secret_key_base
