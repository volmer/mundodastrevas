class AvatarUploader < RaddarImageUploader
  def default_url
    ActionController::Base.helpers.asset_path(
      "fallback/avatar/#{ version_name || 'original' }.png"
    )
  end

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