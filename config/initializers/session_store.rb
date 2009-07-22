# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_foosball_session',
  :secret      => 'ee843846c193f09c50a0b1ed3757d3a541a83ce1212342d8f789dbf66178a103a3e5128d52d37c4c734df62d2a56febde6f403178cefe3bfd7d854ab76a1e366'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
