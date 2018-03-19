require 'i18n'
require 'emojidex-rasters'
require 'emojidex/data/utf'

module ManabuDesktop
  class Tools
    @@_initialized = false
    @@_emojidex = nil

    def self.init()
      return if @@_initialized

      I18n.load_path = Dir["#{__dir__}/../locales/*.yml"]

      # TODO there must be a better way to determine language
      @lang = (ENV['LANG'][0..1]).to_sym
      if I18n.available_locales.include? @lang
        I18n.locale = @lang
      else
        I18n.locale = :en
        @lang = :en
      end

      @@_initialized = true
    end

    def self.emojidex()
      return @@_emojidex if @@_emojidex
      @@_emojidex = Emojidex::Data::UTF.new
      @@_emojidex
    end
  end
end

ManabuDesktop::Tools.init()
