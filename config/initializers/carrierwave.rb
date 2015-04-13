CarrierWave.configure do |config|
config.fog_credentials = {

    :provider                         => 'Google',
    :google_storage_access_key_id     => ENV['GOOGLE_STORAGE_KEY'],
    :google_storage_secret_access_key => ENV['GOOGLE_STORAGE_SECRET']

    }

    config.fog_directory = 'flatiron-twork'
end