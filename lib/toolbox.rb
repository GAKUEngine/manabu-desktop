require 'i18n'

I18n.load_path = Dir["#{__dir__}/../locales/*.yml"]

# TODO there must be a better way to determine language
@lang = (ENV['LANG'][0..1]).to_sym
if I18n.available_locales.include? @lang
  I18n.locale = @lang
else
  I18n.locale = :en
  @lang = :en
end
