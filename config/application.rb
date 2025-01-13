require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Techlog
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec, # ここから5行を追記
                       fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ(FactoryBotを使用するため)
                       view_specs: false, # ビューファイル用のスペックを作成しない
                       helper_specs: false, # ヘルパーファイル用のスペックを作成しない
                       routing_specs: false # routes.rb用のスペックファイル作成しない
    end
  end
end
