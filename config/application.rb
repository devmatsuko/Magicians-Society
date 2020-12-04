require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portfolio
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # libフォルダ内のファイルを読み込み可
    config.paths.add 'lib', eager_load: true

    # タイムゾーンを東京にする
    config.time_zone = 'Tokyo'

    # デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja
    # ロケールファイルを全て読み込む
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    
    # libフォルダの読み込み
    config.paths.add 'lib', eager_load: true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
