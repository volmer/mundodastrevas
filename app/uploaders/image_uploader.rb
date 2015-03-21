class ImageUploader < RaddarImageUploader
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  def default_url
    ActionController::Base.helpers.asset_path("fallback/#{ model.class.model_name.param_key }/#{ version_name || 'original' }.png")
  end

  process resize_to_limit: [760, 1160]

  version :small do
    process resize_to_fill: [160, 160]
  end

  version :thumb do
    process resize_to_fill: [60, 60]
  end
end
