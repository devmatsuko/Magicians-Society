# CarrierWaveの設定呼び出し
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? # 本番環境の場合
    config.fog_provider = 'fog/aws'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/prd-magicians-society'
    config.fog_directory  = 'prd-magicians-society'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1',
      path_style: true
    }
  else # 開発環境の場合
    config.fog_provider = 'fog/aws'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/stg-magicians-society'
    config.fog_directory  = 'stg-magicians-society'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1',
      path_style: true
    }
  end
  #日本語ファイル名の設定
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end

