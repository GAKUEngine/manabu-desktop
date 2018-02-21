require_relative 'base'
require_relative 'login'

module ManabuDesktop
  module Screens
    class MainMenu < ManabuDesktop::Screens::Base
      def initialize()
        super('main_menu')

        connect_button = @builder.get_object('connect.button')
        connect_button.set_label(I18n.t('main_menu.connect'))
        connect_button.signal_connect('clicked') { ManabuDesktop::Screens::Login.new }

        settings_button = @builder.get_object('settings.button')
        settings_button.set_label(I18n.t('main_menu.settings'))
        settings_button.signal_connect('clicked') { puts 'Settings coming soon' }

        exit_button = @builder.get_object('exit.button')
        exit_button.set_label(I18n.t('main_menu.exit'))
        exit_button.signal_connect('clicked') do |_widget|
          Gtk.main_quit()
          @window.destroy()
        end
        _show()
      end
    end
  end
end
