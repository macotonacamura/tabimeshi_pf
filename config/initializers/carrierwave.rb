unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AWS_ACCESS_KEY_ID',
      aws_secret_access_key: 'AWS_SECRET_ACCESS_KEY',
      region: 'AWS_REGION'
    }

    config.fog_directory  = 'AWS_S3_BUCKET_NAME'
    config.cache_storage = :fog
  end
end