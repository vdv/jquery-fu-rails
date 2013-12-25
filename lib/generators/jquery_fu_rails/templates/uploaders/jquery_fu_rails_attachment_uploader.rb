class JqueryFuRailsAttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/jquery_fu_rails/attachments/#{model.id}"
  end

  # version :thumb do
  #   process :resize_to_fill => [118, 100]
  # end

  # version :content do
  #   process :resize_to_limit => [800, 800]
  # end

  # def extension_white_list
  #   FuploadRails.image_file_types
  # end
end
