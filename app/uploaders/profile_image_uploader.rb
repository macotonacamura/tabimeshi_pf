class ProfileImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.development?
   storage :file
  elsif Rails.env.test?
   storage :file
  else
   storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
   def default_url(*args)
    "no_image.jpg"
   end
  # def scale(width, height)
  #   # do something
  # end

  process resize_to_limit: [1200, 5000]

  # サムネイル画像
  version :thumb do
    process resize_to_fill: [100, 100]
  end

  # 許可する画像の拡張子
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

# 保存するファイルの命名規則
  def filename
     "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  # 一意となるトークンを作成
  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
