class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  def default_url
    ActionController::Base.helpers.asset_path(
      "fallback/#{ model.class.model_name.param_key }/"\
      "#{ version_name || 'original' }.png"
    )
  end

  process convert: 'jpg'

  process resize_to_limit: [760, 1160]

  version :medium do
    process resize_to_fill: [360, 360]
  end

  version :small do
    process resize_to_fill: [160, 160]
  end

  version :thumb do
    process resize_to_fill: [60, 60]
  end
end
