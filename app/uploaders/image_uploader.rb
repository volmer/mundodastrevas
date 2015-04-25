class ImageUploader < RaddarImageUploader
  def default_url
    ActionController::Base.helpers.asset_path(
      "fallback/#{ model.class.model_name.param_key }/"\
      "#{ version_name || 'original' }.png"
    )
  end

  process resize_to_limit: [760, 1160]

  version :small do
    process resize_to_fill: [160, 160]
  end

  version :thumb do
    process resize_to_fill: [60, 60]
  end
end
