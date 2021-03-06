class VideoUploader < CarrierWave::Uploader::Base

  require 'streamio-ffmpeg'

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # ファイル名に日本語を使えるようにする。
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  # 動画ごとに保存するディレクトリを変える
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end
  version :screenshot do
    process :screenshot
    def full_filename (for_file = model.logo.file)
      "screenshot.jpg"
    end
  end

  def screenshot
    tmpfile = File.join(File.dirname(current_path), "tmpfile")

    File.rename(current_path, tmpfile)

    movie = FFMPEG::Movie.new(tmpfile)
    movie.screenshot(current_path + ".jpg", {resolution: '512x312' }, preserve_aspect_ratio: :width)
    File.rename(current_path + ".jpg", current_path)
    
    # サムネイルのcontent_typeをvideo/mp4→image/jpegに変換する
    file.content_type = "image/jpeg"

    File.delete(tmpfile)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(gif png MOV wmv mp4)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.#{file.extension}" if original_filename
  end
end
